use project2;
select * from dataset2;

#cleaning dataset1
set sql_safe_updates=0;
update dataset1
      set NumberofFamiliesRedeemedFoodBenefits=replace(NumberofFamiliesRedeemedFoodBenefits,'$',' ');
update dataset1
      set NumberofFamiliesRedeemedFoodBenefits=replace(NumberofFamiliesRedeemedFoodBenefits,',',' ');
update dataset1
      set NumberofFoodInstrumentsRedeemed=replace(NumberofFoodInstrumentsRedeemed,',',' ');
update dataset1
      set NumberofWICCardTransactionsProcessed=replace(NumberofWICCardTransactionsProcessed,',',' ');
update dataset1
      set NumberofFamiliesRedeemedFoodBenefits=replace(NumberofFamiliesRedeemedFoodBenefits,' ','');
update dataset1
      set NumberofFoodInstrumentsRedeemed=replace(NumberofFoodInstrumentsRedeemed,' ','');
update dataset1
      set NumberofWICCardTransactionsProcessed=replace(NumberofWICCardTransactionsProcessed,' ','');
      
## county wise food instrument redeemed #
select VendorCounty,sum(NumberofFoodInstrumentsRedeemed) from dataset1 group by VendorCounty order by sum(NumberofFoodInstrumentsRedeemed) asc;


# Average cost trend with respect to year

select VendorCounty,ObligationYearandMonth,sum(AverageCostperFamily) from dataset1 group by VendorCounty order by sum(AverageCostperFamily);

# clean datset2
select * from dataset2;
update dataset2
      set NumberofParticipantsRedeemed=replace(NumberofParticipantsRedeemed,',','');
update dataset2
      set TotalCostVouchers=replace(TotalCostVouchers,',','');
update dataset2
      set TotalCostVouchers=replace(TotalCostVouchers,'$','');
update dataset2
      set VendorLocation=replace(VendorLocation,' ','');
      
      
#Percentage of participants redeemed as category
select ParticipantCategory,(sum(NumberofParticipantsRedeemed)*100)/(select sum(NumberofParticipantsRedeemed) from dataset2) 
from dataset2 
group by ParticipantCategory
order by sum(NumberofParticipantsRedeemed) asc;

select * from dataset1;
select * from dataset2;

# Total cost vouchers vs number of families redeemed
select dataset2.VendorLocation,
sum(cast(dataset1.NumberofFamiliesRedeemedFoodBenefits as float)) as NumberofFamiliesRedeemedFoodBenefits,
sum(cast(dataset2.TotalCostVouchers as float)) as TotalCostVouchers
from dataset2
join dataset1
on dataset2.VendorLocation=dataset1.VendorCounty
group by VendorLocation
order by NumberofFamiliesRedeemedFoodBenefits desc;