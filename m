From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2019 15:10:02 +0800
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of
 write back
In-Reply-To: <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
References: <20191218082826.25083-1-liwang@redhat.com>
 <2104821569.17247635.1576661091375.JavaMail.zimbra@redhat.com>
 <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
Message-ID: <CAEemH2eRhmozt5OiT6z-YBjJUBNaGZgQVQRh40hNpKcq2d4-aw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sumit,

On Wed, Dec 18, 2019 at 6:14 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> + Cyril (who originally proposed upper bound check)
>
> On Wed, 18 Dec 2019 at 14:55, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> > ----- Original Message -----
> > > " The test's assumptions are fundamentally false; it thinks it can look
> > > at IO counters (tst_dev_bytes_written) for a disk before and after a
> > > system call, and attribute all of the IO seen to the system call that
> > > was made - this isn't necessarily correct. Other processes may generate
> > > IO in the background.
> >
> > We create our own block device, so there shouldn't be other processes
> > writing to it.
> >
> > > ext4 defers a lot of IO on a freshly made filesystem to the kernel -
> > > for example it will initialize the journal and inode tables after the
> > > mount
> >
> > Journal was my guess as well.
>
> To avoid similar scenarios, I suggested to add a "sync()" call just
> prior to test here [1]. And I couldn't reproduce the failure in
> 1000-times run with 4.19 kernel.
>

Yes, that makes sense to me.


>
> Also, I think having a "sync()" call becomes more important in case we
> remove the upper bound otherwise test might not provide reliable
> results.
>
> [1] http://lists.linux.it/pipermail/ltp/2019-October/014157.html
>
> -Sumit
>
> >
> > > Let's remove the toplimit of write back, and think as long as we synced
> > > at least the expected amount, the test passes. The +10% limit seems
> > > arbitrary.
> >
> > I think this is reasonable approach until we find better way
> > to measure what was synced.
> >
> > Acked-by: Jan Stancek <jstancek@redhat.com>
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191219/d21b6bec/attachment.htm>
