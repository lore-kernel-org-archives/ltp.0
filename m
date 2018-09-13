From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Sep 2018 17:44:38 +0300
Subject: [LTP] [RFC PATCH 1/5] Remove the pipes runtest file
In-Reply-To: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1536849882-28897-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have two almost identical runtest files:

[root@localhost runtest]# diff ipc pipes
1c1
< #DESCRIPTION:Interprocess communication stress
---
> #DESCRIPTION:IPC pipes stress
30,32d29
<
< sem01 sem01
< sem02 sem02
[root@localhost runtest]#

Since both are part of the default scenario, their common tests
are executed twice by LTP run. Let's fix that by removing the pipes file.
If one needs to execute only pipeio* test cases, he/she will still be able
to do it by executing the ipc file.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/pipes           | 29 -----------------------------
 scenario_groups/default |  1 -
 2 files changed, 30 deletions(-)
 delete mode 100644 runtest/pipes

diff --git a/runtest/pipes b/runtest/pipes
deleted file mode 100644
index 900c9a2..0000000
--- a/runtest/pipes
+++ /dev/null
@@ -1,29 +0,0 @@
-#DESCRIPTION:IPC pipes stress
-# These tests use tests/pipeio to put pipes (named or unnamed) through a workout
-#
-pipeio_1 pipeio -T pipeio_1 -c 5 -s 4090 -i 100 -b -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
-# using blocking I/O
-#pipeio_2 pipeio -T pipeio_2 -c 5 -s 4090 -i 100 -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
-# using non-blocking I/O
-# This test hits EAGAIN, which pipeio doesn't handle at the moment
-pipeio_3 pipeio -T pipeio_3 -c 5 -s 4090 -i 100 -u -b -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to an unnamed pipe
-# using blocking I/O
-pipeio_4 pipeio -T pipeio_4 -c 5 -s 4090 -i 100 -u -f x80
-# spawns 5 children to write 100 chunks of 4090 bytes to an unnamed pipe
-# using non-blocking I/O
-pipeio_5 pipeio -T pipeio_5 -c 5 -s 5000 -i 10 -b -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to a named pipe
-# using blocking I/O
-pipeio_6 pipeio -T pipeio_6 -c 5 -s 5000 -i 10 -b -u -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
-# using blocking I/O
-#pipeio_7 pipeio -T pipeio_7 -c 5 -s 5000 -i 10 -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to a named pipe
-# using non-blocking I/O
-# This test hits EAGAIN, which pipeio doesn't handle at the moment
-pipeio_8 pipeio -T pipeio_8 -c 5 -s 5000 -i 10 -u -f x80
-# spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
-# using non-blocking I/O
diff --git a/scenario_groups/default b/scenario_groups/default
index 5658a61..a0179c2 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -27,7 +27,6 @@ hyperthreading
 kernel_misc
 modules
 fs_ext4
-pipes
 can
 cpuhotplug
 net.ipv6_lib
-- 
1.8.3.1

