Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA696CCF9FF
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 09:28:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E23F3CC8F1
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 10:28:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED4243CCA98
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 504A5600D57
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE0D522029;
 Fri, 31 Oct 2025 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6Wf1Yy1YWku4i9bx3a0VbkbpVQKteBuduQb8X6OfMg=;
 b=D6NZ3vdd2ASDKrtyJf1Xa9pV4MlrdCdBs89ZHcTLTB4Bjprrq5D4YNw3kNN6FB42I11a6R
 r5YR+3JozvhzNcfMhPuQp4flbybUP/2kE75w0ucY8BDFXUMdn58+oQGycTJuNExzXeKBXL
 uCI4AsTOMZ3oagP93wo/Ed5duhzkmog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6Wf1Yy1YWku4i9bx3a0VbkbpVQKteBuduQb8X6OfMg=;
 b=I24OT3R+Svl5CWjAoO5YssY2OFEDMztNxIz6AU3Mva9FYKwsyOwvg3cAq176afn8bJ1ZHC
 BCVGiskfWGx46ACA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D6NZ3vdd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I24OT3R+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6Wf1Yy1YWku4i9bx3a0VbkbpVQKteBuduQb8X6OfMg=;
 b=D6NZ3vdd2ASDKrtyJf1Xa9pV4MlrdCdBs89ZHcTLTB4Bjprrq5D4YNw3kNN6FB42I11a6R
 r5YR+3JozvhzNcfMhPuQp4flbybUP/2kE75w0ucY8BDFXUMdn58+oQGycTJuNExzXeKBXL
 uCI4AsTOMZ3oagP93wo/Ed5duhzkmog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6Wf1Yy1YWku4i9bx3a0VbkbpVQKteBuduQb8X6OfMg=;
 b=I24OT3R+Svl5CWjAoO5YssY2OFEDMztNxIz6AU3Mva9FYKwsyOwvg3cAq176afn8bJ1ZHC
 BCVGiskfWGx46ACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C05BD13A1F;
 Fri, 31 Oct 2025 09:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sC4XLfKABGk8WQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 31 Oct 2025 09:27:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 31 Oct 2025 10:27:09 +0100
MIME-Version: 1.0
Message-Id: <20251031-kirk_move_submodule-v1-1-3cad4270a0b5@suse.com>
References: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
In-Reply-To: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761902834; l=847;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=LXYkZMAR9Wtz81g8i6SR1STqzMNQplhyqY7S5uNhRc8=;
 b=Y7OJ7wuHpBMOZW65T3k2CEOIMALM5rT1yu+U9AupGL92hAuvJJTXLKT7JeraHssEJGvrgPBOB
 KMW9uuoXq79ArfPWMRc1r790WeHneV4fTispqW/lcrMuHfi0BCwn6Zb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: DE0D522029
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kirk: remove submodule before moving it
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .gitmodules | 3 ---
 tools/kirk  | 1 -
 2 files changed, 4 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index c9a6eea31..8f081decc 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -4,9 +4,6 @@
 [submodule "tools/sparse/sparse-src"]
 	path = tools/sparse/sparse-src
 	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
-[submodule "tools/kirk"]
-	path = tools/kirk
-	url = https://github.com/linux-test-project/kirk.git
 [submodule "tools/ltx/ltx-src"]
 	path = tools/ltx/ltx-src
 	url = https://github.com/linux-test-project/ltx.git
diff --git a/tools/kirk b/tools/kirk
deleted file mode 160000
index e0ef9f28b..000000000
--- a/tools/kirk
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit e0ef9f28bcf15d00cf8a03915df894bb38a5d8ea

-- 
2.51.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
