From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  5 Jun 2020 11:02:19 +0200
Subject: [LTP] [PATCH 1/3] lapi/syscalls: add setns to hppa
Message-ID: <9b9e3d35b4fddb668b02595e418a997332f98491.1591347655.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/syscalls/hppa.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index e00d2dc6d37d..7f9b5e0a01b9 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -17,6 +17,7 @@ splice 291
 tee 293
 vmsplice 294
 syncfs 327
+setns 328
 process_vm_readv 330
 process_vm_writev 331
 memfd_create 340
-- 
2.18.1

