Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE3BC27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 12:43:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16B453D0B40
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:43:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB04A3C00E4
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:43:42 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D0E21400159
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:43:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5323A1F7EF;
 Mon, 10 Jun 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718023421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAxFswveMV2EZFLa8GZulVxz09QOjXbFjJc8l2Y2lr4=;
 b=E/oUUNOFZfeGG9YSFLkLP5IDN9btMVY8AM1stvMgXAH9UP3m8NWK6HqOdCJJfUKC9xnvQb
 UwZGP2We1XNAQDlgrP520fu3Vm/E8P+T9/Yq7NAnqm5AAFDirWwffLzhMRHh/CX6ovXIy6
 12Xl2DYj5sgjiO2Fd+8fdJCmlTn1P/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718023421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAxFswveMV2EZFLa8GZulVxz09QOjXbFjJc8l2Y2lr4=;
 b=5G+fBipfGnhxKv4TEi5nYglXzy11SIumPra116hraD64cShPs2GaeYA6ELTJOI0k/aYf/0
 Cz6VGQlipmHG2VBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="E/oUUNOF";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5G+fBipf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718023421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAxFswveMV2EZFLa8GZulVxz09QOjXbFjJc8l2Y2lr4=;
 b=E/oUUNOFZfeGG9YSFLkLP5IDN9btMVY8AM1stvMgXAH9UP3m8NWK6HqOdCJJfUKC9xnvQb
 UwZGP2We1XNAQDlgrP520fu3Vm/E8P+T9/Yq7NAnqm5AAFDirWwffLzhMRHh/CX6ovXIy6
 12Xl2DYj5sgjiO2Fd+8fdJCmlTn1P/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718023421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAxFswveMV2EZFLa8GZulVxz09QOjXbFjJc8l2Y2lr4=;
 b=5G+fBipfGnhxKv4TEi5nYglXzy11SIumPra116hraD64cShPs2GaeYA6ELTJOI0k/aYf/0
 Cz6VGQlipmHG2VBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33A5D13A51;
 Mon, 10 Jun 2024 12:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Bb6qCv30Zma9JgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Jun 2024 12:43:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Jun 2024 14:43:33 +0200
MIME-Version: 1.0
Message-Id: <20240610-kirk_v1-3-v1-1-157b55f72730@suse.com>
X-B4-Tracking: v=1; b=H4sIAPT0ZmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MD3ezMouz4MkNdY13TZAvjJItks1RTg2QloPqCotS0zAqwWdGxtbU
 AVOYo2VsAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=sXfX+AZIoi0Gwd/K6FH23Xzj7Tkm5sael0T4dK9YKD4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZvT2iI1hFiwVzG9+rM03VqPguWschpDo1jFv/
 mFNhEaQsYaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmb09gAKCRDLzBqyILPm
 RnEEC/9DzlUVjHvxJYGkPEWeD+ndPxLFu397QP2nCe2bbFt9NW+6DB0oAj00nrmPMnC4DBRt1cN
 +xTM85cD/3oJK6QymgHaEKQCajMndPIjuWHy0DkjLJGzfErWry5ky2sPhZmARqpmyDK9adQ7Wg5
 6WhH6b84nYavGx959KqIsaCzATFN+yizLkoWkt76ujq17JjzEJcraxNtDJrEDbRMymWi6w1VJma
 2bqnY8+vBa8hzyYuD4F1gT/lS0WW2zLKcpcL136KIX5Dr1SM/L6sh5wj/vGt5DdACzcEijGSdNy
 JShT0d3NP55oanu57N4bdnypr009He9H+XXFyMgYxOpr2aT4IX0G9joUG2HZ1CGUzOXM5nyJDNw
 FhEhXF/hH3A1T3bmBiZeBHczO+Olp7Wzrur1V2wLT6ugY6UvPF/WwWyvxDpuT/2TvFa07A7k+Cu
 e65wEJUoW+L94vjM8zXnOplf5fctqy64IBYMwOU1z1McHAVWm6uwNz1lZdWRP4tr+cAmY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5323A1F7EF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Update kirk to version 1.3
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

The new kirk version includes:

- Fix cgroup kselftests collection
- Kselftests fix test name
- Wait for SSH command to complete after execution
- Fix SSH execution not redirecting output properly
- Fix SSH module is not showing live stdout/stderr

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Updated kirk version.
---
 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index bcb2df815..5e8c8064a 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit bcb2df815d3fdbca470c1ff6ab14ac9cb2f9e3b7
+Subproject commit 5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2

---
base-commit: dfedace141cd7586dc5533d90fdd43f428da9925
change-id: 20240610-kirk_v1-3-5c83b8c6e50c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
