Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Old10-0006fN-KV
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 07:24:50 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Old0z-0008Cz-Jl
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 07:24:50 +0000
Received: by bwz12 with SMTP id 12so381924bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Aug 2010 00:24:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb3ea4$e05de680$a119b380$@co.jp>
References: <000001cb3ea4$e05de680$a119b380$@co.jp>
Date: Wed, 18 Aug 2010 00:24:43 -0700
Message-ID: <AANLkTinPERZyV=Gq2RA_h5iWeQsu9bcHhEt_AVsg6XYq@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix two "2-1.c" tests of POSIX
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>

2010/8/18 Mitani <mitani@ryobi.co.jp>:
> Hi,
>
> I tried to build open_posix_testsuite testcases with latest git:
> =A0 ltp-dev-e8ad463baada21fb19f4c06f7dcab75c420ae373.tar.gz
>
> Several testcases failed to build.
> Two of them is as follows:
> ------------
> [...]
> conformance/interfaces/pthread_attr_setstack/2-1 compile FAILED
> In file included from
> ../../../conformance/interfaces/pthread_attr_setstack/2-1.c:31:
> ../../../include/posixtest.h:14:2: error: #error "Contains GNU-isms that
> need fixing."
> [...]
> conformance/interfaces/pthread_attr_setstacksize/2-1 compile FAILED
> In file included from
> ../../../conformance/interfaces/pthread_attr_setstacksize/2-1.c:31:
> ../../../include/posixtest.h:14:2: error: #error "Contains GNU-isms that
> need fixing."
> [...]
> ------------
>
> ".../pthread_attr_setstack/2-1.c" and ".../include/posixtest.h" are
> as follows:
> ------------(.../pthread_attr_setstack/2-1.c)
> [...]
> #ifndef _GNU_SOURCE
> #define _GNU_SOURCE
> #endif
> #include <pthread.h>
> #include <limits.h>
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <sys/param.h>
> #include <errno.h>
> #include <unistd.h>
> #include "posixtest.h"
> [...]
> ------------
>
> ------------(posixtest.h)
> [...]
> #if defined(_GNU_SOURCE)
> #error "Contains GNU-isms that need fixing."
> #elif defined(_BSD_SOURCE)
> #error "Contains BSD-isms that need fixing."
> #endif
> [...]
> ------------
>
> In above "2-1.c", "_GNU_SOURCE" is defined. After that, "posixtest.h"
> is included.
> And, in "posixtest.h", if "_GNU_SOURCE" is defined, error occurs.
>
> If "#ifndef _GNU_SOURCE" is arranged after a line of "posixtest.h",
> error doesn't occur.
> I confirmed that build succeeded by this revision and the test
> became PASS.
>
> Another "2-1.c" is same as above testcase.
>
>
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_sets=
tac
> k/2-1.c 2010-08-18 07:18:35.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_sets=
tac
> k/2-1.c 2010-08-18 15:43:16.000000000 +0900
> @@ -17,9 +17,6 @@
> =A0* =A0 =A0 =A0 provided by nptl, which is developed by Ulrich Drepper.
> =A0*/
>
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> =A0#include <pthread.h>
> =A0#include <limits.h>
> =A0#include <stdio.h>
> @@ -30,6 +27,10 @@
> =A0#include <unistd.h>
> =A0#include "posixtest.h"
>
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> =A0#define TEST "2-1"
> =A0#define FUNCTION "pthread_attr_setstack"
> =A0#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_sets=
tac
> ksize/2-1.c =A0 =A0 2010-08-18 07:18:35.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_sets=
tac
> ksize/2-1.c =A0 =A0 2010-08-18 15:44:56.000000000 +0900
> @@ -17,9 +17,6 @@
> =A0* =A0 =A0 =A0 provided by nptl, which is developed by Ulrich Drepper.
> =A0*/
>
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> =A0#include <pthread.h>
> =A0#include <limits.h>
> =A0#include <stdio.h>
> @@ -30,6 +27,10 @@
> =A0#include <unistd.h>
> =A0#include "posixtest.h"
>
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> =A0#define TEST "2-1"
> =A0#define FUNCTION "pthread_attr_setstacksize"
> =A0#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "

This is intentional :). The tests need to be written to use only POSIX
compliant APIs. Otherwise, it isn't truly POSIX compliant.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
