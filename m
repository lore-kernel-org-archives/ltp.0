Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59534E6B26B
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766455793; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=EBwAWzsyE5qRvaUQM//zi8NjvT7vhdNeteAgr2w8+7Y=;
 b=I8Z7QxpYqGwe5ajxC1ptg4ib7H9ynjr3TXQqQzXRLcR8LKAdPL1ZDS33zshvXY4PlVIze
 BGSjMiuyM5sZzdngAQLkmmmB9Dhz9moJ3s71mDkb2xPAGEehvPDGRBg/GfZt6tzlPMOByOW
 BK3rIQALZY4ezLAtlHSWvQlNlFXWRHM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642363D0743
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 03:09:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82FD03D0733
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:43 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C74A6009FD
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:43 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43246af170aso2470501f8f.0
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766455722; x=1767060522; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox9GibLkkhxXKP7NR5WplaOSEXXhq5bR1U2SSx3L3lc=;
 b=EWWJEF9vhCZtr3+P7zmKOziDLs4V7Xj0LZ6nZ4LdS2azDtRPYc7oEd/1/g5YbK7Ofn
 LbovXfZcngsIqNaIma17QXHEfkulug4lL3jnm3c50RGdsWkdoMvHus64nRWjeLdl+67I
 b75cFQ2xqaKHLWMmCkKXzkBtoNA4J93rdjtl0oz1rZ92w2GGUa6HWFr5ERmAl5XTCaVe
 yb0mTQn3FLMnfoxaCCuq3CV90KZvdrPrNc1N4ws+z2m6+4lSB5ZhF9AtnZCjac30DTjW
 vr4gwXen2GmL2cblQKuTmEc8OZV2m5SiZoiDG6Ep21VJRw8bc2VmF00N+ic34OHxQw+N
 ZrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455722; x=1767060522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ox9GibLkkhxXKP7NR5WplaOSEXXhq5bR1U2SSx3L3lc=;
 b=W5d3y6+tbgzU78Qs5RD4IpQUgPMeCRl/HHhougJKV2QFg1mnwacc+DoRjEsx/SpM1P
 B6TjACvi7h4YtCED9NGi3Fxqhomi+VF7lci+t13kfPMEbvEhV/uKyr702gTcFeWm6Xa6
 sdOfrqcqpae0giuuW7WS+CEtdwKAZgVisTcTUXqdfKO6IT0SzC/OCUjlgy0AWhiBizfL
 b9f2nNwn2FPs0uWHg8MshvpfE5E9Bw5MGNdhZL1fgBs4opEBBiiGA5TPPbNVO9bbSWrP
 Dpj/m5Fkpy5OmrYo1SxwQKo/rTzGU5C+a0ZB8GpQllERrpfYuZnt/UgqL4pj+IvCHGk0
 tScA==
X-Gm-Message-State: AOJu0YxfkTeHm57rRc3VSiO5qBfq1F6U9mz+DGqAWOC5G4DcxWEgAGSZ
 pcPwQ/ClNQITAIBXW+JtXlQGd2FlQtIqL1rEGjKyE7Msqs3FTvIJlvPp0m0DMl2Xl4XBtJ91HFx
 A5Mw=
X-Gm-Gg: AY/fxX5n/nKszBQfIWrrCFXgWLklyKdPQcKY6bnzmioeb0AQQDMzWOEgwysYsnaeQer
 w635Qm0+I3DQS+Ux2zSXBFB5Ju7vP4F4UIJpeFekv203ZpGtZZkiu+KObopHegAqtwtn7r8+S8R
 Dl/fGCohr8LgAJ+L+iCfTAySQpNtg13SBTVMrfLi/TfzgydvmhQMSbuhITbtoSG9sFmttV9T4S2
 MeDjrwx51qlSV632931V+fp1chp0lB3vEA5KV2JFzG4+46QWM6B9Z2MYi58sN7Omfsq0qFKSPGv
 b4A0kbIH63ZGr8KYCLNcFJNGmNX0YQ3MYvBZbL0xxD6JZEFaTP4xMwBLsQ3UuQbGIF49o0cOwh5
 G5MH0fnHChOPvHdTrPiB7DjuaWedAVKdFux0egg/rwQ2HaDvc7YALgDakEkkywVjo8koiDCOquL
 d1jx1LcdSQmg==
X-Google-Smtp-Source: AGHT+IGGTHBnxWPiywMJy0Y8aEdrVkPIy9zdGdq3WPY7SICEJ1fJ5SIraPu6m0BVfGpzBBlwZmNMeQ==
X-Received: by 2002:adf:f7cd:0:b0:432:5b18:2cd0 with SMTP id
 ffacd0b85a97d-4325b182ee0mr6653716f8f.5.1766455722279; 
 Mon, 22 Dec 2025 18:08:42 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4324ea1afbfsm25269966f8f.9.2025.12.22.18.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 18:08:42 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 23 Dec 2025 02:08:16 +0000
Message-ID: <20251223020836.9439-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223020836.9439-1-wegao@suse.com>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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
 include/tst_test.h | 12 ++++++++++++
 lib/tst_test.c     | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 38a9d0d54..89dd31582 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -721,6 +721,18 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/**
+ * tst_cmd_present() - Check if a command is present
+ * @cmd: The name of the command to check for.
+ *
+ * This function iterates through the &tst_test->needs_cmds array. It compares
+ * the given command name with each entry in the array and returns the
+ * &tst_cmd->present flag for the matching command.
+ *
+ * Return: `true` if the command is present, `false` otherwise.
+ */
+bool tst_cmd_present(const char *cmd);
+
 /*
  * Validates exit status of child processes
  */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 42a54621e..67553f65d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
 	return tst_dev_fs_type();
 }
 
+bool tst_cmd_present(const char *cmd)
+{
+	struct tst_cmd *pcmd = tst_test->needs_cmds;
+
+	while (pcmd->cmd) {
+		if (!strcmp(pcmd->cmd, cmd))
+			return pcmd->present;
+
+		pcmd++;
+	}
+	return false;
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
