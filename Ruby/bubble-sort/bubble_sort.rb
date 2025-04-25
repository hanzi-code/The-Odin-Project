def bubble_sort(nums)
  length = nums.length
  swapped = true
  count = 0
  swaps = 0

  while swapped
    while count < (nums.length - 1)
      
      nums[count] = nums[count].to_i
      nums[count+1] = nums[count+1].to_i

      if nums[count] > nums[count+1]
        temp = nums[count]
        nums[count] = nums[count+1]
        nums[count+1] = temp
        swaps += 1
      
      end
      count += 1
    end
    
    if swaps == 0
      swapped = false
    else
      swaps = 0
      count = 0
    end
  
  end
  return nums
end

print "Type the numbers to be sorted (with a space in between): "
nums = gets.chomp.split()

p bubble_sort(nums)