# Tank-Volume-Flow-Rate
Just a basic MATLAB script that calculates the volume flow rates for a tank of hydrogen peroxide and plots the flow rates per time. The main differential equation is solved using the basic mass balance equation:<br>

<p align="center">
Accumulation = In + Out + Production – Consumption  (1) <br>
</p>

And plugging the data given in the script, the equation can be written as:<br>
<p align="center">
$$\frac{dn(t)}{dt} = V_1(t) C_1(t)  - [V_1(t) + V_2(t) ]  \frac{n(t)}{V_{tank}} - k  n(t)$$   (2) <br><br>
</p>


The graphs the script plots can be seen below:<br>

![Graph_1](https://github.com/user-attachments/assets/e41a9d20-94bc-48b1-9353-e23b7cc0c763)

