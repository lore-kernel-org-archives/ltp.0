From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jul 2019 11:18:39 +0200
Subject: [LTP] [RFC PATCH] syscalls: Remove getcontext01
In-Reply-To: <20190722091403.GA12237@dell5510>
References: <20190722083356.10142-1-pvorel@suse.cz>
 <20190722085215.GA10580@rei.lan> <20190722091403.GA12237@dell5510>
Message-ID: <20190722091839.GB10580@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Being deprecated from POSIX is never a reason to remove tests as far as
> > the API is exposed to userspace it should be tested.
> OK, thanks for a clarification. I thought that, but wasn't sure. That's
> why this RFC. Agree with the point + it's still in current glibc.
> 
> BTW Maybe it'd be good to write down this policy + write which glibc versions
> we support, which would answer whether some functionality can be removed in
> given point (we describe goals and mention glibc in old document doc/ltp-howto.{txt,lyx},
> but IMHO we should update this document remove lyx version and add it to wiki).

I guess that the ltp-howto.lyx should be just removed along with the
man3 directory, generally the doc/ directory could use some cleanup.

Also we do have most of the up-to-date documentation in the
test-writing-guidelines.txt so I we may as well add this kind of
information there.

> > What is the real motivation for this removal?
> Looking over the weekend on tests which does not compile on musl
> (which does not include deprecated functionality). I'll rewrite the test into
> new API and add autotools check.

Ack.

-- 
Cyril Hrubis
chrubis@suse.cz
