From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Aug 2020 11:28:11 +0800
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
References: <20200806162356.16920-1-mdoucha@suse.cz>
 <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cCq1LL_91pOavNWHmHGQs6EfFsyGXaOBuqh-CrFxP7Pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 10, 2020 at 4:24 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > The mem01 test often fails on PPC systems mainly because it doesn't take
> into
> > account page sizes larger than 4KB. Test scenario review revealed that
> it's
> > not particularly useful because it doesn't have any more specific goal
> than
> > filling large amount of memory and the hardcoded allocation limits are
> too
> > low for modern and future systems. The useful part of this test mostly
> > overlaps with coverage by existing OOM tests.
> >
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>


Pushed, thanks!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200817/d8f0d7f6/attachment.htm>
