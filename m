From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Apr 2020 18:04:57 +0800
Subject: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
 <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com>
Message-ID: <CAEemH2cF-kziNEHuN1GayTtzwdxFFzsu0wRGB85yJ=LaKS-XBw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 23, 2020 at 4:45 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
> > I got a failure on the ppc64le platform(page size: 65536kB).
> >
> > # ./pipe2_03
> > tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> > pipe_size = 1048576
> > PIPE_BUF = 4096
> > packet_num = 256
> > safe_macros.c:457: BROK: pipe2_03.c:58:
> > write(4,0x1001d2b8,18446744073709551615) failed: EAGAIN/EWOULDBLOCK (11)
> I think we should remove PIPE_BUF and use page_size  because we use a
> page to store data not a fixed size buffer in kernel. as below(also,
> man-pages[1] is need to update):
>

Emm, If PIPE_BUF doesn't work correctly, shouldn't this a kernel pipe bug?
I think we need to take a close look at what happened there but not to
replace by using page_size directly.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200423/14abc40f/attachment.htm>
