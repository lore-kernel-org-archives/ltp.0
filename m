Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B0EE7734B
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 00:00:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19D8A3CF888
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 02:00:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C2FC3CE160
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:00:17 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE1221400264
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:00:16 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-57cf261194aso16230286a12.3
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696032015; x=1696636815; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fZetqQEgrwo3EWCfGBrCWzxD4OhIX00BcpEYoULkPEM=;
 b=OPVwIKzew9a2lkf7UhfFM8Rv4Yy2kA8sivxxUFLAvndJDElHkUFe7cAojhir9rROji
 OClVjVitH38/Oq+hM1+z2DZN6EFZM28tdc9dOYZcPFdzC4uEIrsTZUud7Bua3xQn6WW2
 20NtLaKBRCWzi/N/ka6LuYuyFGuM4kFGND3o1ZUZzfb8pu3CgWTzMMgwCgkMusM/k5+C
 +4J2yjn75+I0BzlW++9Myrzou3T2G1EFzJq/bH2S6THTGYCs6HQIDG1AiypDb56V3FtF
 6cddhDn7iKVSF/46hDhqjZNNJun9dhmHvDVKmWh7yueXkgBS2IcdHoEXVALjq4tkF0N0
 c7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696032015; x=1696636815;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZetqQEgrwo3EWCfGBrCWzxD4OhIX00BcpEYoULkPEM=;
 b=beXgcM7bwJ8r9+L5s6nE7fCVXmQQSep6O9xdPpCTgRhCuxDbloqg2PZyMf7npDokRf
 5dyER7CjHGsmh0WDJqFmwk/RnTLYOFcOvkPj1a6SYND3yWaNxs/EzW4dc+RS/yAMco6B
 kN9LMivr08odua1kU2sE8i+l51mNgRK1x/2s/Vdhl3O5s5rW/uPAUErvFMelCv/P9pP5
 ft/gjm2yMa+L7IoHy0Pyl6OxfTddcC7dsW19yIIw+OP1RBtEg+aKOuUiCV+/3J0hXhLO
 0/Q7vHka6N3wy74Pl7AKuhOhWJbPlhskvO8L+qvtSduOJl00Ns2rBjWfTT7m/Gyb2wFW
 d37w==
X-Gm-Message-State: AOJu0YyLHb8GQ0ToRmdIIgAaAjdiAEH+xF0o6o57Clx8yW7+3TWR4KmY
 7/Tun96hV1zU/PHbhDlD0swQe9kICAvqMAj+f6epwy6XHW9QWypCzFpLn6lHr6/01cdWu3Z5Xt3
 Y2+2yXfTx3xi7gz95pKqzcRZNo9WFwhr0vZbzwpGB5vrziTkIp0SyEpfZ
X-Google-Smtp-Source: AGHT+IGzuWGaDYv6mdbrYUFkWsgx9TN+Pk8LPVoY5ENzE/dDhYoHCA8pM070hwcJeDyv+Up1X6qUU/8uEQs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:bf46:0:b0:578:9125:922d with SMTP id
 i6-20020a63bf46000000b005789125922dmr85081pgo.10.1696032014841; Fri, 29 Sep
 2023 17:00:14 -0700 (PDT)
Date: Sat, 30 Sep 2023 00:00:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230930000007.4052837-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pipe07: close /proc/self/fd after counting fds
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Leaving the directory fd open will count against the max number of fds
opened, so the final expected count will be off.

Also, removed the halving / doubling of exp_num_pipes since it is
redundant.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/pipe/pipe07.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 196485684..01f6b78f8 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -45,6 +45,8 @@ static int record_open_fds(void)
 		opened_fds[num_opened_fds++] = fd;
 	}
 
+	SAFE_CLOSEDIR(dir);
+
 	return num_opened_fds;
 }
 
@@ -56,8 +58,8 @@ static void setup(void)
 	tst_res(TINFO, "getdtablesize() = %d", max_fds);
 	pipe_fds = SAFE_MALLOC(max_fds * sizeof(int));
 
-	exp_num_pipes = (max_fds - record_open_fds()) / 2;
-	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes * 2);
+	exp_num_pipes = max_fds - record_open_fds();
+	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes);
 }
 
 static void run(void)
@@ -73,7 +75,7 @@ static void run(void)
 	} while (!TST_RET);
 
 	TST_EXP_EQ_LI(errno, EMFILE);
-	TST_EXP_EQ_LI(exp_num_pipes * 2, num_pipe_fds);
+	TST_EXP_EQ_LI(exp_num_pipes, num_pipe_fds);
 
 	for (int i = 0; i < num_pipe_fds; i++)
 		SAFE_CLOSE(pipe_fds[i]);
-- 
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
