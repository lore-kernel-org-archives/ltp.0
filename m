Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B4CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760695858; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=aHtRIBgXJe1NCYADrjLtmiDslpKnnMWO/Sxw1cBcUeA=;
 b=G6M31UTlbVnAFo7QDlRyjsoN+tV3VS83oiCowBKj/X6tjr/7cP6sJhbBfhpBSmR6V+P/Z
 X42+bOOSiphRJAkbENupjgvkTw6Fw9jz/0HrUNm3SDsvUkPX2QRXxTc9EM9VxXzEAHalvBZ
 9Tv5p92L0k16xM60DtxeLEMesae1LQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD0DA3CEE7A
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 12:10:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6BF3CEE60
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:18 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB5151000DE6
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:17 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1262348f8f.3
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760695817; x=1761300617; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eH4CJMDfnG8xUNKhSy/ZI4crJF58eXgJ6UOmmyu9nDE=;
 b=AN/2LRa4g+WRBS352tXYjl8/g7KkJ4M0so4PllQZAh6V0k3kjAklUsTCMDVjHxJ4xm
 +KvGjxVR3gyUKPhYw59G3g4zhFRsVl7ZNX+5Le5C3COgVcMQiFf6emv+LZiQwUlpE8Pv
 cFBeK30JMgg5Hro3C2K3uugEndsSq5evpp0QmRRUwMRaxURyvhI+CIX96C1Oh0E2pxNz
 CxTy92g6PrUQlnRekdkw2+TORlOSlz/qVIHAuxTipy/FqKBcbo5cO+o5PnM9+tlugV9m
 IVOKD9wwboVFMrIXW69cP+RBKQdVXm71Algod1Ens8OX+13M80cMN5kQnwnDmCaNWYfn
 0Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760695817; x=1761300617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eH4CJMDfnG8xUNKhSy/ZI4crJF58eXgJ6UOmmyu9nDE=;
 b=eOn17ko59dUK+t/SCLFkJSyoZ31L9o54qyIHBKCa2D+AkUGM4q9Rq/udoFkgnuv0zT
 gUSfEadYoROJzuv3SHDGZLojoMibPhiS7bp0QHIVdfvtPFOo2eRPDUjVxRHo1zNOC6Ef
 0qnZ7j5yCbQBMxl9O8Z1xUIwyScszvChHTXSFaWe2pyenQ+aLEH59ov2MguNTO1OSgCR
 iN4c60xlWVHsh8PtygMegD6WrM72nGfukoEIsald2DSdWdFf1b3yFH/FMz8Wn/B+5NZx
 EK3tZgpnn6OjCteM4DtPfRcS696YinxdmE46jgcZzLtdX9z5wU7yO3qsTOO4PGDnXSzn
 wu6w==
X-Gm-Message-State: AOJu0YxUbv0zxUZ8ir+032PGc7UgBUCWXqjEDzRZ4CjT9FZyCjXwdEn8
 eIwRFNEh1lTn7xp4eGeHR6tl3Oj+hID/aUrBUkrIEN4TM2FzA86GYb6S+VVjRCuo/ddIgW7KPHR
 MwV4=
X-Gm-Gg: ASbGncs0WGE7FLc9B2FjgYW1rJnfYXUEUuyCOQvhTJcJX0xR4srltkTBKMJZWpjt2lF
 fDFP110elOqvvPaSnbKI/S263h8pNTxp+3wj77RoqHjXttX+SDiyjnVC4rKf4vsWkG8PZA7aOBH
 sfCNVfNWB5Zv0vLfYf1tzrlNsxDzIejZkPi7J4tb7LPQd0OacueIqXsUarecjqJxEv2nndvKt4N
 +0/hAyLQmO0we3+gwrsWmhTpL26TFIA1Ocg+X4OIGprumSGVR2FHqQEzeGCZhjgEaztJ1QCFvlm
 pwImxU8nLkhyYRN6ozFSJ+R29BxiQ4GR5fbZmZGQx/uvSy3G8D867bcukCLpodthcZ8+CWJUt7/
 jHHjhm8KcsYK0JovYudFIVXO2Gf/xqrJFA2qyPgyPokHl4IjRY7nfUBJ1/5ecX2U6snwMks5XCZ
 M=
X-Google-Smtp-Source: AGHT+IEWaMorYgpRIBABHkPSPVLn+l40FvSmm9kjDGpuouh3QHNSTVndf3DlAAARWCrn+XCvET1Raw==
X-Received: by 2002:a05:6000:24c2:b0:427:376:2f81 with SMTP id
 ffacd0b85a97d-42704d498efmr2610498f8f.5.1760695816952; 
 Fri, 17 Oct 2025 03:10:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42704141cc3sm6547597f8f.9.2025.10.17.03.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 03:10:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Oct 2025 10:09:56 +0000
Message-ID: <20251017101011.3811-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017101011.3811-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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
 include/tst_cmd.h  | 13 +++++++++++++
 include/tst_test.h | 16 ++++++++++++++--
 lib/tst_cmd.c      |  7 ++++++-
 lib/tst_test.c     | 22 ++++++++++++++++++----
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 939825646..3c3668eff 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -16,6 +16,19 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
+/**
+ * struct tst_cmd - Provides details about a command struct needed by LTP test.
+ * @cmd: The name of the command.
+ * @optional: A flag indicating if the command is optional.
+ * @present: A flag indicating if the command was found at runtime. This is an output
+ * parameter, set by the LTP library during the test setup.
+ */
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
index 9c21c1728..9305cf39d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -524,7 +524,7 @@ struct tst_fs {
  *
  * @tags: A {} terminated array of test tags. See struct tst_tag for details.
  *
- * @needs_cmds: A NULL terminated array of commands required for the test to run.
+ * @needs_cmds: A NULL terminated array of struct tst_cmd required for the test to run.
  *
  * @needs_cgroup_ver: If set the test will run only if the specified cgroup
  *                    version is present on the system.
@@ -617,7 +617,7 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
-	const char *const *needs_cmds;
+	struct tst_cmd *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
 
@@ -721,6 +721,18 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/**
+ * tst_cmd_present() - Check if a command is present
+ * @cmd: The name of the command to check for.
+ *
+ * This function iterates through the &tst_test->needs_cmds array. It compares
+ * the given command name with each entry in the array and returns the 'present'
+ * flag for the matching command.
+ *
+ * Return: `true` if the command is present, `false` otherwise.
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
index 53b53af1a..6bd0ea44a 100644
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
@@ -1439,11 +1452,12 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
 
 	if (tst_test->needs_cmds) {
-		const char *cmd;
-		int i;
+		struct tst_cmd *pcmd = tst_test->needs_cmds;
 
-		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd, 1);
+		while (pcmd->cmd) {
+			pcmd->present = tst_check_cmd(pcmd->cmd, !pcmd->optional) ? 0 : 1;
+			pcmd++;
+		}
 	}
 
 	if (tst_test->needs_drivers) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
