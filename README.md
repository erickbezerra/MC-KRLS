# MC-KRLS

| Kernels | Combined	Forecast | Delete Method | Acronym | File |
| ------- | ------------------ | ------------- | ------- | ---- |
| 2 | Arithmetic	Mean | Counter | M2C-KRLS | M2C-KRLS-T.m |
| 3 | Arithmetic	Mean | Counter | M3C-KRLS | M3C-KRLS-T.m |
| 2 | Weighted 	Mean (W) | Counter | M2C-KRLSW | Temp.mat |
| 3 | Weighted 	Mean (W) | Counter | M3C-KRLSW | Temp.mat |
| 2 | Arithmetic	Mean | Aging (A) | M2C-KRLSA | Temp.mat |
| 3 | Arithmetic	Mean | Aging (A) | M3C-KRLSA | Temp.mat |
| 2 | Weighted 	Mean (W) | Aging (A) | M2C-KRLSAW | Temp.mat |
| 3 | Weighted 	Mean (W) | Aging (A) | M3C-KRLSAW | Temp.mat |

Pieces of the code are from the [Kernel Adaptive Filtering Toolbox](https://github.com/steven2358/kafbox).

### COMMON
- Files that must be at the same folder of the model.

### KRLS / KRLS-T / SW-KRLS
- Models using [ALD-KRLS](https://ieeexplore.ieee.org/abstract/document/1315946), [KRLS-T](https://ieeexplore.ieee.org/abstract/document/6227361) and [SW-KRLS](https://ieeexplore.ieee.org/abstract/document/1661394).

:warning: The file normalized_dataset.zip is used for every model and contains the normalized historical measures.

### SOURCE

[E. C. Bezerra, P. Pinson, R. P. S. Leão and A. P. S. Braga, "A Self-Adaptive Multikernel Machine Based on Recursive Least-Squares Applied to Very Short-Term Wind Power Forecasting," in IEEE Access, vol. 9, pp. 104761-104772, 2021, doi: 10.1109/ACCESS.2021.3099999](https://ieeexplore.ieee.org/abstract/document/9495822).

