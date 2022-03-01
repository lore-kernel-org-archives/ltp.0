Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FC3C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 14:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06BA03CA30F
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 15:23:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09743CA08D
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 15:23:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E231600856
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 15:23:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01A351F3A3;
 Tue,  1 Mar 2022 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646144605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oAdk7++EDEb9fp3GHVZRoY46LWe81+ZzHQYIx/59Bo=;
 b=p5ybiRUK/ObKLU19WEA6u62cyviOJbOGypZIuC1ZmXDCz99ys9fZqLrFykLY19Lk3F+81m
 btgx/pHn2zIkrpXKYGv/1NMbrgiv/9WCmUulhKFWiQwki2H/lkScXMo29RgdClPr0t8HeU
 SPSMyejX+r2QqBeEsgrsrebNbhWw7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646144605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oAdk7++EDEb9fp3GHVZRoY46LWe81+ZzHQYIx/59Bo=;
 b=oFSBeuvI4YdSuyJtjAtkVxRXZ/KzFY/631M8fS2dxe4dJTLW9AprK3+2lcfESYmNnoDBxp
 qx5hJFeaBPeLQtAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D006513B67;
 Tue,  1 Mar 2022 14:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MHgSMVwsHmJ8aAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Mar 2022 14:23:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Mar 2022 15:23:22 +0100
Message-Id: <20220301142322.31885-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301142322.31885-1-andrea.cervesato@suse.de>
References: <20220301142322.31885-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] Update ltp-aio-stress suites using new options
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Adapted runtest files according with the new aio-stress test
modifications.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/ltp-aio-stress.part1 | 146 +++++++++++++++++------------------
 runtest/ltp-aio-stress.part2 |  64 +++++++--------
 2 files changed, 99 insertions(+), 111 deletions(-)

diff --git a/runtest/ltp-aio-stress.part1 b/runtest/ltp-aio-stress.part1
index a770a40ae..30ee0b923 100644
--- a/runtest/ltp-aio-stress.part1
+++ b/runtest/ltp-aio-stress.part1
@@ -1,79 +1,73 @@
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
+ADS1000 aio-stress -a500  -o2 -r4 -f1
+ADS1001 aio-stress -a500  -o2 -r8 -f1
+ADS1002 aio-stress -a500  -o2 -r16 -f1
+ADS1003 aio-stress -a500  -o2 -r32 -t2 -f2
+ADS1004 aio-stress -a500  -o2 -r64 -f2
+ADS1005 aio-stress -a500  -o3 -r4 -f2
+ADS1006 aio-stress -a500  -o3 -r8 -f2
+ADS1007 aio-stress -a500  -o3 -r16 -f2
+ADS1008 aio-stress -a500  -o3 -r32 -f4
+ADS1009 aio-stress -a500  -o3 -r64 -t4 -f4
+ADS1010 aio-stress -a500  -o3 -r128 -t4 -f4
+ADS1011 aio-stress -a500  -o3 -r256 -t8 -f8
+ADS1012 aio-stress -a500  -o3 -r512 -t8 -f8
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
+ADS1026 aio-stress -a500  -o0 -r4 -t8 -f8
+ADS1027 aio-stress -a500  -o0 -r8 -f1
+ADS1028 aio-stress -a500  -o0 -r16 -f1
+ADS1029 aio-stress -a500  -o0 -r32 -t2 -f2
+ADS1030 aio-stress -a500  -o0 -r64 -t2 -f2
+ADS1031 aio-stress -a500  -o1 -r4 -t2 -f1
+ADS1032 aio-stress -a500  -o1 -r8 -t2 -f1
+ADS1033 aio-stress -a500  -o1 -r16 -t2 -f2
+ADS1034 aio-stress -a500  -o1 -r32 -t4 -f4
+ADS1035 aio-stress -a500  -o1 -r64 -t4 -f4
+ADS1036 aio-stress -a500  -o1 -r128 -t4 -f4
+ADS1037 aio-stress -a500  -o1 -r256 -t8 -f8
+ADS1038 aio-stress -a500  -o1 -r512 -t8 -f8
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
index 3a60e23e9..0cf905d7d 100644
--- a/runtest/ltp-aio-stress.part2
+++ b/runtest/ltp-aio-stress.part2
@@ -1,38 +1,32 @@
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
+ADS2001 aio-stress -a500  -o2 -r32  -t2 -f2
+ADS2002 aio-stress -a500  -o3 -r8   -t2 -f2
+ADS2003 aio-stress -a500  -o3 -r16  -t2 -f2
+ADS2004 aio-stress -a500  -o3 -r32  -t4 -f4
+ADS2005 aio-stress -a500  -o3 -r64  -t4 -f4
+ADS2006 aio-stress -a500  -o2 -O -r32  -t2 -f2
+ADS2007 aio-stress -a500  -o3 -O -r8   -t2 -f2
+ADS2008 aio-stress -a500  -o3 -O -r16  -t2 -f2
+ADS2009 aio-stress -a500  -o3 -O -r32  -t4 -f4
+ADS2010 aio-stress -a500  -o3 -O -r64  -t4 -f4
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
