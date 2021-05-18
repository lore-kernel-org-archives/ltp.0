From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 16:57:06 +0200
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <87im3gl5yx.fsf@suse.de>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-7-rpalethorpe@suse.com>
 <YKN4SZcHP9GAGRH4@pevik> <87im3gl5yx.fsf@suse.de>
Message-ID: <YKPVwoRiJKLqneN3@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hello Petr,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> >> Abort the build process if a new symbol is exported from the library
> >> without tst_ or safe_ prepended.

> > The PR does not work few on old toolchains [1], it fails on [2]:

> > awk: line 1: regular expression /parse_opts ... exceeds implementation size limit

> > It's one of the 2 awk calls in check_export_syms.sh, I suppose the other one.
> > Maybe put non_prefix_syms into temporary file and then run awk on it?

> I doubt it will help, it seems the ignore regex is too long. I'm not
> sure we need the script to run on old toolchains though.

> Maybe we need a development mode configure flag?

I'll have a look into it, as I'd prefer to be fixed
(than repeat people on mailing list that this does not work on older distros).
It's actually only on Debian stable or older.

Kind regards,
Petr

> > Kind regards,
> > Petr

> > [1] https://travis-ci.org/github/pevik/ltp/builds/771465129
> > [2] https://travis-ci.org/github/pevik/ltp/jobs/771465135#L3115
