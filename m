From: Pankaj-Joshi <pankaj.joshi347@gmail.com>
Date: Thu, 25 Feb 2021 16:20:24 +0530
Subject: [LTP] [PATCH] Updated README.kernel_config
Message-ID: <20210225105024.25561-1-pankaj.joshi347@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: pankajjoshi347 <pankaj.joshi347@gmail.com>

---
 README.kernel_config | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/README.kernel_config b/README.kernel_config
index 547dd4f33..eed19e557 100644
--- a/README.kernel_config
+++ b/README.kernel_config
@@ -18,8 +18,11 @@ CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
+CONFIG_TIME_NS=y
 CONFIG_VETH=y
 CONFIG_MACVLAN=y
+CONFIG_TUN=y
+CONFIG_TAP=y
 
 The IPC namespaces do not automatically enable IPC, so you may
 also want to have:
@@ -128,6 +131,8 @@ CONFIG_CRASH_DUMP=y
 CONFIG_PM=y
 CONFIG_HIBERNATION=y
 CONFIG_KEXEC_JUMP=y
+CONFIG_SECCOMP=y
+CONFIG_NUMA=y
 ---------------------------------
 Enabling HOTPLUG for your Kernels
 ---------------------------------
@@ -281,10 +286,32 @@ end
 1) Add or modify testcases when relevant kernel functionality changes.
 ---------------------------------
 
+---------------------------------
+Enabling Kernel Configuration to test Memory management features
+---------------------------------
+CONFIG_KSM=y
+CONFIG_THP_SWAP=y
+CONFIG_MEMORY_FAILURE=y
+---------------------------------
+Enabling Kernel Configuration to test other filesystems
+---------------------------------
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SWAP=y
+CONFIG_FANOTIFY=y
+CONFIG_QFMT_V2=y
+CONFIG_XFS_QUOTA=y
+CONFIG_HUGETLBFS=y
+CONFIG_HUGETLB_PAGE=y
+---------------------------------
+Enabling Kernel Configuration to test CPU/Task time and stats accounting
+---------------------------------
+CONFIG_BSD_PROCESS_ACCT=y
 ---------------------------------
 Enabling Kernel Configuration to test ext4 new features
 ---------------------------------
 CONFIG_EXT4_FS=y
+CONFIG_EXT4_ENCRYPTION=y
 CONFIG_EXT4DEV_COMPAT=y
 CONFIG_EXT4_FS_XATTR=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.17.1

