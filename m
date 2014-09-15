Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XTWoK-0007sL-Ps
	for ltp-list@lists.sourceforge.net; Mon, 15 Sep 2014 13:59:20 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XTWoE-0006bl-87
	for ltp-list@lists.sourceforge.net; Mon, 15 Sep 2014 13:59:20 +0000
Message-ID: <5416F115.7020301@oracle.com>
Date: Mon, 15 Sep 2014 18:00:53 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1407245680-4715-1-git-send-email-alexey.kodanev@oracle.com>
	<20140911160959.GC2011@Leo.nay.redhat.com>
In-Reply-To: <20140911160959.GC2011@Leo.nay.redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] testscripts/network: uniform network
	parameters
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi,
On 11.09.2014 20:09, Hangbin Liu wrote:
> Hi Alexey,
>
> Here are some humble opinion, please just take it as reference.
>
> On Tue, Aug 05, 2014 at 05:34:40PM +0400, Alexey Kodanev wrote:
>> * Move networktests.sh and networkstress.sh parameters to network.sh.
>>    Both network scripts have the same settings (e.g. RHOST), and
>>    some of the stress test parameters can be used by other net-tests,
>>    such as LHOST_INTERFACE and RHOST_INTERFACE variables.
>> * Add network features group to networkstress.sh.
>> * Add network features tests to 'whole' group.
>>
>> Signed-off-by: Alexey Kodanev<alexey.kodanev@oracle.com>
>> ---
>> v2: Add net features tests to 'whole' group
>>      tst_rhost_hwaddr(): run 'awk' on local machine
>>
>>   runtest/network_stress.features |    9 +++++
>>   runtest/network_stress.tcp      |    2 -
>>   runtest/network_stress.udp      |    4 --
>>   runtest/network_stress.whole    |   10 ++++++
>>   testcases/lib/test_net.sh       |   11 +++++++
>>   testscripts/network.sh          |   63 +++++++++++++++++++++++++++++++++++++++
>>   testscripts/networkstress.sh    |   35 ++++------------------
>>   testscripts/networktests.sh     |   10 +-----
>>   8 files changed, 100 insertions(+), 44 deletions(-)
>>   create mode 100644 runtest/network_stress.features
>>   create mode 100755 testscripts/network.sh
>>
>> diff --git a/runtest/network_stress.features b/runtest/network_stress.features
>> new file mode 100644
>> index 0000000..14fa2d9
>> --- /dev/null
>> +++ b/runtest/network_stress.features
>> @@ -0,0 +1,9 @@
>> +#
>> +# Stress tests for various network features
>> +#
>> +
>> +tcp_fastopen tcp_fastopen_run.sh
>> +
>> +vxlan01 vxlan01.sh
>> +vxlan02 vxlan02.sh
>> +vxlan03 vxlan03.sh
>> diff --git a/runtest/network_stress.tcp b/runtest/network_stress.tcp
>> index 9795d2a..7206b3a 100644
>> --- a/runtest/network_stress.tcp
>> +++ b/runtest/network_stress.tcp
>> @@ -331,5 +331,3 @@ tcp6-multi-diffnic11 tcp6-multi-diffnic11
>>   tcp6-multi-diffnic12 tcp6-multi-diffnic12
>>   tcp6-multi-diffnic13 tcp6-multi-diffnic13
>>   tcp6-multi-diffnic14 tcp6-multi-diffnic14
>> -
>> -tcp_fastopen tcp_fastopen_run.sh
>> diff --git a/runtest/network_stress.udp b/runtest/network_stress.udp
>> index 2f62c14..bfe9d85 100644
>> --- a/runtest/network_stress.udp
>> +++ b/runtest/network_stress.udp
>> @@ -65,7 +65,3 @@ udp6-multi-diffnic04 udp6-multi-diffnic04
>>   udp6-multi-diffnic05 udp6-multi-diffnic05
>>   udp6-multi-diffnic06 udp6-multi-diffnic06
>>   udp6-multi-diffnic07 udp6-multi-diffnic07
>> -
>> -vxlan01 vxlan01.sh
>> -vxlan02 vxlan02.sh
>> -vxlan03 vxlan03.sh
>> diff --git a/runtest/network_stress.whole b/runtest/network_stress.whole
>> index 35c219f..7b0dfa3 100644
>> --- a/runtest/network_stress.whole
>> +++ b/runtest/network_stress.whole
>> @@ -551,3 +551,13 @@ ftp6-download-stress ftp6-download-stress
>>   
>>   ftp4-upload-stress ftp4-upload-stress
>>   ftp6-upload-stress ftp6-upload-stress
>> +
>> +#
>> +# Stress tests for various network features
>> +#
>> +
>> +tcp_fastopen tcp_fastopen_run.sh
>> +
>> +vxlan01 vxlan01.sh
>> +vxlan02 vxlan02.sh
>> +vxlan03 vxlan03.sh
>> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
>> index 51b3e38..f58bf65 100644
>> --- a/testcases/lib/test_net.sh
>> +++ b/testcases/lib/test_net.sh
>> @@ -75,3 +75,14 @@ tst_rhost_run()
>>   
>>   	return $ret
>>   }
>> +
>> +tst_lhost_hwaddr()
>> +{
>> +	echo $(ip link show $LHOST_INTERFACE | awk 'NR==2 { print $2 }')
> Hi, what's the difference to run like
>
> tst_lhost_hwaddr()
> {
> 	ip link show $LHOST_INTERFACE | awk 'NR==2 { print $2 }'
> }

Thanks for noticing :)

