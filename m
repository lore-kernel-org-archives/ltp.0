From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jun 2019 12:03:23 +0800
Subject: [LTP] [PATCH v2 3/3] testcase: get rid of compiling errors
In-Reply-To: <1243296203.28755912.1560807853881.JavaMail.zimbra@redhat.com>
References: <20190615042048.29839-1-liwang@redhat.com>
 <20190615042048.29839-3-liwang@redhat.com>
 <1243296203.28755912.1560807853881.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eCPtc6GrtAVHiHKbOeSMDgPunkBxg8YxaNOKYXLpT7yw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 18, 2019 at 5:44 AM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  configure.ac             | 1 +
> >  testcases/cve/meltdown.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 5ecc92781..521f56541 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -58,6 +58,7 @@ AC_CHECK_HEADERS([ \
> >      sys/shm.h \
> >      sys/ustat.h \
> >      sys/xattr.h \
> > +    emmintrin.h \
> >  ])
> >
> >  AC_CHECK_FUNCS([ \
> > diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
> > index 72c9ec907..bc649b893 100644
> > --- a/testcases/cve/meltdown.c
> > +++ b/testcases/cve/meltdown.c
> > @@ -29,6 +29,7 @@
> >  #include <ctype.h>
> >  #include <sys/utsname.h>
> >
> > +#ifdef HAVE_EMMINTRIN_H
> >  #include <emmintrin.h>
> >
> >  #include "libtsc.h"
> > @@ -387,3 +388,7 @@ static struct tst_test test = {
> >       .cleanup = cleanup,
> >       .min_kver = "2.6.32"
> >  };
> > +
> > +#else /* HAVE_EMMINTRIN_H */
> > +     TST_TEST_TCONF("<emmintrin.h> is not supported");
> > +#endif
>
> This seems more complicated to me than original - extra autoconf check,
> extra ifdef.
>

Indeed.
I choose meltdown.c as a demo randomly, this patch is to solve the
compiling error after removing ifdef __arch__ from code. So, as you can see
the tst_test.arch is not perfect, but it could be used for some general
situations.


> I can see how tst_on_arch() would be useful. Test is valid on all arches,
> but needs different input/constants/code/etc.
>

That's the original reason I exported it in patch v1.

Cyril and I have discussed this part, we think tst_on_arch() is not cleaner
than ifdefs, so it's not suggested to use it directly in a test case.


>
> What is the motivation for tst_test.arch? Is it to have some annotation in
> tst_test struct?
>

The first motivation is to save LTP user from arch ifdefs, moves the
information from code to tst_test metadata, but seems that it can not be
completely replaced because of the specific assembly inline. So I still
hope to find a better way for that, even not go with this tst_test.arch.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190618/f15ba24d/attachment.html>
