# BEZIER CURVES WITH PYTHAGOREAN HODOGRAPH
# (Bezierjeve krivulje s pitagorejskim hodografom)
 
 A project for course Computer aided geometric design (Računalniško podprto geometrijsko oblikovanje).
 
We explored a special type of Bezier curves, curves utilizing Pythagorean *hodograph*, which is nothing else than derivative of Bezier curve whose coordinates suffice the Pythagorean condition. More precise if the Bezier curve in plane is given by p(t) = (x(t), y(t)), then must hold (x'(t))^2 + (y'(t))^2 = c(t)^2 for some polynomial c(t).

The main beauty of such curves comes in play when we compute their *offset curves*. Once we have PH Bezier curve the offset is immediate, even more the offset is then rational Bezier curve. Why is this so important? For computers the rational curve is quick and *exact* to compute. Meaning, we don't need approximations or other tools otherwise used in computer aided design.

In the last section we also explored representation of Bezier curves in the complex plane C. With use of complex numbers we can represent Bezier curves in more concise manner. Additionally we can also simplyfy operations involving Bezier curves and write them down in more compact form.

We implemented a Matlab code for PH Bezier curves, as well as code for generating figures.
