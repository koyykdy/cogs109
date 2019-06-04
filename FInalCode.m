% Import "PRSA_data_2010.1.1-2014.12.31.csv" through GUI as cell array
% Rename cell array "PRSAdata2010" as "PRSAdata"
%index = strcmp(PRSAData(:,6),'NaN'); % returns indices of rows with 'NA' in the PM2.5 column (6)
%PRSAData(index,:) = []; % removes those rows



y = pm25;
col_10 = strrep(cbwd(:,1),"cv","SW"); % replaces 'cv' in cbwd column (10) with 'SW'
adj_col = zeros(41757,4);
for i = 1:41757
    if(col_10(i,1) == "NW")
        adj_col(i,1) = 1;
    end
    if(col_10(i,1) == "NE")
        adj_col(i,2) = 1;
    end
    if(col_10(i,1) == "SE")
        adj_col(i,3) = 1;
    end
    if(col_10(i,1) == "SW")
        adj_col(i,4) = 1;
    end
    
end

finalData = [ year month day hour DEWP TEMP PRES adj_col Iws Is Ir];

finalData_Train = finalData(1:30000,:);
y_Train = y(1:30000,:);
finalData_Test = finalData(30001:40000,:);
y_Test = y(30001:40000,:);


A_Train = [ones(length(finalData_Train),1), finalData_Train];
A_Test = [ones(length(finalData_Test),1), finalData_Test];
% y = w1 + w2*year
A_Train1 = [ones(length(finalData_Train),1), finalData_Train(:,1)];
A_Test1 = [ones(length(finalData_Test),1), finalData_Test(:,1)];
% y = w1 + w2*month
A_Train2 = [ones(length(finalData_Train),1), finalData_Train(:,2)];
A_Test2 = [ones(length(finalData_Test),1), finalData_Test(:,2)];
% y = w1 + w2*day
A_Train3 = [ones(length(finalData_Train),1), finalData_Train(:,3)];
A_Test3 = [ones(length(finalData_Test),1), finalData_Test(:,3)];
% y = w1 + w2*hour
A_Train4 = [ones(length(finalData_Train),1), finalData_Train(:,4)];
A_Test4 = [ones(length(finalData_Test),1), finalData_Test(:,4)];
% y = w1 + w2*DEWP
A_Train5 = [ones(length(finalData_Train),1), finalData_Train(:,5)];
A_Test5 = [ones(length(finalData_Test),1), finalData_Test(:,5)];
% y = w1 + TEMP
A_Train6 = [ones(length(finalData_Train),1), finalData_Train(:,6)];
A_Test6 = [ones(length(finalData_Test),1), finalData_Test(:,6)];
% y = w1 + w2*PRES
A_Train7 = [ones(length(finalData_Train),1), finalData_Train(:,7)];
A_Test7 = [ones(length(finalData_Test),1), finalData_Test(:,7)];
% y = w1 + w2*NW
A_Train8 = [ones(length(finalData_Train),1), finalData_Train(:,8)];
A_Test8 = [ones(length(finalData_Test),1), finalData_Test(:,8)];
% y = w1 + w2*NE
A_Train9 = [ones(length(finalData_Train),1), finalData_Train(:,9)];
A_Test9 = [ones(length(finalData_Test),1), finalData_Test(:,9)];
% y = w1 + w2*SE
A_Train10 = [ones(length(finalData_Train),1), finalData_Train(:,10)];
A_Test10 = [ones(length(finalData_Test),1), finalData_Test(:,10)];
% y = w1 + w2*SW
A_Train11 = [ones(length(finalData_Train),1), finalData_Train(:,11)];
A_Test11 = [ones(length(finalData_Test),1), finalData_Test(:,11)];
% y = w1 + w2*lws (cumulated wind speed
A_Train12 = [ones(length(finalData_Train),1), finalData_Train(:,12)];
A_Test12 = [ones(length(finalData_Test),1), finalData_Test(:,12)];
% y = w1 + w2*ls (snow
A_Train13 = [ones(length(finalData_Train),1), finalData_Train(:,13)];
A_Test13 = [ones(length(finalData_Test),1), finalData_Test(:,13)];
% y = w1 + w2*lr (rain
A_Train14 = [ones(length(finalData_Train),1), finalData_Train(:,14)];
A_Test14 = [ones(length(finalData_Test),1), finalData_Test(:,14)];

A_Train1_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,1),finalData_Train(:,1).^2];
A_Test1_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,1),finalData_Test(:,1).^2];
A_Train2_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,2),finalData_Train(:,2).^2];
A_Test2_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,2),finalData_Test(:,2).^2];
A_Train3_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,3),finalData_Train(:,3).^2];
A_Test3_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,3),finalData_Test(:,3).^2];
A_Train4_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,4),finalData_Train(:,4).^2];
A_Test4_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,4),finalData_Test(:,4).^2];
A_Train5_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,5),finalData_Train(:,5).^2];
A_Test5_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,5),finalData_Test(:,5).^2];
A_Train6_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,6),finalData_Train(:,6).^2];
A_Test6_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,6),finalData_Test(:,6).^2];
A_Train7_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,7),finalData_Train(:,7).^2];
A_Test7_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,7),finalData_Test(:,7).^2];
%A_Train8_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,8),finalData_Train(:,8).^2];
%A_Test8_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,8),finalData_Test(:,8).^2];
%A_Train9_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,9),finalData_Train(:,9).^2];
%A_Test9_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,9),finalData_Test(:,9).^2];
%A_Train10_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,10),finalData_Train(:,10).^2];
%A_Test10_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,10),finalData_Test(:,10).^2];
%A_Train11_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,11),finalData_Train(:,11).^2];
%A_Test11_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,11),finalData_Test(:,11).^2];
A_Train12_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,12),finalData_Train(:,12).^2];
A_Test12_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,12),finalData_Test(:,12).^2];
A_Train13_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,13),finalData_Train(:,13).^2];
A_Test13_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,13),finalData_Test(:,13).^2];
A_Train14_pow2 = [ones(length(finalData_Train),1), finalData_Train(:,14),finalData_Train(:,14).^2];
A_Test14_pow2 = [ones(length(finalData_Test),1), finalData_Test(:,14),finalData_Test(:,14).^2];

