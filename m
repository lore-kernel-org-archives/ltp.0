Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE30CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755834188; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Glz9QhDkqwq/jS6NCDD6A6kiLl6KcB7vAVsOexjjdpg=;
 b=LbiqorvpUMm189ShM1SKIDKN3J0opfTf/qtn817NMErhj5WRQA3BL5AuWKK/F8D32X0pC
 vyOt3TaKVU4qs8rRsaNmZNgeFKKQJ9FYlUE5ssO3PVUmR5vmsQWeyXcSfq9bYjwrnm/9qmN
 M3cJYrvU/Rpj7dDxOx4OxkRx/hcuIuQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D34DD3CCC74
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:43:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7223CCBB7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:28 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 859101000138
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:27 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afcb73621fcso226090666b.0
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755834147; x=1756438947; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKtsabEGTukf8WLbzWDvZ8ITb6jbhAUF9vQoSgo1ATs=;
 b=I6PBMTrqUZSWBiNcYzw32M7IBqQbLfUQDZZXegPk6KY+gUUShzUBJPVpGFvcw7cb5H
 OnvVPvT4oODd5A64naw4+E3tV3lhZIGc+FcZzRrJ4aRCmJY2MqbjcJN58fqBEOXAJjUs
 d++QXdbuAiTHigqE+j/kfqS4Ac0MEJoU14bGC43HOU2znIw/7lxQN+RNOFD1zBB3APSl
 8kb+tf3fHqAMb/3fh0ubFxVz09szVEJDzrqefu/apCwdgjXx0yFlz3U7DwLI3wDaJH7A
 9yZI9QPfni/ABl3ZA7v88pKBB/XL6C8rgbMEpIrRlNzHJNj50P2P3h95SCsYpm24e221
 DVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755834147; x=1756438947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKtsabEGTukf8WLbzWDvZ8ITb6jbhAUF9vQoSgo1ATs=;
 b=upLEutPw6HHnytKBOtrZla1Li6fdNQKmeETDy5JxqkNlZRwNHuOaiAVSbjtrW57WBS
 OGIRWrVE/Nm4DP1XRNXLDis0iFMGYzAF5RiOKbnPyL599MHBLdSDbHszwyM0fN/a1jwN
 yTiwsUv567BlZ3mVo+SGGowR0JrViHpmBHdWKRjghj//MHKyw0cipuCnHulDm58pyxzE
 80H+/DQiIDZP2jXeYesYOWjYP3GKOEYJK71rlcwP+3ooCcX3DAdGwY1mzVvdQPqVpN3y
 Wvoab/QMXHGxNeEUfsvngqRT0Oe3cVmD5Cryk6XD1eUyb3bW5ylqJemMJlS0FVnJwUWA
 EhkQ==
X-Gm-Message-State: AOJu0YwSK2kj9SslLpjzfyKbgQjdeRUJFxu7zdsgm+VIxYAjXoV1x5oi
 AE9wod2xlj6Bmm+iXAJtMCOCShkrHKo3C598giKo4el6crx8wrj0+jfArgNUryhlzHA39EVYLrk
 Ni9s=
X-Gm-Gg: ASbGncuwelz+hiq2OnGzQ0ton8GDlj6RMW12AWMLTC/ecJMvgpc3WMEss0agqWuaK8p
 Uq7S9lkiYUNNxWUhOqCgUJlJUGQEZEx/XhyihAQqECJhejuWQ3QEF1T0knG8MQOfxc6sJrFmBWs
 h706plOXrB/jKwEYmg6+HEkvEwYVcnaUzaywVifbWcw6Z8Wcn85nbkilVI/BDUhj76VpZotdiwH
 RuDbJWHXDDsr5eDYT1aRcoVIgJj4e509P+r748Q4IOqIRKerEoZT4Vpk1t8WafImHhvti0yWOjH
 3nwkY++F178P+04dXNe+kusajiZzHZMiO7KnxDY1bUV0vPtZBaBGzy9jBCDuCyalV0UM88FP+ke
 tqiFFfOIbLK+X8jFkbiJQILxXXeqcXOMLDBeTjhs794Q=
