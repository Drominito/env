var device = (slurp | one)

switch $device {
  case HP {
    # nothing
  }

  case (re '^Eaton') {
    # Industry PC (Eaton Automation GmbH)


    wlr-randr --output eDP-1 --off

	# For E-Ink
    riverctl spawn {
      wlr-randr \
        --output HDMI-A-1 \
        --mode 3200x1800@25.000000 \
        --scale 2
    }
  }

  default {
    echo "Unknown device: "$device >&2
  }
}

# old vertical monitor (global binding)
riverctl map normal Alt V spawn {
  wlr-randr \
    --output HDMI-A-1 \
    --transform normal \
    --mode 3440x1440@99.982002 \
    --scale 2
}

