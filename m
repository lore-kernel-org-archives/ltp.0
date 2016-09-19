From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Sep 2016 15:10:33 +0300
Subject: [LTP] [PATCH 2/3] network/ping01: use ROD_SILENT and report
 test result
In-Reply-To: <20160919103113.GA7877@rei.lan>
References: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
 <1473320058-13205-2-git-send-email-alexey.kodanev@oracle.com>
 <20160919103113.GA7877@rei.lan>
Message-ID: <57DFD5B9.6090800@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09/19/2016 01:31 PM, Cyril Hrubis wrote:
> Hi!
>> @@ -47,12 +46,10 @@ do_test()
>>   	local ipaddr=$(tst_ipaddr rhost)
>>   	for packetsize in $PACKETSIZES; do
>>   		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
>> -		$PING_CMD -c $COUNT -s $packetsize $ipaddr > /dev/null 2>&1
>> -		if [ $? -ne 0 ]; then
>> -			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $ipaddr"
>> -			return
>> -		fi
>> +		ROD_SILENT $PING_CMD -c $COUNT -s $packetsize $ipaddr
> What about we use the EXPECT_PASS here? The ROD_SILENT would produce
> TBROK instead of TFAIL in case of failure.
>
> I know that EXPECT_PASS wouldn't exit the test on first failure, do we
> really need that anyway? And it also wouldn't silence the ping output,
> which shouldn't be so much of a problem since the $COUNT is small.

Yes, $COUNT is small but we should multiply it by $PACKETSIZES. Even 
with '-q' there will be a lot of output.
What about adding redirection to /dev/null and removing tst_resm() as below:

-TST_TOTAL=1
+TST_TOTAL=10
  TCID="ping01"

  . test_net.sh
@@ -45,11 +45,8 @@ do_test()
         tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
         local ipaddr=$(tst_ipaddr rhost)
         for packetsize in $PACKETSIZES; do
-               tst_resm TINFO "call $PING_CMD with packet size = 
$packetsize"
-               ROD_SILENT $PING_CMD -c $COUNT -s $packetsize $ipaddr
+               EXPECT_PASS $PING_CMD -c $COUNT -s $packetsize $ipaddr 
\>/dev/null
         done
-
-       tst_resm TPASS "$PING_CMD test completed"
  }


Thanks,
Alexey
