From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Feb 2020 16:49:41 +0800
Subject: [LTP] [PATCH] syscalls/setrlimit06: lower RLIMIT_CPU parameters
In-Reply-To: <87e6761eb699c7912e2064dea222f5ac7fd04a6b.1581338640.git.jstancek@redhat.com>
References: <87e6761eb699c7912e2064dea222f5ac7fd04a6b.1581338640.git.jstancek@redhat.com>
Message-ID: <CAEemH2f90MPBV_w2+gw331cg0Fiu-=aqgp3M1BHhBCXcFUbyyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 10, 2020 at 8:47 PM Jan Stancek <jstancek@redhat.com> wrote:

> Lower the parameters so that test completes faster where possible.
>
> This also increases alarm timer slightly, which in combination with
> lower RLIMIT_CPU aims to avoid false positives in environments with
> high steal time, where it can take multiple of wall clock seconds
> to spend single second on a cpu.
>

This patch could reduce the test failure possibility, but I'm afraid it
can't fix the problem radically, because with `stress -c 20' to overload an
s390x system(2cpus) in the background then setrlimit06(patched) still
easily gets failed:
    setrlimit06.c:98: FAIL: Got only SIGXCPU after reaching both limit

Another way I can think of is to raise the priority before its running, not
sure if that will disturb the original test but from my test, it always
gets a pass even with too much overload.

--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -25,6 +25,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include <sys/mman.h>
+#include <sys/resource.h>

 #include "tst_test.h"

@@ -37,6 +38,8 @@ static void sighandler(int sig)

 static void setup(void)
 {
+       setpriority(PRIO_PROCESS, 0, -20);
+
        SAFE_SIGNAL(SIGXCPU, sighandler);

        end = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
@@ -110,6 +113,7 @@ static void verify_setrlimit(void)
 }

 static struct tst_test test = {
+       .needs_root = 1,
        .test_all = verify_setrlimit,
        .setup = setup,
        .cleanup = cleanup,

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200211/df7aaa60/attachment.htm>
