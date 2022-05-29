$modelname "mdl\red_plus\red_plus"
$scale 0.04
$staticprop
$cdmaterials "models\mdl\red_plus"

$body "Body" "red_plus.SMD"

$sequence "Idle" "red_plus.SMD" fps 30 ACT_IDLE 1

$surfaceprop "wood"

$collisionmodel "red_plus.SMD" {
	$concave
	$mass 1
}
