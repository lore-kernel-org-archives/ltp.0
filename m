From: Li Wang <liwang@redhat.com>
Date: Sun, 26 Apr 2020 19:59:39 +0800
Subject: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <3268f153-6730-708f-ed93-19ca4cf85fdd@cn.fujitsu.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
 <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com>
 <CAEemH2cF-kziNEHuN1GayTtzwdxFFzsu0wRGB85yJ=LaKS-XBw@mail.gmail.com>
 <3268f153-6730-708f-ed93-19ca4cf85fdd@cn.fujitsu.com>
Message-ID: <CAEemH2ee7c55=EQb5qohpu40XMACSOCrSStwWt7u=_GyqjrxLw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 23, 2020 at 6:32 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi LI
>
> >
> >
> > On Thu, Apr 23, 2020 at 4:45 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com
> > <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> >
> >     ...
> >      > I got a failure on the ppc64le platform(page size: 65536kB).
> >      >
> >      > # ./pipe2_03
> >      > tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> >      > pipe_size = 1048576
> >      > PIPE_BUF = 4096
> >      > packet_num = 256
> >      > safe_macros.c:457: BROK: pipe2_03.c:58:
> >      > write(4,0x1001d2b8,18446744073709551615) failed:
> >     EAGAIN/EWOULDBLOCK (11)
> >     I think we should remove PIPE_BUF and use page_size  because we use a
> >     page to store data not a fixed size buffer in kernel. as below(also,
> >     man-pages[1] is need to update):
> >
> >
> > Emm, If PIPE_BUF doesn't work correctly, shouldn't this a kernel pipe
> > bug? I think we need to take a close look at what happened there but not
> > to replace by using page_size directly.
> > --
> It is only defined in limit.h(I only think it is a error in limit.h) and
>   PIPE_BUF doesn't be used in kernel.
>

[PAGE_SIZE or PIPE_BUFF]

From kernel code seems you are right. The pipe indeed takes use of
PAGE_SIZE(ppc64le: 64kB) to split the writes data in the packetized mode
(marked by O_DIRECT). But in the manual page, O_DIRECT indicates us the
PIPE_BUF is the correct atomic unit. Since PIPE_BUF is defined to 4kB that
is equal to PAGE_SIZE on x86_64 so your test gets PASS there.

I feel confused about whether it's a kernel pipe bug or just need to
correct the manual page.

@Linus, can you give some advice on this? Thanks!


> In kernel code, pipes use struct pipe_buffer to store buffer data and
> other info,
> struct pipe_buffer {
>          struct page *page; //alloc page to store data
>          unsigned int offset, len;
>          const struct pipe_buf_operations *ops;
>          unsigned int flags; //
>          unsigned long private;
> };
>
> as my pipe2_01.c said we only make buf with PIPE_BUF_FLAG_PACKET flag in
> write end , and read will check this flag.  This unit is a page instead
> of this PIPE_BUF macro.
>
> Best Regards
> Yang Xu
> > Regards,
> > Li Wang
>
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200426/205b68e5/attachment.htm>