X-Google-Smtp-Source: AGHT+IGA0kTwZ8PbCTZXmCgGS1uIWdKUXgV/RF5KyXoV0MKoH6Dmr3J+cHUFzqBNTCL35JpuQbzQ3w==
X-Received: by 2002:a17:906:d54e:b0:af9:36b3:d695 with SMTP id
 a640c23a62f3a-afe29637bfbmr124274766b.43.1755834146588; 
 Thu, 21 Aug 2025 20:42:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded539c13sm510209866b.116.2025.08.21.20.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 20:42:26 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 03:41:40 +0000
Message-ID: <20250822034215.28533-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822034215.28533-1-wegao@suse.com>
References: <20250820002556.26865-1-wegao@suse.com>
 <20250822034215.28533-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] fspick01.c: Check mount point was really
 remounted read only
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: #1171
The fspick01 test does not test if FSCONFIG_CMD_RECONFIGURE really
reconfigures the mount point, e.g. if the mount point was really
remounted read only.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/fspick/fspick01.c |  23 ++-
 ver_linux                                   | 191 --------------------
 2 files changed, 22 insertions(+), 192 deletions(-)
 delete mode 100755 ver_linux

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d03cacd3d..8cb2d3669 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,6 +6,7 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
 
 #define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
@@ -24,6 +25,12 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	int fspick_fd;
+	char abspath[PATH_MAX];
+	char *tmpdir = tst_tmpdir_path();
+
+	snprintf(abspath, sizeof(abspath), "%s/%s", tmpdir, MNTPOINT);
+
+	TST_EXP_VAL(tst_is_mounted_rw(abspath), 1);
 
 	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
 	if (fspick_fd == -1) {
@@ -49,8 +56,22 @@ static void run(unsigned int n)
 		goto out;
 	}
 
-	tst_res(TPASS, "%s: fspick() passed", tc->name);
+	TST_EXP_VAL(tst_is_mounted_ro(abspath), 1);
+
+	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
+		goto out;
+	}
 
+	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
+		goto out;
+	}
+
+	TST_EXP_VAL(tst_is_mounted_rw(abspath), 1);
+	tst_res(TPASS, "%s: fspick() passed", tc->name);
 out:
 	SAFE_CLOSE(fspick_fd);
 }