A_Train_Wind = [ones(length(finalData_Train),1), finalData_Train(:,12),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11)];
A_Test_Wind =  [ones(length(finalData_Test),1), finalData_Test(:,12),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11)];
% DEW TEMP PRES
A_Train_Weather = [ones(length(finalData_Train),1), finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7)];
A_Test_Weather = [ones(length(finalData_Test),1), finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7)];
A_Train_WindTemp = [ones(length(finalData_Train),1), finalData_Train(:,6),finalData_Train(:,12)];
A_Test_WindTemp = [ones(length(finalData_Test),1), finalData_Test(:,6),finalData_Test(:,12)];
A_Train_WindTempPow2 = [ones(length(finalData_Train),1), finalData_Train(:,6),finalData_Train(:,6).^2,finalData_Train(:,12),finalData_Train(:,12).^2];
A_Test_WindTempPow2 = [ones(length(finalData_Test),1), finalData_Test(:,6),finalData_Test(:,6).^2,finalData_Test(:,12),finalData_Test(:,12).^2];

A_Train_WindVec = [ones(length(finalData_Train),1), finalData_Train(:,8).*finalData_Train(:,12),finalData_Train(:,9).*finalData_Train(:,12),finalData_Train(:,10).*finalData_Train(:,12),finalData_Train(:,11).*finalData_Train(:,12)];
A_Test_WindVec = [ones(length(finalData_Test),1), finalData_Test(:,8).*finalData_Test(:,12),finalData_Test(:,9).*finalData_Test(:,12),finalData_Test(:,10).*finalData_Test(:,12),finalData_Test(:,11).*finalData_Test(:,12)];




