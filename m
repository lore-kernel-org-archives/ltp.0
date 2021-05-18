From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 18 May 2021 10:57:26 +0100
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <YKN4SZcHP9GAGRH4@pevik>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-7-rpalethorpe@suse.com> <YKN4SZcHP9GAGRH4@pevik>
Message-ID: <87im3gl5yx.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Abort the build process if a new symbol is exported from the library
>> without tst_ or safe_ prepended.
>
> The PR does not work few on old toolchains [1], it fails on [2]:
>
> awk: line 1: regular expression /parse_opts ... exceeds implementation size limit
>
> It's one of the 2 awk calls in check_export_syms.sh, I suppose the other one.
> Maybe put non_prefix_syms into temporary file and then run awk on it?

I doubt it will help, it seems the ignore regex is too long. I'm not
sure we need the script to run on old toolchains though.

Maybe we need a development mode configure flag?

>
> Kind regards,
> Petr
>
> [1] https://travis-ci.org/github/pevik/ltp/builds/771465129
> [2] https://travis-ci.org/github/pevik/ltp/jobs/771465135#L3115


-- 
Thank you,
Richard.
