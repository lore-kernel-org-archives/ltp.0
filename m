From: Li Wang <liwang@redhat.com>
Date: Mon,  5 Jul 2021 16:25:27 +0800
Subject: [LTP] [PATCH v2 2/2] lib: mount tmpfs name as ltp-tmpfs
In-Reply-To: <20210705082527.855688-1-liwang@redhat.com>
References: <20210705082527.855688-1-liwang@redhat.com>
Message-ID: <20210705082527.855688-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Given a specific name as "ltp-tmpfs" instead of the "/dev/loopX"
string in order to make "tmpfs" filesystem more evident.

Achieve that in get_device_name() function.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    V1 --> V2
       * create a function get_device_name()

 lib/tst_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 93761868e..b85134709 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -907,6 +907,14 @@ static char *limit_tmpfs_mount_size(const char *mnt_data,
 	return buf;
 }
 
+static const char *get_device_name(const char *fs_type)
+{
+       if (!strcmp(fs_type, "tmpfs"))
+               return "ltp-tmpfs";
+       else
+               return tdev.dev;
+}
+
 static void prepare_device(void)
 {
 	char *mnt_data, buf[1024];
@@ -926,8 +934,8 @@ static void prepare_device(void)
 		mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
 				buf, sizeof(buf), tdev.fs_type);
 
-		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
-			   tst_test->mnt_flags, mnt_data);
+		SAFE_MOUNT(get_device_name(tdev.fs_type), tst_test->mntpoint,
+				tdev.fs_type, tst_test->mnt_flags, mnt_data);
 		mntpoint_mounted = 1;
 	}
 }
-- 
2.31.1

