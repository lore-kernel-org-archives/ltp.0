From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2019 13:48:09 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190703131005.GA1712@rei>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190703131005.GA1712@rei>
Message-ID: <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 3, 2019 at 9:10 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > +                     if (ret == EINVAL) {
> >                               SAFE_KILL(cpid, SIGKILL);
> >                               SAFE_WAITPID(cpid, &status, 0);
> >                               SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> >                               tst_res(TCONF,
> >                                       "madvise() didn't support
> MADV_SOFT_OFFLINE");
> >                               return;
> > +                     } else if (ret == EBUSY) {
> > +                             SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> > +                             goto out;
>
> Shouldn't we continue with the test here rather than exit?
>
> I guess that there is no harm in doing a few more iterations if we
> manage to hit EBUSY, or is there a good reason to exit the test here?
>

Yes, we can do more iterations then, but it probably makes no sense.

The reason I guess is that, if we get an EBUSY on the hugepage offline,
that means the page is already being isolated by move_pages() in the child
at that moment and we can't really release it. So in the next iteration,
the mmap() will be failed with ENOMEM(since we only have 1 huge page in
/proc/.../nr_hugepages).

To confirm that, I change the code to continue after get EBUSY, but it
couldn't:

# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:251: INFO: Free RAM 30860672 kB
move_pages12.c:269: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:279: INFO: Increasing 2048kB hugepages pool on node 1 to 5
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:185: PASS: Bug not reproduced
move_pages12.c:146: CONF: Cannot allocate hugepage, memory too fragmented?

>
> Otherwise the patch looks good.
>

Thanks for review.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190704/599eaa3d/attachment.htm>
