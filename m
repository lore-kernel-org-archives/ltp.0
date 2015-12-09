From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 09 Dec 2015 14:15:20 +0300
Subject: [LTP] [Query] Regarding network testcases
In-Reply-To: <56680852.9010103@oracle.com>
References: <1246557963.484611449651576462.JavaMail.weblogic@epmlwas02c>
 <56680852.9010103@oracle.com>
Message-ID: <56680D48.7070808@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sending to the correct ML.

On 12/09/2015 01:54 PM, Alexey Kodanev wrote:
> Hi,
> On 12/09/2015 11:59 AM, Manjeet Pawar wrote:
>> Hi,
>>
>> I am facing issues while running some network testcases : e.g. 
>> if4-addr-change
>> This testcase belongs to latest (ltp-full-20150903.tar.bz2)
>> when I run this  if4-addr-change, I exported two new env variables a) 
>> IPV4_NETWORK = "107.109.223" and IPV6_NETWORK = "fd00::1:1:1:1", b) 
>> LHOST_IFACES = eth0 and RHOST_IFACES = eth0, which is not exported in 
>> "test_net.sh" .
>> bacause "if4-addr-change " testcase invokes "est_net.sh".
>>
> ...
>> ++ echo fd00::1:1:1:1:
>> + ip addr add fd00::1:1:1:1:/64 dev eth0
>> ip: RTNETLINK answers: Numerical result out of range
>> + return 2
>> + ret=2
>> + TST_IPV6=
>> + return 2
>> + exit 2
>> <<<<<<<<<<<<<<<<<<<execution_status>>>>>>>>>>>>
>> initiation_status="ok"
>> duration=13 termination_type=exited termination_id=2 corefile=no
>> cutime=49 cstime=627
>> <<<<<<<<<<<<<<<<<<<test_end>>>>>>>>>>>>>>>>>>>>>
>>
>> Please check the IP addresses taken by the program, they are in wrong 
>> format.
>> Is there anything that I am missing to run this testcase ? . Also I 
>> tried to do manually fix to get IP addresses in correct way but that 
>> should not be done, it need many changes to be done in "test_net.sh".
>> This test scripts is invoked by  other testcases like 
>> "network_stress.broken_ip". So all these testcases are failing.
>> Please suggest more detail regarding "test_net.sh".
>
> Defining IPv6 network as IPV6_NETWORK = "fd00::1:1:1:1" is not quite 
> correct. Here you have specified the IPv6 address, not network.
>
> There are other variables that should be defined as well: 
> LHOST_IPV4_HOST, RHOST_IPV4_HOST, LHOST_IPV6_HOST, RHOST_IPV6_HOST, 
> i.e. host specific parts.
>
> In your case IPv6 network is "fd00::/64", and I would set vars as 
> follows:
> IPV6_NETWORK = "fd00"
> LHOST_IPV6_HOST=":1:1:1:1"
>
> After that you will get fd00::1:1:1:1/64 address in the tests 
> (${IPV6_NETWORK}:${LHOST_IPV6_HOST}).
>
> Best regards,
> Alexey
>
>>
>> Thanks
>>
>>
>>
>>
>> ------------------------------------------------------------------------------ 
>>
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

