From: Julio Cruz <jcsistemas2001@gmail.com>
Date: Sun, 20 Mar 2016 21:58:35 +0800
Subject: [LTP] [PATCH] Check available memory to support embedded devices
In-Reply-To: <1423281604.10539234.1458206400762.JavaMail.zimbra@redhat.com>
References: <1458097275-2769-1-git-send-email-jcsistemas2001@gmail.com>
 <1423281604.10539234.1458206400762.JavaMail.zimbra@redhat.com>
Message-ID: <2FBA1145-19A4-4A85-8DD9-169F227E4E19@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,


On Mar 17, 2016, at 5:20 PM, Jan Stancek <jstancek@redhat.com> wrote:





----- Original Message -----
> From: "Julio Cruz" <jcsistemas2001@gmail.com>
> To: "julio cruz" <julio.cruz@smartmatic.com>, ltp@lists.linux.it, chrubis@suse.cz, jstancek@redhat.com
> Cc: "Julio Cruz" <jcsistemas2001@gmail.com>
> Sent: Wednesday, 16 March, 2016 4:01:15 AM
> Subject: [PATCH] Check available memory to support embedded devices
> 
> This patch check the available memory before to perform the
> different test cases. If the memory is not enough (according with
> each test case), the test finish as TCONF.
> This could be usefull when you are testing on embedded devices
> with RAM memory limitation (i.e. 512MB)
> This patch no changed the test case procedure and is still valid
> for non-embedded devices. It just verify the available memory.
> 
> Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>
> ---
> testcases/kernel/syscalls/getrusage/getrusage03.c | 80
> +++++++++++++++++------
> 1 file changed, 61 insertions(+), 19 deletions(-)

Hi,

