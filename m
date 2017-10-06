From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Oct 2017 16:43:20 +0200
Subject: [LTP] [RFC PATCH 0/6] Fix 32-bit cross compilation
In-Reply-To: <874lrc4mrc.fsf@our.domain.is.not.set>
References: <20171006015336.29972-1-pvorel@suse.cz>
 <874lrc4mrc.fsf@our.domain.is.not.set>
Message-ID: <20171006144320.vqrg4i2bte7beklv@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

thanks a lot for a feadback.
> > these patches fixes 32-bit cross compilation build.
> > I'm not an autotools expert so I tried to minimize changes.
> > I extended header checks with library checks.

> Good stuff, I have briefly tested the patch and it seems to
> work. However I am wondering whether it is a good idea to remove the
> header checks. It is not clear to me that AC_CHECK_LIB also somehow
> checks that the relevant header exists as well. Perhaps it guesses the
> header path from the library name, but it doesn't quite make sense to
> me.
No, it an error, AC_CHECK_LIB doesn't check it. I'll put the relevant checks back in v2,
into AC_CHECK_HEADERS in configure.ac.


Kind regards,
Petr