A_Train_AllPow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,1).^2,finalData_Train(:,2),finalData_Train(:,2).^2,finalData_Train(:,3),finalData_Train(:,3).^2,finalData_Train(:,4),finalData_Train(:,4).^2,finalData_Train(:,5),finalData_Train(:,5).^2,finalData_Train(:,6),finalData_Train(:,6).^2,finalData_Train(:,7),finalData_Train(:,7).^2,finalData_Train(:,8),finalData_Train(:,9).^2,finalData_Train(:,10),finalData_Train(:,10).^2,finalData_Train(:,11),finalData_Train(:,11).^2,finalData_Train(:,12),finalData_Train(:,12).^2,finalData_Train(:,13),finalData_Train(:,13).^2,finalData_Train(:,14),finalData_Train(:,14).^2];
A_Test_AllPow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,1).^2,finalData_Test(:,2),finalData_Test(:,2).^2,finalData_Test(:,3),finalData_Test(:,3).^2,finalData_Test(:,4),finalData_Test(:,4).^2,finalData_Test(:,5),finalData_Test(:,5).^2,finalData_Test(:,6),finalData_Test(:,6).^2,finalData_Test(:,7),finalData_Test(:,7).^2,finalData_Test(:,8),finalData_Test(:,9).^2,finalData_Test(:,10),finalData_Test(:,10).^2,finalData_Test(:,11),finalData_Test(:,11).^2,finalData_Test(:,12),finalData_Test(:,12).^2,finalData_Test(:,13),finalData_Test(:,13).^2,finalData_Test(:,14),finalData_Test(:,14).^2];
A_Train_All_1Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,1).^2,finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_2Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,2).^2,finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_3Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,3).^2,finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_4Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,4).^2,finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_5Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,5).^2,finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_6Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,6).^2,finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_7Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,7).^2,finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
%A_Train_All_8Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,8).^2,finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
%A_Train_All_9Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,9).^2,finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
%A_Train_All_10Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,10).^2,finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
%A_Train_All_11Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,11).^2,finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_12Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,12).^2,finalData_Train(:,13),finalData_Train(:,14)];
A_Train_All_13Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,13).^2,finalData_Train(:,14)];
A_Train_All_14Pow2 = [ones(length(finalData_Train),1),finalData_Train(:,1),finalData_Train(:,2),finalData_Train(:,3),finalData_Train(:,4),finalData_Train(:,5),finalData_Train(:,6),finalData_Train(:,7),finalData_Train(:,8),finalData_Train(:,9),finalData_Train(:,10),finalData_Train(:,11),finalData_Train(:,12),finalData_Train(:,13),finalData_Train(:,14),finalData_Train(:,14).^2];
A_Test_All_1Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,1).^2,finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_2Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,2).^2,finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_3Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,3).^2,finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_4Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,4).^2,finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_5Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,5).^2,finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_6Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,6).^2,finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_7Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,7).^2,finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
%A_Test_All_8Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,8).^2,finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
%A_Test_All_9Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,9).^2,finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
%A_Test_All_10Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,10).^2,finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
%A_Test_All_11Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,11).^2,finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_12Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,12).^2,finalData_Test(:,13),finalData_Test(:,14)];
A_Test_All_13Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,13).^2,finalData_Test(:,14)];
A_Test_All_14Pow2 = [ones(length(finalData_Test),1),finalData_Test(:,1),finalData_Test(:,2),finalData_Test(:,3),finalData_Test(:,4),finalData_Test(:,5),finalData_Test(:,6),finalData_Test(:,7),finalData_Test(:,8),finalData_Test(:,9),finalData_Test(:,10),finalData_Test(:,11),finalData_Test(:,12),finalData_Test(:,13),finalData_Test(:,14),finalData_Test(:,14).^2];








