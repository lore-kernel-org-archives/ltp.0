From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 12 Sep 2019 10:55:16 +0100
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <CAEemH2cw+O5ZrZyQV5qy7wp6-h1SSinu3ENueRG7Gr--xJCRfA@mail.gmail.com>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
 <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
 <20190830104609.GA9330@dell5510>
 <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
 <1568279073.3621.12.camel@suse.de>
 <CAEemH2cw+O5ZrZyQV5qy7wp6-h1SSinu3ENueRG7Gr--xJCRfA@mail.gmail.com>
Message-ID: <e07d08e2-df58-2114-0278-8f1e50f2ac3a@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 12/09/2019 10:34, Li Wang wrote:
>>>>> I also wonder if it is worth somehow put this minimum-enforce
>>>>> mechanism inside the framework itself
>>>>> instead that hardcoding it in this specific test (unless you
>>>>> already mean to do it this way...
>>>>> and I misunderstood)
>>>>
>>>> Yes, I was thinking about it as well.
>>>> LTP_TIMEOUT_MUL should be reserved for users, tests should use
>>>> LTP_TIMEOUT_MUL_MIN,
>>>> check for LTP_TIMEOUT_MUL being higher than LTP_TIMEOUT_MUL_MIN
>>>> would be in
>>>> _tst_setup_timer(). Similar mechanism I introduced in 9d6a960d9
>>>> (VIRT_PERF_THRESHOLD_MIN).
>>>
>>> +1 agree.
>>
>> I have a general question. What do we try to get with
>> LTP_TIMEOUT_MUL_MIN? From my perspective, we try to set a minimum
>> timeout value. Isn't it the value (struct tst_test*)->timeout ?
>>
> 
> Well, the (struct tst_test*)->timeout is the default minimum value to set a
> timeout, but for some test case(e.g memcg_stress_test.sh), they required
> time should be higher than the default. So as we discussed in the above
> mails, we're planning to introduce a new variable LTP_TIMEOUT_MUL_MIN to
> set as a new minimum value for test timeout. The operation will be
> encapsulate in function  _tst_setup_timer().
> 
> 
> 
>>
>> I'm missing such configuration value for shell. Is there one?
>>
> 
> No, we don't have it so far.
> 
> 
>>
>> Or do we need to increase timeout in smaller steps and that is why we
>> need this LTP_TIMEOUT_MUL_MIN?
>>
> 
> Hmm, what we want to do is:
> 
> If a testcase needs timeout value is larger than the default (300 sec), we
> could only define a variable LTP_TIMEOUT_MUL_MIN in the test, then the
> _tst_setup_timer() will detect if LTP_TIMEOUT_MUL_MIN is valid and reset
> the minimum time for the test.
> 
> @Petr and @Cristian, If I misunderstand anything, please correct me.

my understanding was that:

- we should already be able to set a non default per-test timeout using
  the existing global LTP_TIMEOUT_MUL (and we are)

- in this test we hardcoded such LTP_TIMEOUT_MUL to 7 because is the minimum sane
  value for this test (less than 7 and it fails 100%)

- we want to allow again the user to specify its own LTP_TIMEOUT_MUL if he wants
  BUT also being able to enforce on a test by test basis a MINIMUM allowed value:
  so we would define LTP_TIMEOUT_MUL_MIN=7 here, and then a user would be free to 
  run LTP with a different global LTP_TIMEOUT_MUL but when running this test
  
  + if LTP_TIMEOUT_MUL < LTP_TIMEOUT_MUL_MIN ===> use local LTP_TIMEOUT_MUL_MIN
  + if LTP_TIMEOUT_MUL >= LTP_TIMEOUT_MUL_MIN  ===> use global LTP_TIMEOUT_MUL

This way you don't break specific tests' needs while allowing the user to global reduce
run-time....now basically the user cannot enforce a higher timeout on this test
using the global LTP_TIMEOUT_MUL even if it should be allowed to since this wouldn't
break the test.

...unless I misunderstood too o_O :D


Thanks

Cristian





> 

