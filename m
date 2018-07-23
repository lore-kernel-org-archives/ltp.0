From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jul 2018 15:01:46 +0200
Subject: [LTP] [PATCH] read_all: Define FNM_EXTMATCH if not already
 (like under musl).
In-Reply-To: <1529939900-28259-1-git-send-email-daniel.diaz@linaro.org>
References: <1529939900-28259-1-git-send-email-daniel.diaz@linaro.org>
Message-ID: <20180723130146.GA2983@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Daniel,

> With musl, FNM_EXTMATCH is not defined:
> | read_all.c: In function 'read_test':
> | read_all.c:201:41: error: 'FNM_EXTMATCH' undeclared (first use in this =
function); did you mean 'FNM_NOMATCH'?
> |   if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
> |                                          ^~~~~~~~~~~~
> |                                          FNM_NOMATCH
> | read_all.c:201:41: note: each undeclared identifier is reported only on=
ce for each function it appears in
> | <builtin>: recipe for target 'read_all' failed
> | make[4]: *** [read_all] Error 1

> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> ---
>  testcases/kernel/fs/read_all/read_all.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/f=
s/read_all/read_all.c
> index 42babae..f68217b 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -60,6 +60,10 @@
>  #define MAX_PATH 4096
>  #define MAX_DISPLAY 40

> +#if !defined(FNM_EXTMATCH)
Maybe just
#ifndef FNM_EXTMATCH

And maybe it'd be good to put this definition into include/lapi/fnmatch.h
(create it), so it can be reused.

FYI: LTP isn't musl ready atm.

> +#define FNM_EXTMATCH 0
> +#endif
> +
>  struct queue {
>  	sem_t sem;
>  	int front;


Kind regards,
Petr