W = A_Train\y_Train;
W1 = A_Train1\y_Train;
W2 = A_Train2\y_Train;
W3 = A_Train3\y_Train;
W4 = A_Train4\y_Train;
W5 = A_Train5\y_Train;
W6 = A_Train6\y_Train;
W7 = A_Train7\y_Train;
W8 = A_Train8\y_Train;
W9 = A_Train9\y_Train;
W10 = A_Train10\y_Train;
W11 = A_Train11\y_Train;
W12 = A_Train12\y_Train;
W13 = A_Train13\y_Train;
W14 = A_Train14\y_Train;

W1_pow2 = A_Train1_pow2\y_Train;
W2_pow2 = A_Train2_pow2\y_Train;
W3_pow2 = A_Train3_pow2\y_Train;
W4_pow2 = A_Train4_pow2\y_Train;
W5_pow2 = A_Train5_pow2\y_Train;
W6_pow2 = A_Train6_pow2\y_Train;
W7_pow2 = A_Train7_pow2\y_Train;
%W8_pow2 = A_Train8_pow2\y_Train;
%W9_pow2 = A_Train9_pow2\y_Train;
%W10_pow2 = A_Train10_pow2\y_Trai;n
%W11_pow2 = A_Train11_pow2\y_Train;
W12_pow2 = A_Train12_pow2\y_Train;
W13_pow2 = A_Train13_pow2\y_Train;
W14_pow2 = A_Train14_pow2\y_Train;

W_Wind = A_Train_Wind\y_Train;
W_Weather = A_Train_Weather\y_Train;
W_WindTemp = A_Train_WindTemp\y_Train;
W_WindTempPow2 = A_Train_WindTempPow2\y_Train;

W_WindVec = A_Train_WindVec\y_Train;

W_AllPow2 = A_Train_AllPow2\y_Train;
W_All_1Pow2 = A_Train_All_1Pow2\y_Train;
W_All_2Pow2 = A_Train_All_1Pow2\y_Train;
W_All_3Pow2 = A_Train_All_1Pow2\y_Train;
W_All_4Pow2 = A_Train_All_1Pow2\y_Train;
W_All_5Pow2 = A_Train_All_1Pow2\y_Train;
W_All_6Pow2 = A_Train_All_1Pow2\y_Train;
W_All_7Pow2 = A_Train_All_1Pow2\y_Train;
%W_All_8Pow2 = A_Train_All_1Pow2\y_Train;
%W_All_9Pow2 = A_Train_All_1Pow2\y_Train
%W_All_10Pow2 = A_Train_All_1Pow2\y_Train
%W_All_11Pow2 = A_Train_All_1Pow2\y_Train
W_All_12Pow2 = A_Train_All_1Pow2\y_Train;
W_All_13Pow2 = A_Train_All_1Pow2\y_Train;
W_All_14Pow2 = A_Train_All_1Pow2\y_Train;






