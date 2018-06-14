From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jun 2018 21:47:31 +0800
Subject: [LTP] [PATCH v2] open08: rewrite to newlib
In-Reply-To: <787996724f38cfa88d0a8c9a0a713d056ba01307.1528980323.git.jstancek@redhat.com>
References: <787996724f38cfa88d0a8c9a0a713d056ba01307.1528980323.git.jstancek@redhat.com>
Message-ID: <CAEemH2dFRruWBBU+p5qU5vtGxc-ibjbFpW5TjNd=P0G=7TALfA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 14, 2018 at 8:48 PM, Jan Stancek <jstancek@redhat.com> wrote:
> Fixes: https://github.com/linux-test-project/ltp/issues/330
>
> EACCES testcase changed:
> Test now creates file (0600) in tmpdir, that is owned by privileged user,
> and unprivileged user tries to open it for writing.
>
> EFAULT testcase changed:
> Comments say the intent is to use address outside of process mapped space.
> So, test is changed to map/unmap rather than map as PROT_NONE.
>
> uclinux ifdefs dropped.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/open/open08.c | 140 +++++++++++++-------------------
>  1 file changed, 58 insertions(+), 82 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
> index d55d8e6bdd53..d749d1e7100e 100644
> --- a/testcases/kernel/syscalls/open/open08.c
> +++ b/testcases/kernel/syscalls/open/open08.c
> @@ -1,5 +1,6 @@
>  /*
>   *   Copyright (c) 2013 Wanlong Gao <gaowanlong@cn.fujitsu.com>
> + *   Copyright (c) 2018 Linux Test Project
>   *
>   *   This program is free software;  you can redistribute it and/or modify
>   *   it under the terms of the GNU General Public License as published by
> @@ -39,7 +40,7 @@
>   *     4. Attempt to open() a filename which is more than VFS_MAXNAMLEN, and
>   *        check for errno to be ENAMETOOLONG.
>   *
> - *     5. Attempt to open a test executable in WRONLY mode,
> + *     5. Attempt to open a (0600) file owned by different user in WRONLY mode,
>   *        open(2) should fail with EACCES.
>   *
>   *     6. Attempt to pass an invalid pathname with an address pointing outside
> @@ -56,113 +57,88 @@
>  #include <fcntl.h>
>  #include <signal.h>
>  #include <pwd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "open08";
> -
> -static char nobody_uid[] = "nobody";
> -static struct passwd *ltpuser;
> -
> -static char *bad_addr;
> +#include "tst_test.h"
>
>  static char filename[40] = "";
> -static char fname[] = "/bin/cat";
> +static char user2_file[] = "user2_0600";
>  static char bad_file[] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
>
> +struct test_case_t;
> +static void setup_badfname_buf(struct test_case_t *t);
> +
>  static struct test_case_t {
> +       void (*setup)(struct test_case_t *t);

This function pointer named setup make me a little bit confused at first sight.
It makes me thinking about what's the relationship to ltp steup()
function for a while, actually it does not have.

To avoid the situation to other person, how about just using
   void (*func) (struct test_case_t *t);
here?

And my propose change like:

--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -64,10 +64,10 @@ static char user2_file[] = "user2_0600";
 static char bad_file[] =
"abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghi

 struct test_case_t;
-static void setup_badfname_buf(struct test_case_t *t);
+static void get_badfname_buf(struct test_case_t *t);

 static struct test_case_t {
-       void (*setup)(struct test_case_t *t);
+       void (*func)(struct test_case_t *t);
        char *fname;
        int flags;
        int error;
@@ -77,13 +77,14 @@ static struct test_case_t {
        {NULL, filename, O_DIRECTORY, ENOTDIR},
        {NULL, bad_file, O_RDWR, ENAMETOOLONG},
        {NULL, user2_file, O_WRONLY, EACCES},
-       {setup_badfname_buf, NULL, O_CREAT, EFAULT}
+       {get_badfname_buf, NULL, O_CREAT, EFAULT}
 };

+
 void verify_open(unsigned int i)
 {
-       if (tcases[i].setup)
-               tcases[i].setup(&tcases[i]);
+       if (tcases[i].func)
+               tcases[i].func(&tcases[i]);

        TEST(open(tcases[i].fname, tcases[i].flags,
                S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
@@ -104,7 +105,7 @@ void verify_open(unsigned int i)
        }
 }

-static void setup_badfname_buf(struct test_case_t *t)
+static void get_badfname_buf(struct test_case_t *t)
 {
        char *bad_addr;
        int len = getpagesize();


And, I have to say this is a nice cleanup work. Others looks good to me.

-- 
Regards,
Li Wang
