Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15971C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 15:09:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 649453C925A
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 16:09:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21DEF3C8E4D
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 16:09:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB6661A001D5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 16:09:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1472821117;
 Tue, 21 Dec 2021 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640099360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=C5LgtYd7anoFqak+eQ0p4PUiuYUaqUTHz9Bs81A3080=;
 b=C+UGMNM8Ht6J1NkvWwIaLaKj0o+jeIU4B1v2bMWY1ie3UwJ8qPABxgsOOeMshNRInUP1yq
 nsVOEqTP5RdZqfX9NA0Y9MCK34u6X1mU2YW4mqT9rdZbKxIsdX9vIh0W6Hm0eqvYsLrUYe
 3yr8PRlI4+mceKjle+Iw9a6Y24nGdHU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD89D13CAD;
 Tue, 21 Dec 2021 15:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BefMLx/uwWEvXwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 21 Dec 2021 15:09:19 +0000
To: ltp@lists.linux.it
Date: Tue, 21 Dec 2021 16:09:18 +0100
Message-Id: <20211221150918.3987-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactoring aio-stress.c using LTP API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/ltp-aio-stress.part1                | 147 ++--
 runtest/ltp-aio-stress.part2                |  65 +-
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 809 +++++++++-----------
 3 files changed, 482 insertions(+), 539 deletions(-)

diff --git a/runtest/ltp-aio-stress.part1 b/runtest/ltp-aio-stress.part1
index a770a40ae..656e71872 100644
--- a/runtest/ltp-aio-stress.part1
+++ b/runtest/ltp-aio-stress.part1
@@ -1,79 +1,74 @@
 #DESCRIPTION:ltp A-sync IO Stress IO tests
 #
-# aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
-#                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [file2 ...]
-#       -a size in KB at which to align buffers
-#       -b max number of iocbs to give io_submit at once
-#       -c number of io contexts per file
-#       -C offset between contexts, default 2MB
-#       -s size in MB of the test file(s), default 1024MB
-#       -r record size in KB used for each io, default 64KB
-#       -d number of pending aio requests for each file, default 64
-#       -i number of ios per file sent before switching
-#          to the next file, default 8
-#       -O Use O_DIRECT (not available in 2.4 kernels),
-#       -S Use O_SYNC for writes
-#       -o add an operation to the list: write=0, read=1,
-#          random write=2, random read=3.
-#          repeat -o to specify multiple ops: -o 0 -o 1 etc.
-#       -m shm use ipc shared memory for io buffers instead of malloc
-#       -m shmfs mmap a file in /dev/shm for io buffers
-#       -n no fsyncs between write stage and read stage
-#       -l print io_submit latencies after each stage
-#       -t number of threads to run
-#       -v verification of bytes written
-#       -x turn off thread stonewalling
-#       -h this message
+# -f       Number of files to generate
+# -b       Max number of iocbs to give io_submit at once
+# -c       Number of io contexts per file
+# -g       Offset between contexts (default 2M)
+# -s       Size in MB of the test file(s) (default 1024M)
+# -r       Record size in KB used for each io (default 64K)
+# -d       Number of pending aio requests for each file (default 64)
+# -e       Number of I/O per file sent before switching to the next file (default 8)
+# -a       Total number of ayncs I/O the program will run, default is run until Cntl-C
+# -O       Use O_DIRECT (not available in 2.4 kernels)
+# -S       Use O_SYNC for writes
+# -o       Add an operation to the list: write=0, read=1, random write=2, random read=3
+# -m       SHM use ipc shared memory for io buffers instead of malloc
+# -n       No fsyncs between write stage and read stage
+# -l       Print io_submit latencies after each stage
+# -L       Print io completion latencies after each stage
+# -t       Number of threads to run
+# -u       Unlink files after completion
+# -v       Verification of bytes written
+# -x       Turn off thread stonewalling
 #
