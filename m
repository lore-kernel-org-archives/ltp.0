From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Nov 2019 15:59:42 +0800
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
Message-ID: <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

On Thu, Nov 14, 2019 at 2:31 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> ...
> > From the original intention, it likely to set yes as the default, so
> > maybe the [action-if-not-given] should as  [with_expect=yes]?
> Maybe, but I did not want to change the current behavior here. This
> should be done in another patch.
>

Ok, sure.


> >
> >
> >     -# testcases/realtime requires bash and python.
> >     -if test "x$with_bash" = xyes && test "x$with_python" = xyes; then
> >     -    AC_ARG_WITH([realtime-testsuite],
> >     -      [AC_HELP_STRING([--with-realtime-testsuite],
> >     -        [compile and install the realtime testsuite (default=no)])],
> >     -      [with_realtime_testsuite=yes]
> >     -    )
> >     -fi
> >     +# TODO: testcases/realtime requires bash and python.
> >
> >
> > Why remove the judgment of bash/python here?
> It simply does not work as intended. See last part of my patch description:
>

Ah, sorry for missing this part.


> Defining AC_ARG_WITH within an if to express dependencies does not work.
> ./configure --with-realtime-testsuite set with_realtime_testsuite=yes,
> even if with_bash=no or with_python=no. The check is removed completely.
>

Or, maybe we can make use of AS_IF here? and I noticed there are many
places that use "if test ..." in the configure.ac file. That looks tangly...


>
> I though removing it is better than leaving something that does nothing
> anyway
>

Indeed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191114/8a071407/attachment.htm>
