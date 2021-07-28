From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed, 28 Jul 2021 14:20:42 +0300
Subject: [LTP] [PATCH 2/2] broken_ip: TCONF when test run on unsupported
 protocol
In-Reply-To: <YQBD4w2nKwY2G1l+@pevik>
References: <20210714140716.1568-1-pvorel@suse.cz>
 <20210714140716.1568-3-pvorel@suse.cz>
 <57d4c109-d01a-2c7f-39c7-41013e70abf9@bell-sw.com> <YQBD4w2nKwY2G1l+@pevik>
Message-ID: <b0638d98-88d5-76d7-78a1-631c801d88ad@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 27.07.2021 20:35, Petr Vorel wrote:
> Hi Alexey,
> 
>> On 14.07.2021 17:07, Petr Vorel wrote:
>>> net_stress.broken_ip runtest file is correct, but some users try to run
>>> tests manually.
> 
>>> Fixes: #843
> 
...
>>>  do_test()
> 
>> The generic version looks fine:
> 
>> Reviewed-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> 
> I didn't understand whether you'd prefer to add TST_IPV6=6 (or TST_IPV6=) where
> needed or accept this patchset. Both would work.

I think for manual runs it is better to set TST_IPV6=6 in the test
so it will run the test rather the require passing some options.


> Kind regards,
> Petr
> 

