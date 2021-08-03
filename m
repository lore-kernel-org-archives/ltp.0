From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 3 Aug 2021 13:31:22 +0300
Subject: [LTP] [PATCH 2/2] broken_ip: TCONF when test run on unsupported
 protocol
In-Reply-To: <YQg0LIXG8LK0OV74@pevik>
References: <20210714140716.1568-1-pvorel@suse.cz>
 <20210714140716.1568-3-pvorel@suse.cz>
 <57d4c109-d01a-2c7f-39c7-41013e70abf9@bell-sw.com> <YQBD4w2nKwY2G1l+@pevik>
 <b0638d98-88d5-76d7-78a1-631c801d88ad@bell-sw.com> <YQg0LIXG8LK0OV74@pevik>
Message-ID: <80a6cbec-50b7-9912-d682-915a1076bbec@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 02.08.2021 21:06, Petr Vorel wrote:
> Hi Alexey,
> 
>> Hi Petr,
>> On 27.07.2021 20:35, Petr Vorel wrote:
>>> Hi Alexey,
> 
>>>> On 14.07.2021 17:07, Petr Vorel wrote:
>>>>> net_stress.broken_ip runtest file is correct, but some users try to run
>>>>> tests manually.
> 
>>>>> Fixes: #843
> 
>> ...
>>>>>  do_test()
> 
>>>> The generic version looks fine:
> 
>>>> Reviewed-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> 
>>> I didn't understand whether you'd prefer to add TST_IPV6=6 (or TST_IPV6=) where
>>> needed or accept this patchset. Both would work.
> 
>> I think for manual runs it is better to set TST_IPV6=6 in the test
>> so it will run the test rather the require passing some options.
> It looks like specifying TST_IPV6=6 is not enough, because tests are using
> $NS_ICMP_SENDER_DATA_MAXSIZE which is defined in tst_net.sh according to
> TST_IPV6. We can
> 
> 1) overwrite NS_ICMP_SENDER_DATA_MAXSIZE="$NS_ICMPV6_SENDER_DATA_MAXSIZE"
> 2) check TST_IPV6 before running tst_net_parse_args and if set overwrite -6 flag
> 
> But both are quite ugly, thus unless you have better idea I merge this patchset.


Are you sure that you are getting the wrong maxsize? if TST_IPV6=6
is set before the setup, in the test, why tst_net_setup() is setting
the IPv4 value?

> 
> Kind regards,
> Petr
> 
>>> Kind regards,
>>> Petr
> 
> 

