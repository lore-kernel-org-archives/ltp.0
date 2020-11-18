From: Petr Cervinka <pcervinka@suse.com>
Date: Wed, 18 Nov 2020 11:37:05 +0100
Subject: [LTP] [PATCH v1] Fix SPDX License GPL-2.0-or-later identifier
Message-ID: <20201118103705.19876-1-pcervinka@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Cervinka <pcervinka@suse.com>
---
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c | 2 +-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c | 2 +-
 testcases/kernel/syscalls/pipe2/pipe2_01.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 226985d5..43bc732f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-late
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 506d1df0..1f88166d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-late
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index efb82af4..6597162e 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-late
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Ulrich Drepper <drepper@redhat.com>
  * Copyright (c) International Business Machines  Corp., 2009
-- 
2.29.2

