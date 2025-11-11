# Hand-Guiding-IR-ExtendedWorkspaces
This dataset refers to the paper titled "Enabling Manual Guidance in High-Payload Industrial Robots for Flexible Manufacturing Applications in Large Workspaces" published on MDPI Machines journal. It contains the research material developed to implement manual guidance on both the 6DoF KUKA robot (KRC4 controller + Robot Sensor Interface package) and the 1DoF servoactuated linear robotic axis (Beckhoff PC, AX8118 Drive, AM8052 servomotor).

## 📂 Repository structure:

RSI Projects
--> 6DoF manual guidance
- RSI project files to be loaded on the KUKA controller to enable external, sensor-guided, movements. They implement the logic described in Section 3.1 and Figure 4 of the paper.
- KRL scripts to be lanched to effectively run the tests

P.S. the folder contains also the files related to the load-sensing procedure, to be executed prior to starting the hand-guiding.

Experiments on Robot
--> 6DoF manual guidance
- position and force data sampled during the physical tests on the KUKA robot.
- Matlab files used for data processing and plotting

PLC Projects
--> 1DoF manual guidance
- PLC program implementing the simplified logig (refer to Figure 4, but considering only 1 DoF).

--------------------------------------
## 🧩 Requirements
- MATLAB R202x
- WorkVisual / KUKA RSI
- Beckhoff TwinCAT 3
