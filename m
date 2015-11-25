From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 25 Nov 2015 09:34:11 +0800
Subject: [LTP] [PATCH v3 1/2] kernel/io/disktest: cleanup upon failure occurs
In-Reply-To: <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <1448415252-11221-1-git-send-email-weijg.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/io/disktest/dump.c | 2 ++
 testcases/kernel/io/disktest/main.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/testcases/kernel/io/disktest/dump.c b/testcases/kernel/io/disktest/dump.c
index 615e8b4..4c38311 100644
--- a/testcases/kernel/io/disktest/dump.c
+++ b/testcases/kernel/io/disktest/dump.c
@@ -192,12 +192,14 @@ int do_dump(child_args_t * args)
 		pMsg(ERR, args, "could not open %s.\n", args->device);
 		pMsg(ERR, args, "%s: Error = %u\n", args->device,
 		     GETLASTERROR());
+		FREE(buff);
 		return (-1);
 	}
 
 	TargetLBA = Seek(fd, args->start_lba * BLK_SIZE);
 	if (TargetLBA != (args->start_lba * (OFF_T) BLK_SIZE)) {
 		pMsg(ERR, args, "Could not seek to start position.\n");
+		FREE(buff);
 		CLOSE(fd);
 		return (-1);
 	}
diff --git a/testcases/kernel/io/disktest/main.c b/testcases/kernel/io/disktest/main.c
index 9484ec1..c372b04 100644
--- a/testcases/kernel/io/disktest/main.c
+++ b/testcases/kernel/io/disktest/main.c
@@ -501,6 +501,7 @@ test_ll_t *run()
 			     &cleanArgs,
 			     "%s is not a regular file, could not be opened for reading, or was not found.",
 			     filespec);
+			FREE(aFilespec);
 
 			return newTest;
 		}
-- 
1.9.3



