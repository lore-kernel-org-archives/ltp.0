From: Leo Yu-Chi Liang <ycliang@andestech.com>
Date: Fri, 11 Jun 2021 01:58:12 +0800
Subject: [LTP] [PATCH 1/1] fs/racer: Fix LTP hang caused by fs_racer.sh
Message-ID: <20210610175812.13730-1-ycliang@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fs_racer.sh test could cause LTP to hang if the file
gets removed when it's at time same time being renamed.

The if statement in mv source implemented by busybox is as follows:

	if (dest_exists) {
		if (flags & OPT_NOCLOBBER)
			goto RET_0;
		if (!(flags & OPT_FORCE)           // OPT_FORCE is set by -f option
		 && ((access(dest, W_OK) < 0 && isatty(0))
		    || (flags & OPT_INTERACTIVE))  // this is set by -i option
		) {
			if (fprintf(stderr, "mv: overwrite '%s'? ", dest) < 0) {
				goto RET_1;  /* Ouch! fprintf failed! */
			}
			if (!bb_ask_y_confirmation()) {
				goto RET_0;
			}
		}
	}

If somehow the dest_file exists when mv executes the first if "if (dest_exists)",
and gets removed when mv executes the third if "if (access(...))".
Then it is possible for mv to reach "bb_ask_y_confirmation" and to try to read from tty.

However, the mv process is executing in the background,
so when it tries to read from tty,
the processes in the same process group as mv would all receive SIGTTIN
and be changed into TASK_STOPPED state.

This would cause this testcase to hang, though happens rarely.

Add -f option to suppress the attempt to read from tty.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/fs/racer/fs_racer_file_rename.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/racer/fs_racer_file_rename.sh b/testcases/kernel/fs/racer/fs_racer_file_rename.sh
index 7e2e6b1b2..15090361f 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_rename.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_rename.sh
@@ -25,5 +25,5 @@ MAX=$2
 while true ; do
     file=$(($RANDOM%$MAX))
     new_file=$((($file + 1)%$MAX))
-    mv $DIR/$file $DIR/$new_file 2> /dev/null
+    mv -f $DIR/$file $DIR/$new_file 2> /dev/null
 done
-- 
2.17.0

