From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2019 17:46:02 +0800
Subject: [LTP] [PATCH V2] madvise09:Update PAGES to a larger value
In-Reply-To: <20190912094121.GA7714@rei.lan>
References: <1568266635-17666-1-git-send-email-shuang.qiu@oracle.com>
 <CAEemH2dnWfhmTBHyKPJ9iAgEKPNcCBGwuUJ+zC8+UCFCvX5eSw@mail.gmail.com>
 <20190912094121.GA7714@rei.lan>
Message-ID: <CAEemH2eydf8umq3NSfQJDcSxKnfLPsV=mzaJ1r5Q9LkcSedmAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 12, 2019 at 5:41 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Thanks for the quick work on this.
> >
> > There are two problems that you probably ignored.
> >
> > 1. On ppc64 system, the page size is 64KB, and 970 * 64KB is almost 60MB
> > which we do allocate. So we'd better raise
> > the limit_in_bytes/memsw.limit_in_bytes a little in cgroup
> correspondingly.
> >
> > 2. As Cascardo points out, madvise09 gets retries in an infinite loop
> when
> > hitting OOM. That's because, in the run() function, it does not limit the
> > retry times. We need to take care of this as well.
>
> I guess that the debug printing would go out of hand as well, 970
> characters printed into the console is no fun either. The test needs a
> bit more than just bumping the number of pages. However as we are
> getting really close to release I guess that the best course of action
> would be workarounding the issue for now by bumping the number of pages
> to something as 128 pages. Then we can rework the test once LTP has been
> released.
>

OK for me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/053bfaca/attachment-0001.htm>
