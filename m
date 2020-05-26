From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 May 2020 02:11:59 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Waiting_for_review=3A_Test_rep?=
 =?utf-8?q?ort_for_kernel_5=2E6=2E14-dbf782f=2Ecki_=28stable-queue=29?=
In-Reply-To: <CAEemH2dCnkczxB2jWrGprRGQ=F7PB=o53MmUNDrcfhB34z4P9A@mail.gmail.com>
References: <cki.5639E3C778.X5N9P4R7GB@redhat.com>
 <2102236949.13452256.1590328678642.JavaMail.zimbra@redhat.com>
 <CAEemH2dNB3Ktt5LeBLxMKekv7-gj4d=EkQouYmO1SgbyzjLEaw@mail.gmail.com>
 <1440024610.13546915.1590416134343.JavaMail.zimbra@redhat.com>
 <CAEemH2dCnkczxB2jWrGprRGQ=F7PB=o53MmUNDrcfhB34z4P9A@mail.gmail.com>
Message-ID: <218996157.13586289.1590473519056.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Mon, May 25, 2020 at 10:15 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> > ...
> 
> 
> > > > >     s390x:
> > > > >      ? LTP
> > > >
> > > > @Li, any thoughts on hugetlb TBROKs here? I thought you said
> > > > 'request_hugepages'
> > > > was not supposed to be hard test requirement.
> > > >
> > >
> > > The hugemmap05.c doesn't goes the new 'request_hugepages' way in the huge
> > > page reserving. it tries to reserve 128 hpages and overcommits 192 hpages
> > > in hard coding, and probably touch the memory available uplimit on s390x.
> > > static long size = 128, length = 384;
> > > ...
> > > addr = SAFE_MMAP(ADDR, (length / 2 * hugepagesize), PROTECTION, FLAGS,
> > fd,
> > > 0);
> > >
> > > We could convert this to use the new request_hugepages API and do the
> > > requested number of huge page checking at setup() to make sure the system
> > > only running in a reasonable situation.
> >
> > Sorry, I didn't make it clear I was talking about hugemmap06. The patch is
> > OK,
> > since it makes both use request_hugepages API. But should we also do
> > something
> > with this TBROK?
> >
> 
> It seems unkind and useless to exit with TBROK when failed to reserve with
> 80% max_hpages again. I'm thinking if it could be directly replaced by
> TCONF to skip the whole test?

I think it can fail even when request is less than 80%, when memory is too fragmented.
I agree with TCONF, but I'd keep numbers (val, tst_hugepages) in output, so we know
how close it was to the requested number.

> 
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -43,7 +43,7 @@ unsigned long tst_request_hugepages(unsigned long hpages)
>         SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
>         SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
>         if (val != tst_hugepages)
> -               tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val,
> tst_hugepages);
> +               tst_brk(TCONF, "Not enough hugepages for testing.");
> 
>         tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
>  out:
> 
> 
> >
> >     tst_hugepage.c:46: BROK: nr_hugepages = 171, but expect 255
> >
> >
> 
> --
> Regards,
> Li Wang
> 

