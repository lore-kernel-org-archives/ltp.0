From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 6 Dec 2019 17:50:27 +0200
Subject: [LTP] LTP realtime tests
In-Reply-To: <6a7fbfdf-4fda-70bb-01d8-19fb6218170d@jv-coder.de>
References: <20191205135020.GA7951@dell5510>
 <6a7fbfdf-4fda-70bb-01d8-19fb6218170d@jv-coder.de>
Message-ID: <bc04bede-48fb-68e4-2ade-6125268008a4@ti.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CC:

On 06/12/2019 08:13, Joerg Vehlow wrote:
> Hi Petr,
> 
> we are running these tests and from what I've seen the quality is very poor.
> We had to make changes to a lot of them to make them pass reliably:
> most of the tests: Missing checks of return value for pthread function and resulting deadlock
> prio-wake and prio-preempt: Bound to a single cpu core
> sched_football: Needs a sleep to run reliable (I send a mail some time ago to this mailing list
> regarding the validity of the test, which got forwarded to lkml by cyril, but no reply)
> 
> Some tests do not return the correct result e.g.:
> testpi-5, testpi-6, sched_jitter, gtod_latency
> 
> I haven't really looked into most of these tests.
> 
> J?rg
> 
> Am 05.12.2019 um 14:50 schrieb Petr Vorel:
>> Hi RT folks,
>>
>> looking into LTP realtime tests (testcases/realtime/ [1]),
>> the code certainly deserves cleanup.
>>
>> Looking at [2], it does not mention these tests at all.
>> Can anyone comment on relevance of these tests to current RT?
>> Does anyone use these tests?
>>
>> Thanks for feedback.
>>
>> Kind regards,
>> Petr
>>
>> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/realtime
>> [2] https://elinux.org/Realtime_Testing_Best_Practices#Test_programs
>>
> 

-- 
Best regards,
grygorii
