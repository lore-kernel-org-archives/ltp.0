From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jul 2021 21:17:41 +0800
Subject: [LTP] [PATCH] gethostid: Rewrite with newlib and use/test
 sethostid
In-Reply-To: <YOboa9GY1eL+HR99@yuki>
References: <20210708080720.18997-1-xieziyao@huawei.com>
 <CAEemH2cTBd45n9F5Db+Xc3ZE0R8GyLVa1AVsgbEPYFB+2hVV5Q@mail.gmail.com>
 <16e18b1d-93c7-9885-9485-c2d08c17c02d@huawei.com> <YOboa9GY1eL+HR99@yuki>
Message-ID: <CAEemH2c7jk0C7DGkbeb_99ysCzQr-5bn1NDb0y9LXHdR56vqOQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Ziyao,

Thanks for catching the failure, I have posted a new patch fixing that.
And sorry for my negligence in code pushing.

On Thu, Jul 8, 2021 at 8:24 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > I made some refine and pushed, thanks!
> > Thanks for your review. Besides, I noticed the CI fails to be compiled
> > on Apine. The difference appears to be caused by the underlying libc
> > implementation: glibc and Alpine's musl-libc.
> >
> > Is there anything that needs to be modified for this patch? Or simply
> > ignore it in the CI script.
>
> This has to be fixed, the whole point of the CI is to catch build
> failures on different libc/compiler combinations.
>
> Looking at musl the sethostid() is not implemented at all, so I guess
> that the correct solution here would be adding a configure check for
> sethostid() and skip the whole test if it's not available.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/6ef6576a/attachment.htm>