-ADS1000 aio-stress -I500  -o2 -S -r4   $TMPDIR/file1
-ADS1001 aio-stress -I500  -o2 -S -r8   $TMPDIR/file1
-ADS1002 aio-stress -I500  -o2 -S -r16  $TMPDIR/file1
-ADS1003 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1004 aio-stress -I500  -o2 -S -r64   $TMPDIR/junkfile $TMPDIR/file2
-ADS1005 aio-stress -I500  -o3 -S -r4    $TMPDIR/junkfile $TMPDIR/file2
-ADS1006 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1007 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1008 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
-ADS1009 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
-ADS1010 aio-stress -I500  -o3 -S -r128 -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
-ADS1011 aio-stress -I500  -o3 -S -r256 -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
-ADS1012 aio-stress -I500  -o3 -S -r512 -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
-ADS1013 aio-stress -I500  -o2 -O -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
-ADS1014 aio-stress -I500  -o2 -O -r8         $TMPDIR/file1 $TMPDIR/file2
-ADS1015 aio-stress -I500  -o2 -O -r16        $TMPDIR/file1 $TMPDIR/file2
-ADS1016 aio-stress -I500  -o2 -O -r32   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1017 aio-stress -I500  -o2 -O -r64   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1018 aio-stress -I500  -o3 -O -r4    -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1019 aio-stress -I500  -o3 -O -r8    -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1020 aio-stress -I500  -o3 -O -r16   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS1021 aio-stress -I500  -o3 -O -r32   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
-ADS1022 aio-stress -I500  -o3 -O -r64   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
-ADS1023 aio-stress -I500  -o3 -O -r128  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
-ADS1024 aio-stress -I500  -o3 -O -r256  -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
-ADS1025 aio-stress -I500  -o3 -O -r512  -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1026 aio-stress -I500  -o0 -S -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2       $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1027 aio-stress -I500  -o0 -S -r8           $TMPDIR/file2
-ADS1028 aio-stress -I500  -o0 -S -r16          $TMPDIR/file2
-ADS1029 aio-stress -I500  -o0 -S -r32   -t2    $TMPDIR/junkfile $TMPDIR/file2
-ADS1030 aio-stress -I500  -o0 -S -r64   -t2    $TMPDIR/junkfile $TMPDIR/file2
-ADS1031 aio-stress -I500  -o1 -S -r4    -t2    $TMPDIR/junkfile $TMPDIR/file2
-ADS1032 aio-stress -I500  -o1 -S -r8    -t2    $TMPDIR/junkfile $TMPDIR/file2
-ADS1033 aio-stress -I500  -o1 -S -r16   -t2    $TMPDIR/junkfile $TMPDIR/file2
-ADS1034 aio-stress -I500  -o1 -S -r32   -t4    $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
-ADS1035 aio-stress -I500  -o1 -S -r64   -t4    $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
-ADS1036 aio-stress -I500  -o1 -S -r128  -t4    $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
-ADS1037 aio-stress -I500  -o1 -S -r256  -t8  $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
-ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x $TMPDIR/junkfile $TMPDIR/file2
-ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  $TMPDIR/junkfile $TMPDIR/file2
-ADS1042 aio-stress -I500  -o1 -O -r32   -t2   $TMPDIR/junkfile $TMPDIR/file2
-ADS1043 aio-stress -I500  -o1 -O -r64   -t2   $TMPDIR/junkfile $TMPDIR/file2
-ADS1044 aio-stress -I500  -o1 -O -r4    -t4   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8
-ADS1045 aio-stress -I500  -o1 -O -r8    -t4   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
-ADS1046 aio-stress -I500  -o1 -O -r16   -t4   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8
-ADS1047 aio-stress -I500  -o1 -O -r32   -t8   $TMPDIR/junkfile $TMPDIR/file2     $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
-ADS1048 aio-stress -I500  -o1 -O -r64   -t8   $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1049 aio-stress -I500  -o1 -O -r128  -t8   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
-ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMPDIR/junkfile $TMPDIR/file2
+ADS1000 aio-stress -a500  -o2 -S -r4 -f1
+ADS1001 aio-stress -a500  -o2 -S -r8 -f1
+ADS1002 aio-stress -a500  -o2 -S -r16 -f1
+ADS1003 aio-stress -a500  -o2 -S -r32 -t2 -f2
+ADS1004 aio-stress -a500  -o2 -S -r64 -f2
+ADS1005 aio-stress -a500  -o3 -S -r4 -f2
+ADS1006 aio-stress -a500  -o3 -S -r8 -f2
+ADS1007 aio-stress -a500  -o3 -S -r16 -f2
+ADS1008 aio-stress -a500  -o3 -S -r32 -f4
+ADS1009 aio-stress -a500  -o3 -S -r64 -t4 -f4
+ADS1010 aio-stress -a500  -o3 -S -r128 -t4 -f4
+ADS1011 aio-stress -a500  -o3 -S -r256 -t8 -f8
+ADS1012 aio-stress -a500  -o3 -S -r512 -t8 -f8
+ADS1013 aio-stress -a500  -o2 -O -r4 -t8 -f8
+ADS1014 aio-stress -a500  -o2 -O -r8 -f2
+ADS1015 aio-stress -a500  -o2 -O -r16 -f2
+ADS1016 aio-stress -a500  -o2 -O -r32 -t2 -f2
+ADS1017 aio-stress -a500  -o2 -O -r64 -t2 -f2
+ADS1018 aio-stress -a500  -o3 -O -r4 -t2 -f2
+ADS1019 aio-stress -a500  -o3 -O -r8 -t2 -f2
+ADS1020 aio-stress -a500  -o3 -O -r16 -t2 -f2
+ADS1021 aio-stress -a500  -o3 -O -r32 -t4 -f4
+ADS1022 aio-stress -a500  -o3 -O -r64 -t4 -f4
+ADS1023 aio-stress -a500  -o3 -O -r128 -t4 -f4
+ADS1024 aio-stress -a500  -o3 -O -r256 -t8 -f8
+ADS1025 aio-stress -a500  -o3 -O -r512 -t8 -f8
+ADS1026 aio-stress -a500  -o0 -S -r4 -t8 -f8
+ADS1027 aio-stress -a500  -o0 -S -r8 -f1
+ADS1028 aio-stress -a500  -o0 -S -r16 -f1
+ADS1029 aio-stress -a500  -o0 -S -r32 -t2 -f2
+ADS1030 aio-stress -a500  -o0 -S -r64 -t2 -f2
+ADS1031 aio-stress -a500  -o1 -S -r4 -t2 -f1
+ADS1032 aio-stress -a500  -o1 -S -r8 -t2 -f1
+ADS1033 aio-stress -a500  -o1 -S -r16 -t2 -f2
+ADS1034 aio-stress -a500  -o1 -S -r32 -t4 -f4
+ADS1035 aio-stress -a500  -o1 -S -r64 -t4 -f4
+ADS1036 aio-stress -a500  -o1 -S -r128 -t4 -f4
+ADS1037 aio-stress -a500  -o1 -S -r256 -t8 -f8
+ADS1038 aio-stress -a500  -o1 -S -r512 -t8 -f8
+ADS1039 aio-stress -a500  -o1 -O -r4 -t8 -f8
+ADS1040 aio-stress -a500  -o1 -O -r8 -t2 -f2
+ADS1041 aio-stress -a500  -o1 -O -r16 -t2 -f2
+ADS1042 aio-stress -a500  -o1 -O -r32 -t2 -f2
+ADS1043 aio-stress -a500  -o1 -O -r64 -t2 -f2
+ADS1044 aio-stress -a500  -o1 -O -r4 -t4 -f4
+ADS1045 aio-stress -a500  -o1 -O -r8 -t4 -f4
+ADS1046 aio-stress -a500  -o1 -O -r16 -t4 -f4
+ADS1047 aio-stress -a500  -o1 -O -r32 -t8 -f8
+ADS1048 aio-stress -a500  -o1 -O -r64 -t8 -f8
+ADS1049 aio-stress -a500  -o1 -O -r128 -t8 -f8
+ADS1050 aio-stress -a500  -o1 -O -r256 -t2 -f2
diff --git a/runtest/ltp-aio-stress.part2 b/runtest/ltp-aio-stress.part2
index 3a60e23e9..e1b837a39 100644
--- a/runtest/ltp-aio-stress.part2
+++ b/runtest/ltp-aio-stress.part2
@@ -1,38 +1,33 @@
 #DESCRIPTION:ltp A-sync IO Stress IO tests
 #
-# aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
-#                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
-#                 file1 [file2 ...]
-#       -a size in KB at which to align buffers
-#       -b max number of iocbs to give io_submit at once
-#       -c number of io contexts per file
-#       -C offset between contexts, default 2MB
-#       -s size in MB of the test file(s), default 1024MB
-#       -r record size in KB used for each io, default 64KB
-#       -d number of pending aio requests for each file, default 64
-#       -i number of ios per file sent before switching
-#          to the next file, default 8
-#       -O Use O_DIRECT (not available in 2.4 kernels),
-#       -S Use O_SYNC for writes
-#       -o add an operation to the list: write=0, read=1,
-#          random write=2, random read=3.
-#          repeat -o to specify multiple ops: -o 0 -o 1 etc.
-#       -m shm use ipc shared memory for io buffers instead of malloc
-#       -m shmfs mmap a file in /dev/shm for io buffers
-#       -n no fsyncs between write stage and read stage
-#       -l print io_submit latencies after each stage
-#       -t number of threads to run
-#       -v verification of bytes written
-#       -x turn off thread stonewalling
-#       -h this message
+# -f       Number of files to generate
+# -b       Max number of iocbs to give io_submit at once
+# -c       Number of io contexts per file
+# -g       Offset between contexts (default 2M)
+# -s       Size in MB of the test file(s) (default 1024M)
+# -r       Record size in KB used for each io (default 64K)
+# -d       Number of pending aio requests for each file (default 64)
+# -e       Number of I/O per file sent before switching to the next file (default 8)
+# -a       Total number of ayncs I/O the program will run, default is run until Cntl-C
+# -O       Use O_DIRECT (not available in 2.4 kernels)
+# -S       Use O_SYNC for writes
+# -o       Add an operation to the list: write=0, read=1, random write=2, random read=3
+# -m       SHM use ipc shared memory for io buffers instead of malloc
+# -n       No fsyncs between write stage and read stage
+# -l       Print io_submit latencies after each stage
+# -L       Print io completion latencies after each stage
+# -t       Number of threads to run
+# -u       Unlink files after completion
+# -v       Verification of bytes written
+# -x       Turn off thread stonewalling
 #
