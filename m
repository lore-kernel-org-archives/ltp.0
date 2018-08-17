From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Aug 2018 11:09:32 +0800
Subject: [LTP] [PATCH v2] pty: fix some issues in pty02
In-Reply-To: <5B763508.2070504@cn.fujitsu.com>
References: <20180817022623.2657-1-liwang@redhat.com>
 <5B763508.2070504@cn.fujitsu.com>
Message-ID: <CAEemH2enO9wzqL2AAeuNMwNS5VxQTgi+bxUPgTMujoeaQvMqDQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> +     TEST(tcsetattr(ptmx, TCSANOW, &io));
> > +     if (TEST_RET == -1) {
> > +             if (TEST_ERR == EINVAL)
> > +                     tst_res(TCONF, "tcsetattr(, , EXTPROC | ICANON) is
> not supported");
> Hi Li,
>
> Should we use tst_brk(TCONF, ...) instead?


Yes, right.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180817/a3cee8ec/attachment.html>
