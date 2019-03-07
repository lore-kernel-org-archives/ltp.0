From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Mar 2019 15:31:48 -0800
Subject: [LTP] [PATCH v2] setpriority01: Skip only PRIO_USER when unable
 to add test user
In-Reply-To: <20190307232804.10311-1-saravanak@google.com>
References: <20190307232804.10311-1-saravanak@google.com>
Message-ID: <CAGETcx_DWBy2MzfGmBR-3zJwi4-uK=EsezGUZe7Zm3sp4w5QSA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sent the wrong patch by mistake. Sending the right one (with minor edits to
commit text).

On Thu, Mar 7, 2019 at 3:28 PM Saravana Kannan <saravanak@google.com> wrote:

> We don't need to skip all the tests just because we are unable to add
> a test user. Not having a test user only affects PRIO_USER test case.
> So just skip that one and continue running the rest of the tests.
>
> This also allows this test case to be built and run on Android.
>
> Change-Id: Ie6eaf771002842fc1c768adf70bb2d1ef534f120
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../kernel/syscalls/setpriority/Makefile      |  5 ----
>  .../syscalls/setpriority/setpriority01.c      | 29 +++++++++++++------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setpriority/Makefile
> b/testcases/kernel/syscalls/setpriority/Makefile
> index 5d00984ea..7a1a87a28 100644
> --- a/testcases/kernel/syscalls/setpriority/Makefile
> +++ b/testcases/kernel/syscalls/setpriority/Makefile
> @@ -19,9 +19,4 @@
>  top_srcdir             ?= ../../../..
>
>  include $(top_srcdir)/include/mk/testcases.mk
> -
> -ifeq ($(ANDROID), 1)
> -FILTER_OUT_MAKE_TARGETS        += setpriority01
> -endif
> -
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c
> b/testcases/kernel/syscalls/setpriority/setpriority01.c
> index 38b77b77f..92b1b4ef4 100644
> --- a/testcases/kernel/syscalls/setpriority/setpriority01.c
> +++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
> @@ -92,9 +92,16 @@ static void verify_setpriority(unsigned int n)
>  {
>         struct tcase *tc = &tcases[n];
>
> +       if (tc->which == PRIO_USER && !user_added) {
> +               tst_res(TCONF, "setpriority(%s(%d), %d, -20..19) skipped -
> Can't add user",
> +                       str_which(tc->which), tc->which, *tc->who);
> +               return;
> +       }
> +
>         pid = SAFE_FORK();
>         if (pid == 0) {
> -               SAFE_SETUID(uid);
> +               if (user_added)
> +                       SAFE_SETUID(uid);
>                 SAFE_SETPGID(0, 0);
>
>                 TST_CHECKPOINT_WAKE_AND_WAIT(0);
> @@ -115,15 +122,19 @@ static void setup(void)
>  {
>         const char *const cmd_useradd[] = {"useradd", username, NULL};
>         struct passwd *ltpuser;
> +       int rc;
>
> -       if (eaccess("/etc/passwd", W_OK))
> -               tst_brk(TCONF, "/etc/passwd is not accessible");
> -
> -       tst_run_cmd(cmd_useradd, NULL, NULL, 0);
> -       user_added = 1;
> -
> -       ltpuser = SAFE_GETPWNAM(username);
> -       uid = ltpuser->pw_uid;
> +       switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> +       case 0:
> +               user_added = 1;
> +               ltpuser = SAFE_GETPWNAM(username);
> +               uid = ltpuser->pw_uid;
> +               return;
> +       case 255:
> +               return;
> +       default:
> +               tst_brk(TBROK, "Useradd failed (%d)", rc);
> +       }
>  }
>
>  static void cleanup(void)
> --
> 2.21.0.360.g471c308f928-goog
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190307/2746ea65/attachment.html>
