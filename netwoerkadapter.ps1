
clear
#Win32_NetworkAdapterConfiguration is used to obtain network configuration settings and value is stored in variable $NA   
$NA = Get-WMIObject -class Win32_NetworkAdapterConfiguration 
    
# where IPenabled property is set to True that value is added to $netenabled 
$netenabled = $NA | where {$_.IPenabled} 
    
#for every enabled card DHCP lease is released 
foreach ($NetCard in $netenabled) 
   	 {  
	  "Releasing lease on: {0}" -f $netcard.caption  
    
      #It disables the Network card
      $netcard.ReleaseDHCPLease()  
     }  
    
# Result message
    
write-host "Your Network Adapter has been Successfully Disabled"
	
# End of Script
