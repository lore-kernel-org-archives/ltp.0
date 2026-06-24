Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8562CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D724F3E6208
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:20:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39CB23E4D45
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB141200AC7
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7FB771449
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRX9iBquXstbDzKzQfM37Esk05A/a1SULyfxr5Klstk=;
 b=uvcho/dDaxZ7CIhNpD51aWRZRXlHxJBtw/kEBULKbr3YLPRVGgg1CWWodghaxJVhmK0R3c
 MrNWRsfPxh2v03hShVlF626L52WX2bFvhFUpBPnYfY+mX3SbDKeVEpzhLCQ5In1COuYZxT
 NpwEOWgc4hNtUNDJQ9TJ2cN0PQ9CE9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRX9iBquXstbDzKzQfM37Esk05A/a1SULyfxr5Klstk=;
 b=Q7c4/u1b+/4DzHsn6rI9dFTwUkJdoK491kv1X2mWa9bF+ro3ynmwT8flprIHZ0EkrU5R5o
 aXCbvFsK5zsk46BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRX9iBquXstbDzKzQfM37Esk05A/a1SULyfxr5Klstk=;
 b=uvcho/dDaxZ7CIhNpD51aWRZRXlHxJBtw/kEBULKbr3YLPRVGgg1CWWodghaxJVhmK0R3c
 MrNWRsfPxh2v03hShVlF626L52WX2bFvhFUpBPnYfY+mX3SbDKeVEpzhLCQ5In1COuYZxT
 NpwEOWgc4hNtUNDJQ9TJ2cN0PQ9CE9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRX9iBquXstbDzKzQfM37Esk05A/a1SULyfxr5Klstk=;
 b=Q7c4/u1b+/4DzHsn6rI9dFTwUkJdoK491kv1X2mWa9bF+ro3ynmwT8flprIHZ0EkrU5R5o
 aXCbvFsK5zsk46BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B639B779B4
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iO+VKwihO2pbAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:57 +0200
Message-ID: <20260624091900.4107041-11-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/13] testcases: Fix the CVE tags
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

The tags should be in the format year-seq. With the CVE prefix our
tolling is broken e.g. tst_test.c prints wrong URLs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/userns/userns08.c                 | 2 +-
 testcases/kernel/pty/pty04.c                                  | 2 +-
 testcases/kernel/security/dirtypipe/dirtypipe.c               | 2 +-
 testcases/kernel/syscalls/bpf/bpf_prog05.c                    | 2 +-
 testcases/kernel/syscalls/bpf/bpf_prog06.c                    | 2 +-
 testcases/kernel/syscalls/bpf/bpf_prog07.c                    | 2 +-
 testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c | 2 +-
 testcases/kernel/syscalls/kill/kill13.c                       | 2 +-
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c     | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt03.c           | 2 +-
 testcases/network/sockets/vsock01.c                           | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 2ee4da558..4196bb064 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -139,7 +139,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d2f007dbe7e4"},
-		{"CVE", "CVE-2018-18955"},
+		{"CVE", "2018-18955"},
 		{}
 	},
 };
diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 8bd1bfff5..b23cc0a9d 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -494,7 +494,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "b9258a2cece4ec1f020715fe3554bc2e360f6264"},
-		{"CVE", "CVE-2020-11494"},
+		{"CVE", "2020-11494"},
 		{}
 	}
 };
diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
index 981793e64..a1bbe9465 100644
--- a/testcases/kernel/security/dirtypipe/dirtypipe.c
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -164,7 +164,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9d2231c5d74e"},
-		{"CVE", "CVE-2022-0847"},
+		{"CVE", "2022-0847"},
 		{},
 	}
 };
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 05cb34e13..6412ca205 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -210,7 +210,7 @@ static struct tst_test test = {
 		{"linux-git", "468f6eafa6c4"},
 		{"linux-git", "e88b2c6e5a4d"},
 		{"linux-git", "9b00f1b78809"},
-		{"CVE", "CVE-2021-3444"},
+		{"CVE", "2021-3444"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
index f701e9599..830159427 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog06.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -149,7 +149,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "64620e0a1e71"},
-		{"CVE", "CVE-2021-4204"},
+		{"CVE", "2021-4204"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
index e3bf6e7cc..d82f97faf 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog07.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -153,7 +153,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "64620e0a1e71"},
-		{"CVE", "CVE-2022-23222"},
+		{"CVE", "2022-23222"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
index e4c0cb716..73bf5da99 100644
--- a/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
+++ b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
@@ -56,7 +56,7 @@ static struct tst_test test = {
 	.test_all = check_vulnerable,
 	.tags = (const struct tst_tag[]) {
 		{"glibc-git", "d5dd6189d506"},
-		{"CVE", "CVE-2015-0235"},
+		{"CVE", "2015-0235"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/kill/kill13.c b/testcases/kernel/syscalls/kill/kill13.c
index ca281ca6c..bf6e4efeb 100644
--- a/testcases/kernel/syscalls/kill/kill13.c
+++ b/testcases/kernel/syscalls/kill/kill13.c
@@ -37,7 +37,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4ea77014af0d"},
-		{"CVE", "CVE-2018-10124"},
+		{"CVE", "2018-10124"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 65061bf3d..7481dcd8d 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -117,7 +117,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "cf01fb9985e8"},
-		{"CVE", "CVE-2017-7616"},
+		{"CVE", "2017-7616"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 90d546611..134734acd 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -79,7 +79,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "ce683e5f9d04"},
-		{"CVE", "CVE-2016-4997"},
+		{"CVE", "2016-4997"},
 		{}
 	}
 };
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index e46f663ed..84c9f9577 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -118,7 +118,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c518adafa39f"},
-		{"CVE", "CVE-2021-26708"},
+		{"CVE", "2021-26708"},
 		{}
 	},
 };
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
