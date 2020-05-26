From: Li Wang <liwang@redhat.com>
Date: Tue, 26 May 2020 18:23:44 +0800
Subject: [LTP] [PATCH] lib: use TCONF if hpage reserve failed in retry
In-Reply-To: <2000957070.13598874.1590483511876.JavaMail.zimbra@redhat.com>
References: <20200526070901.12957-1-liwang@redhat.com>
 <2000957070.13598874.1590483511876.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2enek2YivV+F9bLGXqnHEVVM7cLPyvyYUnrw5z9NPQcYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 26, 2020 at 4:58 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > Test still easy to get fail in hpages reserving (only 80% of
> > max_hpages) because of memory fragmentation.
> >
> >   tst_hugepage.c:46: BROK: nr_hugepages = 171, but expect 255
> >
> > But it seems unkind and useless to exit with TBROK when failed
> > in hpage reserve retrying. This patch proposes to use TCONF for
> > better log review.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Jan Stancek <jstancek@redhat.com>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>

Pushed, thanks for the review.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200526/d7090e1a/attachment-0001.htm>
