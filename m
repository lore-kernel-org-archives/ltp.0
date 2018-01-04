From: Qiao Zhao <qiaozqjhsy@gmail.com>
Date: Thu,  4 Jan 2018 16:44:32 +0800
Subject: [LTP] [PATCH] crasher/crasher.c: Fix release incompatibilities
	issue.
Message-ID: <1515055472-7443-1-git-send-email-qiaozqjhsy@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since 4.x kernel, the old function "create_proc_entry" is not in
in use, we need to use new function "proc_create_data", and to
match all kernel version.
Others, I have tested this case on RHEL 6, 7, and Fedora 26 and 27.

Signed-off-by: Qiao Zhao <qiaozqjhsy@gmail.com>
---
 testcases/kdump/lib/crasher/crasher.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/testcases/kdump/lib/crasher/crasher.c b/testcases/kdump/lib/crasher/crasher.c
index fe72986..d850634 100644
--- a/testcases/kdump/lib/crasher/crasher.c
+++ b/testcases/kdump/lib/crasher/crasher.c
@@ -26,9 +26,7 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
-# include <asm/system.h>
-#endif
+#include <linux/uaccess.h>
 
 MODULE_LICENSE("GPL");
 
@@ -39,14 +37,24 @@ module_exit(crasher_exit);
 
 #define CRASH "crasher"		/* name of /proc entry file */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 static int crasher_read(char *buf, char **start, off_t offset, int len,
 			int *eof, void *data)
+#else
+static ssize_t crasher_read(struct file *file, char __user *buf, size_t len,
+				loff_t *offset)
+#endif
 {
 	return (sprintf(buf, "\n"));
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 static int crasher_write(struct file *file, const char *buffer,
 			 unsigned long count, void *data)
+#else
+static ssize_t crasher_write(struct file *file, const char __user *buffer,
+			size_t count, loff_t *data)
+#endif
 {
 	char value, *a;
 	DEFINE_SPINLOCK(mylock);
@@ -84,6 +92,15 @@ static int crasher_write(struct file *file, const char *buffer,
 
 /* create a directory in /proc and a debug file in the new directory */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+#else
+static const struct file_operations crasher_proc_fops = {
+	.owner = THIS_MODULE,
+	.read  = crasher_read,
+	.write = crasher_write,
+};
+#endif
+
 int crasher_init(void)
 {
 	struct proc_dir_entry *crasher_proc;
@@ -91,14 +108,19 @@ int crasher_init(void)
 	printk("loaded crasher module\n");
 
 	/* build a crasher file that can be set */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 	if ((crasher_proc = create_proc_entry(CRASH, 0, NULL)) == NULL) {
 		return -ENOMEM;
 	}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
 	crasher_proc->owner = THIS_MODULE
-#endif
 	crasher_proc->read_proc = crasher_read;
 	crasher_proc->write_proc = crasher_write;
+#else
+	if ((crasher_proc = proc_create_data(CRASH, 0, NULL,
+			&crasher_proc_fops,NULL)) == NULL) {
+		return -ENOMEM;
+	}
+#endif
 	return 0;
 }
 
-- 
1.8.3.1

