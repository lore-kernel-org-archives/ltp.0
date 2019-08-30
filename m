From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 30 Aug 2019 10:07:26 +0100
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <20190830085036.GA27453@dell5510>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
Message-ID: <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 30/08/2019 09:50, Petr Vorel wrote:
> Hi Li,
> 
> Good point. Something like this could do it:
> -LTP_TIMEOUT_MUL=7
> +min_timeout=7
> +[ -z "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt $min_timeout ] && LTP_TIMEOUT_MUL=$min_timeout
> 
> Unless we test only integers:
> +[ is_int "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt $min_timeout ] && LTP_TIMEOUT_MUL=$min_timeout
> 

I would certainly introduce a check on the minimum allowed test-timeout and just stick to integers.
(is it really needed to worry for float multipliers ?)

I also wonder if it is worth somehow put this minimum-enforce mechanism inside the framework itself
instead that hardcoding it in this specific test (unless you already mean to do it this way...
and I misunderstood)

So that, roughly, in the test

LTP_TIMEOUT_MUL_MIN=7
LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-7}

and somewhere in framework test initialization you enforce it (maybe with a warning for the user when overriding its setup)

[ -z "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt $LTP_TIMEOUT_MUL_MIN ] && LTP_TIMEOUT_MUL=$LTP_TIMEOUT_MUL_MIN

(but my LTP framework memories are a bit blurred now...so feel free to ignore if it is not feasible or practical)

Thanks

Cristian

> But that'd require using only integers, while C allows to use floating point
> numbers :(. We can
> 1) either live with the limitation of integers for shell (+ document it)
> 2) or use awk or bc (but that's external dependency for shell tests (currently
> tst_test.sh requires: cut, tr, wc; tst_net.sh requires awk and ip; so I'd be for
> awk dependency; dependencies should be documented as well)
> 3) write simple utility (tst_float_cmp.c) to compare strings for us
> 
> Of course, we can test only integers:
> +[ is_int "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt $min_timeout ] && LTP_TIMEOUT_MUL=$min_timeout
> 
> Also, C code requires LTP_TIMEOUT_MUL > 1 in tst_set_timeout().
> We don't have this check. Again, adding it brings problem with float number.
> 
> Kind regards,
> Petr
> 
>> On Fri, Aug 30, 2019 at 2:12 AM Petr Vorel <pvorel@suse.cz> wrote:
> 
>>> While it's good to increase the default LTP_TIMEOUT_MUL value, give user
>>> a chance to change it.
> 
>> It's a good proposal, but one thing we need to consider that there is
>> possible to pass a small timeout value(<5mins) from the user. So what
>> about set a condition judgment which only accepts time value which >=
>> 7?
> 
>>>  # Each test case runs for 900 secs when everything fine
>>>  # therefore the default 5 mins timeout is not enough.
> 
>> Here the code comments reminder this.
> 

