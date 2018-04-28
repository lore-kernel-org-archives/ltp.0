From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Sat, 28 Apr 2018 14:29:57 +0300
Subject: [LTP] [PATCH v3 3/3] sctp_big_chunk: use SPDX-License-Identifier
	GPL-2.0
In-Reply-To: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1524914997-27080-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: new patch in v3

 testcases/network/sctp/sctp_big_chunk.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 89c5e0d..333e502 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -1,18 +1,5 @@
-/*
- * Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
  *
  * Regression test-case for the crash caused by over-sized SCTP chunk,
  * fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a new
-- 
1.7.1

