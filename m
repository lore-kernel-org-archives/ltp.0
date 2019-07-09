From: Christian Amann <camann@suse.com>
Date: Tue, 9 Jul 2019 08:10:35 +0000
Subject: [LTP] [PATCH v1] syscalls/ioctl08: Add check for btrfs
In-Reply-To: <20190709073228.18707-1-camann@suse.com>
References: <20190709073228.18707-1-camann@suse.com>
Message-ID: <MW2PR18MB2234061990DCAD3F1D38941FABF10@MW2PR18MB2234.namprd18.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, I just found out that my mail forwarding stopped working so I didn't see that there's already a patch for that.

Please Ignore this, thanks!


Regards,

Christian


________________________________
From: Christian Amann
Sent: Tuesday, July 9, 2019 9:32:28 AM
To: ltp@lists.linux.it
Cc: amir73il@gmail.com; Christian Amann
Subject: [PATCH v1] syscalls/ioctl08: Add check for btrfs

This test used to fail on systems with missing btrfs support. Now it
ends with TCONF.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl08.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 8de80048c..c39423b8b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -112,9 +112,15 @@ static void setup(void)
                         sizeof(struct file_dedupe_range_info));
 }

+static const char *kconfigs[] = {
+       "CONFIG_BTRFS_FS",
+       NULL
+};
+
 static struct tst_test test = {
         .test = verify_ioctl,
         .tcnt = ARRAY_SIZE(tcases),
+       .needs_kconfigs = kconfigs,
         .setup = setup,
         .cleanup = cleanup,
         .min_kver = "4.5",
--
2.16.4

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190709/0bdb9c6b/attachment-0001.htm>
