From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Oct 2018 08:23:47 +0300
Subject: [LTP] [RFC 1/3] syscalls/fanotify03: defined additional tcase
 members to support more tcase control
In-Reply-To: <2e4b79178a769f3657fee97ebc48f533d5218602.1540348505.git.mbobrowski@mbobrowski.org>
References: <cover.1540348505.git.mbobrowski@mbobrowski.org>
 <2e4b79178a769f3657fee97ebc48f533d5218602.1540348505.git.mbobrowski@mbobrowski.org>
Message-ID: <CAOQ4uxg1s0tMOVzXzTOBbym924drT8-1q=hYy77UXLre-m3G=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 24, 2018 at 6:27 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> * Included the event mask member to be used for fanotify_mark() within
>   the tcase. This allows control over what event types are to be
>   generated on a tcase by tcase level as oppose to having it globally
>   defined for all tcases.
>
> * Included the event_set and event_resp arrays into a tcase so that
>   the sequence of expected events can be defined on a test case by test
>   case level. Both event_set and event_resp are now represented by the
>   event struct.
>
> * Added event_count member to tcase in order to represent the number of
>   expected events for each tcase.
>
> * Fanotify permission events cannot be merged, thus cleaned up some
>   unnecessary code in test_fanotify() that checks whether any additional
>   bits are left within event->mask.
>
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---

Looks good! nits below.

>  .../kernel/syscalls/fanotify/fanotify03.c     | 90 ++++++++++---------
>  1 file changed, 50 insertions(+), 40 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 5c105ed32..cca15aa00 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -42,28 +42,48 @@ static volatile int fd_notify;
>
>  static pid_t child_pid;
>
> -static unsigned long long event_set[EVENT_MAX];
> -static unsigned int event_resp[EVENT_MAX];
> -
>  static char event_buf[EVENT_BUF_LEN];
>  static int support_perm_events;
>
> +struct event {
> +       unsigned long long type;

It's better to name this also 'mask' as in the near future you will
want to assign it the value of OPEN_PERM|OPEN_EXEC_PERM
which is not a 'type'.

> +       unsigned int response;
> +};
> +
>  static struct tcase {
>         const char *tname;
>         struct fanotify_mark_type mark;
> +       unsigned long long mask;
> +       int event_count;
> +       struct event event_set[EVENT_MAX];

Better change the value of EVENT_MAX...
or even decouple it from EVENT_BUF_LEN

>  } tcases[] = {
>         {
>                 "inode mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(INODE),
> +               FAN_OPEN_PERM | FAN_ACCESS_PERM, 2,
> +               {
> +                       {FAN_OPEN_PERM, FAN_ALLOW},
> +                       {FAN_ACCESS_PERM, FAN_DENY}
> +               }
>         },
>         {
>                 "mount mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +               FAN_OPEN_PERM | FAN_ACCESS_PERM, 2,
> +               {
> +                       {FAN_OPEN_PERM, FAN_ALLOW},
> +                       {FAN_ACCESS_PERM, FAN_DENY}
> +               }
>         },
>         {
>                 "filesystem mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> -       },
> +               FAN_OPEN_PERM | FAN_ACCESS_PERM, 2,
> +               {
> +                       {FAN_OPEN_PERM, FAN_ALLOW},
> +                       {FAN_ACCESS_PERM, FAN_DENY}
> +               }
> +       }
>  };
>
>  static void generate_events(void)
> @@ -146,8 +166,7 @@ static int setup_mark(unsigned int n)
>
>         fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
>
> -       if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> -                         FAN_ACCESS_PERM | FAN_OPEN_PERM,
> +       if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
>                           AT_FDCWD, fname) < 0) {
>                 if (errno == EINVAL && support_perm_events &&
>                     mark->flag == FAN_MARK_FILESYSTEM) {
> @@ -167,7 +186,7 @@ static int setup_mark(unsigned int n)
>                 }
>         } else {
>                 /*
> -                * To distigouish between perm event not supported and
> +                * To distinguish between perm event not supported and
>                  * filesystem mark not supported.
>                  */
>                 support_perm_events = 1;
> @@ -179,32 +198,22 @@ static int setup_mark(unsigned int n)
>
>  static void test_fanotify(unsigned int n)
>  {
> -       int tst_count;
>         int ret, len = 0, i = 0, test_num = 0;
> +       struct tcase *tc = &tcases[n];
> +       struct event *event_set = tc->event_set;
>
>         if (setup_mark(n) != 0)
>                 return;
>
>         run_child();
>
> -       tst_count = 0;
> -
> -       event_set[tst_count] = FAN_OPEN_PERM;
> -       event_resp[tst_count++] = FAN_ALLOW;
> -       event_set[tst_count] = FAN_ACCESS_PERM;
> -       event_resp[tst_count++] = FAN_DENY;
> -
> -       /* tst_count + 1 is for checking child return value */
> -       if (TST_TOTAL != tst_count + 1) {
> -               tst_brk(TBROK,
> -                       "TST_TOTAL and tst_count do not match");
> -       }
> -       tst_count = 0;
> -
>         /*
> -        * check events
> +        * Process events
> +        *
> +        * tc->count + 1 is to accommodate for checking the child process
> +        * return value
>          */
> -       while (test_num < TST_TOTAL && fd_notify != -1) {
> +       while (test_num < tc->event_count + 1 && fd_notify != -1) {
>                 struct fanotify_event_metadata *event;
>
>                 if (i == len) {
> @@ -222,12 +231,12 @@ static void test_fanotify(unsigned int n)
>                 }
>
>                 event = (struct fanotify_event_metadata *)&event_buf[i];
> -               if (!(event->mask & event_set[test_num])) {
> +               if (!(event->mask & event_set[test_num].type)) {

/* Permission events cannot be merged, so... */
+               if (event->mask != event_set[test_num].mask) {

Thanks,
Amir.
