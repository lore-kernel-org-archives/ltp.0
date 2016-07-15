From: Nga Hoang <nga.hoangthithuy@vn.bosch.com>
Date: Fri, 15 Jul 2016 16:47:03 +0700
Subject: [LTP] [PATCH] consolidate 4 TCs message_queue_test_02_* into
	message_queue_test_02.sh to avoid fail in case of random execution
Message-ID: <1468576023-32754-1-git-send-email-nga.hoangthithuy@vn.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Signed-off-by: Hoang Thi Thuy Nga (RBVH/ENG2) <ngh1hc@HCUT2832C.hc.apac.bosch.com>
---
 runtest/ipc                                              | 5 +----
 testcases/kernel/ipc/ipc_stress/Makefile                 | 2 +-
 testcases/kernel/ipc/ipc_stress/message_queue_test_02.sh | 6 ++++++
 3 files changed, 8 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/ipc/ipc_stress/message_queue_test_02.sh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-consolidate-4-TCs-message_queue_test_02_-into-messag.patch
Type: text/x-patch
Size: 1534 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160715/edef22ab/attachment.bin>
