From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 23 Mar 2016 11:21:37 +0300
Subject: [LTP] [PATCHv3 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <20160323020243.GB8609@Leo.nay.redhat.com>
References: <1458209056-18829-1-git-send-email-haliu@redhat.com>
 <1458209056-18829-4-git-send-email-haliu@redhat.com>
 <56F149FC.4030604@oracle.com> <20160323020243.GB8609@Leo.nay.redhat.com>
Message-ID: <56F25211.5090902@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/23/2016 05:02 AM, Hangbin Liu wrote:
> Hi,
>
> On Tue, Mar 22, 2016 at 04:34:52PM +0300, Alexey Kodanev wrote:
>> On 03/17/2016 01:04 PM, Hangbin Liu wrote:
>>> Also check each msg_size in $ICMP_SIZE_ARRAY to make sure the connectvity.
>>>
>>> Signed-off-by: Hangbin Liu <haliu@redhat.com>
>>> ---
>>>   .../stress/icmp/uni-basic/icmp4-uni-basic01        | 160 ++++-----------------
>>>   1 file changed, 24 insertions(+), 136 deletions(-)
>>>
>>> diff --git a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01 b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
>>> index b78ac8f..7c23cc7 100644
>>> --- a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
>>> +++ b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
>>> @@ -42,17 +42,13 @@
>>>   #	Oct 19 2005 - Created (Mitsuru Chinen)
>>>   #
>>>   #-----------------------------------------------------------------------
>>> -# Uncomment line below for debug output.
>>> -#trace_logic=${trace_logic:-"set -x"}
>>> -$trace_logic
>>> -
>>>   # The test case ID, the test case count and the total number of test case
>>>   TCID=${TCID:-icmp4-uni-basic01}
>>>   TST_TOTAL=1
>>>   TST_COUNT=1
>>> -export TCID
>>> -export TST_COUNT
>>> -export TST_TOTAL
>>> +TST_CLEANUP="do_cleanup"
>>> +
>>> +. ipsec_lib.sh
>>>   # Test description
>>>   tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions"
>>> @@ -61,9 +57,6 @@ tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending
>>>   LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
>>>   export LTPROOT
>>> -# Check the environmanet variable
>>> -. check_envval || exit $TST_TOTAL
>>> -
>>>   # Dulation of the test [sec]
>>>   NS_DURATION=${NS_DURATION:-3600}      # 1 hour
>> I'd remove defining these variables here... in the test. Weshouldhave them
>> already
>> defined in network.sh or it could be done in test_net.sh in case we're not
>> going to
>> runnetwork.sh.
> OK, I will remove this
>>> @@ -72,6 +65,7 @@ LINK_NUM=${LINK_NUM:-0}
>>>   # The version of IP
>>>   IP_VER=${IP_VER:-4}
>>> +[ $IP_VER -eq 6 ] && TST_IPV6=6
>> just "ipv=${TST_IPV6:-4}" instead of two lines.
> This is not work. Because test_net.sh will set TST_IPV6= , and icmp4-uni-basic01
> need source it before test. The relation looks like
>
> icmp6-uni-basic01
>    . icmp4-uni-basic01
>      . ipsec_lib.sh
>        . test_net.sh
>
> If we want to use like ipv=${TST_IPV6:-4}, we need source test_net.sh in all
> sub-testcases instead of in ipsec_lib.sh. Which will like
>
> icmp6-uni-basic01
>    . test_net.sh
>    . icmp4-uni-basic01
>      . ipsec_lib.sh

Could you add "ipv=..." to ipsec_lib.sh and we wouldn't set it in every 
test-case?

BTW, does the attached patch help in the first case (added export to 
TST_IPV6)?


>> -# Run a client
>> -$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
>> -
>> -sleep $NS_DURATION
>> -killall_icmp_traffic
>> -wait
>> +# Make sure the connectvity
>> +for msg_size in $ICMP_SIZE_ARRAY; do
>> +    tst_ping $lhost_ifname $rhost_addr $msg_size
>> +    if [ $? -ne 0 ]; then
>> +        tst_brkm TBROK "There is no IPv$IP_VER connectivity with msg_size $msg_size"
>> +    else
>> +        tst_resm TPASS "There has IPv$IP_VER connectivity with msg_size $msg_size"
>> +    fi
>> +done
>>
>> Is it really needed to ping with different message sizes? if yes, we
>> couldadd this
>> functionality to tst_ping().
> Yes, we need to make sure ipsec can handle all kinds of message size. But we
> could not make it in tst_ping because ah/esp and tunnel/transport have
> different header length. e.g. when there is no ipsec, the max playload is
> 65507. If we test ah + transport, the max playload is 65483. etc. It's hard to
> make tst_ping to handle all these scenarios.

I thought we could add variable length parameters, something like this

tst_ping p1 ... pN $ICMP_SIZE_ARRAY

tst_ping()
{
     local msg_sizes=${@:N+1}

     for size in msg_sizes; do
     ...
}


Best regards,
Alexey

> Thanks
> Hangbin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-testcases-lib-test_net.sh-export-TST_IPV6-var.patch
Type: text/x-patch
Size: 702 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160323/29814bb0/attachment-0001.bin>