diff --git a/ver_linux b/ver_linux
deleted file mode 100755
index 4333575d3..000000000
--- a/ver_linux
+++ /dev/null
@@ -1,191 +0,0 @@
-#!/bin/sh
-# Before running this script please ensure that your PATH is
-# typical as you use for compilation/istallation. I use
-# /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
-# differ on your system.
-
-PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
-
-tst_cmd_available()
-{
-	if type command > /dev/null 2>&1; then
-		command -v $1 > /dev/null 2>&1 || return 1
-	else
-		which $1 > /dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			return 0
-		else
-			return 1
-		fi
-	fi
-}
-
-tst_cmd_run()
-{
-	local cmd="$1"
-	shift
-	tst_cmd_available $cmd && eval "$cmd $@"
-}
-
-is_enabled()
-{
-	[ -f "$1" ] && [ "$(cat $1)" = "Y" -o "$(cat $1)" = "1" ]
-}
-
-echo 'If some fields are empty or look unusual you may have an old version.'
-echo 'Compare to the current minimal requirements in Documentation/Changes.'
-
-echo
-echo "`ls /etc/*release 2> /dev/null`"
-cat /etc/*release 2> /dev/null
-if [ $? = 1 ]; then
-   echo "`ls /usr/lib/*release 2> /dev/null`"
-   cat /usr/lib/*release 2> /dev/null
-fi
-if [ $? = 1 ]; then
-   echo '/etc/issue:'
-   cat /etc/issue 2> /dev/null
-fi
-if [ $? = 1 ]; then
-	echo 'lsb_release -a'
-	lsb_release -a 2> /dev/null
-fi
-
-echo
-echo 'uname:'
-uname -a
-
-echo
-echo '/proc/cmdline'
-cat /proc/cmdline
-
-echo
-
-echo "Gnu C                 " `gcc --version 2>/dev/null | head -n 1`
-echo "Clang                 " `clang --version 2>/dev/null | head -n 1`
-
-make --version 2>&1 | awk -F, '{print $1}' | awk \
-      '/GNU Make/{print "Gnu make              ",$NF}'
-
-ld -v 2>&1 | awk -F\) '{print $1}' | awk \
-      '/BFD/{print "binutils              ",$NF}'
-
-mkswap -V 2>&1 | awk '{print "util-linux            ", $NF}'
-
-mount --version 2>&1 | awk '{$1=$2=""; print "mount               ", $0}'
-
-insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'
-
-bcachefs version 2>&1 | grep "^[0-9]"  | awk \
-'NR==1 {print "bcachefs              ", $1}'
-
-mkfs.btrfs -V 2>&1 | grep "^mkfs.btrfs" | sed 's/,//' | awk \
-'NR==1 {print "btrfs                 ", $5}'
-
-tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' | awk \
-'NR==1 {print "e2fsprogs             ", $2}'
-
-mkfs.exfat -V 2>&1 | grep "^exfatprogs" | sed 's/,//' | awk \
-'NR==1 {print "exfat                 ", $4}'
-
-mkfs.ntfs -V 2>&1 | grep "^mkntfs" | sed 's/,//' | awk \
-'NR==1 {$1="";print "ntfs                 ", $0}'
-
-mkfs.vfat 2>&1 | grep "^mkfs\." | sed 's/,//' | awk \
-'NR==1 {print "vfat                  ", $2}'
-
-mkfs.xfs -V 2>&1 | grep "^mkfs.xfs" | sed 's/,//' | awk \
-'NR==1 {print "xfs                   ", $3}'
-
-cardmgr -V 2>&1| grep version | awk \
-'NR==1{print "pcmcia-cs             ", $3}'
-
-isdnctrl 2>&1 | grep version | awk \
-'NR==1{print "isdn4k-utils          ", $NF}'
-
-printf "Linux C Library        $($(ldd /bin/sh | \
-awk '/libc/{print $3}') 2>&1 | \
-grep -i -e libc.*version -e musl.*libc -e ^version)\n"
-
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n 1 | awk \
-'NR==1{print "Dynamic linker (ldd)  ", $NF}'
-
-ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
-       '{print "Linux C++ Library      " $4"."$5"."$6}'
-
-ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
-
-ifconfig --version 2>&1 | grep tools | awk \
-'NR==1{print "Net-tools             ", $NF}'
-
-ip -V 2>&1 | awk \
-'NR==1{print "iproute2              ", $NF}'
-
-ping -V 2>&1 | awk \
-'NR==1{print "iputils               ", $NF}'
-
-ethtool --version | grep version 2>&1 | awk \
-'NR==1{print "ethtool               ", $NF}'
-
-# Kbd needs 'loadkeys -h',
-loadkeys -h 2>&1 | awk \
-'(NR==1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'
-
-# while console-tools needs 'loadkeys -V'.
-loadkeys -V 2>&1 | awk \
-'(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
-
-expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
-
-echo
-if [ -e /proc/modules ]; then
-    X=`cat /proc/modules | sed -e "s/ .*$//"`
-    echo "Modules Loaded         "$X
-fi
-
-echo
-echo 'cpuinfo:'
-tst_cmd_run lscpu || cat /proc/cpuinfo
-
-echo
-echo 'free reports:'
-free
-
-echo
-echo 'memory (/proc/meminfo):'
-cat /proc/meminfo
-
-echo
-echo 'available filesystems:'
-echo $(cut -f2 /proc/filesystems | sort -u)
-
-echo
-echo 'mounted filesystems (/proc/mounts):'
-cat /proc/mounts
-
-echo
-echo 'mounted filesystems (df):'
-if `df -hT >/dev/null 2>/dev/null`; then
-	df -hT
-else
-	df
-fi
-
-echo
-echo 'tainted (/proc/sys/kernel/tainted):'
-cat /proc/sys/kernel/tainted
-
-echo
-if is_enabled /sys/module/apparmor/parameters/enabled; then
-	echo 'AppArmor enabled'
-	tst_cmd_run aa-status
-else
-	echo 'AppArmor disabled'
-fi
-
-echo
-
-if ! tst_cmd_run sestatus; then
-	printf 'SELinux mode: '
-	tst_cmd_run getenforce || echo 'unknown'
-fi
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
