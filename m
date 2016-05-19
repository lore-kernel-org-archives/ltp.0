From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 19 May 2016 19:01:30 +0300
Subject: [LTP] [PATCH 1/4] network/stress/icmp: add icmp-multi-diffip.sh
 to implement diffip stress test
In-Reply-To: <20160519142900.GG19992@Leo.nay.redhat.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
 <573B0499.9020308@oracle.com> <20160519142900.GG19992@Leo.nay.redhat.com>
Message-ID: <573DE35A.7060106@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/19/2016 05:29 PM, Hangbin Liu wrote:
> On Tue, May 17, 2016 at 02:46:33PM +0300, Alexey Kodanev wrote:
>> Hi,
>> On 05/09/2016 10:57 AM, Hangbin Liu wrote:
>>> Signed-off-by: Hangbin Liu <haliu@redhat.com>
>>> ---
>>>   runtest/network_stress.icmp                        |  29 ++---
>>>   testcases/network/stress/icmp/icmp-multi-diffip.sh | 138 +++++++++++++++++++++
>>>   2 files changed, 153 insertions(+), 14 deletions(-)
>>>   create mode 100755 testcases/network/stress/icmp/icmp-multi-diffip.sh
>>>
>>> diff --git a/runtest/network_stress.icmp b/runtest/network_stress.icmp
>>> index 2b989b1..87feb74 100644
>>> --- a/runtest/network_stress.icmp
>>> +++ b/runtest/network_stress.icmp
>>> @@ -36,21 +36,22 @@ icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65
>>>   icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
>>>   icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
>>> -icmp4-multi-diffip01 icmp4-multi-diffip01
>>> -icmp4-multi-diffip02 icmp4-multi-diffip02
>>> -icmp4-multi-diffip03 icmp4-multi-diffip03
>>> -icmp4-multi-diffip04 icmp4-multi-diffip04
>>> -icmp4-multi-diffip05 icmp4-multi-diffip05
>>> -icmp4-multi-diffip06 icmp4-multi-diffip06
>>> -icmp4-multi-diffip07 icmp4-multi-diffip07
>>> +# networkstress.sh set IP_TOTAL=10000 by default, which is too much for these tests
>> if it is too much, I would rather check it in the script and set to the
>> appropriate maximum.
> OK, I will do it in the script.
>
>>> +
>>> +	# Make sure the connectvity
>>> +	tst_ping $lhost_iface $rhost_addr
>>> +	if [ $? -ne 0 ]; then
>>> +		tst_resm TFAIL "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"
>> proto/mode were printed in the beginning of the test so it seems redundant
>> to print it again and again during the test.
> Ah, yes, exactly. I will simplify it.
>
>>> +	else
>>> +		tst_resm TPASS "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"
>>> +	fi
>> TST_TOTAL doesn't match TPASS/TFAIL assertions.
> Hmm...I didn't notice about this. We should to make sure the connectivity. But
> the checking times is based on $IP_TOTAL.
>
> OK, I will use tst_brkm TCONF instead of tst_resm TFAIL. Which report you feel
> is better,
>
> tst_brkm TCONF "IPv${TST_IPV6:-4} connectivity after add $cnt addresses" or
>
> tst_brkm TCONF "$cnt addr: IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask connectivity"
>
>
>>> +	rhost_addr_array[$cnt]=$rhost_addr
>> Please don't use arrays, it's a bash extension.
> Is there a better way to store the addresses? Use a temp file?

We can easily calculate them again, why store them... number might be 
quite big.

>>> +done
>>> +
>>> +# Do Stress testing, ping flood
>>> +tst_resm TINFO "start ping flood stress testing"
>>> +for rhost_addr in ${rhost_addr_array[@]}; do
>>> +	for size in ${ICMP_SIZE_ARRAY}; do
>>> +		ping$TST_IPV6 -f -q -I $lhost_iface $rhost_addr -s $size &> /dev/null &
>>> +	done
>>> +done

Can we start ping test in background after adding each IP, i.e. after 
tst_ping finished?



>>> +
>>> +sleep ${NS_DURATION}
>>> +
>>> +tst_resm TPASS "$TCID IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE stress test"
>> Is the test always passing here with no checks?
> Yes, if the system under test do not crash with ping flood after ${NS_DURATION}
> seconds, we can pass the test.

What if remote host crashed somehow, and local not... test would pass in 
that case.

May be we should kill ping processes (or add -w deadline) and check 
connectivity again,
what do you think?

Thanks,
Alexey

