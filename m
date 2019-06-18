From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jun 2019 10:53:39 +0800
Subject: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
	structure
In-Reply-To: <20190617214619.GB19347@x230>
References: <20190615042048.29839-1-liwang@redhat.com>
 <20190617214619.GB19347@x230>
Message-ID: <CAEemH2fOWyn2oUdzw5QAWazwLHiXjUAVHxYzqA8A4rm72AjWwA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 18, 2019 at 5:46 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > Testcases for specified arch should be limited on that only being
> supported
> > platform to run, we now create a function tst_on_arch to achieve this new
> > feature in LTP library.  All you need to run a test on the expected arch
> is
> > to set the '.arch' string in the 'struct tst_test' to choose the required
> > arch list. e.g. '.arch = "x86_64 i386"'.
>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> LGTM. FYI there is also HOST_CPU variable (since 00ff2c348f),
> but that does not help your patch.
>
> > ---
> >  doc/test-writing-guidelines.txt | 26 ++++++++++
> >  include/tst_arch.h              | 16 ++++++
> >  include/tst_test.h              |  7 ++-
> >  lib/tst_arch.c                  | 92 +++++++++++++++++++++++++++++++++
> >  4 files changed, 140 insertions(+), 1 deletion(-)
> >  create mode 100644 include/tst_arch.h
> >  create mode 100644 lib/tst_arch.c
>
> > diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> > index f1912dc12..b4fba0190 100644
> > --- a/doc/test-writing-guidelines.txt
> > +++ b/doc/test-writing-guidelines.txt
> > @@ -1668,6 +1668,32 @@ sturct tst_test test = {
> >  };
> >
> -------------------------------------------------------------------------------
>
> > +2.2.30 Testing on specified architecture
>                      ^ maybe specific?
>

Agree.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190618/4025d50c/attachment.html>
