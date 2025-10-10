Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBB1CCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760078921; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Zm38strKpSYMm8G5mYN4pVOTJN9eP8X1MiAlZ4AwslE=;
 b=WkJNCV/AoKDe5lneSbJ2H072+RX6pRK+tS82lhu9RY4PT9SjPXnUy2FaVHSjvya4tDSyh
 +OYyuIZIVR2svihvlkfWMtjtb3u89+ebsrQCUib5G4/mKNHBSSp2edYQnuHcz9Ou5DpwFLN
 +rY/9C/tS92CwB80r9ljzlizcUuInvA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B6A93CE970
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:48:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425CB3CE959
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:47:59 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEA75140026E
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:47:58 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so20138035e9.2
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760078878; x=1760683678; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2mhgzcXKxW7ilU7NoJKHUbEGu79j2saQ3ij8YjD9ig=;
 b=KcUjSzoIONejsemgJXw0QouGXCaKL7/M4HAs64gzxthNMqcjpUvzrz69UOmA0qszXh
 T8l9bS05MBJj2MFwGCTEjNNFTMDHyPjMvDYPwiE2hCJlrtnPXO9PBIpipWRvVVaMvlqZ
 J+VcngofqxSc/7yK6czvqZZr9z6SpM8ofZGjsgIrkx1l3Kh04x6ZX6DvClmETQbm81iU
 KsO2RP5TaBYIFLKIL3ftBK3JpaifoqT8Mu2wfMBkRDS8/PY76q4xMmXVtekYPzT2K0rp
 wKGaiNLlELxb7lHeIZIFr/5X0exWkIPdnM5PVaemfFgV1VF51mqKJzZUo/XV+QvJkgF9
 5+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078878; x=1760683678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2mhgzcXKxW7ilU7NoJKHUbEGu79j2saQ3ij8YjD9ig=;
 b=PkeCdSSYqvfUF4lk/EFp/Meh5tAJInDjJ8LegIyamQh57QtBpfsdGjeAGEmJRxDRmA
 hHc1swqmqHKm1WXid4gwfgx+OhRrMuGlHJ4C1oCZupk31w6NeCSUTnG+95whjvV53vgs
 w46KC5TxoCB2gKOKjMHaC9qXeIZZa9z/U2HYhHGERricfTxWTisolqGa02YLJqrF0l9S
 d/aoFrnrDBM+rILGIXQhL3SnH3SpUhwWoJaN7SN87Z2CrG11/fHr6jmDPUTwof5oQCxw
 aLPRMRO8t2DuCOrZ98CB2/LREmjl1/+7llxQPS3DFN28sFusEike51Kvw5E9R7bnoeMn
 ojjA==
X-Gm-Message-State: AOJu0Yx/Z1RNEW7tVaK8iNCQas63hmt4zdh/2uoi5t8Cqjt17vADGuG5
 FMYFPZOitq4NDLt+OdgZwOC6rH/PFmFKGlADSaGGhMetJuJjYadYrnkYntdQ+gE1Ew9eilqwZhb
 sQcg=
X-Gm-Gg: ASbGncvTkRG/1CbHf/67M5LzNwx7wk3hqTbl89o4cn29gL7TRodQz1JToZZfsCrINWu
 f2NhKUtHjyMJe1q5K7U9kqVHfwzkEbrnAA0B/4z1UAVHpd70qk20TKLXKxSWl0NFSbvqBzeDMYM
 DPA2yADI6AWN70BAtOPwXJn6bBWXDOPVtBm8C/hd9l0YA1NcULwjJAZNNWhUCvaOlrNMibthkCM
 4Zim5cdiQDbKYlLn3L1aqu8X51hwip24QD6Bi3RCikSwwdWZFInFiNs2BIDoclTG6HKfeGzmNcw
 o7pyGGz5Gp/QUeNdnpkxgT4Hh8HE+5wzMo1LpBq/c4+U/kkQXuXflaC3UMHRuLX8lteRdtxn1Zd
 4XY+bJi6aHnc+qF8dlCTK4swU+GwSpg==
X-Google-Smtp-Source: AGHT+IFJJYNjPV9T9f2i6o3nTuz3xx7wbrcnluPJ4JEEGGvqfYV50DjOozpDlrk8Xh5AyxcrCz+kLA==
X-Received: by 2002:a05:6000:230c:b0:3fb:9950:b9eb with SMTP id
 ffacd0b85a97d-4266e7c0445mr5445901f8f.28.1760078877972; 
 Thu, 09 Oct 2025 23:47:57 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-426ce5e833dsm2581847f8f.53.2025.10.09.23.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:47:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 06:45:47 +0000
Message-ID: <20251010064745.31361-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lib: Add support option for .needs_cmds
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
 include/tst_test.h | 15 +++++++++++++--
 lib/tst_cmd.c      |  7 ++++++-
 lib/tst_test.c     | 22 ++++++++++++++++++----
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 939825646..703589019 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -16,6 +16,19 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
+/**
+ * struct tst_cmd - This structure provides details about a command needed by LTP test
+ * @cmd: The name of the command.
+ * @optional: A flag indicating if the command is optional.
+ * @present: A flag indicating if the command was found at runtime, this is an output
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
index 9c21c1728..2730d22c1 100644
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
 
@@ -721,6 +721,17 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/**
+ * tst_cmd_present() - Check if a command is present
+ * @cmd: The name of the command to check for.
+ *
+ * This function iterates through the 'needs_cmds' array. It compares the given command name
+ * with each entry in the array and returns the 'present' flag for the matching command.
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
