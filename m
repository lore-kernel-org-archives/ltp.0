From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jun 2020 09:31:08 +0800
Subject: [LTP] [PATCH] clocks/invaliddates.c: relax acceptable delta
In-Reply-To: <53a3e9975f00c50c78528994472ec7e9f8adeb90.1592475774.git.jstancek@redhat.com>
References: <53a3e9975f00c50c78528994472ec7e9f8adeb90.1592475774.git.jstancek@redhat.com>
Message-ID: <CAEemH2fgg9KOO5KxTwr0LpGdL2X0p_aGefNuwQQjajkRNJKk9Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 18, 2020 at 6:24 PM Jan Stancek <jstancek@redhat.com> wrote:

> Test allows just 5ms delta for PASS, and test randomly fails in
> environments with shared resources and increased steal time.
>
> Relax the condition and also print deltas if test fails.
> Remove DEBUG ifdefs and main parameters to avoid unused variable
> warning.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../functional/timers/clocks/invaliddates.c   | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git
> a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
> b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
> index face334fd250..d4116b1e9bc0 100644
> ---
> a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
> +++
> b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
> @@ -18,8 +18,7 @@
>
>  #define NUMTESTS 5
>
> -#define ACCEPTABLESECDELTA 0
> -#define ACCEPTABLENSECDELTA 5000000
> +#define ACCEPTABLESECDELTA 2
>

It's hard to say what size of the second-delta is a proper value, but to
increase it can obviously decrease the failure probability. If there is no
better way I'd go with this patch.

Reviewed-by: Li Wang <liwang@redhat.com>



>
>  static int testtimes[NUMTESTS][2] = {
>         {INT32_MAX, 999999999}, // large number
> @@ -29,7 +28,7 @@ static int testtimes[NUMTESTS][2] = {
>         {1049623200, 999999999},        // daylight savings 2003
>  };
>
> -int main(int argc, char *argv[])
> +int main(void)
>  {
>         struct timespec tpset, tpget, tsreset;
>         int secdelta, nsecdelta;
> @@ -44,9 +43,6 @@ int main(int argc, char *argv[])
>         for (i = 0; i < NUMTESTS; i++) {
>                 tpset.tv_sec = testtimes[i][0];
>                 tpset.tv_nsec = testtimes[i][1];
> -#ifdef DEBUG
> -               printf("Test: %ds %dns\n", testtimes[i][0],
> testtimes[i][1]);
> -#endif
>                 if (clock_settime(CLOCK_REALTIME, &tpset) == 0) {
>                         if (clock_gettime(CLOCK_REALTIME, &tpget) == -1) {
>                                 printf("Error in clock_gettime()\n");
> @@ -58,16 +54,13 @@ int main(int argc, char *argv[])
>                                 nsecdelta = nsecdelta + 1000000000;
>                                 secdelta = secdelta - 1;
>                         }
> -#ifdef DEBUG
> -                       printf("Delta:  %ds %dns\n", secdelta, nsecdelta);
> -#endif
> -                       if ((secdelta > ACCEPTABLESECDELTA) || (secdelta <
> 0)) {
> -                               printf("clock does not appear to be
> set\n");
> -                               failure = 1;
> -                       }
> -                       if ((nsecdelta > ACCEPTABLENSECDELTA) ||
> -                           (nsecdelta < 0)) {
> -                               printf("clock does not appear to be
> set\n");
> +
> +                       if ((secdelta > ACCEPTABLESECDELTA)
> +                               || (secdelta < 0)) {
> +                               printf("FAIL: test(%d,%d), secdelta: %d,"
> +                                       " nsecdelta: %d\n",
> +                                       testtimes[i][0], testtimes[i][1],
> +                                       secdelta, nsecdelta);
>                                 failure = 1;
>                         }
>                 } else {
> --
> 2.18.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200619/1ffe0c9f/attachment-0001.htm>
