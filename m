Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1812CCCD192
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726653857; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=WMmXzmzSzR24ex7eoKcCFGpBU/KZ0k1nirF/HgCN7IQ=;
 b=mK15trNEqJ0+hYXlCIL/2uIoclxz33BOCLkdkKb2GHPzzwpnBWdPsyvkOPxDUjqnrzPeR
 L9X01k6V5LCO/0csBHD2U7BxtLFinPSZB3PbH0b+a1NFWm0/P79t0NadmrPbt2ObmpTgm5k
 OliVhJix+yPhZY3Pte8IQnGfJuiDBhs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F3453C2EA3
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 12:04:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41CCA3C0BBD
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 12:03:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F741603EA3
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 12:03:56 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c3400367so4856803f8f.2
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726653835; x=1727258635; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rh9Xdf/yn5izokoT9H+6vSGUL8gD7mYc9bJHSGfu5gM=;
 b=CH/zSqHa/NZfk78nKHW3XFzn4iEV5tjYyp96MFhNQ+cXBIx3xW4up4K4Ad8c4PZimQ
 1JpXJPw3wD+VxAuiYiIKpjMEP+oddcz6I8zxXSao2sTmyAXpIVYDwkEkvyMv1EszQlks
 lKo3NlA/Io7hxuKKnEQn3+5DI25fozCARsQ5m8REgJPtLJc7A015eGJgr6x6BjIxZd30
 XnqV6Vr7napZvM3LkDClboeyd8nSTxG4KWHvf03hnCYd+ug9XBFmjMAR+07AWGvWzPpt
 u9irmpKgalxs4GYW7BCUiKdPP3/C0rvN3vz4i/2TiwXcCY5xodLVbq24ZhEP6I0Ad6YG
 K6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726653835; x=1727258635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rh9Xdf/yn5izokoT9H+6vSGUL8gD7mYc9bJHSGfu5gM=;
 b=RQScGiKQOySwdjs/d29HYgSiZAkVteF3COAZ4HKRJmx9QAlCvLqHzOCzVeXpXHHZB1
 r5wug05eJGNbh/z+5blq9JmjgvktjolfAQsNuQzHLyARSJlZfkGprGJ5O0sOAwW02ezR
 upQ9Eewl9PXrocgLMFNMg2AGr18hxZNXUibB2CYojJ3jwwWkDfppFcBXyY3+Yr5UDIyY
 8CiNxRYdCl3CKoVnuQ/8fwpxIt+DRJ9GAPM8WjPQAqlVCv6oOzFZlfLZVozx1ZHLkd/g
 AiqRs12jS0bElB2u3ZubpONs+t4MQByt4HtcE6AO/pAD2JPPbxQri0TAACZ28hs1aTvZ
 gERA==
X-Gm-Message-State: AOJu0Yw4H0lNo58XIXxp7LM5/jw+hIYQs5I6NtSvmLxoP7S9jFi7gsW6
 eNU5ozT1NhpaJcdayElHmgJUN8tB0FIbNWG0BKciYeRaWzvqD3lVBW0IOK420XizGFKwnAiy194
 =
X-Google-Smtp-Source: AGHT+IH7MPd33Zhe2XEhsfWpHsJTtgrejfGmao7VXfkbVDZYFtvsbgIUFVis7pb3u8p7mpaA5XN05g==
X-Received: by 2002:a5d:58d4:0:b0:374:c7a5:d610 with SMTP id
 ffacd0b85a97d-378d6236b9cmr14933775f8f.43.1726653834754; 
 Wed, 18 Sep 2024 03:03:54 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd52e2eb85sm2741860a91.1.2024.09.18.03.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 03:03:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 18 Sep 2024 06:03:44 -0400
Message-Id: <20240918100344.21316-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_test.sh: Add support for localhost ssh key
 setup
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

When RHOST=localhost, ssh@localhost will encounter error since
no correct setup for authorized_keys and known_hosts etc.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/lib/tst_test.sh               | 32 +++++++++++++++++++++++++
 testcases/network/tcp_cmds/ftp/ftp01.sh | 12 ++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c19c30b76..6df16bd17 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -784,6 +784,34 @@ tst_run()
 	_tst_do_exit
 }
 
+_tst_setup_localhost_ssh()
+{
+	if [ -z "$TST_SSHD_CONFIG" ]; then
+		TST_SSHD_CONFIG="/etc/ssh/sshd_config"
+	fi
+
+	if [ -z "$TST_SSH_DIR" ]; then
+		TST_SSH_DIR="/root/.ssh/"
+	fi
+
+	if [ ! -e "$TST_SSHD_CONFIG" ]; then
+		echo 'PermitRootLogin yes' >$TST_SSHD_CONFIG
+	elif [ ! `grep "^PermitRootLogin *yes" $TST_SSHD_CONFIG | wc -l` -gt 0 ]; then
+		echo 'PermitRootLogin yes' >>$TST_SSHD_CONFIG
+	fi
+
+	if [ ! -e "$TST_SSH_DIR/id_rsa" ]; then
+		ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_SSH_DIR/id_rsa
+	fi
+
+	if [ -e "$TST_SSH_DIR/id_rsa.pub" ]; then
+		cat $TST_SSH_DIR/id_rsa.pub >> $TST_SSH_DIR/authorized_keys
+		ssh-keyscan -H localhost >> $TST_SSH_DIR/known_hosts
+	fi
+
+	systemctl restart sshd
+}
+
 _tst_run_iterations()
 {
 	local _tst_i=$TST_ITERATIONS
@@ -910,6 +938,10 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 	tst_res TINFO "Running: $(basename $0) $TST_ARGS"
 	tst_res TINFO "Tested kernel: $(uname -a)"
 
+	if [ "$TST_NEEDS_LOCALHOST_SSH" = 1 ]; then
+		_tst_setup_localhost_ssh
+	fi
+
 	OPTIND=1
 
 	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 53d1eec53..8ec7f4fca 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -4,13 +4,21 @@
 # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
 # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
 
+TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_CNT=4
 TST_NEEDS_CMDS='awk ftp'
 TST_NEEDS_TMPDIR=1
+TST_NEEDS_LOCALHOST_SSH=1
 
 RUSER="${RUSER:-root}"
 RHOST="${RHOST:-localhost}"
+FTP_CLIENT_CMD="ftp -nv"
+
+setup()
+{
+    grep -q 'sles' /etc/os-release && FTP_CLIENT_CMD='lftp'
+}
 
 do_test()
 {
@@ -41,7 +49,7 @@ test_get()
             echo cd $TST_NET_DATAROOT
             echo get $file
             echo quit
-        } | ftp -nv $RHOST
+        } | $FTP_CLIENT_CMD $RHOST
 
         sum1="$(ls -l $file | awk '{print $5}')"
         sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
@@ -62,7 +70,7 @@ test_put()
             echo cd $TST_TMPDIR
             echo put $file
             echo quit
-        } | ftp -nv $RHOST
+        } | $FTP_CLIENT_CMD $RHOST
 
         sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
         sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
