From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jul 2019 12:53:03 +0800
Subject: [LTP] [PATCH v2] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190726133124.GC28028@rei.lan>
References: <20190725033713.8551-1-liwang@redhat.com>
 <20190726121255.GA28028@rei.lan>
 <CAEemH2c96sB1ZA_vnTxSaBy-v=G_WnR58LX+Wt=Q8=UxO0dNtQ@mail.gmail.com>
 <20190726133124.GC28028@rei.lan>
Message-ID: <CAEemH2dHY8A8baLEMP5hEy51_r+=5Q63j2uqG6FHHYuf43sY2w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 26, 2019 at 9:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > So, maybe we have to re-evaluate this patch V2 and to figure out why
> > the retry mmap() hitting SIGBUS fails.
>
> One possibility would be that the numa_move_pages() triggers SIGBUS
> while we do the usleep() before we attempt to retry the mmap(). In that
> case the race was present in the test all the time but couldn't be
> triggered because the window where the memory is unmapped was very
> short. If that is the case we should as well set up a handler to SIGBUS
> and ignore it as well.

No, It's not like the numa_move_pages() triggers SIGBUS because in the
end child print:
    move_pages12.c:114: FAIL: move_pages failed: ESRCH
that ESRCH means the child is still alive and detect ppid is not available.

It's more like to retry mmap() triggers SIGBUS while doing the
numa_move_pages() in background. That is very similar to the kernel
bug which was mentioned by commit 6bc9b56433b76e40d(mm: fix race on
soft-offlining ). A race condition between soft offline and
hugetlb_fault which causes unexpected process SIGBUS killing.

And, I will send an email to linux-mm@ to RFC.

--
Regards,
Li Wang
