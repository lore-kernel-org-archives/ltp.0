From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Sep 2020 13:23:27 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <87sgbgy946.fsf@suse.de>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916071106.GB1433@dell5510> <20200916085405.GB4464@yuki.lan>
 <87sgbgy946.fsf@suse.de>
Message-ID: <20200917112327.GA16492@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Cyril Hrubis <chrubis@suse.cz> writes:

> > Hi!
> >> Although leaving this to Cyril (although having T prefix or not is quite
> >> cosmetic, he had a reason to omit it).  Also there is ongoing rewrite of tests
> >> still using legacy API to use new API, thus the inconsistency will disappear in
> >> the long term.

> >> IMHO: don't care that much about legacy API, but synchronize new C and shell
> >> API.

> > I do not care that much here, but I do not think that we should expect
> > exact test output unless we have specified it somewhere.

> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz

> It would be possible to output something like TAP and allow it to be set
> at compile time.

> Infact it should be possible to print JSON, xUnit or whatever
> snippets. We could also print the meta data for each test at the
> begining which would work quite well with structured formats.
+1. JSON or xUnit would certainly be useful for integrating LTP into other
testing frameworks. Sure, all frameworks which embeds LTP are fine with just
grep the output for T?PASS, (T?FAIL, ...), but this way we could also pass
test metadata to frameworks.

Kind regards,
Petr
