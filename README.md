# Defender
A tower defense game built using Java for phidgets using non traditional inputs and outputs to provide a more intuitive and fun experience.

Compile Instructions:
- Place all the included files in a folder called "Defender"
- Open the file "Defender.pde" using processing.
- Execute the file.

Assembly of the interface:
- Inputs:
The Ministick is supposed to be connected to the first(0)
and second(1) voltage port of the phidget interface kit.
  - The rotation sensor is connected to he third(2)
  - The temperature sensor is connected to the fourth(3).
  - Note: Depending on how the ministick is connected, it
orientation will kill enemies in the aligning waves.
We must make sure that when the ministick is moved
towards the right end, a shot is fired in lane 3, lane 2 when
its moved front or back and lane 1 when its moved to the
left.
- Outputs:
  - The servo motor should be used with either of the non
circular heads so that they can clearly show the passage of
time, and the initial orientation should align with either the
horizontal or the vertical axis to clearly know when
180 degrees have been completed.
  - The LEDs are supposed to be connected to the Digital
outputs 1, 3 and 6 which are the second, fourth and the
seventh
digital output ports respectively. These will tell us the
enemies in range for the lanes 1, 2 and 3 respectively.

Game Design:
- The basic premise of the game is to defend our base from
waves of incoming enemies but because of the extreme
cold, most of the sensors to detect the enemy are not
responding. We only have a distance sensor that lights up
when an enemy enters its proximity range. Our task is to
kill the enemies as soon as possible so that they don't reach
our base.
We have to use our limited stash of ammunition to defend
our base so we must be careful.
We have enough energy to power up our heating systems
for a few seconds before it overloads the supply and turns
off while it recharges. While the heat is on, we have more
of our sensory equipment online so we can get more
information on the number and location of the incoming
enemies.
We also have a powerful cryogenic freeze ray that can slow
down the enemies but we must be careful as we have no
way of recharging the ray.
We have to use all the equipment we have to defend our
base for as long as we can against the incoming invasion.

Interface Elements:
- Inputs:
  - Ministick: This is the basic control of the shooting system of the game,
once it is aimed towards a lane, a shot is fired in that lane
and the first enemy within it range is killed.
  - Temperature Sensor: This is what we use to simulate the heating of the sensory
equipment. Once the temperature crosses 39 degrees, we
are able to see more information about the location and the
number of enemies.
  - Rotation Sensor: This is the control dial of the freeze ray. Turning this will
slow the enemies down but because of the limited charge,
we must be careful about using it as the enemies get faster
and more numerous as the waves progress.
We must also remember to charge the ray before we go to
the front lines to defend the base as there is no way to
charge once we are at the front lines.
- Outputs:
  - LEDs: These are the proximity sensors. We have three, one for
each lane, which turn on as soon as an enemy enters the
sensor’s range (which coincidentally coincides with the
firing range of our turrets).
  - Servo Motor: This is a timer that shows how much time is left before the
bombers come to kill of any enemies still alive from the
current wave before they have to return and reload. Because
this have no way of contacting us, they do this even when
the enemies for the current wave are killed and thus the
timer resets after every wave.