> 
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c
> b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index 54cdc83..8967c8e 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -45,7 +45,10 @@
> char *TCID = "getrusage03";
> int TST_TOTAL = 1;
> 
> -#define DELTA_MAX    10240
> +#define DELTA_MAX            10240
> +#define DEFAULT_ALLOCATION_MB    100
> +
> +unsigned long avail_memory_mb;
> 
> static struct rusage ru;
> static long maxrss_init;
> @@ -65,6 +68,14 @@ static void consume(int mega);
> static void setup(void);
> static void cleanup(void);
> 
> +unsigned long get_available_memory_mb(void)
> +{
> +    unsigned long long ps, pn;
> +    ps = sysconf(_SC_PAGESIZE);
> +    pn = sysconf(_SC_AVPHYS_PAGES);
> +    return ps * pn / (1024*1024);

What I was suggesting was:
 return (ps / 1024) * pn / 1024;

All of the page sizes are at least 4k (grep "define PAGE_SHIFT" -r linux/arch/).
This way "unsigned long" should do just fine for all variables.

Ok!

> +}
> +
> int main(int argc, char *argv[])
> {
>    int lc;
> @@ -73,19 +84,26 @@ int main(int argc, char *argv[])
> 
>    setup();
> 
> -    for (lc = 0; TEST_LOOPING(lc); lc++) {
> -        tst_count = 0;
> -
> -        tst_resm(TINFO, "allocate 100MB");
> -        consume(100);
> -
> -        inherit_fork();
> -        inherit_fork2();
> -        fork_malloc();
> -        grandchild_maxrss();
> -        zombie();
> -        sig_ign();
> -        exec_without_fork();
> +    avail_memory_mb = get_available_memory_mb();
> +
> +    tst_resm(TINFO, "Available memory: %ldMB\n", avail_memory_mb);
> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB) {
> +        tst_resm(TCONF, "Not enough memory to run this case\n");

We have tst_brkm(TCONF, cleanup, "...");, which will print message,
run cleanup and exit testcase.

Much better!

> +    } else {
> +        for (lc = 0; TEST_LOOPING(lc); lc++) {
> +            tst_count = 0;
> +
> +            tst_resm(TINFO, "allocate %dMB", DEFAULT_ALLOCATION_MB);
> +            consume(DEFAULT_ALLOCATION_MB);

This consume() is within loop, and it doesn't look like
same loop frees any memory. I suggest you move it before loop.
You can try running the testcase with "-i 20".

You are right. I didn't see this because my test run one time. I will fix.


> +
> +            inherit_fork();
> +            inherit_fork2();
> +            fork_malloc();
> +            grandchild_maxrss();
> +            zombie();
> +            sig_ign();
> +            exec_without_fork();
> +        }
>    }
>    cleanup();
>    tst_exit();
> @@ -95,11 +113,15 @@ int main(int argc, char *argv[])
>  * expect: initial.self ~= child.self */
> static void inherit_fork(void)
> {
> -    tst_resm(TINFO, "Testcase #01: fork inherit");
> -
>    SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
>    tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> 
> +    tst_resm(TINFO, "Testcase #01: fork inherit");
> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {

Is this needed? Child is not allocating anything, and fork
should use copy-on-write.

During my testing, if the memory available is not the double, the test had problem. I will recheck.

> +        tst_resm(TCONF, "Not enough memory to run this case\n");
> +        return;
> +    }
> +
>    switch (pid = fork()) {
>    case -1:
>        tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
> @@ -119,17 +141,21 @@ static void inherit_fork(void)
> }
> 
> /* Testcase #02: fork inherit (cont.)
> - * expect: initial.children ~= 100MB, child.children = 0 */
> + * expect: initial.children ~= DEFAULT_ALLOCATION_MB, child.children = 0 */
> static void inherit_fork2(void)
> {
>    tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {

Same as above.

Similar to previous problem

> +        tst_resm(TCONF, "Not enough memory to run this case\n");
> +        return;
> +    }
> 
>    SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>    tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
>    if (is_in_delta(ru.ru_maxrss - 102400))
> -        tst_resm(TPASS, "initial.children ~= 100MB");
> +        tst_resm(TPASS, "initial.children ~= %dMB", DEFAULT_ALLOCATION_MB);
>    else
> -        tst_resm(TFAIL, "initial.children !~= 100MB");
> +        tst_resm(TFAIL, "initial.children !~= %dMB", DEFAULT_ALLOCATION_MB);
> 
>    switch (pid = fork()) {
>    case -1:
> @@ -153,6 +179,10 @@ static void inherit_fork2(void)
> static void fork_malloc(void)
> {
>    tst_resm(TINFO, "Testcase #03: fork + malloc");
> +    if (avail_memory_mb < (DEFAULT_ALLOCATION_MB*2+50)) {

Same as above, isn't "50" going to be enough?

Again, similar.

Thanks for your review. I will send another patch.

Regards,
Jan

> +        tst_resm(TCONF, "Not enough memory to run this case\n");
> +        return;
> +    }
> 
>    SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
>    tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> @@ -182,6 +212,10 @@ static void fork_malloc(void)
> static void grandchild_maxrss(void)
> {
>    tst_resm(TINFO, "Testcase #04: grandchild maxrss");
> +    if (avail_memory_mb <= (DEFAULT_ALLOCATION_MB+300)) {
> +        tst_resm(TCONF, "Not enough memory to run this case\n");
> +        return;
> +    }
> 
>    SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>    tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> @@ -216,6 +250,10 @@ static void grandchild_maxrss(void)
> static void zombie(void)
> {
>    tst_resm(TINFO, "Testcase #05: zombie");
> +    if (avail_memory_mb <= (DEFAULT_ALLOCATION_MB+400)) {
> +        tst_resm(TCONF, "Not enough memory to run this case\n");
> +        return;
> +    }
> 
>    SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>    tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> @@ -259,6 +297,10 @@ static void zombie(void)
> static void sig_ign(void)
> {
>    tst_resm(TINFO, "Testcase #06: SIG_IGN");
> +    if (avail_memory_mb <= (DEFAULT_ALLOCATION_MB+500)) {
> +        tst_resm(TCONF, "Not enough memory to run test case");
> +        return;
> +    }
> 
>    SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>    tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> --
> 1.9.1
> 
> 