SSE = zeros(41,2);
%Calculating the SSE for the Training set
for i = 1:30000
  
    SSE(1,1) = SSE(1,1) + ( y_Train(i) -(A_Train(i,:)*W)).^2;
    SSE(2,1) = SSE(2,1) + ( y_Train(i) -(A_Train1(i,:)*W1)).^2;
    SSE(3,1) = SSE(3,1) + ( y_Train(i) -(A_Train2(i,:)*W2)).^2;
    SSE(4,1) = SSE(4,1) + ( y_Train(i) -(A_Train3(i,:)*W3)).^2;
    SSE(5,1) = SSE(5,1) + ( y_Train(i) -(A_Train4(i,:)*W4)).^2;
    SSE(6,1) = SSE(6,1) + ( y_Train(i) -(A_Train5(i,:)*W5)).^2;
    SSE(7,1) = SSE(7,1) + ( y_Train(i) -(A_Train6(i,:)*W6)).^2;
    SSE(8,1) = SSE(8,1) + ( y_Train(i) -(A_Train7(i,:)*W7)).^2;
    SSE(9,1) = SSE(9,1) + ( y_Train(i) -(A_Train8(i,:)*W8)).^2;
    SSE(10,1) = SSE(10,1) + ( y_Train(i) -(A_Train9(i,:)*W9)).^2;
    SSE(11,1) = SSE(11,1) + ( y_Train(i) -(A_Train10(i,:)*W10)).^2;
    SSE(12,1) = SSE(12,1) + ( y_Train(i) -(A_Train11(i,:)*W11)).^2;
    SSE(13,1) = SSE(13,1) + ( y_Train(i) -(A_Train12(i,:)*W12)).^2;
    SSE(14,1) = SSE(14,1) + ( y_Train(i) -(A_Train13(i,:)*W13)).^2;
    SSE(15,1) = SSE(15,1) + ( y_Train(i) -(A_Train14(i,:)*W14)).^2;
    SSE(16,1) = SSE(16,1) + ( y_Train(i) - (A_Train1_pow2(i,:)*W1_pow2)).^2;
    SSE(17,1) = SSE(17,1) + ( y_Train(i) - (A_Train2_pow2(i,:)*W2_pow2)).^2;
    SSE(18,1) = SSE(18,1) + ( y_Train(i) - (A_Train3_pow2(i,:)*W3_pow2)).^2;
    SSE(19,1) = SSE(19,1) + ( y_Train(i) - (A_Train4_pow2(i,:)*W4_pow2)).^2;
    SSE(20,1) = SSE(20,1) + ( y_Train(i) - (A_Train5_pow2(i,:)*W5_pow2)).^2;
    SSE(21,1) = SSE(21,1) + ( y_Train(i) - (A_Train6_pow2(i,:)*W6_pow2)).^2;
    SSE(22,1) = SSE(22,1) + ( y_Train(i) - (A_Train7_pow2(i,:)*W7_pow2)).^2;
    SSE(23,1) = SSE(23,1) + ( y_Train(i) - (A_Train12_pow2(i,:)*W12_pow2)).^2;
    SSE(24,1) = SSE(24,1) + ( y_Train(i) - (A_Train13_pow2(i,:)*W13_pow2)).^2;
    SSE(25,1) = SSE(25,1) + ( y_Train(i) - (A_Train14_pow2(i,:)*W14_pow2)).^2;
    SSE(26,1) = SSE(26,1) + ( y_Train(i) - (A_Train_Wind(i,:)*W_Wind)).^2;
    SSE(27,1) = SSE(27,1) + (y_Train(i) - (A_Train_Weather(i,:)*W_Weather)).^2;
    SSE(28,1) = SSE(28,1) + (y_Train(i) - (A_Train_WindTemp(i,:)*W_WindTemp)).^2;
    SSE(29,1) = SSE(29,1) + (y_Train(i) - (A_Train_WindTempPow2(i,:)*W_WindTempPow2)).^2;
    SSE(30,1) = SSE(30,1) + (y_Train(i) - (A_Train_WindVec(i,:)*W_WindVec)).^2;
    SSE(31,1) = SSE(31,1) + (y_Train(i) - (A_Train_AllPow2(i,:)*W_AllPow2)).^2;
    SSE(32,1) = SSE(32,1) + (y_Train(i) - (A_Train_All_1Pow2(i,:)*W_All_1Pow2)).^2;
    SSE(33,1) = SSE(33,1) + (y_Train(i) - (A_Train_All_2Pow2(i,:)*W_All_2Pow2)).^2;
    SSE(34,1) = SSE(34,1) + (y_Train(i) - (A_Train_All_3Pow2(i,:)*W_All_3Pow2)).^2;
    SSE(35,1) = SSE(35,1) + (y_Train(i) - (A_Train_All_4Pow2(i,:)*W_All_4Pow2)).^2;
    SSE(36,1) = SSE(36,1) + (y_Train(i) - (A_Train_All_5Pow2(i,:)*W_All_5Pow2)).^2;
    SSE(37,1) = SSE(37,1) + (y_Train(i) - (A_Train_All_6Pow2(i,:)*W_All_6Pow2)).^2;
    SSE(38,1) = SSE(38,1) + (y_Train(i) - (A_Train_All_7Pow2(i,:)*W_All_7Pow2)).^2;
    SSE(39,1) = SSE(39,1) + (y_Train(i) - (A_Train_All_12Pow2(i,:)*W_All_12Pow2)).^2;
    SSE(40,1) = SSE(40,1) + (y_Train(i) - (A_Train_All_13Pow2(i,:)*W_All_13Pow2)).^2;
    SSE(41,1) = SSE(41,1) + (y_Train(i) - (A_Train_All_14Pow2(i,:)*W_All_14Pow2)).^2;
    
    
