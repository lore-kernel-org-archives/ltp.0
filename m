From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Aug 2020 12:23:33 +0800
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <462582af-8a13-e5c1-a8f7-63a7e03571c7@cn.fujitsu.com>
References: <20200806162356.16920-1-mdoucha@suse.cz>
 <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
 <CAEemH2cCq1LL_91pOavNWHmHGQs6EfFsyGXaOBuqh-CrFxP7Pg@mail.gmail.com>
 <462582af-8a13-e5c1-a8f7-63a7e03571c7@cn.fujitsu.com>
Message-ID: <CAEemH2cVgM8tmANMRUBnL1M6E_t94H7vb5eaahy8YyO2StEPcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 17, 2020 at 11:47 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Li
>
>
> >
> >
> > On Mon, Aug 10, 2020 at 4:24 PM Jan Stancek <jstancek@redhat.com
> > <mailto:jstancek@redhat.com>> wrote:
> >
> >
> >     ----- Original Message -----
> >      > The mem01 test often fails on PPC systems mainly because it
> >     doesn't take into
> >      > account page sizes larger than 4KB. Test scenario review revealed
> >     that it's
> >      > not particularly useful because it doesn't have any more specific
> >     goal than
> >      > filling large amount of memory and the hardcoded allocation
> >     limits are too
> >      > low for modern and future systems. The useful part of this test
> >     mostly
> >      > overlaps with coverage by existing OOM tests.
> >      >
> >      > Signed-off-by: Martin Doucha <mdoucha@suse.cz
> >     <mailto:mdoucha@suse.cz>>
> >
> >     Acked-by: Jan Stancek <jstancek@redhat.com <mailto:
> jstancek@redhat.com>>
> >
> > Pushed, thanks!
> >
> [root@localhost ltp]# git grep mem01
> testcases/kernel/syscalls/ioctl/ioctl_sg01.c: * a read-accessible
> SCSI-compatible device (e.g. SATA disk). Running mem01
> [root@localhost ltp]#
>
> ioctl_sg01.c has such description " Running mem01
>   * test program before this one may increase the chance of successfully
>   * reproducing the bug."
>
> I guess we should also remove this or use oom testcases can also
> increase this rate(I don't try ).
>

Good catch, I will help submit a patch to fix that code comment.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200817/5e323fd6/attachment.htm>