-ADS2001 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2002 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2003 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2004 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3 $TMPDIR/file4
-ADS2005 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3 $TMPDIR/file4
-ADS2006 aio-stress -I500  -o2 -O -r32  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2007 aio-stress -I500  -o3 -O -r8   -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2008 aio-stress -I500  -o3 -O -r16  -t2  $TMPDIR/junkfile $TMPDIR/file2
-ADS2009 aio-stress -I500  -o3 -O -r32  -t4  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3 $TMPDIR/file4
-ADS2010 aio-stress -I500  -o3 -O -r64  -t4  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3 $TMPDIR/file4
+ADS2001 aio-stress -a500  -o2 -S -r32  -t2 -f2
+ADS2002 aio-stress -a500  -o3 -S -r8   -t2 -f2
+ADS2003 aio-stress -a500  -o3 -S -r16  -t2 -f2
+ADS2004 aio-stress -a500  -o3 -S -r32  -t4 -f4
+ADS2005 aio-stress -a500  -o3 -S -r64  -t4 -f4
+ADS2006 aio-stress -a500  -o2 -O -r32  -t2 -f2
+ADS2007 aio-stress -a500  -o3 -O -r8   -t2 -f2
+ADS2008 aio-stress -a500  -o3 -O -r16  -t2 -f2
+ADS2009 aio-stress -a500  -o3 -O -r32  -t4 -f4
+ADS2010 aio-stress -a500  -o3 -O -r64  -t4 -f4
diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 348f398db..16b38e91e 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1,51 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2004 SuSE, Inc.  All Rights Reserved.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- *
- * aio-stress
- *
- * will open or create each file on the command line, and start a series
+ * Will open or create each file on the command line, and start a series
  * of aio to it.
  *
- * aio is done in a rotating loop.  first file1 gets 8 requests, then
- * file2, then file3 etc.  As each file finishes writing, it is switched
- * to reads
- *
- * io buffers are aligned in case you want to do raw io
+ * aio is done in a rotating loop. First file1.bin gets 8 requests, then
+ * file2.bin, then file3.bin etc. As each file finishes writing, it is switched
+ * to reads.
  *
- * compile with gcc -Wall -laio -lpthread -o aio-stress aio-stress.c
- *
- * run aio-stress -h to see the options
- *
- * Please mail Chris Mason (mason@suse.com) with bug reports or patches
+ * io buffers are aligned in case you want to do raw io.
  */
+
 #define _FILE_OFFSET_BITS 64
-#define PROG_VERSION "0.21"
 #define NEW_GETEVENTS
 
 #define _GNU_SOURCE
+#include "tst_test.h"
+
+#ifdef HAVE_LIBAIO
 #include <stdio.h>
 #include <errno.h>
 #include <assert.h>
@@ -60,11 +38,6 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <pthread.h>
-
-#include "config.h"
-#include "tst_res_flags.h"
-
-#ifdef HAVE_LIBAIO
 #include <libaio.h>
 
 #define IO_FREE 0