>> +}
>> +
>> +tst_rhost_hwaddr()
>> +{
>> +	echo $(tst_rhost_run -s -c "ip link show $RHOST_INTERFACE" | \
>> +		awk 'NR==2 { print $2 }')
>> +}
>> diff --git a/testscripts/network.sh b/testscripts/network.sh
>> new file mode 100755
>> index 0000000..b322713
>> --- /dev/null
>> +++ b/testscripts/network.sh
>> @@ -0,0 +1,63 @@
>> +#!/bin/sh
>> +
>> +# Network Test Parameters
>> +#
>> +# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
>> +
>> +export RHOST=
> How about export the following global variables like
>
> export RHOST=${RHOST:-""}
>
> So we can export what we want before run network.sh and no need to modify it
> everytime. In our lab, we will git clone the latest ltp repo before testing,
> so I really do not want to change the script, even with sed...
>
> If any one want to use a static value, he can still add it in "".
or substitute '${..}'. Sounds reasonable.

>> +export PASSWD=
>> +
>> +# ---***************************************************---
>> +# More information about network parameters can be found
>> +# in the following document: testcases/network/stress/README
>> +
>> +LTP_RSH=
>> +
>> +# Set names for test interfaces
>> +LHOST_INTERFACE=
>> +RHOST_INTERFACE=
> I would like to use LHOST_IFACE or LOCAL_IFACE to make it shorter, just
> personal habit :)

Vote for LHOST_IFACE.

>> +
>> +# Set first three octets of the network address
>> +IPV4_NETWORK=
>> +# Set local host last octet
>> +LHOST_IPV4_HOST=
>> +# Set remote host last octet
>> +RHOST_IPV4_HOST=
>> +# Set the reverse of IPV4_NETWORK
>> +IPV4_NETWORK_REVERSE=
>> +# Set firt three octets of the network address
>> +IPV6_NETWORK=
>> +# Set local host last octet
>> +LHOST_IPV6_HOST=
>> +# Set remote host last octet
>> +RHOST_IPV6_HOST=
>> +
>> +export HTTP_DOWNLOAD_DIR=
>> +export FTP_DOWNLOAD_DIR=
>> +export FTP_UPLOAD_DIR=
>> +export FTP_UPLOAD_URLDIR=
>> +
>> +# Set default parameters
>> +export LTP_RSH=${LTP_RSH:-"rsh -n"}
>> +export LHOST_INTERFACE=${LHOST_INTERFACE:-"eth0"}
> Ah, see you use LHOST_INTERFACE=${LHOST_INTERFACE:-"eth0"} here, but since you
> have set LHOST_INTERFACE to NULL before, then LHOST_INTERFACE will absolutely
> eth0 here expect the tester have set value before. Then how about remove the
> previous LHOST_INTERFACE definition and let tester modify the default
> interface here.

