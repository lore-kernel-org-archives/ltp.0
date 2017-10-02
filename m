From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 02 Oct 2017 16:51:52 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
	SOCKET} macros
In-Reply-To: <20171002122920.rpurivi6x46duh4c@dell5510>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
 <20171002122920.rpurivi6x46duh4c@dell5510>
Message-ID: <878tgtwqk7.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel writes:

> Hi Richard, Cyril,
>
>> Hello Petr,
>
>> > Patch was made thanks to Coccinelle.
>> Very good. Also how about including the Coccinelle patch in the tools or
>> scripts folder?
>
> Cyril, do you like this idea?
>
> Well, I'm not much proud on that script, it's my first Coccinelle
> script :-)

It is more advanced than the one I created to do something similar.

>
> @test_h@
> @@
> #include "test.h"
>
> @tst_test_h@
> @@
> #include "tst_test.h"
>
> // test.h does not include safe_macros.h
> @safe_macros_h@
> @@
> #include "safe_macros.h"
>
> @is_safe_socket@
> @@
> int safe_socket(...) {...}
>
> // SAFE_BIND
> @old_safe_bind depends on test_h@
> expression sockfd, sockaddr, addrlen;
> identifier cleanup_fn;
> expression e, x;
> constant TFAIL;
> @@
> -if (bind(sockfd, sockaddr, addrlen) < 0) {
> -	tst_brkm(e, cleanup_fn, ...);
> (
> -	return -1;
> |
> )
> 	... when != x & TFAIL

What does the last line do? I am guessing it prevents the substitution
if it finds TFAIL anywhere in the above expression.

-- 
Thank you,
Richard.
