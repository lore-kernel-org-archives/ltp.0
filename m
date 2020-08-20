From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 20 Aug 2020 18:36:10 +0800
Subject: [LTP] [PATCH 1/1] tst_kvcmp: Fix parsing format for
 /etc/os-release
In-Reply-To: <20200820100238.15925-1-pvorel@suse.cz>
References: <20200820100238.15925-1-pvorel@suse.cz>
Message-ID: <CAMy_GT8uNt4aLQPgbtFRrABmesFQ6WyOCEOtOF=A0EZ4h0McCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

I tried to run this with the syscalls/utimensat01 test on Ubuntu
(ID=ubuntu), it will fail with:
safe_file_ops.c:220: BROK: Expected 1 conversions got 0 FILE
'/etc/os-release' at tst_kvercmp.c:152

On Thu, Aug 20, 2020 at 6:02 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> We need to strip double quotes.
> Also for openSUSE Tumbleweed, which contains ID="opensuse-tumbleweed"
> it "\"%s\"" does not remove trailing double quote, thus match all but
> double quote.
>
> Fixes: e2e60a39b ("lib/tst_kvercmp: Add support /etc/os-release")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_kvercmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index 185a5c39c..7e980e076 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -146,7 +146,8 @@ const char *tst_kvcmp_distname(const char *kver)
>                 return "RHEL6";
>
>         if (access(OSRELEASE_PATH, F_OK) != -1) {
> -               SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
> +               SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=\"%[^\"]\"",
> +                                     distname);
>
>                 while (*p) {
>                         *p = toupper((unsigned char)*p);
> --
> 2.28.0
>
