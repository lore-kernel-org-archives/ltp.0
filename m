From: Li Wang <liwang@redhat.com>
Date: Sat, 14 Mar 2020 16:01:45 +0800
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
In-Reply-To: <20200313141458.GB21248@dell5510>
References: <20200313141458.GB21248@dell5510>
Message-ID: <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

This is a good topic, thanks for kicking off this initiative!

On Fri, Mar 13, 2020 at 10:15 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> I'm sorry, I've raised this question in the past, but it got lost.
> I remember we talked about 2.6 something.
>

Yes, the past discussion is still valuable to us. see:
http://lists.linux.it/pipermail/ltp/2019-May/011990.html


> It'd be good to state publicly the oldest kernel and glibc (or even other
> libc
> versions) we support.  This would allow us to remove some legacy code or
> force
> support for legacy code.
>

Maybe we could also state the oldest GCC version too? Though I haven't seen
any conflict or supporting issue from my side, it helps avoid some
potential error in cross-compilation I guess.

    i.e.  kernel-3.10.0 / glibc-2.17 / gcc-4.8.0


>
> This shouldn't require test to be functional (e.g. for some cases like
> module
> drivers it could be hard), but LTP to be compiled and when
> difficult/impossible
> to achieve this functionality, it could resulted in TCONF (skipped test).
>
+1


>
> I created github issue for this [1], where I put link to this thread, so we
> don't loose it again.
>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/issues/657
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200314/6475dc29/attachment.htm>
