From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Dec 2018 11:00:13 +0100
Subject: [LTP] [PATCH] openposix: Remove _XOPEN_SOURCE in
 strchr/strcpy/strncpy
In-Reply-To: <1544089211-8138-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1544089211-8138-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181207100013.GA14165@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Xiao,

> We have defined _XOPEN_SOURCE to 600 by gcc -D in open_posix_testsuite/CF=
LAGS=EF=BC=8C
> So defining _XOPEN_SOURCE to different value in test results in a "_XOPEN=
_SOURCE
> redefined" warning.

> It seems that all of tests get pass even if _XOPEN_SOURCE is defined to 6=
00
> by default, so remove the duplicate _XOPEN_SOURCE in test.

FYI I also mentioned it in https://github.com/linux-test-project/ltp/pull/4=
23
but it was ignored.
This is a side effect, that we use mailing list and github pull requests.

I guess _XOPEN_SOURCE 600 is ok.
If _XOPEN_SOURCE 700 is really needed, we can use:
#ifdef _XOPEN_SOURCE
#undef _XOPEN_SOURCE
#endif
#define _XOPEN_SOURCE 700

Kind regards,
Petr

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---


>  testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c  | 1 -
>  testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c  | 1 -
>  testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c | 1 -
>  testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c | 1 -
>  4 files changed, 4 deletions(-)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strchr=
/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
> index 95eda79..611a64d 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
> @@ -25,7 +25,6 @@
>   *	-Repeat the above all steps for given number of iterations.
>  */

> -#define _XOPEN_SOURCE 700
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strcpy=
/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
> index 2fdc002..adfbfc3 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
> @@ -17,7 +17,6 @@
>   *  -Also compare returned pointer with s2.
>  */

> -#define _XOPEN_SOURCE 700
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncp=
y/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1=
.c
> index 3458015..396bd60 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
> @@ -20,7 +20,6 @@
>   *  -Repeat the above steps for given number of iterations.
>  */

> -#define _XOPEN_SOURCE 700
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncp=
y/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1=
.c
> index a7761c5..2a20872 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
> @@ -20,7 +20,6 @@
>   *  -Repeat the above steps for given number of iterations.
>  */

> -#define _XOPEN_SOURCE 700
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
