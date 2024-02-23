
# coding: utf-8

# # Project_Unit of Measurement Convertor:
# 
# 
#     

# ## Table of content:
#     1) convert from inches to feet/yard
#     2) convert from feet to inches/yard
#     3) convert from yard to inches/feet

# In[60]:


# Code for Inputing a number to see the coversion of measurements

convert_from = input('Enter starting unit of measurement[inches, feet, yards] :')

convert_to = input('Enter unit of measurement to convert to[inches, feet, yards]:')


# ---- Part 1 --------------
# code to convert inches to feet/yard

if convert_from.lower() in ['inches','inch','in']:
    number_to_inches = int(input("Enter the measurement in inches: "))
    
    if convert_to.lower() in ['feet','foot','ft']:
        print("Result: " + str(number_to_inches) + " Inches =  " +  str(round(number_to_inches/ 12,2)) + " Feet")
    elif convert_to.lower() in ['yards','yard','yd','yds']:
        print("Result: " + str(number_to_inches) + " Inches =  " +  str(round(number_to_inches / 36,2)) + " Yard")
    else:
        print('your input was incorrect[inches, feet, yards]')
    

    
# ---- Part 2 --------------
# code to convert feet to inches/yard

elif convert_from.lower() in ['feet','foot','ft']:
    number_to_feet = int(input('Enter the measurement in feet: '))
    
    if convert_to.lower() in ['inches','inch','in']:
        print("Result: " + str(number_to_feet) + " Feet =  " +  str(round(number_to_feet * 12)) + " Inches")
    elif convert_to.lower() in ['yards','yard','yd','yds']:
        print("Result: " + str(number_to_feet) + " Feet =  " +  str(round(number_to_feet / 3,2)) + " Yard")
    else:
        print('Please Enter either Feet, Inches or Yards')
        


# ---- Part 3 --------------     
# code to convert yard to inches/feet 

elif convert_from.lower() in ['yards','yard','yd','yds']:
    number_to_yards = int(input('Enter the measurement in yard: '))
    
    if convert_to.lower() in ['inches','inch','in']:
        print("Result: " + str(number_to_yards) + " Yard =  " +  str(round(number_to_yards * 36)) + " Inches")
    elif convert_to.lower() in ['feet','foot','ft']:
        print("Result: " + str(number_to_yards) + " Yard =  " +  str(round(number_to_yards * 3)) + " Feet")
        
    else:
        print('Please Enter either Feet, Inches or Yards')
        
        
else:
    print('Please Enter either Feet, Inches or Yards')

    
    

