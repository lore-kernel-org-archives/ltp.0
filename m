From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Sep 2017 19:29:48 +0800
Subject: [LTP] [PATCH v2] thp01: Find largest arguments size
In-Reply-To: <20170901141343.27416-1-rpalethorpe@suse.com>
References: <20170901100319.GA26071@rei>
 <20170901141343.27416-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2d=EE0R5np6=ZUMQDYG3XBJc5dXoGCZYszctBMBa1XEqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 1, 2017 at 10:13 PM, Richard Palethorpe
<rpalethorpe@suse.com> wrote:
>
>  static void thp_test(void)
>  {
> -       int i;
>         pid_t pid;
>
> -       switch (pid = SAFE_FORK()) {
> -       case 0:
> -               memset(arg, 'c', length - 1);
> -               arg[length - 1] = '\0';
> -               array[0] = "true";
> -               for (i = 1; i < ARRAY_SZ - 1; i++)
> -                       array[i] = arg;
> -               array[ARRAY_SZ - 1] = NULL;
> -               if (setrlimit(RLIMIT_STACK, &rl) == -1) {
> -                       perror("setrlimit");
> -                       exit(1);
> -               }
> -               if (execvp("true", array) == -1) {
> -                       perror("execvp");
> -                       exit(1);
> +       while (*change > 1) {
> +               *arg_count = *arg_count_next;
> +               *change /= 2;
> +               *arg_count_next = *arg_count + *change;
> +
> +               pid = SAFE_FORK();
> +               if (!pid) {
> +                       args[*arg_count] = NULL;
> +
> +                       TEST(execvp("true", args));

Do binary search in shared memory is really good to performance.

But here maybe we could NOT find the largest arguments size rightly.

Cut from manual page:
  "Traditionally, the functions execlp() and execvp() ignored all
errors except for the ones described above and ENOMEM and E2BIG, upon
which they returned.  They now return if any error other than the ones
described above occurs."

Let me give an example, if we just add one line in your thp01.c as:

--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -65,6 +65,7 @@ static void thp_test(void)
                        if (TEST_ERRNO != E2BIG)
                                tst_brk(TBROK | TTERRNO,
"execvp(\"true\", ...)");

+                       printf("debuginfo: *arg_count = %ld\n", *arg_count);
                        *arg_count_next = *arg_count - *change;
                        exit(0);
                }



Compile and run thp01 as below:

# ./thp01
tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
thp01.c:76: INFO: count: 4095, change: 2047, next: 6142
debuginfo: *arg_count = 4095
thp01.c:76: INFO: count: 2048, change: 1023, next: 3071
debuginfo: *arg_count = 2048
thp01.c:76: INFO: count: 1025, change: 511, next: 1536
thp01.c:76: INFO: count: 1536, change: 255, next: 1791
debuginfo: *arg_count = 1536
thp01.c:76: INFO: count: 1281, change: 127, next: 1408
thp01.c:76: INFO: count: 1408, change: 63, next: 1471
thp01.c:76: INFO: count: 1471, change: 31, next: 1502
thp01.c:76: INFO: count: 1502, change: 15, next: 1517
thp01.c:76: INFO: count: 1517, change: 7, next: 1524
thp01.c:76: INFO: count: 1524, change: 3, next: 1527
thp01.c:76: INFO: count: 1527, change: 1, next: 1528
thp01.c:95: PASS: system didn't crash, pass.

Summary:
passed   1
failed   0
skipped  0
warnings 0


Do you notice that some debuginfo sentence have not been printed?
because it will be never return if the children process run
successfully. Though the while loop finished and *chage == 1, the
*arg_count == 1527 is still not the largest value as we expected.

I'm not sure if that is on purpose, if yes, maybe you should not say
find largest arguments size in the subject. :)


>
> +       pid = SAFE_FORK();
> +       if (!pid) {
> +               args[*arg_count] = NULL;
> +               do {
> +                       TEST(execvp("true", args));
> +                       if (TEST_ERRNO != E2BIG)
> +                               tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
> +                       tst_res(TINFO, "Binary search finished on 2BIG value: %ld",
> +                               *arg_count);
> +                       args[--(*arg_count)] = NULL;
> +               } while (*arg_count > 0);
> +               exit(0);
> +       }
> +

here also need:   tst_reap_children();

>         tst_res(TPASS, "system didn't crash, pass.");
>  }



-- 
Li Wang
liwang@redhat.com
