From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 10 Feb 2021 14:56:13 +0300
Subject: [LTP] [PATCH 1/4] net/multicast: Create mcast_setup_normal()
In-Reply-To: <YB7qefsNWbCJXUEu@pevik>
References: <20210205151015.7465-1-pvorel@suse.cz> <YB7qefsNWbCJXUEu@pevik>
Message-ID: <5f9aecc2-096b-6b24-bdfa-f9d361fcbac7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06.02.2021 22:14, Petr Vorel wrote:
> Hi,
> 
>> +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
>> @@ -8,14 +8,11 @@
>>  # a single socket, then receiving a large number of UDP packets at the socket
> 
>>  TST_NEEDS_ROOT=1
>> +TST_SETUP="mcast_setup_normal"
>>  . mcast-lib.sh
> 
>> -do_setup()
>> -{
>> -	mcast_setup $MCASTNUM_NORMAL
>> -	MCAST_LCMD=ns-mcast_receiver
>> -	MCAST_RCMD=ns-udpsender
>> -}
>> +MCAST_LCMD="ns-mcast_receiver"
>> +MCAST_RCMD="ns-udpsender"
> Actually, this is wrong.
> Variables must be set after setup has been run.
> 
>>  do_test()
>>  {
>> diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
>> index 76d184995..2c356917a 100755
>> --- a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
>> +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
>> @@ -9,14 +9,11 @@
>>  # packets at each socket
> 
>>  TST_NEEDS_ROOT=1
>> +TST_SETUP="mcast_setup_normal"
>>  . mcast-lib.sh
> 
>> -do_setup()
>> -{
>> -	mcast_setup $MCASTNUM_NORMAL
>> -	MCAST_LCMD=ns-mcast_receiver
>> -	MCAST_RCMD=ns-udpsender
>> -}
>> +MCAST_LCMD="ns-mcast_receiver"
>> +MCAST_RCMD="ns-udpsender"
> And here as well.
> 
> Fix is to move it into test function.
> 
> Kind regards,
> Petr
> 
> diff --git testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
> index 1db7b0605..1b9fe9d79 100755
> --- testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
> +++ testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
> @@ -11,13 +11,13 @@ TST_NEEDS_ROOT=1
>  TST_SETUP="mcast_setup_normal"
>  . mcast-lib.sh
>  
> -MCAST_LCMD="ns-mcast_receiver"
> -MCAST_RCMD="ns-udpsender"
> -
>  do_test()
>  {
>  	tst_res TINFO "joining an IPv${TST_IPVER} multicast group with a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION seconds"
>  
> +	MCAST_LCMD="ns-mcast_receiver"
> +	MCAST_RCMD="ns-udpsender"
> +
>  	local addr="$MCAST_IPV4_ADDR"
>  	[ "$TST_IPV6" ] && addr="$MCAST_IPV6_ADDR"
>  
> diff --git testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> index ee62b347e..9b5de60db 100755
> --- testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> +++ testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> @@ -12,13 +12,13 @@ TST_NEEDS_ROOT=1
>  TST_SETUP="mcast_setup_normal"
>  . mcast-lib.sh
>  
> -MCAST_LCMD="ns-mcast_receiver"
> -MCAST_RCMD="ns-udpsender"
> -
>  do_test()
>  {
>  	tst_res TINFO "joining $MCASTNUM_NORMAL IPv${TST_IPVER} multicast groups on separate sockets, then receiving a large number of UDP packets at each socket in $NS_DURATION seconds"
>  
> +	MCAST_LCMD="ns-mcast_receiver"
> +	MCAST_RCMD="ns-udpsender"
> +

Hi Petr,

Perhaps it would be better to move this to another wrapper
in the lib along with mcast_setup_normal()?

mcast_setup_normal_udp()
{
        mcast_setup_normal
	MCAST_LCMD="ns-mcast_receiver"
	MCAST_RCMD="ns-udpsender"
}