end

%Calculating the SSE for the Test set
for i = 1:10000
    
    SSE(1,2) = SSE(1,2) + ( y_Test(i) -(A_Test(i,:)*W)).^2;
    SSE(2,2) = SSE(2,2) + ( y_Test(i) -(A_Test1(i,:)*W1)).^2;
    SSE(3,2) = SSE(3,2) + ( y_Test(i) -(A_Test2(i,:)*W2)).^2;
    SSE(4,2) = SSE(4,2) + ( y_Test(i) -(A_Test3(i,:)*W3)).^2;
    SSE(5,2) = SSE(5,2) + ( y_Test(i) -(A_Test4(i,:)*W4)).^2;
    SSE(6,2) = SSE(6,2) + ( y_Test(i) -(A_Test5(i,:)*W5)).^2;
    SSE(7,2) = SSE(7,2) + ( y_Test(i) -(A_Test6(i,:)*W6)).^2;
    SSE(8,2) = SSE(8,2) + ( y_Test(i) -(A_Test7(i,:)*W7)).^2;
    SSE(9,2) = SSE(9,2) + ( y_Test(i) -(A_Test8(i,:)*W8)).^2;
    SSE(10,2) = SSE(10,2) + ( y_Test(i) -(A_Test9(i,:)*W9)).^2;
    SSE(11,2) = SSE(11,2) + ( y_Test(i) -(A_Test10(i,:)*W10)).^2;
    SSE(12,2) = SSE(12,2) + ( y_Test(i) -(A_Test11(i,:)*W11)).^2;
    SSE(13,2) = SSE(13,2) + ( y_Test(i) -(A_Test12(i,:)*W12)).^2;
    SSE(14,2) = SSE(14,2) + ( y_Test(i) -(A_Test13(i,:)*W13)).^2;
    SSE(15,2) = SSE(15,2) + ( y_Test(i) -(A_Test14(i,:)*W14)).^2;
    SSE(16,2) = SSE(16,2) + ( y_Test(i) - (A_Test1_pow2(i,:)*W1_pow2)).^2;
    SSE(17,2) = SSE(17,2) + ( y_Test(i) - (A_Test2_pow2(i,:)*W2_pow2)).^2;
    SSE(18,2) = SSE(18,2) + ( y_Test(i) - (A_Test3_pow2(i,:)*W3_pow2)).^2;
    SSE(19,2) = SSE(19,2) + ( y_Test(i) - (A_Test4_pow2(i,:)*W4_pow2)).^2;
    SSE(20,2) = SSE(20,2) + ( y_Test(i) - (A_Test5_pow2(i,:)*W5_pow2)).^2;
    SSE(21,2) = SSE(21,2) + ( y_Test(i) - (A_Test6_pow2(i,:)*W6_pow2)).^2;
    SSE(22,2) = SSE(22,2) + ( y_Test(i) - (A_Test7_pow2(i,:)*W7_pow2)).^2;
    SSE(23,2) = SSE(23,2) + ( y_Test(i) - (A_Test12_pow2(i,:)*W12_pow2)).^2;
    SSE(24,2) = SSE(24,2) + ( y_Test(i) - (A_Test13_pow2(i,:)*W13_pow2)).^2;
    SSE(25,2) = SSE(25,2) + ( y_Test(i) - (A_Test14_pow2(i,:)*W14_pow2)).^2;
    SSE(26,2) = SSE(26,2) + ( y_Test(i) - (A_Test_Wind(i,:)*W_Wind)).^2;
    SSE(27,2) = SSE(27,2) + (y_Test(i) - (A_Test_Weather(i,:)*W_Weather)).^2;
    SSE(28,2) = SSE(28,2) + (y_Test(i) - (A_Test_WindTemp(i,:)*W_WindTemp)).^2;
    SSE(29,2) = SSE(29,2) + (y_Test(i) - (A_Test_WindTempPow2(i,:)*W_WindTempPow2)).^2;
    SSE(30,2) = SSE(30,2) + (y_Test(i) - (A_Test_WindVec(i,:)*W_WindVec)).^2;
    SSE(31,2) = SSE(31,2) + (y_Test(i) - (A_Test_AllPow2(i,:)*W_AllPow2)).^2;
    SSE(32,2) = SSE(32,2) + (y_Test(i) - (A_Test_All_1Pow2(i,:)*W_All_1Pow2)).^2;
    SSE(33,2) = SSE(33,2) + (y_Test(i) - (A_Test_All_2Pow2(i,:)*W_All_2Pow2)).^2;
    SSE(34,2) = SSE(34,2) + (y_Test(i) - (A_Test_All_3Pow2(i,:)*W_All_3Pow2)).^2;
    SSE(35,2) = SSE(35,2) + (y_Test(i) - (A_Test_All_4Pow2(i,:)*W_All_4Pow2)).^2;
    SSE(36,2) = SSE(36,2) + (y_Test(i) - (A_Test_All_5Pow2(i,:)*W_All_5Pow2)).^2;
    SSE(37,2) = SSE(37,2) + (y_Test(i) - (A_Test_All_6Pow2(i,:)*W_All_6Pow2)).^2;
    SSE(38,2) = SSE(38,2) + (y_Test(i) - (A_Test_All_7Pow2(i,:)*W_All_7Pow2)).^2;
    SSE(39,2) = SSE(39,2) + (y_Test(i) - (A_Test_All_12Pow2(i,:)*W_All_12Pow2)).^2;
    SSE(40,2) = SSE(40,2) + (y_Test(i) - (A_Test_All_13Pow2(i,:)*W_All_13Pow2)).^2;
    SSE(41,2) = SSE(41,2) + (y_Test(i) - (A_Test_All_14Pow2(i,:)*W_All_14Pow2)).^2;
    
end


close all
figure
subplot(1,2,1)
bar(1:1:15,SSE(1:15,1))
xlabel('Model #')
ylabel('SSE')
title('Training')
subplot(1,2,2)
bar(1:1:15,SSE(1:15,2))
xlabel('Model #')
ylabel('SSE')
title('Testing')

figure
subplot(1,2,1)
bar(16:1:25,SSE(16:25,1))
xlabel('Model #')
ylabel('SSE')
title('Training')
subplot(1,2,2)
bar(16:1:25,SSE(16:25,2))
xlabel('Model #')
ylabel('SSE')
title('Testing')

figure
subplot(1,2,1)
bar(26:1:30,SSE(26:30,1))
xlabel('Model #')
ylabel('SSE')
title('Training')
subplot(1,2,2)
bar(26:1:30,SSE(26:30,2))
xlabel('Model #')
ylabel('SSE')
title('Testing')

figure
subplot(1,2,1)
bar(31:1:37,SSE(31:37,1))
axis('tight')
%axis([31 37 10000 3000000000])
xlabel('Model #')
ylabel('SSE')
title('Training')
subplot(1,2,2)
bar(31:1:41,SSE(31:41,2))
xlabel('Model #')
ylabel('SSE')
title('Testing')









