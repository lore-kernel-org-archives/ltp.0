From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Oct 2017 17:04:17 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <878tgtwqk7.fsf@our.domain.is.not.set>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
 <20171002122920.rpurivi6x46duh4c@dell5510>
 <878tgtwqk7.fsf@our.domain.is.not.set>
Message-ID: <20171002150417.jodtfynklflxe5pl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> It is more advanced than the one I created to do something similar.

> > // SAFE_BIND
> > @old_safe_bind depends on test_h@
> > expression sockfd, sockaddr, addrlen;
> > identifier cleanup_fn;
> > expression e, x;
> > constant TFAIL;
> > @@
> > -if (bind(sockfd, sockaddr, addrlen) < 0) {
> > -	tst_brkm(e, cleanup_fn, ...);
> > (
> > -	return -1;

> > )
> > 	... when != x & TFAIL

> What does the last line do? I am guessing it prevents the substitution
> if it finds TFAIL anywhere in the above expression.
Precisely :-).


Kind regards,
Petr
