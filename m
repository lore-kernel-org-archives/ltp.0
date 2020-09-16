From: Bird, Tim <Tim.Bird@sony.com>
Date: Wed, 16 Sep 2020 16:29:04 +0000
Subject: [LTP] TPASS in new test lib
In-Reply-To: <20200916085405.GB4464@yuki.lan>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916071106.GB1433@dell5510> <20200916085405.GB4464@yuki.lan>
Message-ID: <CY4PR13MB1175364547D2DA3A96262516FD210@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz>
> 
> Hi!
> > Although leaving this to Cyril (although having T prefix or not is quite
> > cosmetic, he had a reason to omit it).  Also there is ongoing rewrite of tests
> > still using legacy API to use new API, thus the inconsistency will disappear in
> > the long term.
> >
> > IMHO: don't care that much about legacy API, but synchronize new C and shell
> > API.
> 
> I do not care that much here, but I do not think that we should expect
> exact test output unless we have specified it somewhere.

That's fine.  But it's probably better to avoid differences in
test output as much as possible, when the change is so trivial.  Petr seems to think
there was a reason that the result string was changed between the old and new C library.
If so, what is the reason?  If the change is only cosmetic, then I'd argue it's worth
being consistent, and I'll submit the patch properly.  (Sorry the earlier version was
inline in the message, rather than formatted correctly.)
 -- Tim

