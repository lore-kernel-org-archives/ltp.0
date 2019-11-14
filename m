From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 14 Nov 2019 07:31:51 +0100
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
Message-ID: <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> I think this patch makes sense. It follows the AC_ARG_WITH official 
> usage, and make use?of the shell variable 'withval' is also a wise choice.
>
> Just a few queries below:
>
>
>
>     ?AC_ARG_WITH([expect],
>     ? ?[AC_HELP_STRING([--with-expect],
>     -? ? [have the Tcl/expect library (default=yes)])],
>     -? [with_expect=yes],
>     +? ? [have the Tcl/expect library])],
>     +? [with_expect=$withval],
>     ?[with_expect=no]
>
>
> From the original intention, it likely to set yes as the default, so 
> maybe the?[action-if-not-given] should as ?[with_expect=yes]?
Maybe, but I did not want to change the current behavior here. This 
should be done in another patch.
>
>
>     -# testcases/realtime requires bash and python.
>     -if test "x$with_bash" = xyes && test "x$with_python" = xyes; then
>     -? ? AC_ARG_WITH([realtime-testsuite],
>     -? ? ? [AC_HELP_STRING([--with-realtime-testsuite],
>     -? ? ? ? [compile and install the realtime testsuite (default=no)])],
>     -? ? ? [with_realtime_testsuite=yes]
>     -? ? )
>     -fi
>     +# TODO: testcases/realtime requires bash and python.
>
>
> Why remove the judgment?of bash/python here?
It simply does not work as intended. See last part of my patch description:
Defining AC_ARG_WITH within an if to express dependencies does not work.
./configure --with-realtime-testsuite set with_realtime_testsuite=yes,
even if with_bash=no or with_python=no. The check is removed completely.

I though removing it is better than leaving something that does nothing 
anyway
>
J?rg
