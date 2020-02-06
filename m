From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 06 Feb 2020 13:36:26 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <87imkjhq6m.fsf@our.domain.is.not.set>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz> <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz> <20200205155012.GA4920@rei>
 <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz> <20200205191006.GA18877@rei>
 <87lfpgges0.fsf@our.domain.is.not.set>
 <f50e75f0-5575-0753-5b3e-dc1e6d66e2b7@suse.cz>
 <87imkjhq6m.fsf@our.domain.is.not.set>
Message-ID: <87h803hoz9.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hi,
>
> Martin Doucha <mdoucha@suse.cz> writes:
>
>> On 2/6/20 12:02 PM, Richard Palethorpe wrote:
>>> Hello,
>>>
>>> Cyril Hrubis <chrubis@suse.cz> writes:
>>>> Can we please discuss things calmly and rationally? If you want to give
>>>> up on your patch that's fine, however if you want to continue to discuss
>>>> technical details, let's do it without emotions, okay?
>>>
>>> Honestly this is a style issue, so we can exchange one or two opinions,
>>> but then just decide Cyril is right (because he has survived as
>>> maintainer for X years with similar ideas about style) and move on to
>>> things where the universe proves you right or wrong in the time it takes
>>> to compile and run your code.
>>
>> Do I really need to remind you all that we've had a bug caused by this
>> exact lack of basic code hygiene right before the last release?
>>
>> http://lists.linux.it/pipermail/ltp/2020-January/015099.html
>
> Yes, how is this the exact same issue?
>
> There is a big difference between showing a concrete example and
> simply asserting something.

OK, I see why it is, it prevents a class of bugs by avoiding "namespace
pollution". This is a concrete argument which has a history of causing
problems.

OTOH, At least with compilers which don't have link time optimisation
(everything except Clang?), there is an advantage to including stuff
inline. Hence why fzsync is entirely in the header, although I don't
think it matters much either way for LTP.

So perhaps it should be the default to seperate headers from
implementation...

I still just defer to Cyril though. He deals with most of these
problems...

--
Thank you,
Richard.
