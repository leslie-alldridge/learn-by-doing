# Find occurances of Sky strict
from collections import Counter
import re

text = 'Sky is Blue ,Sky is Hight'
counter = Counter(re.split(r'[\s,]', text))
print(counter['Sky'])
