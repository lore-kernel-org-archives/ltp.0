From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 7 Jul 2021 12:16:18 +0200
Subject: [LTP] [PATCH] kill13, CVE-2018-10124: Reproduce INT_MIN negation
In-Reply-To: <87a6my788m.fsf@suse.de>
References: <20210707071838.27834-1-rpalethorpe@suse.com>
 <43e8b66b-04df-9c4f-c47b-aba13347b6d8@jv-coder.de>
 <6c665478-d831-9e3f-470c-8538a399e4f7@jv-coder.de> <87a6my788m.fsf@suse.de>
Message-ID: <c67e4bc2-3159-d61d-0307-38e83e50ea24@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 7/7/2021 12:01 PM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> Hi,
>>
>> On 7/7/2021 10:35 AM, Joerg Vehlow wrote:
>>> Hi Richard,
>>>
>>> On 7/7/2021 9:18 AM, Richard Palethorpe via ltp wrote:
>>> Results in INT_MIN? What does this mean or did you meant to write
>>> results in ESRCH?
>>> Default negating int min in two's complement yields 0 (INT_MIN =
>>> b1000... and negating means inverting the first bit -> thus 0).
>> Nevermind... Just checked. Looks like somehow x86 keeps -INT_MIN.
>> Now I know what you mean with "results in INT_MIN"
>>
>> Joerg
> Actually this seems to be expected unless the CPU takes action to prvent
> it. As you invert all the bits then add one in two's complement. So
> inverting results in INT_MAX then we add one and overflow back to
> INT_MIN.
Ahh yes totally had the wrong model of * -1 in my head... Of course it 
is invert everything and add +1.
That of course means -INT_MIN == INT_MIN.

>
> It is undefined though so the CPU could decide to do something
> else. OTOH it seems quite unlikely we will get anything other than
> INT_MIN or INT_MAX. So I will set sig number to zero as you suggested
> and we will just have to rely on UBSAN.
With this change:
Acked-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

J?rg
