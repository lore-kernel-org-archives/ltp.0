From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Dec 2019 14:59:36 +0800
Subject: [LTP] [PATCH v2 1/2] lib: add .needs_hugepages to reserve
 hugepage
In-Reply-To: <20191205115742.GA5693@rei.lan>
References: <20191205103342.5980-1-liwang@redhat.com>
 <20191205115742.GA5693@rei.lan>
Message-ID: <CAEemH2cq2WSFW=iEEOiDW4=ZiHyMNb0Dj2goaKSEVnj7wOM_fw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 5, 2019 at 7:57 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> ...
> > +2.2.34 Reproducing race-conditions
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Can we please avoid renumbering the paragraphs, i.e. can you add the
> hugepages docs after this?
>

Yes, sure.


> ...
> > +/*
> > + * If system does not support hugetlb or failed to reserve the expected
> > + * number of hugepage, then this value will be set to 1.
> > + */
> > +extern unsigned int tst_no_hugepage;
>
> Hmm, this needs a bit more thoughts.
>
> So far all the needs_foo flags require the foo to be present on the
> system, i.e. are hard requirements. In this case hugepages are soft
> requirement, i.e. only part of the test will need that.
>
> We probably need a better name for this than needs_hugepages in
> tst_test. We may as well need a generic way how to describe that some of
> the requirements are hard and some of them are soft. I will give it some
> thoughts.
>

Your consideration is valuable. '.needs_hugepages' might fail to reserve
the expected page numbers on any kind of platform which with fragmental
memory, we'd better give an elegant way to handle that situation to make
our test can work well on the remaining part.


>
> At least we should just call it request_hugepages in the tst_test
> structure instead.
>

Ok, it's fine. Unless we can come up with a better.


> ...
> > +
> > +int tst_request_hugepages(int hpages)
> > +{
> > +     int val;
> > +     long mem_avail, max_hpages;
> > +
> > +     if (access(PATH_HUGEPAGES, F_OK)) {
> > +             tst_res(TCONF, "Huge page is not supported.");
> > +             tst_no_hugepage = 1;
>
> I guess that it will make more sense to call it tst_hugepages and set it
> to a number of hugepages that we were able to reserve. I.e. set it to 0
> here and to hpages at the end.
>

Agree, that sounds more useful in many situations.


> ...
> > +     if (tst_test->needs_hugepages) {
> > +             tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
>
> Can we call this from the tst_hugepage.c instead and only if we actually
> written to that file?
>

I will have a try then.


> > +             tst_request_hugepages(tst_test->needs_hugepages);
> > +     }
> > +
> >       setup_ipc();
> >
> >       if (tst_test->bufs)
> > @@ -1006,7 +1011,8 @@ static void do_cleanup(void)
> >               tst_rmdir();
> >       }
> >
> > -     if (tst_test->save_restore)
> > +     if (tst_test->save_restore ||
> > +             (tst_test->needs_hugepages && !tst_no_hugepage))
> >               tst_sys_conf_restore(0);
>
> We can call the tst_sys_conf_restore() unconditionally here, if nothing
> has been saved it's no-op.
>

Right!


>
> >       if (tst_test->restore_wallclock)
>
> Otherwise it looks good.
>

Thanks for these useful advises.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191211/d92c3b59/attachment.htm>
