# constants.gd
extends Resource

# Pollux Translation
const MAX_SPEED : float = 1.0
const ACCELERATION : float = 0.2
const DECELERATION : float = 0.2

# Pollux Rotation
const MAX_ROT_SPEED : float = 45.0   # degrees per second
const ROT_ACCELERATION : float = 15.0
const ROT_DECELERATION : float = 15.0

# Propeller spin multipliers
const MAIN_PROPELLER_SPIN : float = 600.0   # rpm equivalent
const SIDE_PROPELLER_SPIN : float = 400.0

# --- AKA Deployment ---
const AKA_LEFT_INITIAL : float = 900.0
const AKA_LEFT_FINAL   : float = 0.0
const AKA_RIGHT_INITIAL : float = 900.0
const AKA_RIGHT_FINAL   : float = 0.0

# --- Camera Bracket Deployment ---
const SENSORA_INITIAL : float = 0.0
const SENSORA_FINAL   : float = 15.0
const SENSORB_INITIAL : float = 0.0
const SENSORB_FINAL   : float = -20.0
const SENSORC_INITIAL : float = 0.0
const SENSORC_FINAL   : float = 10.0
const SENSOR_BODY_INITIAL : float = 0.0
const SENSOR_BODY_FINAL   : float = -30.0

# --- Handlebar Deployment ---
const HANDLE_LEFT_INITIAL : float = 0.0
const HANDLE_LEFT_FINAL   : float = 90.0
const HANDLE_RIGHT_INITIAL : float = 0.0
const HANDLE_RIGHT_FINAL   : float = -90.0
