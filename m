From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Nov 2019 16:36:47 +0800
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
 <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
 <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
Message-ID: <CAEemH2dPwqX1FtNvF7=hxbAfVMz7i_u+TpUBaU1mqKhY-G0Vig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 14, 2019 at 4:09 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi,
> >
> >     Defining AC_ARG_WITH within an if to express dependencies does not
> >     work.
> >     ./configure --with-realtime-testsuite set
> with_realtime_testsuite=yes,
> >     even if with_bash=no or with_python=no. The check is removed
> >     completely.
> >
> >
> > Or, maybe we can make use of AS_IF here? and I noticed there are many
> > places that use "if test ..." in the configure.ac
> > <http://configure.ac> file. That looks tangly...
> I left a TODO in there so it can be fixed later, maybe together with
> other errors. I think this does not block merging this patch first?
>

Well, I just saw adding new #TODO here and hoping to solve this together, a
simple way I was thinking is:

+AS_IF([test "x$with_bash" != xyes || test "x$with_python" != xyes],
+  [with_realtime_testsuite=no]
+)

Of course, It's fine to fix that in a separate patch!


> The python requirement for realtime-testsuite is outdated/wrong anyway,
> if I remember correctly. A colleague of mine recently
> investigated the python requirement and we came to the conclusion, that
> it is not needed for running the test.
> I think it was used only for manual test result evaluation.


> So there seems to be more work regarding dependencies between configure
> options.
>

Yes, thanks for investigating this. Looking forward to more patches :).

For this one:
    Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191114/00f1db0f/attachment.htm>
