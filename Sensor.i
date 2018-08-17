%module sensorutils
%{
  #include "Sensor.h"
  #include "sensorcore.h"
%}

%include <std_string.i>
%include Sensor.h
%include sensorcore.h
