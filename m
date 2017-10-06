From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 06 Oct 2017 12:02:47 +0200
Subject: [LTP] [RFC PATCH 0/6] Fix 32-bit cross compilation
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <874lrc4mrc.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello Petr,

Petr Vorel writes:

> Hi,
>
> these patches fixes 32-bit cross compilation build.
> I'm not an autotools expert so I tried to minimize changes.
> I extended header checks with library checks.

Good stuff, I have briefly tested the patch and it seems to
work. However I am wondering whether it is a good idea to remove the
header checks. It is not clear to me that AC_CHECK_LIB also somehow
checks that the relevant header exists as well. Perhaps it guesses the
header path from the library name, but it doesn't quite make sense to
me.

--
Thank you,
Richard.
