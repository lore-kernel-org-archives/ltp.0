Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF38FCAC5B5
	for <ltp@archiver.kernel.org>; Sun, 28 Sep 2025 23:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759102077; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=PYbXNaR4gk4678CgHHUsf9JwQ5GkO9bY+2FBofRaKcs=;
 b=crhveAh5lzu4WaP+RGBoze5k98Q8qpA2GyM3BLPqLSr2/ODm8vtTMvBwTl9NV8mTqfmaX
 XowxVLXE5WO53xpxQJWWvTEquhU2AmzbWH4McJhLe8yEeJRvJC6MSDzDlsRAbeV424yA+dT
 gPphDvR8yzjmJ+soxYp0W1ZBsHSlTdw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 423643CE1B3
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 01:27:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED39E3CAD69
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:15 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19CA11A0009C
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:15 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62fc89cd68bso7451457a12.0
 for <ltp@lists.linux.it>; Sun, 28 Sep 2025 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759102034; x=1759706834; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPyJw1szReqLGzWz/39l4S7WamDw9uDOSLBfH125x+w=;
 b=IYsf/1h/uehPQO725Aj//JKQxx6xfNcYkEyy/BSLNqin8bx4O3lKBAwrqWVmGSEyGr
 FvKsuXL7eVzq+eHFsTqEH7buRcujhTBHUCCeKcsmj6h3/KzDomFB+yzMzvv9bCoNEzuD
 icu8FPdsBM991HRQaLdY/0eljyySRFDVC8AS3lIWPSndroXOVdVPMkpJ+wZLbymwAOtd
 jrFziSFyaOowCEp3RtUaT73Roy+10tiHgnvHVoOfGO3dVWSW1n421sSuqJ5sg/S8+ZSo
 U28vGg3Oay8JlIEZZmCat/sSvNTOE0cL6YBzFIH+xiflYVcEVUOGXBRmYtj5I79LrKzJ
 E7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102034; x=1759706834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPyJw1szReqLGzWz/39l4S7WamDw9uDOSLBfH125x+w=;
 b=ayHMftKvp2/s4oGSKjPLid5atF5OIv+EO035CtSQv9degWGdimJT3IvetKA1yq4eq3
 V6HuE842JFw5rP6knvyNjArEnf1W7PXnJu+yEL2aO4GcYqacdbPL6NG2LFiUkszmlWYo
 9AePAo1/0ngivvA9wP5/9FWyDg3KPWoGmi3but89CeV32Hq31PNsnZCxLivT5tuzRgoS
 dIQSqZ8AZClN+zznRdqyy40Ug/S0A9kkHc+hHvoHUZql/M2auYsnbYh3T7ms/rMrRjyy
 59ttJadBOLspj7bOMGgNem7mnxGpi7SBzqIZOrrhHt2GWixPwpClckSBnWkbu/akQgiB
 CXYg==
X-Gm-Message-State: AOJu0YwwxFJCMza8ambPIUh6kYWO4tWOLIjF7cCKKdSH3XbW5chFP56T
 37GWwKPtu7cfGxjLKdmbXBVrE7mDuBaVB9kEtWXSw7RVFdp1NhEK8P9VACZtTm1l+ym7UfBQ5qD
 E2wzXCg==
X-Gm-Gg: ASbGnct8FQJAyROXzvZimTn8R/I8hBPwhItKMfmmz8eIX13kMH9byaHeyXiuuRmm2Rl
 xf6ZjH3EpSAhkqILOAmQw01HYxMjLmuXbM5MW/c09iMlv0Z1hB6OZ6WXU3iopTEvYBbDeHMV1Yt
 NkPPYCNSR22UweuoaGzdQbe5NliC71JOy2nxyt9aABJA8pWzx7Xb0DTkm6vvl1EVlKM3LJM1JRY
 +tXIKzIuM/6rwYteJemjSPKACGGAntGJbeu/HsJwTSS9n+44SBvFYyDg/Zz8ZOjXe49hXoVgemp
 gMeI3fQp7DgXdSKyNBZ78OrF9/T7OLBrUzV7u41JxtPoYJ9UVWThJy8B7WX+RI90qekDYtXJLsY
 QBPFEfN+/TqcVkC7D413qFT22peJsfPwY/Ceumk1a4tntTn0BrW3hYA==
X-Google-Smtp-Source: AGHT+IEknlClt9TtRz7DtIaC/LWRSWQ+rkbbiv8/On1a8LOeOoCB0DiLLD/zJbs0FQldW9WTWznltg==
X-Received: by 2002:a05:6402:8c2:b0:634:4e0a:9d32 with SMTP id
 4fb4d7f45d1cf-6349f9cb9f1mr9550169a12.7.1759102034233; 
 Sun, 28 Sep 2025 16:27:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-634a367924esm6840661a12.23.2025.09.28.16.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 16:27:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 28 Sep 2025 23:26:57 +0000
Message-ID: <20250928232708.24007-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928232708.24007-1-wegao@suse.com>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250928232708.24007-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Add support option for .needs_cmds
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
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_cmd.h  |  6 ++++++
 include/tst_test.h |  8 +++++++-
 lib/tst_cmd.c      |  7 ++++++-
 lib/tst_test.c     | 25 +++++++++++++++++++++----
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 939825646..148afc49c 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -16,6 +16,12 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
+struct tst_cmd {
+	const char *cmd;
+	unsigned int optional:1;
+	unsigned int present:1;
+};
+
 /*
  * vfork() + execvp() specified program.
  *
diff --git a/include/tst_test.h b/include/tst_test.h
index 9c21c1728..bef836525 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -617,7 +617,7 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
-	const char *const *needs_cmds;
+	struct tst_cmd *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
 
@@ -721,6 +721,12 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/*
+ * tst_cmd_present would loop over the tst_cmd array and return the supported flag
+ * value.
+ */
+bool tst_cmd_present(const char *cmd);
+
 /*
  * Validates exit status of child processes
  */
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 82d60497a..cfd38c31a 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -265,7 +265,12 @@ int tst_check_cmd(const char *cmd, const int brk_nosupp)
 	str = strtok_r(NULL, " ", &next);
 
 	if (tst_get_path(cmd_token, path, sizeof(path)))
-		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+		if (brk_nosupp) {
+			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+		} else {
+			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
+			return 1;
+		}
 
 	if (!op_token)
 		return 0;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8894f782..ed9459e2f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1353,6 +1353,19 @@ static const char *default_fs_type(void)
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
@@ -1422,11 +1435,15 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
 
 	if (tst_test->needs_cmds) {
-		const char *cmd;
-		int i;
+		struct tst_cmd *pcmd = tst_test->needs_cmds;
 
-		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd, 1);
+		while (pcmd->cmd) {
+			if (tst_check_cmd(pcmd->cmd, !pcmd->optional))
+				pcmd->present = 0;
+			else
+				pcmd->present = 1;
+			pcmd++;
+		}
 	}
 
 	if (tst_test->needs_drivers) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
