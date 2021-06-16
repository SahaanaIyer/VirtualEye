import os
import itertools
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import extract
import categorize

X_baseline_angle = []
X_top_margin = []
X_letter_size = []
X_line_spacing = []
X_word_spacing = []
X_pen_pressure = []
X_slant_angle = []
y_t1 = []
y_t2 = []
y_t3 = []
y_t4 = []
y_t5 = []
y_t6 = []
y_t7 = []
y_t8 = []
page_ids = []
strong_traits = []
weak_traits = []

def strong_weak(category, val, st, wt) : 
	if (val == 1.0) :
		st.append(category)
	else :
		wt.append(category)
	return st, wt

def findPersonalityTraits(file_name) :
	strong_traits = []
	weak_traits = []
	if os.path.isfile("label_list"):
		with open("label_list", "r") as labels:
			for line in labels:
				content = line.split()
				
				baseline_angle = float(content[0])
				X_baseline_angle.append(baseline_angle)
				
				top_margin = float(content[1])
				X_top_margin.append(top_margin)
				
				letter_size = float(content[2])
				X_letter_size.append(letter_size)
				
				line_spacing = float(content[3])
				X_line_spacing.append(line_spacing)
				
				word_spacing = float(content[4])
				X_word_spacing.append(word_spacing)
				
				pen_pressure = float(content[5])
				X_pen_pressure.append(pen_pressure)
				
				slant_angle = float(content[6])
				X_slant_angle.append(slant_angle)
				
				trait_1 = float(content[7])
				y_t1.append(trait_1)
				
				trait_2 = float(content[8])
				y_t2.append(trait_2)
				
				trait_3 = float(content[9])
				y_t3.append(trait_3)
				
				trait_4 = float(content[10])
				y_t4.append(trait_4)

				trait_5 = float(content[11])
				y_t5.append(trait_5)

				trait_6 = float(content[12])
				y_t6.append(trait_6)

				trait_7 = float(content[13])
				y_t7.append(trait_7)
				
				trait_8 = float(content[14])
				y_t8.append(trait_8)
				
				page_id = content[15]
				page_ids.append(page_id)
		
		# emotional stability
		X_t1 = []
		for a, b in zip(X_baseline_angle, X_slant_angle):
			X_t1.append([a, b])
		
		# mental energy or will power
		X_t2 = []
		for a, b in zip(X_letter_size, X_pen_pressure):
			X_t2.append([a, b])
		
		# modesty
		X_t3 = []
		for a, b in zip(X_letter_size, X_top_margin):
			X_t3.append([a, b])
			
		# personal harmony and flexibility
		X_t4 = []
		for a, b in zip(X_line_spacing, X_word_spacing):
			X_t4.append([a, b])
			
		# lack of discipline
		X_t5 = []
		for a, b in zip(X_slant_angle, X_top_margin):
			X_t5.append([a, b])
			
		# poor concentration
		X_t6 = []
		for a, b in zip(X_letter_size, X_line_spacing):
			X_t6.append([a, b])
			
		# non communicativeness
		X_t7 = []
		for a, b in zip(X_letter_size, X_word_spacing):
			X_t7.append([a, b])
		
		# social isolation
		X_t8 = []
		for a, b in zip(X_line_spacing, X_word_spacing):
			X_t8.append([a, b])
		
		X_train, X_test, y_train, y_test = train_test_split(X_t1, y_t1, test_size = .30, random_state=8)
		clf1 = SVC(kernel='rbf')
		clf1.fit(X_train, y_train)
		a = accuracy_score(clf1.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t2, y_t2, test_size = .30, random_state=16)
		clf2 = SVC(kernel='rbf')
		clf2.fit(X_train, y_train)
		b = accuracy_score(clf2.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t3, y_t3, test_size = .30, random_state=32)
		clf3 = SVC(kernel='rbf')
		clf3.fit(X_train, y_train)
		c = accuracy_score(clf3.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t4, y_t4, test_size = .30, random_state=64)
		clf4 = SVC(kernel='rbf')
		clf4.fit(X_train, y_train)
		d = accuracy_score(clf4.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t5, y_t5, test_size = .30, random_state=42)
		clf5 = SVC(kernel='rbf')
		clf5.fit(X_train, y_train)
		e = accuracy_score(clf5.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t6, y_t6, test_size = .30, random_state=52)
		clf6 = SVC(kernel='rbf')
		clf6.fit(X_train, y_train)
		f = accuracy_score(clf6.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t7, y_t7, test_size = .30, random_state=21)
		clf7 = SVC(kernel='rbf')
		clf7.fit(X_train, y_train)
		g = accuracy_score(clf7.predict(X_test), y_test)
		
		X_train, X_test, y_train, y_test = train_test_split(X_t8, y_t8, test_size = .30, random_state=73)
		clf8 = SVC(kernel='rbf')
		clf8.fit(X_train, y_train)
		h = accuracy_score(clf8.predict(X_test), y_test)	
		
		raw_features = extract.start(file_name)

		raw_baseline_angle = raw_features[0]
		baseline_angle, comment = categorize.determine_baseline_angle(raw_baseline_angle)
		print ("Baseline Angle: "+comment)
			
		raw_top_margin = raw_features[1]
		top_margin, comment = categorize.determine_top_margin(raw_top_margin)
		print ("Top Margin: "+comment)
			
		raw_letter_size = raw_features[2]
		letter_size, comment = categorize.determine_letter_size(raw_letter_size)
		print ("Letter Size: "+comment)
		
		raw_line_spacing = raw_features[3]
		line_spacing, comment = categorize.determine_line_spacing(raw_line_spacing)
		print ("Line Spacing: "+comment)
				
		raw_word_spacing = raw_features[4]
		word_spacing, comment = categorize.determine_word_spacing(raw_word_spacing)
		print ("Word Spacing: "+comment)
				
		raw_pen_pressure = raw_features[5]
		pen_pressure, comment = categorize.determine_pen_pressure(raw_pen_pressure)
		print ("Pen Pressure: "+comment)
			
		raw_slant_angle = raw_features[6]
		slant_angle, comment = categorize.determine_slant_angle(raw_slant_angle)
		print ("Slant: "+comment)

		print("\n")
		
		val = clf1.predict([[baseline_angle, slant_angle]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Is Emotionally Stable", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("Is Not Emotionally Stable", val, strong_traits, weak_traits)
		print ("Emotional Stability: ", clf1.predict([[baseline_angle, slant_angle]]))
		
		val = clf2.predict([[letter_size, pen_pressure]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Has Strong Will Power and Mental Energy", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("Has Low Will Power", val, strong_traits, weak_traits)
		print ("Mental Energy or Will Power: ", clf2.predict([[letter_size, pen_pressure]]))
		
		val = clf3.predict([[letter_size, top_margin]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Is Modest", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("Is Boastful", val, strong_traits, weak_traits)
		print ("Modesty: ", clf3.predict([[letter_size, top_margin]]))
		
		val = clf4.predict([[line_spacing, word_spacing]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Is Flexible and Maintains Personal Harmony", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("Is Inconsistent and Lazy", val, strong_traits, weak_traits)
		print ("Personal Harmony and Flexibility: ", clf4.predict([[line_spacing, word_spacing]]))
		
		val = clf5.predict([[slant_angle, top_margin]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Does not believe in leading a disciplined life", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("Is disciplined in all aspects of life", val, strong_traits, weak_traits)
		print ("Lack of Discipline: ", clf5.predict([[slant_angle, top_margin]]))
		
		val = clf6.predict([[letter_size, line_spacing]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("Is unable to concentrate on work", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("has good concentration power", val, strong_traits, weak_traits)
		print ("Poor Concentration: ", clf6.predict([[letter_size, line_spacing]]))
		
		val = clf7.predict([[letter_size, word_spacing]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("find it difficult to express and communicate", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("communicates effectively", val, strong_traits, weak_traits)
		print ("Uncommunicativeness: ", clf7.predict([[letter_size, word_spacing]]))
		
		val = clf8.predict([[line_spacing, word_spacing]])[0]
		if (val == 1.0) : strong_traits, weak_traits = strong_weak("prefers keeping him or herself socially isolated", val, strong_traits, weak_traits)
		if (val == 0.0) : strong_traits, weak_traits = strong_weak("enjoys socializing with people", val, strong_traits, weak_traits)
		print ("Social Isolation: ", clf8.predict([[line_spacing, word_spacing]]))
		
		text = "The person "
		for i in strong_traits :
			text += i + ", "
		text += "Additionally, the person "
		for i in weak_traits :
			text += i + ", "
	return text