Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922A3CF9C6C
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 03:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727236707; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8UPu5tUmym0VR6+TYsDRcvLCfhSfYFeIS6dxuqzfOaU=;
 b=Yx2mYZz4g7miWCHIRvOzbSrarbt/mYCRL4Gh92MmBliIdsLhtWP7XlpKWcXObtkZCw8li
 VXDuIkSoMimkwMB3OHey7s3pu5n/OjmRS8JOUS0KmgNUgRdIXe65H/jDUxrs2PzZGfglZ/p
 81xfeK8XE23oMmA1j3lo+Ky8lxn+64A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62FDD3C4D2C
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 05:58:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B6113C2978
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 05:58:05 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9988D600070
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 05:58:04 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c43003a667so8690873a12.3
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727236684; x=1727841484; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eg39yxsi0nDDn+mzuyJTrgRdDSeUMpqefU2NsgfY1PE=;
 b=fFbsRo3m5sE5QKOTWIbLRVWK+mhsRz4yWaT5Z8FeXBtpFJqkj+MhNypO2VvSRKHiA3
 GcPMKam/apczashe3faOaexxUiVAow4K42uxXQRDyPCfRKwQT6iQ/+ESitmYwv6P1r3g
 tUpSsQvO6mtMevv+AT/WyZ68Wc+TjJlhK8z0uL7JGiSvgSiFV32FZSRLNGAjZYT0qkQz
 8beYAV03cgrs7S7EcjHdUiSLZ23llcH4Jl611Oz8bzYYPkpeNiyoYcE7MivyNMFvnndZ
 Fccd+pDAgy4qLY1O3ZAAh86lL7dHknA7NJ/74oLTGvzCw+6lifN8WEc8WGgp9wvYGw36
 KJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727236684; x=1727841484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eg39yxsi0nDDn+mzuyJTrgRdDSeUMpqefU2NsgfY1PE=;
 b=MgdWFRVt7mCyfz+jDSf5xChRH9siXcTDeIQoVs4Jq/JHBaj0Fu3TTz+hXmmTEoXjsj
 g0f+4WwIpr5TTmtqJhv/vleyW0g8LdJKCLmEegM/Tcy1ovsv3dVtnmWduHWgvwTQIQOo
 evyIbTMx5pH4aeDUnuZ0vBjzQ0BnOwkoZs0E7FJhVLOqpPAkDJ7dtaw6gDWW3uW1tatc
 7kDp3wKlWiNZwrzugMKGuLAr0hrNy6aFM30wFFectVyxeHrKy1Hjmlhl+hGY1inJ7fBM
 5IlPqAeUHYLmnBPHKJRPvwTsSANt7owa/17FUjq7DrjtWEzBqZ7Bs3VTeaddWidQ1QcB
 FXTw==
X-Gm-Message-State: AOJu0Yyv16u4lhTFAmS4yHCYi5/LFTgGuPXuEtch3/UEYu69JlKzUpvW
 nc+4FFtbQtRfy9hPc9IIYzlTUj0YGBXnkPjQJc0ukocnH6MHW1i1mp6UkkERul2BvbfhhRpbnSY
 =
X-Google-Smtp-Source: AGHT+IHtB5NCLqgJWt/IeZhyrBuvkNaEWnVdH4brrm7c0knaYjws6OHaI6943DMbp/csH5Vo21WQSw==
X-Received: by 2002:a17:907:928e:b0:a8a:91f4:fd30 with SMTP id
 a640c23a62f3a-a93a06b96c2mr121350766b.56.1727236683700; 
 Tue, 24 Sep 2024 20:58:03 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9393133c51sm161328666b.189.2024.09.24.20.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 20:58:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 24 Sep 2024 23:57:56 -0400
Message-Id: <20240925035756.14873-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240918100344.21316-1-wegao@suse.com>
References: <20240918100344.21316-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 53d1eec53..12d32a9a9 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -4,6 +4,7 @@
 # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
 # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
 
+TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_CNT=4
 TST_NEEDS_CMDS='awk ftp'
@@ -11,6 +12,16 @@ TST_NEEDS_TMPDIR=1
 
 RUSER="${RUSER:-root}"
 RHOST="${RHOST:-localhost}"
+FTP_CMD="ftp -nv"
+
+setup()
+{
+    if tst_cmd_available lftp; then
+        FTP_CMD="lftp --norc"
+    else
+        tst_brkm TCONF "No FTP client found"
+    fi
+}
 
 do_test()
 {
@@ -41,7 +52,7 @@ test_get()
             echo cd $TST_NET_DATAROOT
             echo get $file
             echo quit
-        } | ftp -nv $RHOST
+        } | $FTP_CMD $RHOST
 
         sum1="$(ls -l $file | awk '{print $5}')"
         sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
@@ -62,7 +73,7 @@ test_put()
             echo cd $TST_TMPDIR
             echo put $file
             echo quit
-        } | ftp -nv $RHOST
+        } | $FTP_CMD $RHOST
 
         sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
         sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
