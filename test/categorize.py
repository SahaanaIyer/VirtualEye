def determine_baseline_angle(raw_baseline_angle):
	comment = ""
	if(raw_baseline_angle >= 0.2):           # falling
		baseline_angle = 0
		comment = "DESCENDING"
	elif(raw_baseline_angle <= -0.3):        # rising
		baseline_angle = 1
		comment = "ASCENDING"
	else:                        	         # straight
		baseline_angle = 2
		comment = "STRAIGHT"
	return baseline_angle, comment

def determine_top_margin(raw_top_margin):
	comment = ""
	if(raw_top_margin >= 1.7):               # medium and bigger
		top_margin = 0
		comment = "MEDIUM OR BIGGER"
	else:                                    # narrow
		top_margin = 1
		comment = "NARROW"
	return top_margin, comment

def determine_letter_size(raw_letter_size):
	comment = ""
	if(raw_letter_size >= 18.0):             # big
		letter_size = 0
		comment = "BIG"
	elif(raw_letter_size < 13.0):            # small
		letter_size = 1
		comment = "SMALL"
	else:                                    # medium
		letter_size = 2
		comment = "MEDIUM"
	return letter_size, comment

def determine_line_spacing(raw_line_spacing):
	comment = ""
	if(raw_line_spacing >= 3.5):             # big
		line_spacing = 0
		comment = "BIG"
	elif(raw_line_spacing < 2.0):            # small
		line_spacing = 1
		comment = "SMALL"
	else:                                    # medium
		line_spacing = 2
		comment = "MEDIUM"
	return line_spacing, comment

def determine_word_spacing(raw_word_spacing):
	comment = ""
	if(raw_word_spacing > 2.0):              # big
		word_spacing = 0
		comment = "BIG"
	elif(raw_word_spacing < 1.2):            # small
		word_spacing = 1
		comment = "SMALL"
	else:                                    # medium
		word_spacing = 2
		comment = "MEDIUM"
	return word_spacing, comment

def determine_pen_pressure(raw_pen_pressure):
	comment = ""
	if(raw_pen_pressure > 180.0):            # heavy
		pen_pressure = 0
		comment = "HEAVY"
	elif(raw_pen_pressure < 151.0):          # light
		pen_pressure = 1
		comment = "LIGHT"
	else:                                    # medium
		pen_pressure = 2
		comment = "MEDIUM"
	return pen_pressure, comment

def determine_slant_angle(raw_slant_angle):
	comment = ""
	if(raw_slant_angle == -45.0 or raw_slant_angle == -30.0):          # extremely reclined
		slant_angle = 0
		comment = "EXTREMELY RECLINED"
	elif(raw_slant_angle == -15.0 or raw_slant_angle == -5.0 ):        # a little reclined or moderately reclined
		slant_angle = 1
		comment = "A LITTLE OR MODERATELY RECLINED"
	elif(raw_slant_angle == 5.0 or raw_slant_angle == 15.0 ):          # a little inclined
		slant_angle = 2
		comment = "A LITTLE INCLINED"
	elif(raw_slant_angle == 30.0 ):                                    # moderately inclined
		slant_angle = 3
		comment = "MODERATELY INCLINED"
	elif(raw_slant_angle == 45.0 ):                                    # extremely inclined
		slant_angle = 4
		comment = "EXTREMELY INCLINED"
	elif(raw_slant_angle == 0.0 ):                                     # straight
		slant_angle = 5
		comment = "STRAIGHT"
	else:
		slant_angle = 6
		comment = "IRREGULAR"
	return slant_angle, comment
