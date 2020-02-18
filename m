From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Feb 2020 14:24:27 +0530
Subject: [LTP] stable-rc 5.5.5-rc1: [drm:ade_irq_handler [kirin_drm]]
 *ERROR* LDI underflow!
Message-ID: <CA+G9fYtmJkYdUG1wXgUHs3KoLdGQPYFcR8oTzFmDJ5oMXu5kaQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The arm64 device running LTP hugetlb test suite caused test hang on
stable-rc 5.5.5-rc1 due to [drm:ade_irq_handler [kirin_drm]] *ERROR*
LDI underflow!.
Same problem noticed while running libhugetlbfs test suite.

Problematic patch not identified yet.

hugemmap05.c:223: INFO: original nr_hugepages is 0
hugemmap05.c:236: INFO: original nr_overcommit_hugepages is 0
hugemmap05.c:104: INFO: check /proc/meminfo before allocation.
hugemmap05.c:285: INFO: HugePages_Total is 192.
hugemmap05.c:285: INFO: HugePages_Free is 192.
hugemmap05.c:285: INFO: HugePages_Surp is 64.
hugemmap05.c:285: INFO: HugePages_[   51.411646] [drm:ade_irq_handler
[kirin_drm]] *ERROR* LDI underflow!
Rsvd is 192.
[   51.411735] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.419705] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.427680] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.434455] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.441179] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.447912] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.454639] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.461395] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.468175] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.475014] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.481868] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.488621] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.495367] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.502113] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.508845] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.515582] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.522316] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.529054] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.535836] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.542621] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.549399] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.556144] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.562897] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.569634] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.576378] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.583142] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.589889] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.596610] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
hugemmap05.c:260:[   51.603356] [drm:ade_irq_handler [kirin_drm]]
*ERROR* LDI underflow!
 INFO: First hex is 7070707
[   51.610101] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   51.621956] [drm:ade_ldi_set_mode [kirin_drm]] *ERROR* failed to
set pixel clk 0Hz (-22)
hugemmap05.c:139: INFO: check /proc/meminfo.
hugemmap05.c:285: INFO: HugePages_Total is 192.
hugemmap05.c:285: INFO: HugePages_Free is 0.
hugemmap05.c:285: INFO: HugePages_Surp is 64.
hugemmap05.c:285: INFO: HugePages_Rsvd is 0.
hugemmap05.c:163: PASS: hugepages overcommit test pass
hugemmap05.c:180: INFO: restore nr_hugepages to 0.
hugemmap05.c:189: INFO: restore nr_overcommit_hugepages to 0.
Summary:
passed   1
failed   0
skipped  0
warnings 0
tst_test.c:1217: INFO: Timeout per run is 0h 15m 00s
mem.c:817: INFO: set nr_hugepages to 255
[   54.139687] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   54.143384] [drm:ade_ldi_set_mode [kirin_drm]] *ERROR* failed to
set pixel clk 0Hz (-22)
[   54.278589] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   54.280642] [drm:ade_ldi_set_mode [kirin_drm]] *ERROR* failed to
set pixel clk 0Hz (-22)
hugemmap06.c:139: PASS: No regression found.
[   54.520165] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   54.522769] [drm:ade_ldi_set_mode [kirin_drm]] *ERROR* failed to
set pixel clk 0Hz (-22)
[   54.664774] [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
[   54.668013] [drm:ade_ldi_set_mode [kirin_drm]] *ERROR* failed to
set pixel clk 0Hz (-22)

<SYSTEM HANGS HERE>

Ref:
https://lkft.validation.linaro.org/scheduler/job/1227316#L4288

metadata:
  git branch: linux-5.5.y
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git commit: 7d6c8f2632c92635fcef4175921a7742f23947e4
  git describe: v5.5.4-46-g7d6c8f2632c9
  make_kernelversion: 5.5.5-rc1
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/hikey/lkft/linux-stable-rc-5.5/24/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/hikey/lkft/linux-stable-rc-5.5/24

-- 
Linaro LKFT
https://lkft.linaro.org