It can be done for other variables as well.

>> +export RHOST_INTERFACE=${RHOST_INTERFACE:-"eth0"}
>> +export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
>> +export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
>> +export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
>> +export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
>> +export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
>> +export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
>> +export IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
>> +
>> +TST_TOTAL=1
>> +TCID="network_settings"
>> +
>> +. test_net.sh
>> +
>> +export LHOST_HWADDRS=$(tst_lhost_hwaddr)
> Thers are also some network tests need to use two interfaces. I have been
> suggested to use INTERFACE="eth0|eth1" and use
> LHOST_HWADDRS=`ifconfig | grep -P ${INTERFACE} | grep HWaddr |awk '{print $5}'`
> to get HWADDRESS, just a remind.

That's why I don't like the idea to get it by LTP, because the command 
output not always the same (the example doesn't work with the newer 
net-tools versions).

May be we should change the syntax of specifying multiple links: 
LHOST_IFACE="eth0 eht1 ...", LHOST_HWADDRS="00:00:00:00:00:01 
00:00:00:00:00:01 ...".

If we want to get interface or hwaddr in the tests we will use functions 
from test_net.sh library. For example 'get_lhost_iface', 
'get_lhost_hwaddr'. Without args, it'll return link 0.

Any suggestions, ideas?


>> +export RHOST_HWADDRS=$(tst_rhost_hwaddr)
>> +
>> +export TMPDIR=/tmp/netpan-$$
>> +mkdir -p $TMPDIR
>> +CMDFILE=${TMPDIR}/network.tests
>> +VERBOSE="no"
>> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
>> index b40af72..47f365d 100755
>> --- a/testscripts/networkstress.sh
>> +++ b/testscripts/networkstress.sh
>> @@ -12,32 +12,10 @@ if [ $? -eq 0 ]; then
>>    export LTPROOT=${PWD}
>>   fi
>>   
>> -export TMPDIR=/tmp/netst-$$
>> -mkdir $TMPDIR
>> -VERBOSE="no"
>> -INTERFACE="eth0"
>> -
>> -#===========================================================================
>> -# Network parameters
>> -export RHOST=
>> -export RHOST_HWADDRS=
>> -export HTTP_DOWNLOAD_DIR=
>> -export FTP_DOWNLOAD_DIR=
>> -export FTP_UPLOAD_DIR=
>> -export FTP_UPLOAD_URLDIR=
>> -
>> -# Set firt three octets of the network address, by default 10.0.0
>> -export IPV4_NETWORK=
>> -# Set local host last octet, by default 2
>> -export LHOST_IPV4_HOST=
>> -# Set remote host last octet, by default 1
>> -export RHOST_IPV4_HOST=
>> -# Set the reverse of IPV4_NETWORK, by default 0.0.10
>> -export IPV4_NETWORK_REVERSE=
>> +. $LTPROOT/testscripts/network.sh $0
>>   
>>   #===========================================================================
>>   # Default Test Settings
>> -# export LTP_RSH=rsh
>>   # export NS_DURATION=3600	# 1 hour
>>   # export NS_TIMES=10000
>>   # export CONNECTION_TOTAL=4000
>> @@ -67,6 +45,7 @@ usage () {
>>       echo " -R|r: Stress test for routing table"
>>       echo " -B|b: Stress Broken IP packets"
>>       echo " -M|m: Multicast stress tests"
>> +    echo " -F|f: Stress test for network features"
>>       echo " -S|s: Run selected tests"
>>       echo " -W|w: Run whole network stress tests"
>>       echo " -D|d: Test duration (default ${NS_DURATION} sec)"
>> @@ -77,7 +56,7 @@ usage () {
>>       exit 1
>>   }
>>   
>> -while getopts AaEeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
>> +while getopts AaEeTtIiUuRrMmFfSsWwBbVvN:n:D:d: OPTION
> Where is -N|n: Select the network interface (default: $INTERFACE), I saw there
> is still N:n:, but I can't find it in your usage or OPTARGS
>
> Also, should we remove this parameter or add it in both networktest.sh and
> networkstress.sh?

I would remove it.

>
> Also for the parameters, I think use two parameters for one option is waste.
> Like INTERFACE, -I have been taken by icmp testing in networkstress.sh, and -N
> have been taken by nfs test in networktest.sh which is use by networkstress.sh
>
> So how about use lowercase for test cases and uppercase for environment
> variables.

or lowercase for tests and uppercase for stress tests.

>>   do
>>       case $OPTION in
>>   	A|a) TEST_CASE="network_stress.appl";;
>> @@ -88,6 +67,7 @@ do
>>   	U|u) TEST_CASE="network_stress.udp";;
>>   	R|r) TEST_CASE="network_stress.route";;
>>   	M|m) TEST_CASE="network_stress.multicast";;
>> +	F|f) TEST_CASE="network_stress.features";;
>>   	S|s) TEST_CASE="network_stress.selected";;
>>   	W|w) TEST_CASE="network_stress.whole";;
>>   	V|v) VERBOSE="yes";;
>> @@ -102,8 +82,6 @@ if [ -z ${TEST_CASE} ]; then
>>   	usage
>>   fi
>>   
>> -export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk '{print $5}'`
>> -
>>   if [ -z ${RHOST} ]; then
>>   	## Just a silly check
>>   	echo "Error: pay attention to configure"
>> @@ -119,9 +97,8 @@ export PATH="${PATH}:${LTPROOT}/testcases/bin"
>>   
>>   if [ ${VERBOSE} = "yes" ]; then
>>   	echo "Network parameters:"
>> -	echo " - ${INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
>> -	echo " - Remote IP address: ${RHOST}"
>> -	echo " - Remote MAC address: ${RHOST_HWADDRS}"
>> +	echo " - ${LHOST_INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
>> +	echo " - ${RHOST_INTERFACE} remote interface (MAC address: ${RHOST_HWADDRS})"
>>   
>>   	cat $TMPDIR/network_stress.tests
>>   	${LTPROOT}/ver_linux
>> diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
>> index b136749..507b7e3 100755
>> --- a/testscripts/networktests.sh
>> +++ b/testscripts/networktests.sh
>> @@ -1,11 +1,6 @@
>>   #!/bin/sh
>>   # This will run all the network tests, with the status logged in /tmp/netpan.log
>>   
>> -# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
>> -export RHOST=
>> -export PASSWD=
>> -# ---***************************************************---
>> -
>>   cd `dirname $0`
>>   export LTPROOT=${PWD}
>>   echo $LTPROOT | grep testscripts > /dev/null 2>&1
>> @@ -14,10 +9,7 @@ if [ $? -eq 0 ]; then
>>    export LTPROOT=${PWD}
>>   fi
>>   
>> -export TMPDIR=/tmp/netpan-$$
>> -mkdir -p $TMPDIR
>> -CMDFILE=${TMPDIR}/network.tests
>> -VERBOSE="no"
>> +. $LTPROOT/testscripts/network.sh $0
>>   
>>   # For bitwise operation to determine which testsets run
>>   CMD_IPV6=1		# 0x0001
>> -- 
>> 1.7.1
>>
>>
>> ------------------------------------------------------------------------------
>> Infragistics Professional
>> Build stunning WinForms apps today!
>> Reboot your WinForms applications with our WinForms controls.
>> Build a bridge from your legacy apps to the future.
>> http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
