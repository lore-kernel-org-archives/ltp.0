From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jul 2019 14:09:13 +0800
Subject: [LTP] [PATCH v1] Moved timer tests to syscall directory
In-Reply-To: <20190726061316.9183-1-camann@suse.com>
References: <20190726061316.9183-1-camann@suse.com>
Message-ID: <CAEemH2egK86uQW+OCj0o7AM=cVEkAP+TC8JvoU3PfW_maz7xKg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 26, 2019 at 2:13 PM Christian Amann <camann@suse.com> wrote:
>
> - Moved all timer tests to the syscall directory and made the numbers
>   start from 1 again (e.g timer_create02 -> timer_create01).
> - Moved common_timers.h to lapi include directory.
> - Moved the contents of the runtest/timers file into the
>   runtest/syscalls file
> - Moved leapsec_timer test to the other clock_gettime tests
>
> Signed-off-by: Christian Amann <camann@suse.com>

Pushed with tiny fixes. Thank you, Christian.

Remove timers from kernel/Makefile otherwise, it will fail at compiling phase.

--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -53,7 +53,6 @@ SUBDIRS                       += connectors \
                           sched \
                           security \
                           sound \
-                          timers \
                           tracing \


Also correct the clock_gettime03.c TCID:

--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -35,7 +35,7 @@
 #define SECONDS_BEFORE_LEAP 2
 #define SECONDS_AFTER_LEAP 2

-char *TCID = "leapsec_timer";
+char *TCID = "clock_gettime03";
 int TST_TOTAL = 1;

-- 
Regards,
Li Wang
