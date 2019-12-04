From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Dec 2019 14:40:10 +0800
Subject: [LTP] [PATCH 1/2] lib: add tst_request_hugepages
In-Reply-To: <20191203104917.GA2844@rei>
References: <20191128084506.7587-1-liwang@redhat.com>
 <20191203104917.GA2844@rei>
Message-ID: <CAEemH2d0KJ_oi7j5sjcT=uUo28crB_hCs-gJzvWhczvKOG-mdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 3, 2019 at 6:49 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
>
> Can we add this to the tst_test structure so that test case use this as:
>
> static struct tst_test test = {
>         ...
>         .needs_hugepages = 1,
>         ...
> }
>
>
Good point.


> That way it will be included in the test metadata I'm working on.
>
> ...
> > +
> > +     if (hpages > max_hpages) {
> > +             tst_res(TINFO, "Request %ld hugepages failed, memory too
> fragmented? "
> > +                             "The max hugepage available count %ld",
> > +                             hpages, max_hpages);
> > +             return 0;
>
> I guess that rest of the library functions returns non-zero on failure.
>

Sure, will reset the value for return.


>
> > +     }
> > +
> > +     SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%ld", hpages);
> > +     SAFE_FILE_SCANF("/proc/sys/vm/nr_hugepages", "%d", &val);
> > +     if (val != hpages)
> > +             tst_brk(TBROK, "nr_hugepages = %d, but expect %ld", val,
> hpages);
> > +
> > +     return 1;
>
> I guess that things will be more complicated than this. If there is
> already a pool of hugepages allocated on the machine and some are used
> this will utimatelly fail.
>

I don't think so, if they're already many huge pages being used, the free
memory of the system will firstly tell us the max_hpages is not satisfy for
testing, it means we have no chance to arrive here.


>
> I rember that we changed some tests to increase the nr_hugepages if
> needed instead of blindly writing values there.
>

Yes, but that's only fit for the situation which does not need the precise
number of pages, we could take 80% of the max_hpages and do our testing in
our system.

But in this function, my purpose is to request the least number of pages
for the test. e.g if the .needs_hugepages is set to an expected number, we
should verify strictly if the system can provide that.


>
> Also this fails to cleanup after itself, we have to restore the system
> after the test, which is one more reason why we need .needs_hugepages in
> the tst_test structure because the test library can cleanup after the
> test with that.
>

Agree, I will add the save/restore part for this.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191204/d52cedff/attachment.htm>
