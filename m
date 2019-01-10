From: Christian Lanig <clanig@suse.de>
Date: Thu, 10 Jan 2019 14:29:38 +0100
Subject: [LTP] LTP survey
In-Reply-To: <87zhs8lsgl.fsf@rpws.prws.suse.cz>
References: <20190109152532.GA346@rei.lan> <87zhs8lsgl.fsf@rpws.prws.suse.cz>
Message-ID: <e12f43e9-e09d-3aaf-b409-05ad1d62e824@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

thanks for your email. I have filled out the survey as good as possible.

I also agree that the MI metric might contain inaccuracy.

As an example, you might conclude that a high percentage of
comments(COM) eases maintainability and readability of code but comments
can contain exactly no semantic information at all but just increase the
visual attraction. In this case comments are counter productive,
introducing overhead that makes the code more difficult to maintain. In
the function high percentages of COM might be weakened already but it
still shows that the result is probably not very accurate.

It might be possible to use syntactic analysis when you presume that all
developers use given syntactic expressions to produce an optimally
readable and functional code. But then you also have to presume that
they have an infinite amount of time to solve the specific problem and
so on...

Regards,

Christian

Am 10.01.19 um 11:25 schrieb Richard Palethorpe:
> Hello,
>
> Cyril Hrubis <chrubis@suse.cz> writes:
>
>> Hi!
>> I've been asked if we can help to fill in data for the LTP Survey from
>> Jonatas send to the mailing list earlier.
>>
>> So if you haven't done so yet and can spare 10 minutes of your time,
>> please go to:
>>
>> https://docs.google.com/forms/d/e/1FAIpQLSePEESEVOCVtjuAIvm1BkToLJzEcxv_m4HBRiJzuRcQQ4DzHQ/viewform?vc=0&c=0&w=1
>>
>> And fill it in.
>>
>> Many thanks on behalf of Jonatas!
> I already filled it in once and I don't think my answers will change
> much (despite any corrects to the survey).
>
> I will add that I think MI is bullshit, it is not a metric because it
> doesn't follow the triangle inequality and it is trying to compress an
> N-dimensional problem (where N is very large) into a single scalar value
> which is dangerous if people take it seriously. The fact it has
> decreased as the LTP's code has improved shows Wittgenstein's ruler at
> work. At best it is a heuristic, but it is probably better to use/view
> its component metrics directly.
>
> --
> Thank you,
> Richard.
>
-- 
Christian Lanig - SUSE Engineering Apprentice
SUSE Linux GmbH, Maxfeldstraße 5, D-90409 Nürnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)