@@ -83,52 +56,71 @@ enum {
 #define USE_SHM 1
 #define USE_SHMFS 2
 
-/*
- * various globals, these are effectively read only by the time the threads
- * are started
- */
-long stages = 0;
-unsigned long page_size_mask;
-int o_direct = 0;
-int o_sync = 0;
-int latency_stats = 0;
-int completion_latency_stats = 0;
-int io_iter = 8;
-int iterations = RUN_FOREVER;
-int max_io_submit = 0;
-long rec_len = 64 * 1024;
-int depth = 64;
-int num_threads = 1;
-int num_contexts = 1;
-off_t context_offset = 2 * 1024 * 1024;
-int fsync_stages = 1;
-int use_shm = 0;
-int shm_id;
-char *unaligned_buffer = NULL;
-char *aligned_buffer = NULL;
-int padded_reclen = 0;
-int stonewall = 1;
-int verify = 0;
-char *verify_buf = NULL;
-int unlink_files = 0;
+static char *str_num_files;
+static char *str_max_io_submit;
+static char *str_num_contexts;
+static char *str_context_offset;
+static char *str_file_size;
+static char *str_rec_len;
+static char *str_depth;
+static char *str_io_iter;
+static char *str_iterations;
+static char *str_o_direct;
+static char *str_o_sync;
+static char *str_stages;
+static char *str_use_shm;
+static char *str_fsync_stages;
+static char *str_latency_stats;
+static char *str_completion_latency_stats;
+static char *str_num_threads;
+static char *str_unlink_files;
+static char *str_verify;
+static char *str_stonewall;
+
+static int num_files;
+static long long file_size;
+static long stages;
+static unsigned long page_size_mask;
+static int o_direct;
+static int o_sync;
+static int latency_stats;
+static int completion_latency_stats;
+static int io_iter;
+static int iterations;
+static int max_io_submit;
+static long rec_len;
+static int depth;
+static int num_threads;
+static int num_contexts;
+static long long context_offset;
+static int fsync_stages;
+static int use_shm;
+static int shm_id;
+static char *unaligned_buffer;
+static char *aligned_buffer;
+static int padded_reclen;
+static int stonewall;
+static int verify;
+static char *verify_buf;
+static int unlink_files;
 
 struct io_unit;
 struct thread_info;
 
 /* pthread mutexes and other globals for keeping the threads in sync */
-pthread_cond_t stage_cond = PTHREAD_COND_INITIALIZER;
-pthread_mutex_t stage_mutex = PTHREAD_MUTEX_INITIALIZER;
-int threads_ending = 0;
-int threads_starting = 0;
-struct timeval global_stage_start_time;
-struct thread_info *global_thread_info;
+static pthread_cond_t stage_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t stage_mutex = PTHREAD_MUTEX_INITIALIZER;
+static int threads_ending;
+static int threads_starting;
+static struct timeval global_stage_start_time;
+static struct thread_info *global_thread_info;
 
 /*
  * latencies during io_submit are measured, these are the
  * granularities for deviations
  */
 #define DEVIATIONS 6
-int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
+static int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
 
 struct io_latency {
 	double max;
@@ -262,6 +254,7 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
 {
 	double sec, usec;
 	double ret;
+
 	sec = stop_tv->tv_sec - start_tv->tv_sec;
 	usec = stop_tv->tv_usec - start_tv->tv_usec;
 	if (sec > 0 && usec < 0) {
@@ -280,6 +273,7 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
 static double time_since_now(struct timeval *start_tv)
 {
 	struct timeval stop_time;
+
 	gettimeofday(&stop_time, NULL);
 	return time_since(start_tv, &stop_time);
 }
@@ -292,6 +286,7 @@ static void calc_latency(struct timeval *start_tv, struct timeval *stop_tv,
 {
 	double delta;
 	int i;
+
 	delta = time_since(start_tv, stop_tv);
 	delta = delta * 1000;
 
@@ -320,7 +315,6 @@ static void oper_list_add(struct io_oper *oper, struct io_oper **list)
 	oper->next = *list;
 	(*list)->prev->next = oper;
 	(*list)->prev = oper;
-	return;
 }
 
 static void oper_list_del(struct io_oper *oper, struct io_oper **list)
@@ -338,11 +332,16 @@ static void oper_list_del(struct io_oper *oper, struct io_oper **list)
 /* worker func to check error fields in the io unit */
 static int check_finished_io(struct io_unit *io)
 {
+	char out[4 * 1024];
+	char *ptr = out;
+	char *msg;
+	int length;
 	int i;
-	if (io->res != io->buf_size) {
 
+	if (io->res != io->buf_size) {
 		struct stat s;
-		fstat(io->io_oper->fd, &s);
+
+		SAFE_FSTAT(io->io_oper->fd, &s);
 
 		/*
 		 * If file size is large enough for the read, then this short
@@ -351,8 +350,8 @@ static int check_finished_io(struct io_unit *io)
 		if ((io->io_oper->rw == READ || io->io_oper->rw == RREAD) &&
 		    s.st_size > (io->iocb.u.c.offset + io->res)) {
 
-			fprintf(stderr,
-				"io err %lu (%s) op %d, off %Lu size %d\n",
+			tst_res(TINFO,
+				"io err %lu (%s) op %d, off %llu size %d",
 				io->res, strerror(-io->res),
 				io->iocb.aio_lio_opcode, io->iocb.u.c.offset,
 				io->buf_size);
@@ -361,19 +360,20 @@ static int check_finished_io(struct io_unit *io)
 			return -1;
 		}
 	}
+
 	if (verify && io->io_oper->rw == READ) {
 		if (memcmp(io->buf, verify_buf, io->io_oper->reclen)) {
-			fprintf(stderr,
-				"verify error, file %s offset %Lu contents (offset:bad:good):\n",
+			tst_res(TINFO,
+				"verify error, file %s offset %llu contents (offset:bad:good):",
 				io->io_oper->file_name, io->iocb.u.c.offset);
 
 			for (i = 0; i < io->io_oper->reclen; i++) {
 				if (io->buf[i] != verify_buf[i]) {
-					fprintf(stderr, "%d:%c:%c ", i,
-						io->buf[i], verify_buf[i]);
+					asprintf(&msg, "%d:%c:%c ", i, io->buf[i], verify_buf[i]);
+					ptr += sprintf(ptr, msg);
 				}
 			}
-			fprintf(stderr, "\n");
+			tst_res(TINFO, "%s", out);
 		}
 
 	}
@@ -392,7 +392,7 @@ static int grab_iou(struct io_unit *io, struct io_oper *oper)
 	return 0;
 }
 
-char *stage_name(int rw)
+static char *stage_name(int rw)
 {
 	switch (rw) {
 	case WRITE:
@@ -422,38 +422,47 @@ static void print_time(struct io_oper *oper)
 	runtime = time_since_now(&oper->start_time);
 	mb = oper_mb_trans(oper);
 	tput = mb / runtime;
-	fprintf(stderr, "%s on %s (%.2f MB/s) %.2f MB in %.2fs\n",
+	tst_res(TINFO, "%s on %s (%.2f MB/s) %.2f MB in %.2fs",
 		stage_name(oper->rw), oper->file_name, tput, mb, runtime);
 }
 
 static void print_lat(char *str, struct io_latency *lat)
 {
+	char out[4 * 1024];
+	char *ptr = out;
+	char *msg;
 	double avg = lat->total_lat / lat->total_io;
 	int i;
 	double total_counted = 0;
-	fprintf(stderr, "%s min %.2f avg %.2f max %.2f\n\t",
-		str, lat->min, avg, lat->max);
+
+	tst_res(TINFO, "%s min %.2f avg %.2f max %.2f", str, lat->min, avg, lat->max);
 
 	for (i = 0; i < DEVIATIONS; i++) {
-		fprintf(stderr, " %.0f < %d", lat->deviations[i],
-			deviations[i]);
+		asprintf(&msg, " %.0f < %d", lat->deviations[i], deviations[i]);
+		ptr += sprintf(ptr, msg);
 		total_counted += lat->deviations[i];
 	}
-	if (total_counted && lat->total_io - total_counted)
-		fprintf(stderr, " < %.0f", lat->total_io - total_counted);
-	fprintf(stderr, "\n");
+
+	if (total_counted && lat->total_io - total_counted) {
+		asprintf(&msg, " < %.0f", lat->total_io - total_counted);
+		ptr += sprintf(ptr, msg);
+	}
+
+	tst_res(TINFO, "%s", out);
 	memset(lat, 0, sizeof(*lat));
 }
 
 static void print_latency(struct thread_info *t)
 {
 	struct io_latency *lat = &t->io_submit_latency;
+
 	print_lat("latency", lat);
 }
 
 static void print_completion_latency(struct thread_info *t)
 {
 	struct io_latency *lat = &t->io_completion_latency;
+
 	print_lat("completion latency", lat);
 }
 
@@ -461,7 +470,7 @@ static void print_completion_latency(struct thread_info *t)
  * updates the fields in the io operation struct that belongs to this
  * io unit, and make the io unit reusable again
  */
-void finish_io(struct thread_info *t, struct io_unit *io, long result,
+static void finish_io(struct thread_info *t, struct io_unit *io, long result,
 	       struct timeval *tv_now)
 {
 	struct io_oper *oper = io->io_oper;
@@ -480,7 +489,7 @@ void finish_io(struct thread_info *t, struct io_unit *io, long result,
 	}
 }
 
-int read_some_events(struct thread_info *t)
+static int read_some_events(struct thread_info *t)
 {
 	struct io_unit *event_io;
 	struct io_event *event;
@@ -524,7 +533,7 @@ retry:
 		event_io = t->free_ious;
 		t->free_ious = t->free_ious->next;
 		if (grab_iou(event_io, oper)) {
-			fprintf(stderr, "io unit on free list but not free\n");
+			tst_res(TINFO, "io unit on free list but not free");
 			abort();
 		}
 		return event_io;
@@ -533,7 +542,8 @@ retry:
 	if (nr > 0)
 		goto retry;
 	else
-		fprintf(stderr, "no free ious after read_some_events\n");
+		tst_res(TINFO, "no free ious after read_some_events");
+
 	return NULL;
 }
 
@@ -545,9 +555,8 @@ static int io_oper_wait(struct thread_info *t, struct io_oper *oper)
 	struct io_event event;
 	struct io_unit *event_io;
 
-	if (oper == NULL) {
+	if (oper == NULL)
 		return 0;
-	}
 
 	if (oper->num_pending == 0)
 		goto done;
@@ -561,6 +570,7 @@ static int io_oper_wait(struct thread_info *t, struct io_oper *oper)
 	while (io_getevents(t->io_ctx, 1, &event, NULL) > 0) {
 #endif
 		struct timeval tv_now;
+
 		event_io = (struct io_unit *)((unsigned long)event.obj);
 
 		gettimeofday(&tv_now, NULL);
@@ -570,14 +580,13 @@ static int io_oper_wait(struct thread_info *t, struct io_oper *oper)
 			break;
 	}
 done:
-	if (oper->num_err) {
-		fprintf(stderr, "%u errors on oper, last %u\n",
-			oper->num_err, oper->last_err);
-	}
+	if (oper->num_err)
+		tst_res(TINFO, "%u errors on oper, last %u", oper->num_err, oper->last_err);
+
 	return 0;
 }
 
-off_t random_byte_offset(struct io_oper * oper)
+static off_t random_byte_offset(struct io_oper *oper)
 {
 	off_t num;
 	off_t rand_byte = oper->start;
@@ -603,9 +612,9 @@ off_t random_byte_offset(struct io_oper * oper)
 	num = (num + page_size_mask) & ~page_size_mask;
 	rand_byte += num;
 
-	if (rand_byte + oper->reclen > oper->end) {
+	if (rand_byte + oper->reclen > oper->end)
 		rand_byte -= oper->reclen;
-	}
+
 	return rand_byte;
 }
 
@@ -623,10 +632,8 @@ static struct io_unit *build_iocb(struct thread_info *t, struct io_oper *oper)
 	off_t rand_byte;
 
 	io = find_iou(t, oper);
-	if (!io) {
-		fprintf(stderr, "unable to find io unit\n");
-		return NULL;
-	}
+	if (!io)
+		tst_brk(TBROK, "unable to find io unit");
 
 	switch (oper->rw) {
 	case WRITE:
@@ -667,10 +674,10 @@ static int finish_oper(struct thread_info *t, struct io_oper *oper)
 
 	io_oper_wait(t, oper);
 	last_err = oper->last_err;
-	if (oper->num_pending > 0) {
-		fprintf(stderr, "oper num_pending is %d\n", oper->num_pending);
-	}
-	close(oper->fd);
+	if (oper->num_pending > 0)
+		tst_res(TINFO, "oper num_pending is %d", oper->num_pending);
+
+	SAFE_CLOSE(oper->fd);
 	free(oper);
 	return last_err;
 }
@@ -685,11 +692,7 @@ static struct io_oper *create_oper(int fd, int rw, off_t start, off_t end,
 {
 	struct io_oper *oper;
 
-	oper = malloc(sizeof(*oper));
-	if (!oper) {
-		fprintf(stderr, "unable to allocate io oper\n");
-		return NULL;
-	}
+	oper = SAFE_MALLOC(sizeof(*oper));
 	memset(oper, 0, sizeof(*oper));
 
 	oper->depth = depth;
@@ -709,7 +712,7 @@ static struct io_oper *create_oper(int fd, int rw, off_t start, off_t end,
  * does setup on num_ios worth of iocbs, but does not actually
  * start any io
  */
-int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
+static int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
 	       struct iocb **my_iocbs)
 {
 	int i;
@@ -726,9 +729,9 @@ int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
 
 	for (i = 0; i < num_ios; i++) {
 		io = build_iocb(t, oper);
-		if (!io) {
+		if (!io)
 			return -1;
-		}
+
 		my_iocbs[i] = &io->iocb;
 	}
 	return num_ios;
@@ -743,6 +746,7 @@ static void update_iou_counters(struct iocb **my_iocbs, int nr,
 {
 	struct io_unit *io;
 	int i;
+
 	for (i = 0; i < nr; i++) {
 		io = (struct io_unit *)(my_iocbs[i]);
 		io->io_oper->num_pending++;
@@ -752,7 +756,7 @@ static void update_iou_counters(struct iocb **my_iocbs, int nr,
 }
 
 /* starts some io for a given file, returns zero if all went well */
-int run_built(struct thread_info *t, int num_ios, struct iocb **my_iocbs)
+static int run_built(struct thread_info *t, int num_ios, struct iocb **my_iocbs)
 {
 	int ret;
 	struct timeval start_time;
@@ -778,17 +782,17 @@ resubmit:
 		 */
 		if (ret > 0 || ret == -EAGAIN) {
 			int old_ret = ret;
-			if ((ret = read_some_events(t) > 0)) {
+
+			ret = read_some_events(t);
+			if (ret > 0) {
 				goto resubmit;
 			} else {
-				fprintf(stderr, "ret was %d and now is %d\n",
-					ret, old_ret);
+				tst_res(TINFO, "ret was %d and now is %d", ret, old_ret);
 				abort();
 			}
 		}
 
-		fprintf(stderr, "ret %d (%s) on io_submit\n", ret,
-			strerror(-ret));
+		tst_res(TINFO, "ret %d (%s) on io_submit", ret, strerror(-ret));
 		return -1;
 	}
 	update_iou_counters(my_iocbs, ret, &stop_time);
@@ -803,6 +807,7 @@ resubmit:
 static int restart_oper(struct io_oper *oper)
 {
 	int new_rw = 0;
+
 	if (oper->last_err)
 		return 0;
 
@@ -847,17 +852,15 @@ static int oper_runnable(struct io_oper *oper)
 	 */
 	if (oper->started_ios || oper->start == 0)
 		return 1;
-	/*
-	 * only the sequential phases force delays in starting */
+
+	/* only the sequential phases force delays in starting */
 	if (oper->rw >= RWRITE)
 		return 1;
-	ret = fstat(oper->fd, &buf);
-	if (ret < 0) {
-		perror("fstat");
-		exit(1);
-	}
+
+	ret = SAFE_FSTAT(oper->fd, &buf);
 	if (S_ISREG(buf.st_mode) && buf.st_size < oper->start)
 		return 0;
+
 	return 1;
 }
 
@@ -903,10 +906,9 @@ static int run_active_list(struct thread_info *t,
 	}
 	if (num_built) {
 		ret = run_built(t, num_built, t->iocbs);
-		if (ret < 0) {
-			fprintf(stderr, "error %d on run_built\n", ret);
-			exit(1);
-		}
+		if (ret < 0)
+			tst_brk(TBROK, "error %d on run_built", ret);
+
 		while (built_opers) {
 			oper = built_opers;
 			oper_list_del(oper, &built_opers);
@@ -917,46 +919,44 @@ static int run_active_list(struct thread_info *t,
 			}
 		}
 	}
+
 	return 0;
 }
 
-void drop_shm()
+static void drop_shm(void)
 {
 	int ret;
 	struct shmid_ds ds;
+
 	if (use_shm != USE_SHM)
 		return;
 
 	ret = shmctl(shm_id, IPC_RMID, &ds);
-	if (ret) {
-		perror("shmctl IPC_RMID");
-	}
+	if (ret)
+		tst_brk(TBROK, "shmctl IPC_RMID");
 }
 
-void aio_setup(io_context_t * io_ctx, int n)
+static void aio_setup(io_context_t *io_ctx, int n)
 {
 	int res = io_queue_init(n, io_ctx);
-	if (res != 0) {
-		fprintf(stderr, "io_queue_setup(%d) returned %d (%s)\n",
-			n, res, strerror(-res));
-		exit(3);
-	}
+
+	if (res != 0)
+		tst_brk(TBROK, "io_queue_setup(%d) returned %d (%s)", n, res, strerror(-res));
 }
 
 /*
  * allocate io operation and event arrays for a given thread
  */
-int setup_ious(struct thread_info *t,
+static int setup_ious(struct thread_info *t,
 	       int num_files, int depth, int reclen, int max_io_submit)
 {
 	int i;
 	size_t bytes = num_files * depth * sizeof(*t->ios);
 
 	t->ios = malloc(bytes);
-	if (!t->ios) {
-		fprintf(stderr, "unable to allocate io units\n");
-		return -1;
-	}
+	if (!t->ios)
+		tst_brk(TBROK, "unable to allocate io units");
+
 	memset(t->ios, 0, bytes);
 
 	for (i = 0; i < depth * num_files; i++) {
@@ -977,7 +977,7 @@ int setup_ious(struct thread_info *t,
 
 	t->iocbs = malloc(sizeof(struct iocb *) * max_io_submit);
 	if (!t->iocbs) {
-		fprintf(stderr, "unable to allocate iocbs\n");
+		tst_res(TINFO, "unable to allocate iocbs");
 		goto free_buffers;
 	}
 
@@ -985,9 +985,10 @@ int setup_ious(struct thread_info *t,
 
 	t->events = malloc(sizeof(struct io_event) * depth * num_files);
 	if (!t->events) {
-		fprintf(stderr, "unable to allocate ram for events\n");
+		tst_res(TINFO, "unable to allocate ram for events");
 		goto free_buffers;
 	}
+
 	memset(t->events, 0, num_files * sizeof(struct io_event) * depth);
 
 	t->num_global_ios = num_files * depth;
@@ -1008,7 +1009,7 @@ free_buffers:
  * and without trying to find a special place in each thread to map the
  * buffers to
  */
-int setup_shared_mem(int num_threads, int num_files, int depth,
+static int setup_shared_mem(int num_threads, int num_files, int depth,
 		     int reclen, int max_io_submit)
 {
 	char *p = NULL;
@@ -1024,17 +1025,17 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
 	total_ram += page_size_mask;
 
 	if (use_shm == USE_MALLOC) {
-		p = malloc(total_ram);
+		p = SAFE_MALLOC(total_ram);
 	} else if (use_shm == USE_SHM) {
 		shm_id = shmget(IPC_PRIVATE, total_ram, IPC_CREAT | 0700);
 		if (shm_id < 0) {
-			perror("shmget");
+			tst_res(TINFO, "shmget error");
 			drop_shm();
 			goto free_buffers;
 		}
 		p = shmat(shm_id, (char *)0x50000000, 0);
 		if ((long)p == -1) {
-			perror("shmat");
+			tst_res(TINFO, "shmat error");
 			goto free_buffers;
 		}
 		/* won't really be dropped until we shmdt */
@@ -1046,22 +1047,22 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
 		strcpy(mmap_name, "/dev/shm/XXXXXX");
 		fd = mkstemp(mmap_name);
 		if (fd < 0) {
-			perror("mkstemp");
+			tst_res(TINFO, "mkstemp error");
 			goto free_buffers;
 		}
-		unlink(mmap_name);
-		ftruncate(fd, total_ram);
+		SAFE_UNLINK(mmap_name);
+		SAFE_FTRUNCATE(fd, total_ram);
 		shm_id = fd;
 		p = mmap((char *)0x50000000, total_ram,
 			 PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
 		if (p == MAP_FAILED) {
-			perror("mmap");
+			tst_res(TINFO, "mmap error");
 			goto free_buffers;
 		}
 	}
 	if (!p) {
-		fprintf(stderr, "unable to allocate buffers\n");
+		tst_res(TINFO, "unable to allocate buffers");
 		goto free_buffers;
 	}
 	unaligned_buffer = p;
@@ -1080,7 +1081,7 @@ free_buffers:
  * runs through all the thread_info structs and calculates a combined
  * throughput
  */
-void global_thread_throughput(struct thread_info *t, char *this_stage)
+static void global_thread_throughput(struct thread_info *t, char *this_stage)
 {
 	int i;
 	double runtime = time_since_now(&global_stage_start_time);
@@ -1093,12 +1094,10 @@ void global_thread_throughput(struct thread_info *t, char *this_stage)
 			min_trans = t->stage_mb_trans;
 	}
 	if (total_mb) {
-		fprintf(stderr, "%s throughput (%.2f MB/s) ", this_stage,
-			total_mb / runtime);
-		fprintf(stderr, "%.2f MB in %.2fs", total_mb, runtime);
+		tst_res(TINFO, "%s throughput (%.2f MB/s)", this_stage, total_mb / runtime);
+		tst_res(TINFO, "%.2f MB in %.2fs", total_mb, runtime);
 		if (stonewall)
-			fprintf(stderr, " min transfer %.2fMB", min_trans);
-		fprintf(stderr, "\n");
+			tst_res(TINFO, "min transfer %.2fMB", min_trans);
 	}
 }
 
@@ -1111,7 +1110,7 @@ void global_thread_throughput(struct thread_info *t, char *this_stage)
  * various timings are printed in between the stages, along with
  * thread synchronization if there are more than one threads.
  */
-int worker(struct thread_info *t)
+static int worker(struct thread_info *t)
 {
 	struct io_oper *oper;
 	char *this_stage = NULL;
@@ -1176,7 +1175,7 @@ restart:
 	oper = t->finished_opers;
 	while (oper) {
 		if (fsync_stages)
-			fsync(oper->fd);
+			SAFE_FSYNC(oper->fd);
 		t->stage_mb_trans += oper_mb_trans(oper);
 		if (restart_oper(oper)) {
 			oper_list_del(oper, &t->finished_opers);
@@ -1191,8 +1190,8 @@ restart:
 
 	if (t->stage_mb_trans && t->num_files > 0) {
 		double seconds = time_since_now(&stage_time);
-		fprintf(stderr,
-			"thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
+
+		tst_res(TINFO, "thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs",
 			t - global_thread_info, this_stage,
 			t->stage_mb_trans / seconds, t->stage_mb_trans,
 			seconds);
@@ -1224,210 +1223,166 @@ restart:
 		status = finish_oper(t, oper);
 	}
 
-	if (t->num_global_pending) {
-		fprintf(stderr, "global num pending is %d\n",
-			t->num_global_pending);
-	}
+	if (t->num_global_pending)
+		tst_res(TINFO, "global num pending is %d", t->num_global_pending);
+
 	io_queue_release(t->io_ctx);
 
 	return status;
 }
 
 typedef void *(*start_routine) (void *);
-int run_workers(struct thread_info *t, int num_threads)
+static int run_workers(struct thread_info *t, int num_threads)
 {
+	void *retval;
 	int ret;
 	int i;
 
 	for (i = 0; i < num_threads; i++) {
-		ret =
-		    pthread_create(&t[i].tid, NULL, (start_routine) worker,
-				   t + i);
-		if (ret) {
-			perror("pthread_create");
-			exit(1);
-		}
+		ret = pthread_create(&t[i].tid, NULL, (start_routine) worker, t + i);
+		if (ret)
+			tst_brk(TBROK, "pthread_create: %s", tst_strerrno(ret));
 	}
+
 	for (i = 0; i < num_threads; i++) {
-		ret = pthread_join(t[i].tid, NULL);
-		if (ret) {
-			perror("pthread_join");
-			exit(1);
-		}
+		ret = pthread_join(t[i].tid, &retval);
+		if (ret)
+			tst_brk(TBROK, "pthread_join: %s", tst_strerrno(ret));
+
+		ret = ((int *) retval);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
-off_t parse_size(char *size_arg, off_t mult)
+static void setup(void)
 {
-	char c;
-	int num;
-	off_t ret;
-	c = size_arg[strlen(size_arg) - 1];
-	if (c > '9') {
-		size_arg[strlen(size_arg) - 1] = '\0';
-	}
-	num = atoi(size_arg);
-	switch (c) {
-	case 'g':
-	case 'G':
-		mult = 1024 * 1024 * 1024;
-		break;
-	case 'm':
-	case 'M':
-		mult = 1024 * 1024;
-		break;
-	case 'k':
-	case 'K':
-		mult = 1024;
-		break;
-	case 'b':
-	case 'B':
-		mult = 1;
-		break;
+	struct stat sb;
+	int maxaio;
+	int stages_i;
+
+	num_files = 1;
+	max_io_submit = 0;
+	num_contexts = 1;
+	context_offset = 2 * 1024 * 1024 * 1024;
+	file_size = 1024 * 1024 * 1024;
+	rec_len = 64 * 1024;
+	depth = 64;
+	io_iter = 8;
+	iterations = RUN_FOREVER;
+	o_direct = 0;
+	o_sync = 0;
+	stages = 0;
+	use_shm = 0;
+	fsync_stages = 1;
+	latency_stats = 0;
+	completion_latency_stats = 0;
+	num_threads = 1;
+	unlink_files = 0;
+	verify = 0;
+	stonewall = 1;
+	padded_reclen = 0;
+	threads_ending = 0;
+	threads_starting = 0;
+
+	SAFE_STAT(".", &sb);
+	page_size_mask = sb.st_blksize;
+
+	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
+	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
+
+	if (tst_parse_int(str_num_files, &num_files, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of files to generate '%s'", str_num_files);
+
+	if (tst_parse_int(str_max_io_submit, &max_io_submit, 0, INT_MAX))
+		tst_brk(TBROK, "Invalid number of iocbs '%s'", str_max_io_submit);
+
+	if (max_io_submit > maxaio)
+		tst_res(TCONF, "Number of async IO blocks passed the maximum (%d)", maxaio);
+
+	if (tst_parse_int(str_num_contexts, &num_contexts, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of contexts per file '%s'", str_num_contexts);
+
+	if (tst_parse_filesize(str_context_offset, &context_offset, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid offset between contexts '%s'", str_context_offset);
+
+	if (tst_parse_filesize(str_file_size, &file_size, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid file size '%s'", str_file_size);
+
+	if (tst_parse_long(str_rec_len, &rec_len, 1, LONG_MAX))
+		tst_brk(TBROK, "Invalid record size '%s'", str_rec_len);
+
+	if (tst_parse_int(str_depth, &depth, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of pending aio requests '%s'", str_depth);
+
+	if (tst_parse_int(str_io_iter, &io_iter, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of I/O per file '%s'", str_io_iter);
+
+	if (tst_parse_int(str_iterations, &iterations, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of total ayncs I/O '%s'", str_iterations);
+
+	if (iterations == INT_MAX)
+		iterations = RUN_FOREVER;
+
+	if (tst_parse_int(str_stages, &stages_i, 0, INT_MAX))
+		tst_brk(TBROK, "Invalid stage number '%s'", str_stages);
+
+	if (stages_i) {
+		stages |= 1 << stages_i;
+		tst_res(TINFO, "Adding stage %s", stage_name(stages_i));
+	}
+
+	if (tst_parse_int(str_num_threads, &num_threads, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of threads '%s'", str_num_threads);
+
+	if (str_o_direct)
+		o_direct = O_DIRECT;
+
+	if (str_o_sync)
+		o_sync = O_SYNC;
+
+	if (str_use_shm) {
+		if (!strcmp(str_use_shm, "shm")) {
+			tst_res(TINFO, "using ipc shm");
+			use_shm = USE_SHM;
+		} else if (!strcmp(str_use_shm, "shmfs")) {
+			tst_res(TINFO, "using /dev/shm for buffers");
+			use_shm = USE_SHMFS;
+		}
 	}
-	ret = mult * num;
-	return ret;
-}
 
-void print_usage(void)
-{
-	printf
-	    ("usage: aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]\n");
-	printf
-	    ("                  [-i num] [-t num] [-c num] [-C size] [-nxhOS ]\n");
-	printf("                  file1 [file2 ...]\n");
-	printf("\t-a size in KB at which to align buffers\n");
-	printf("\t-b max number of iocbs to give io_submit at once\n");
-	printf("\t-c number of io contexts per file\n");
-	printf("\t-C offset between contexts, default 2MB\n");
-	printf("\t-s size in MB of the test file(s), default 1024MB\n");
-	printf("\t-r record size in KB used for each io, default 64KB\n");
-	printf
-	    ("\t-d number of pending aio requests for each file, default 64\n");
-	printf("\t-i number of I/O per file sent before switching\n"
-	       "\t   to the next file, default 8\n");
-	printf("\t-I total number of ayncs I/O the program will run, "
-	       "default is run until Cntl-C\n");
-	printf("\t-O Use O_DIRECT (not available in 2.4 kernels),\n");
-	printf("\t-S Use O_SYNC for writes\n");
-	printf("\t-o add an operation to the list: write=0, read=1,\n");
-	printf("\t   random write=2, random read=3.\n");
-	printf("\t   repeat -o to specify multiple ops: -o 0 -o 1 etc.\n");
-	printf
-	    ("\t-m shm use ipc shared memory for io buffers instead of malloc\n");
-	printf("\t-m shmfs mmap a file in /dev/shm for io buffers\n");
-	printf("\t-n no fsyncs between write stage and read stage\n");
-	printf("\t-l print io_submit latencies after each stage\n");
-	printf("\t-L print io completion latencies after each stage\n");
-	printf("\t-t number of threads to run\n");
-	printf("\t-u unlink files after completion\n");
-	printf("\t-v verification of bytes written\n");
-	printf("\t-x turn off thread stonewalling\n");
-	printf("\t-h this message\n");
-	printf
-	    ("\n\t   the size options (-a -s and -r) allow modifiers -s 400{k,m,g}\n");
-	printf("\t   translate to 400KB, 400MB and 400GB\n");
-	printf("version %s\n", PROG_VERSION);
+	if (str_fsync_stages)
+		fsync_stages = 0;
+
+	if (str_latency_stats)
+		latency_stats = 1;
+
+	if (str_completion_latency_stats)
+		completion_latency_stats = 1;
+
+	if (str_unlink_files)
+		unlink_files = 1;
+
+	if (str_verify)
+		verify = 1;
+
+	if (str_stonewall)
+		stonewall = 0;
 }
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int rwfd;
-	int i;
-	int j;
-	int c;
-
-	off_t file_size = 1 * 1024 * 1024 * 1024;
+	char files[num_files][265];
 	int first_stage = WRITE;
 	struct io_oper *oper;
 	int status = 0;
-	int num_files = 0;
 	int open_fds = 0;
 	struct thread_info *t;
-
-	page_size_mask = getpagesize() - 1;
-
-	while (1) {
-		c = getopt(ac, av, "a:b:c:C:m:s:r:d:i:I:o:t:lLnhOSxvu");
-		if (c < 0)
-			break;
-
-		switch (c) {
-		case 'a':
-			page_size_mask = parse_size(optarg, 1024);
-			page_size_mask--;
-			break;
-		case 'c':
-			num_contexts = atoi(optarg);
-			break;
-		case 'C':
-			context_offset = parse_size(optarg, 1024 * 1024);
-		case 'b':
-			max_io_submit = atoi(optarg);
-			break;
-		case 's':
-			file_size = parse_size(optarg, 1024 * 1024);
-			break;
-		case 'd':
-			depth = atoi(optarg);
-			break;
-		case 'r':
-			rec_len = parse_size(optarg, 1024);
-			break;
-		case 'i':
-			io_iter = atoi(optarg);
-			break;
-		case 'I':
-			iterations = atoi(optarg);
-			break;
-		case 'n':
-			fsync_stages = 0;
-			break;
-		case 'l':
-			latency_stats = 1;
-			break;
-		case 'L':
-			completion_latency_stats = 1;
-			break;
-		case 'm':
-			if (!strcmp(optarg, "shm")) {
-				fprintf(stderr, "using ipc shm\n");
-				use_shm = USE_SHM;
-			} else if (!strcmp(optarg, "shmfs")) {
-				fprintf(stderr, "using /dev/shm for buffers\n");
-				use_shm = USE_SHMFS;
-			}
-			break;
-		case 'o':
-			i = atoi(optarg);
-			stages |= 1 << i;
-			fprintf(stderr, "adding stage %s\n", stage_name(i));
-			break;
-		case 'O':
-			o_direct = O_DIRECT;
-			break;
-		case 'S':
-			o_sync = O_SYNC;
-			break;
-		case 't':
-			num_threads = atoi(optarg);
-			break;
-		case 'x':
-			stonewall = 0;
-			break;
-		case 'u':
-			unlink_files = 1;
-			break;
-		case 'v':
-			verify = 1;
-			break;
-		case 'h':
-		default:
-			print_usage();
-			exit(1);
-		}
-	}
+	int rwfd;
+	int i;
+	int j;
 
 	/*
 	 * make sure we don't try to submit more I/O than we have allocated
@@ -1435,28 +1390,15 @@ int main(int ac, char **av)
 	 */
 	if (depth < io_iter) {
 		io_iter = depth;
-		fprintf(stderr, "dropping io_iter to %d\n", io_iter);
-	}
-
-	if (optind >= ac) {
-		print_usage();
-		exit(1);
+		tst_res(TINFO, "dropping io_iter to %d", io_iter);
 	}
 
-	num_files = ac - optind;
-
 	if (num_threads > (num_files * num_contexts)) {
 		num_threads = num_files * num_contexts;
-		fprintf(stderr,
-			"dropping thread count to the number of contexts %d\n",
-			num_threads);
+		tst_res(TINFO, "Dropping thread count to the number of contexts %d", num_threads);
 	}
 
-	t = malloc(num_threads * sizeof(*t));
-	if (!t) {
-		perror("malloc");
-		exit(1);
-	}
+	t = SAFE_MALLOC(num_threads * sizeof(*t));
 	memset(t, 0, num_threads * sizeof(*t));
 	global_thread_info = t;
 
@@ -1471,100 +1413,111 @@ int main(int ac, char **av)
 	 */
 	if (max_io_submit < io_iter) {
 		io_iter = max_io_submit;
-		fprintf(stderr, "dropping io_iter to %d\n", io_iter);
+		tst_res(TINFO, "dropping io_iter to %d", io_iter);
 	}
 
 	if (!stages) {
-		stages =
-		    (1 << WRITE) | (1 << READ) | (1 << RREAD) | (1 << RWRITE);
+		stages = (1 << WRITE) | (1 << READ) | (1 << RREAD) | (1 << RWRITE);
 	} else {
 		for (i = 0; i < LAST_STAGE; i++) {
 			if (stages & (1 << i)) {
 				first_stage = i;
-				fprintf(stderr, "starting with %s\n",
-					stage_name(i));
+				tst_res(TINFO, "starting with %s", stage_name(i));
 				break;
 			}
 		}
 	}
 
-	if (file_size < num_contexts * context_offset) {
-		fprintf(stderr, "file size %ld too small for %d contexts\n",
+	if (file_size < num_contexts * context_offset)
+		tst_brk(TBROK, "file size %ld too small for %d contexts",
 			(long)file_size, num_contexts);
-		exit(1);
-	}
 
-	fprintf(stderr, "file size %ldMB, record size %ldKB, depth %d, "
-		"I/O per iteration %d\n",
+	tst_res(TINFO, "file size %ldMB, record size %ldKB, depth %d, "
+		"I/O per iteration %d",
 		(long)(file_size / (1024 * 1024)),
 		rec_len / 1024, depth, io_iter);
-	fprintf(stderr, "max io_submit %d, buffer alignment set to %luKB\n",
+	tst_res(TINFO, "max io_submit %d, buffer alignment set to %luKB",
 		max_io_submit, (page_size_mask + 1) / 1024);
-	fprintf(stderr, "threads %d files %d contexts %d context offset %ldMB "
-		"verification %s\n", num_threads, num_files, num_contexts,
+	tst_res(TINFO, "threads %d files %d contexts %d context offset %ldMB "
+		"verification %s", num_threads, num_files, num_contexts,
 		(long)(context_offset / (1024 * 1024)), verify ? "on" : "off");
+
 	/* open all the files and do any required setup for them */
-	for (i = optind; i < ac; i++) {
+	for (i = 0; i < num_files; i++) {
 		int thread_index;
+
+		snprintf(files[i], sizeof(files[i]), "file%d.bin", i);
+
 		for (j = 0; j < num_contexts; j++) {
 			thread_index = open_fds % num_threads;
 			open_fds++;
 
-			rwfd =
-			    open(av[i], O_CREAT | O_RDWR | o_direct | o_sync,
-				 0600);
-			if (rwfd == -1) {
-				fprintf(stderr,
-					"error while creating file %s: %s",
-					av[i], strerror(errno));
-				exit(1);
-			}
+			rwfd = SAFE_OPEN(files[i], O_CREAT | O_RDWR | o_direct | o_sync, 0600);
+
+			oper = create_oper(rwfd, first_stage, j * context_offset,
+				file_size - j * context_offset, rec_len,
+				depth, io_iter, files[i]);
+			if (!oper)
+				tst_brk(TBROK, "error in create_oper");
 
-			oper =
-			    create_oper(rwfd, first_stage, j * context_offset,
-					file_size - j * context_offset, rec_len,
-					depth, io_iter, av[i]);
-			if (!oper) {
-				fprintf(stderr, "error in create_oper\n");
-				exit(-1);
-			}
 			oper_list_add(oper, &t[thread_index].active_opers);
 			t[thread_index].num_files++;
 		}
 	}
-	if (setup_shared_mem(num_threads, num_files * num_contexts,
-			     depth, rec_len, max_io_submit)) {
-		exit(1);
-	}
+
+	if (setup_shared_mem(num_threads, num_files * num_contexts, depth, rec_len, max_io_submit))
+		tst_brk(TBROK, "error in setup_shared_mem");
+
 	for (i = 0; i < num_threads; i++) {
-		if (setup_ious
-		    (&t[i], t[i].num_files, depth, rec_len, max_io_submit))
-			exit(1);
+		if (setup_ious(&t[i], t[i].num_files, depth, rec_len, max_io_submit))
+			tst_brk(TBROK, "error in setup_ious");
 	}
+
 	if (num_threads > 1) {
-		printf("Running multi thread version num_threads:%d\n",
-		       num_threads);
-		run_workers(t, num_threads);
+		tst_res(TINFO, "Running multi thread version num_threads: %d", num_threads);
+		status = run_workers(t, num_threads);
 	} else {
-		printf("Running single thread version \n");
+		tst_res(TINFO, "Running single thread version");
 		status = worker(t);
 	}
-	if (unlink_files) {
-		for (i = optind; i < ac; i++) {
-			printf("Cleaning up file %s \n", av[i]);
-			unlink(av[i]);
-		}
-	}
 
-	if (status) {
-		exit(1);
-	}
-	return status;
+	for (i = 0; i < num_files; i++)
+		SAFE_UNLINK(files[i]);
+
+	if (status)
+		tst_res(TFAIL, "Test did not pass");
+	else
+		tst_res(TPASS, "Test passed");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"f:", &str_num_files, "Number of files to generate"},
+		{"b:", &str_max_io_submit, "Max number of iocbs to give io_submit at once"},
+		{"c:", &str_num_contexts, "Number of io contexts per file"},
+		{"g:", &str_context_offset, "Offset between contexts (default 2M)"},
+		{"s:", &str_file_size, "Size in MB of the test file(s) (default 1024M)"},
+		{"r:", &str_rec_len, "Record size in KB used for each io (default 64K)"},
+		{"d:", &str_depth, "Number of pending aio requests for each file (default 64)"},
+		{"e:", &str_io_iter, "Number of I/O per file sent before switching to the next file (default 8)"},
+		{"a:", &str_iterations, "Total number of ayncs I/O the program will run, default is run until Cntl-C"},
+		{"O", &str_o_direct, "Use O_DIRECT (not available in 2.4 kernels)"},
+		{"S", &str_o_sync, "Use O_SYNC for writes"},
+		{"o:", &str_stages, "Add an operation to the list: write=0, read=1, random write=2, random read=3"},
+		{"m", &str_use_shm, "SHM use ipc shared memory for io buffers instead of malloc"},
+		{"n", &str_fsync_stages, "No fsyncs between write stage and read stage"},
+		{"l", &str_latency_stats, "Print io_submit latencies after each stage"},
+		{"L", &str_completion_latency_stats, "Print io completion latencies after each stage"},
+		{"t:", &str_num_threads, "Number of threads to run"},
+		{"u", &str_unlink_files, "Unlink files after completion"},
+		{"v", &str_verify, "Verification of bytes written"},
+		{"x", &str_stonewall, "Turn off thread stonewalling"},
+		{}
+	}
+};
 #else
-int main(void)
-{
-	fprintf(stderr, "test requires libaio and it's development packages\n");
-	return TCONF;
-}
+TST_TEST_TCONF("test requires libaio and its development packages");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
