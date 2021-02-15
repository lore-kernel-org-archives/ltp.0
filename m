From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Feb 2021 11:55:24 +0100
Subject: [LTP] [COMMITTED] [PATCH] mq_timedreceive_5-3: Initialize
 maxmsg properly
In-Reply-To: <853a0890-6426-5708-88a8-692885b9dd6f@jv-coder.de>
References: <20210212151525.20112-1-chrubis@suse.cz>
 <853a0890-6426-5708-88a8-692885b9dd6f@jv-coder.de>
Message-ID: <YCpTHC2FLaC5vzVH@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The test can be actually executed as non-root user but the maxmsg must
> > be set to a value that is less by user limit for messages and since we
> > do not send any messages we can safely initialize it to 1.
> This is applies to more than only this test. I also recognized this when 
> fixing the time issue, but decided not to change it, because it is not 
> the only affected test.

Feel free to send a patch for the rest :-).

Setting the mq_maxmsg to BUFFER which is supposed to be constant for the
mq_msgsize is quite confusing and also prevents these tests from being
executed as ordinary user so I think that it's worth fixing.

> The max message size could be up to /proc/sys/fs/mqueue/msg_max. This is 
> usually 10.

Looking at the rest of the tests I guess the original author either did
not care that much or was clueless since it does not really make sense
to set mq_maxmsg to the same number as mq_msgsize in tests that send
just one or two message.

So we should either set it to 2 in all tests, or set it to 1 or 2
depending on how many messages test sends.

-- 
Cyril Hrubis
chrubis@suse.cz
