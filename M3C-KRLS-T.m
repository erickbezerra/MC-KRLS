% Kernel Recursive Least Square - T
clear all; close all; tic;

% 5 Blocks of 8421 points, k-fold cross validation
TAD = [];
VarM = [ 20 30 40 50 60 70 ]; NVarM = size(VarM,2); % M 20, 30, 40, 50, 60, 70
Jitter = [ 5E-4 1E-3 .01 .05 .1 ]; NJitter = size(Jitter,2); % jitter 5E-4 1E-3 .01 .05 .1
Varembedding = [ 1 2 3 4 5 6 7 8 ]; NVarembedding = size(Varembedding,2); % LAG 1, 2, 3, 4, 5, 6, 7, 8
Lambda = [ .9 .99 .999 ]; NLambda = size(Lambda,2); % lambda 0.9, 0.99, 0.999
SN2 = [ 5E-3 5E-2, 1E-2 ]; NSN2 = size(SN2,2); % sn2 5E-3, 5E-2, 1E-2

for ze = 1:NVarM
    % 5 Blocks of 8421 points, k-fold cross validation ( T T T T V )
    for zed = 1:NJitter
        for zedd = 1:NVarembedding
            for zeddd = 1:NLambda
                for zedddd = 1:NSN2
                    
                    % Data order ( T T T T V )		                        
                    [X1,Y1] = kafbox_data(struct('file','Normalized_WATERLWF_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X2,Y2] = kafbox_data(struct('file','Normalized_HALLWF2_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X3,Y3] = kafbox_data(struct('file','Normalized_SNOWTWN1_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X4,Y4] = kafbox_data(struct('file','Normalized_HALLWF1_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X5,Y5] = kafbox_data(struct('file','Normalized_LKBONNY2_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X6,Y6] = kafbox_data(struct('file','Normalized_NBHWF1_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X7,Y7] = kafbox_data(struct('file','Normalized_CLEMGPWF_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    [X8,Y8] = kafbox_data(struct('file','Normalized_LKBONNY3_without_NaN.dat','embedding',Varembedding(zedd),'horizon',1)); % Using fuction to prepare the data input/output
                    X = [ X1 X2 X3 X4 X5 X6 X7 X8 ]; Y = [ Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 ]; % ( T T T T V )

                    % New data order ( T T T V T )		                        
                    %X1 = [ X1(1:8421*3,:) ; X1(8421*4+1:8421*5,:) ; X1(8421*3+1:8421*4,:) ; X1(8421*5+1:end,:) ]; Y1 = [ Y1(1:8421*3,:) ; Y1(8421*4+1:8421*5,:) ; Y1(8421*3+1:8421*4,:) ; Y1(8421*5+1:end,:) ];
		    %X2 = [ X2(1:8421*3,:) ; X2(8421*4+1:8421*5,:) ; X2(8421*3+1:8421*4,:) ; X2(8421*5+1:end,:) ]; Y2 = [ Y2(1:8421*3,:) ; Y2(8421*4+1:8421*5,:) ; Y2(8421*3+1:8421*4,:) ; Y2(8421*5+1:end,:) ];
		    %X3 = [ X3(1:8421*3,:) ; X3(8421*4+1:8421*5,:) ; X3(8421*3+1:8421*4,:) ; X3(8421*5+1:end,:) ]; Y3 = [ Y3(1:8421*3,:) ; Y3(8421*4+1:8421*5,:) ; Y3(8421*3+1:8421*4,:) ; Y3(8421*5+1:end,:) ];
		    %X4 = [ X4(1:8421*3,:) ; X4(8421*4+1:8421*5,:) ; X4(8421*3+1:8421*4,:) ; X4(8421*5+1:end,:) ]; Y4 = [ Y4(1:8421*3,:) ; Y4(8421*4+1:8421*5,:) ; Y4(8421*3+1:8421*4,:) ; Y4(8421*5+1:end,:) ];
		    %X5 = [ X5(1:8421*3,:) ; X5(8421*4+1:8421*5,:) ; X5(8421*3+1:8421*4,:) ; X5(8421*5+1:end,:) ]; Y5 = [ Y5(1:8421*3,:) ; Y5(8421*4+1:8421*5,:) ; Y5(8421*3+1:8421*4,:) ; Y5(8421*5+1:end,:) ];
		    %X6 = [ X6(1:8421*3,:) ; X6(8421*4+1:8421*5,:) ; X6(8421*3+1:8421*4,:) ; X6(8421*5+1:end,:) ]; Y6 = [ Y6(1:8421*3,:) ; Y6(8421*4+1:8421*5,:) ; Y6(8421*3+1:8421*4,:) ; Y6(8421*5+1:end,:) ];
		    %X7 = [ X7(1:8421*3,:) ; X7(8421*4+1:8421*5,:) ; X7(8421*3+1:8421*4,:) ; X7(8421*5+1:end,:) ]; Y7 = [ Y7(1:8421*3,:) ; Y7(8421*4+1:8421*5,:) ; Y7(8421*3+1:8421*4,:) ; Y7(8421*5+1:end,:) ];
		    %X8 = [ X8(1:8421*3,:) ; X8(8421*4+1:8421*5,:) ; X8(8421*3+1:8421*4,:) ; X8(8421*5+1:end,:) ]; Y8 = [ Y8(1:8421*3,:) ; Y8(8421*4+1:8421*5,:) ; Y8(8421*3+1:8421*4,:) ; Y8(8421*5+1:end,:) ];
		    %X = [ X1 X2 X3 X4 X5 X6 X7 X8 ]; Y = [ Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 ]; % ( T T T V T )		    
        
                    % New data order ( T T V T T )		                        
                    %X1 = [ X1(1:8421*2,:) ; X1(8421*3+1:8421*5,:) ; X1(8421*2+1:8421*3,:) ; X1(8421*5+1:end,:) ]; Y1 = [ Y1(1:8421*2,:) ; Y1(8421*3+1:8421*5,:) ; Y1(8421*2+1:8421*3,:) ; Y1(8421*5+1:end,:) ];
		    %X2 = [ X2(1:8421*2,:) ; X2(8421*3+1:8421*5,:) ; X2(8421*2+1:8421*3,:) ; X2(8421*5+1:end,:) ]; Y2 = [ Y2(1:8421*2,:) ; Y2(8421*3+1:8421*5,:) ; Y2(8421*2+1:8421*3,:) ; Y2(8421*5+1:end,:) ];
		    %X3 = [ X3(1:8421*2,:) ; X3(8421*3+1:8421*5,:) ; X3(8421*2+1:8421*3,:) ; X3(8421*5+1:end,:) ]; Y3 = [ Y3(1:8421*2,:) ; Y3(8421*3+1:8421*5,:) ; Y3(8421*2+1:8421*3,:) ; Y3(8421*5+1:end,:) ];
		    %X4 = [ X4(1:8421*2,:) ; X4(8421*3+1:8421*5,:) ; X4(8421*2+1:8421*3,:) ; X4(8421*5+1:end,:) ]; Y4 = [ Y4(1:8421*2,:) ; Y4(8421*3+1:8421*5,:) ; Y4(8421*2+1:8421*3,:) ; Y4(8421*5+1:end,:) ];
		    %X5 = [ X5(1:8421*2,:) ; X5(8421*3+1:8421*5,:) ; X5(8421*2+1:8421*3,:) ; X5(8421*5+1:end,:) ]; Y5 = [ Y5(1:8421*2,:) ; Y5(8421*3+1:8421*5,:) ; Y5(8421*2+1:8421*3,:) ; Y5(8421*5+1:end,:) ];
		    %X6 = [ X6(1:8421*2,:) ; X6(8421*3+1:8421*5,:) ; X6(8421*2+1:8421*3,:) ; X6(8421*5+1:end,:) ]; Y6 = [ Y6(1:8421*2,:) ; Y6(8421*3+1:8421*5,:) ; Y6(8421*2+1:8421*3,:) ; Y6(8421*5+1:end,:) ];
		    %X7 = [ X7(1:8421*2,:) ; X7(8421*3+1:8421*5,:) ; X7(8421*2+1:8421*3,:) ; X7(8421*5+1:end,:) ]; Y7 = [ Y7(1:8421*2,:) ; Y7(8421*3+1:8421*5,:) ; Y7(8421*2+1:8421*3,:) ; Y7(8421*5+1:end,:) ];
		    %X8 = [ X8(1:8421*2,:) ; X8(8421*3+1:8421*5,:) ; X8(8421*2+1:8421*3,:) ; X8(8421*5+1:end,:) ]; Y8 = [ Y8(1:8421*2,:) ; Y8(8421*3+1:8421*5,:) ; Y8(8421*2+1:8421*3,:) ; Y8(8421*5+1:end,:) ]; 
		    %X = [ X1 X2 X3 X4 X5 X6 X7 X8 ]; Y = [ Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 ]; % ( T T V T T )		                        

		    % New data order ( T V T T T )		                        
                    %X1 = [ X1(1:8421*1,:) ; X1(8421*2+1:8421*5,:) ; X1(8421*1+1:8421*2,:) ; X1(8421*5+1:end,:) ]; Y1 = [ Y1(1:8421*1,:) ; Y1(8421*2+1:8421*5,:) ; Y1(8421*1+1:8421*2,:) ; Y1(8421*5+1:end,:) ];
		    %X2 = [ X2(1:8421*1,:) ; X2(8421*2+1:8421*5,:) ; X2(8421*1+1:8421*2,:) ; X2(8421*5+1:end,:) ]; Y2 = [ Y2(1:8421*1,:) ; Y2(8421*2+1:8421*5,:) ; Y2(8421*1+1:8421*2,:) ; Y2(8421*5+1:end,:) ];
		    %X3 = [ X3(1:8421*1,:) ; X3(8421*2+1:8421*5,:) ; X3(8421*1+1:8421*2,:) ; X3(8421*5+1:end,:) ]; Y3 = [ Y3(1:8421*1,:) ; Y3(8421*2+1:8421*5,:) ; Y3(8421*1+1:8421*2,:) ; Y3(8421*5+1:end,:) ];
		    %X4 = [ X4(1:8421*1,:) ; X4(8421*2+1:8421*5,:) ; X4(8421*1+1:8421*2,:) ; X4(8421*5+1:end,:) ]; Y4 = [ Y4(1:8421*1,:) ; Y4(8421*2+1:8421*5,:) ; Y4(8421*1+1:8421*2,:) ; Y4(8421*5+1:end,:) ];
		    %X5 = [ X5(1:8421*1,:) ; X5(8421*2+1:8421*5,:) ; X5(8421*1+1:8421*2,:) ; X5(8421*5+1:end,:) ]; Y5 = [ Y5(1:8421*1,:) ; Y5(8421*2+1:8421*5,:) ; Y5(8421*1+1:8421*2,:) ; Y5(8421*5+1:end,:) ];
		    %X6 = [ X6(1:8421*1,:) ; X6(8421*2+1:8421*5,:) ; X6(8421*1+1:8421*2,:) ; X6(8421*5+1:end,:) ]; Y6 = [ Y6(1:8421*1,:) ; Y6(8421*2+1:8421*5,:) ; Y6(8421*1+1:8421*2,:) ; Y6(8421*5+1:end,:) ];
		    %X7 = [ X7(1:8421*1,:) ; X7(8421*2+1:8421*5,:) ; X7(8421*1+1:8421*2,:) ; X7(8421*5+1:end,:) ]; Y7 = [ Y7(1:8421*1,:) ; Y7(8421*2+1:8421*5,:) ; Y7(8421*1+1:8421*2,:) ; Y7(8421*5+1:end,:) ];
		    %X8 = [ X8(1:8421*1,:) ; X8(8421*2+1:8421*5,:) ; X8(8421*1+1:8421*2,:) ; X8(8421*5+1:end,:) ]; Y8 = [ Y8(1:8421*1,:) ; Y8(8421*2+1:8421*5,:) ; Y8(8421*1+1:8421*2,:) ; Y8(8421*5+1:end,:) ];
		    %X = [ X1 X2 X3 X4 X5 X6 X7 X8 ]; Y = [ Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 ]; % ( T V T T T )		    

		    % New data order ( V T T T T )		                        
                    %X1 = [ X1(8421*1+1:8421*5,:) ; X1(1:8421*1,:) ; X1(8421*5+1:end,:) ]; Y1 = [ Y1(8421*1+1:8421*5,:) ; Y1(1:8421*1,:) ; Y1(8421*5+1:end,:) ];
		    %X2 = [ X2(8421*1+1:8421*5,:) ; X2(1:8421*1,:) ; X2(8421*5+1:end,:) ]; Y2 = [ Y2(8421*1+1:8421*5,:) ; Y2(1:8421*1,:) ; Y2(8421*5+1:end,:) ];
		    %X3 = [ X3(8421*1+1:8421*5,:) ; X3(1:8421*1,:) ; X3(8421*5+1:end,:) ]; Y3 = [ Y3(8421*1+1:8421*5,:) ; Y3(1:8421*1,:) ; Y3(8421*5+1:end,:) ];
		    %X4 = [ X4(8421*1+1:8421*5,:) ; X4(1:8421*1,:) ; X4(8421*5+1:end,:) ]; Y4 = [ Y4(8421*1+1:8421*5,:) ; Y4(1:8421*1,:) ; Y4(8421*5+1:end,:) ];
		    %X5 = [ X5(8421*1+1:8421*5,:) ; X5(1:8421*1,:) ; X5(8421*5+1:end,:) ]; Y5 = [ Y5(8421*1+1:8421*5,:) ; Y5(1:8421*1,:) ; Y5(8421*5+1:end,:) ];
		    %X6 = [ X6(8421*1+1:8421*5,:) ; X6(1:8421*1,:) ; X6(8421*5+1:end,:) ]; Y6 = [ Y6(8421*1+1:8421*5,:) ; Y6(1:8421*1,:) ; Y6(8421*5+1:end,:) ];
		    %X7 = [ X7(8421*1+1:8421*5,:) ; X7(1:8421*1,:) ; X7(8421*5+1:end,:) ]; Y7 = [ Y7(8421*1+1:8421*5,:) ; Y7(1:8421*1,:) ; Y7(8421*5+1:end,:) ];
		    %X8 = [ X8(8421*1+1:8421*5,:) ; X8(1:8421*1,:) ; X8(8421*5+1:end,:) ]; Y8 = [ Y8(8421*1+1:8421*5,:) ; Y8(1:8421*1,:) ; Y8(8421*5+1:end,:) ];
		    %X = [ X1 X2 X3 X4 X5 X6 X7 X8 ]; Y = [ Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 ]; % ( V T T T T )		    
                    
                    %% RUN ALGORITHM
                    N = size(X,1); % Size of the data file.
                    NY = size(Y,2); Y_est = zeros(N,NY); % Number of outputs
                    % make a kernel object with options:
                    kaf1 = krlst(struct('lambda',Lambda(zeddd),'jitter',Jitter(zed),'sn2',SN2(zedddd),'M',VarM(ze),'kerneltype','gauss','kernelpar',32,'NY',NY)); % Kernel 1
                    kaf2 = krlst(struct('lambda',Lambda(zeddd),'jitter',Jitter(zed),'sn2',SN2(zedddd),'M',VarM(ze),'kerneltype','gauss','kernelpar',32,'NY',NY)); % Kernel 2
                    kaf3 = krlst(struct('lambda',Lambda(zeddd),'jitter',Jitter(zed),'sn2',SN2(zedddd),'M',VarM(ze),'kerneltype','gauss','kernelpar',32,'NY',NY)); % Kernel 3                    
                    deletcounter = 0; deletcountermax = max([ kaf1.M kaf2.M ]); % Used to determine the start of kernel delet process
                    for i=1:N,
                        % Computing the output of each kernel
                        if size(kaf1.dict,1)>0 % Kernel 01
                            k1 = kernel(kaf1.dict,X(i,:),kaf1.kerneltype,kaf1.kernelpar);
                            q1 = kaf1.Q*k1;
                            Y_est1(i,:) = q1'*kaf1.mu; % predictive mean
                        else
                            Y_est1(i,:) = zeros(size(X(i,:),1),kaf1.NY); % 8 outputs
                        end
                        if size(kaf2.dict,1)>0 % Kernel 02
                            k2 = kernel(kaf2.dict,X(i,:),kaf2.kerneltype,kaf2.kernelpar);
                            q2 = kaf2.Q*k2;
                            Y_est2(i,:) = q2'*kaf2.mu; % predictive mean
                        else
                            Y_est2(i,:) = zeros(size(X(i,:),1),NY); % 8 outputs
                        end
                        if size(kaf3.dict,1)>0 % Kernel 03
                            k3 = kernel(kaf3.dict,X(i,:),kaf3.kerneltype,kaf3.kernelpar);
                            q3 = kaf3.Q*k3;
                            Y_est3(i,:) = q3'*kaf3.mu; % predictive mean
                        else
                            Y_est3(i,:) = zeros(size(X(i,:),1),NY); % 8 outputs
                        end                        
                        
                        % Ensemble the outputs
                        if (size(kaf1.dict,1)>0 && size(kaf2.dict,1)>0 && size(kaf3.dict,1)>0)
                            Y_est(i,:)=(Y_est1(i,:)+Y_est2(i,:)+Y_est3(i,:))/3;
                        end
                        if (size(kaf1.dict,1)>0 && size(kaf2.dict,1)>0 && size(kaf3.dict,1)==0) || (size(kaf1.dict,1)>0 && size(kaf2.dict,1)==0 && size(kaf3.dict,1)>0) || (size(kaf1.dict,1)==0 && size(kaf2.dict,1)>0 && size(kaf3.dict,1)>0)
                            Y_est(i,:)=(Y_est1(i,:)+Y_est2(i,:)+Y_est3(i,:))/2;
                        end
                        if (size(kaf1.dict,1)>0 && size(kaf2.dict,1)==0 && size(kaf3.dict,1)==0 ) || (size(kaf1.dict,1)==0 && size(kaf2.dict,1)>0 && size(kaf3.dict,1)==0 ) || (size(kaf1.dict,1)==0 && size(kaf2.dict,1)==0 && size(kaf3.dict,1)>0 )
                            Y_est(i,:)=(Y_est1(i,:)+Y_est2(i,:)+Y_est3(i,:));
                        end
                        
                        if (size(kaf1.dict,1)==0 && size(kaf2.dict,1)==0 && size(kaf3.dict,1)==0)
                            Y_est(i,:)=zeros(size(X(i,:),1),NY);
                        end
                        
                        % "Training" kernels
                        kaf1 = kaf1.train(X(i,:),Y(i,:)); % train with one input-output pair
                        if size(kaf1.dict,1) >= kaf1.M/4 % if dic size is above 25% (kaf1.M/4) of the dictionary size (VarM) starts the second kernel machine.
                            kaf2 = kaf2.train(X(i,:),Y(i,:)); % train with one input-output pair
                        end
                        if size(kaf2.dict,1) >= kaf2.M/4 % if dic size is above 25% (kaf1.M/4) of the dictionary size (VarM) starts the second kernel machine.
                            kaf3 = kaf3.train(X(i,:),Y(i,:)); % train with one input-output pair
                        end                        
                        
                        % Count KafMAX.M iterations as a criteria to start matrix delet
                        % process
                        if (size(kaf1.dict,1)==kaf1.M && size(kaf2.dict,1)==kaf2.M && size(kaf3.dict,1)==kaf3.M)
                            deletcounter = deletcounter + 1;
                        end
                        
                        % Conditional to verify wich matrix will be deleted
                        if deletcounter == deletcountermax % (i + size(kaf1.dict,1)+size(kaf2.dict,1)+size(kaf3.dict,1) == i + kaf1.M+kaf2.M+kaf3.M*2 )
                            SE1 = (Y(i-deletcounter:i,:)-Y_est1(i-deletcounter:i,:)).^2; % (Y(i-kaf1.M-kaf2.M-kaf3.M:i-1,:)-Y_est1(i-kaf1.M-kaf2.M-kaf3.M:i-1,:)).^2;
                            SE2 = (Y(i-deletcounter:i,:)-Y_est2(i-deletcounter:i,:)).^2; % (Y(i-kaf1.M-kaf2.M-kaf3.M:i-1,:)-Y_est2(i-kaf1.M-kaf2.M-kaf3.M:i-1,:)).^2;
                            SE3 = (Y(i-deletcounter:i,:)-Y_est3(i-deletcounter:i,:)).^2;
                            MSEtemp = [ sum(mean(SE1,2)) sum(mean(SE2,2)) sum(mean(SE3,2)) ];
                            AptdMax = max(MSEtemp); % Find Max MSE
                            [rAptdMax,cAptdMax] = find( MSEtemp == AptdMax); % Find coordinates
                            % Remove kernel with the bigger MSE
                            eval(['kaf' int2str(cAptdMax(1,1)) '.dict' '=[];']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.Q' '=[];']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.mu' '=[];']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.Sigma' '=[];']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.nums02ML' '=0;']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.dens02ML' '=0;']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.s02' '=0;']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.prune' '=false;']);
                            eval(['kaf' int2str(cAptdMax(1,1)) '.reduced' '=false;']);
                            deletcounter = 0;
                        end
                    end
                    SE = (Y-Y_est).^2; % Square error
                    MSETraining = mean(SE(1:8421*4,1:end)); % Mean square error ("Training")
                    MSEValidation = mean(SE(8421*4+1:8421*5,1:end)); % Mean square error ("Validation")
                    MSETest = mean(SE(42106:end,1:end)); % Mean square error ("Training")
                    RMSETraining = sqrt(MSETraining)*100; % Root mean square error ("Training")
                    RMSEValidation = sqrt(MSEValidation)*100; % Root mean square error ("Validation")
                    RMSETest = sqrt(MSETest)*100; % Root mean square error ("Training")
                    
                    TAD = [ TAD ; Jitter(zed) Varembedding(1,zedd) Lambda(1,zeddd) SN2(1,zedddd) RMSEValidation RMSETest ];
                    clearvars -except TAD ze zed zedd zeddd zedddd VarM Jitter Varembedding Lambda SN2 NVarM NJitter NVarembedding NLambda NSN2; clc;
                end
            end
        end
    end
    
    Exec_time = toc;
    % Saving file  
    outfile = ['025n_M3KRLS_T_M',int2str(VarM(ze)),'_1'];
    % 025n (% of dic size to start nem kernel machine);
    % M2 (number of kernel machines);
    % KRLS_T (type of kernel machine)
    % M (size of the kernel matrix)
    % _1 ( T T T T V ); _2 ( T T T V T ); _3 ( T T V T T ); _4 ( T V T T T );  _5 ( V T T T T );
    save(outfile);
end
