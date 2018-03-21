From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Mar 2018 13:59:37 +0300
Subject: [LTP] Error: in6_02 report "LHOST_IFACES not defined,
	default to eth0"
In-Reply-To: <18f4e8af-4228-fd05-415f-ae88994ff011@cn.fujitsu.com>
References: <18f4e8af-4228-fd05-415f-ae88994ff011@cn.fujitsu.com>
Message-ID: <c1cec9cc-3181-af6b-43e9-3927efd0307b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 03/20/2018 09:07 AM, sunlianwen wrote:
> Hi Alexey
> 
>    I set eth1 as  test interface in test_net.sh. but in6_02 test report
> 
> "in6_02.c:264: LHOST_IFACES not defined, default to eth0" ,this cause
> 
> in6_02 test fail. although I can set  LHOST_IFACES global variable,let this
> 
> case test pass. But if this ,the test_net.sh is meaningless.
> 

No, if you run it via network.sh help script, it will source test_net.sh eventually,
and export this variable as well, otherwise you need to define them manually.

The test actually passed, but ltp-pan reports overall result as TFAIL because the
status not equals zero, but there is no TFAIL flag in the status, just TWARN flag.

Thanks,
Alexey

> the test result is below:
> 
> <<<test_output>>>                                                                                                                             
> in6_02      0  TINFO  :  get interface name from LHOST_IFACES var                                                                             
> in6_02      0  TWARN  :  in6_02.c:264: LHOST_IFACES not defined, default to eth0                                                              
> in6_02      0  TINFO  :  if_nametoindex("lo") 1                                                                                               
> in6_02      0  TINFO  :  if_nametoindex("eth0") 2                                                                                             
> incrementing stop                                                                                                                             
> in6_02      0  TINFO  :  if_nametoindex("hoser75") 0                                                                                          
> in6_02      0  TINFO  :  if_nametoindex("6") 0                                                                                                
> in6_02      1  TPASS  :  if_nametoindex() tests succeed                                                                                       
> in6_02      0  TINFO  :  if_indextoname(0) returns NULL                                                                                       
> in6_02      0  TINFO  :  if_indextoname(1) returns "lo"                                                                                       
> in6_02      0  TINFO  :  if_indextoname(2) returns "eth0"                                                                                     
> in6_02      0  TINFO  :  if_indextoname(3) returns "eth1"                                                                                     
> in6_02      0  TINFO  :  if_indextoname(4) returns NULL                                                                                       
> in6_02      0  TINFO  :  if_indextoname(5) returns NULL                                                                                       
> in6_02      0  TINFO  :  if_indextoname(6) returns NULL
> in6_02      0  TINFO  :  if_indextoname(7) returns NULL
> in6_02      0  TINFO  :  if_indextoname(8) returns NULL
> in6_02      0  TINFO  :  if_indextoname(9) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1804289383) returns NULL
> in6_02      0  TINFO  :  if_indextoname(846930886) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1681692777) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1714636915) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1957747793) returns NULL
> in6_02      0  TINFO  :  if_indextoname(424238335) returns NULL
> in6_02      0  TINFO  :  if_indextoname(719885386) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1649760492) returns NULL
> in6_02      0  TINFO  :  if_indextoname(596516649) returns NULL
> in6_02      0  TINFO  :  if_indextoname(1189641421) returns NULL
> in6_02      2  TPASS  :  if_indextoname() tests succeed
> in6_02      0  TINFO  :  if_nameindex idx 1 name "lo"
> in6_02      0  TINFO  :  if_nameindex idx 2 name "eth0"
> in6_02      0  TINFO  :  if_nameindex idx 3 name "eth1"
> in6_02      0  TINFO  :  if_freenameindex passed 4096 iterations
> in6_02      3  TPASS  :  if_nameindex() tests succeed
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=4 corefile=no
> cutime=0 cstime=5
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20180118
> 
> Thanks ,
> 
> Lianwen Sun
> 

