From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Nov 2018 16:56:44 +0100
Subject: [LTP] RFC: changed error code when binding unix socket twice
In-Reply-To: <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
 <20181029163331.GA31059@dell5510>
 <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
Message-ID: <20181107155644.GA29531@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

> I forgot that 4.1 has ended a while ago. Greg also sometimes still takes patches
> for 3.18, so that might be a candidate aside from 3.18

Gregkh, David, does it make sense to you to merge commit 0fb44559ffd6 ("af_unix:
move unix_mknod() out of bindlock") to 3.18? If yes, please do so.


> > I guess we need to adjust LTP test to accept either return code as EOL longterm
> > branches probably will not take this patch.

> I'd argue that if we decide that EADDRINUSE is the intended return value,
> it would be appropriate for LTP to warn about kernels that never got the
> backport.

> The alternative would be to not backport the patch further, and then change LTP
> to no longer warn. Note that the bug that got fixed by the 0fb44559ffd6 patch
> is probably more important than the return code, so I would say
> we want the patch backported to anything that people still run anyway,
> especially if they are running LTP to make sure it works correctly.

>         Arnd

Kind regards,
Petr
