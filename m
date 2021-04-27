From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 27 Apr 2021 10:50:39 +0100
Subject: [LTP] [PATCH 2/2] bpf: Check truncation on 32bit div/mod by zero
In-Reply-To: <YIfZqZ29H2AN1vqh@pevik>
References: <20210426120107.6632-1-rpalethorpe@suse.com>
 <20210426120107.6632-2-rpalethorpe@suse.com> <YIfZqZ29H2AN1vqh@pevik>
Message-ID: <87k0oot5sg.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richard,
>
>> Add a test which checks for a number of issues surrounding division by
>> zero.
>
>> +++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
> ...
>> +/*\
>> + * [Description]
>> + *
>> + * Compare the effects of 32-bit div/mod by zero with the "expected"
> FYI this causes docparser error:
>
> /usr/src/ltp/docparse/testinfo.pl metadata.json
> , or ] expected while parsing array, at character offset 70801 (before "expected"",\n     "b...") at /usr/src/ltp/docparse/testinfo.pl line 423
>
> Because we don't escap double quotes (among other issues previously reported,
> e.g. tabs), it produces invalid json:

bah, maybe we should just base64 encode doc strings in the JSON?

>
>    "doc": [
>      "[Description]",
>      "",
>      "Compare the effects of 32-bit div/mod by zero with the "expected"",
>      "behaviour.",
>      "",
>
> But I tested it on various OS and the code compiles and runs ok.
>
> I also looked at the code (very interesting), but with my minimal bpf knowledge
> I'm not the one who should review it.
>
>> + * behaviour.
>> + *
>> + * The commit "bpf: fix subprog verifier bypass by div/mod by 0
>> + * exception", changed div/mod by zero from exiting the current
>> + * program to setting the destination register to zero (div) or
>> + * leaving it untouched (mod).
>> + *
>> + * This solved one verfier bug which allowed dodgy pointer values, but
>                       ^
>                       verifier

+1

>
>> + * it turned out that the source register was being 32-bit truncated
>> + * when it should not be. Also the destination register for mod was
>> + * not being truncated when it should be.
>> + *
>> + * So then we have the following two fixes:
>> + * "bpf: Fix 32 bit src register truncation on div/mod"
>> + * "bpf: Fix truncation handling for mod32 dst reg wrt zero"
> - * "bpf: Fix 32 bit src register truncation on div/mod"
> - * "bpf: Fix truncation handling for mod32 dst reg wrt zero"
> (making it list)

+1
>
>> + *
>> + * Testing for all of these issues is a problem. Not least because
>> + * division by zero is undefined, so in theory any result is
>> + * acceptable so long as the verifier and runtime behaviour
>> + * match.
>> + *
>> + * However to keep things simple we just check if the source and
>> + * destination register runtime values match the current upstream
>> + * behaviour at the time of writing.
>> + *
>> + * If the test fails you may have one or more of the above patches
>> + * missing. In this case it is possible that you are not vulnerable
>> + * depending on what other backports and fixes have been applied. If
>> + * upstream changes the behaviour of division by zero, then the test
>> + * will need updating.
>> +\*/
> @metan: remove this before merge.
>
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
