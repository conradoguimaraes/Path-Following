%%
dx0y0 = costArray(1)
timeZero = timeZero

totalCost = sum(costArray)
mediaTotal = mean(costArray)

totalCost_t0 = sum(costArray(firstZero:end))
mediaTotal_t0 = mean(costArray(firstZero:end))


controlEffort = sum(controlEffortArray.^2)
controlEffort_t0 = sum(controlEffortArray(firstZero:end).^2)


