Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39EDD3C537
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 12:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CB8E3CE324
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 13:30:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CA933CD28A
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 13:29:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8232D200743
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 13:29:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A7B73388E;
 Wed, 10 Dec 2025 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765369793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5NfoHDhR+g9oZZJa/Gvy8eRGnC/tbeDDvjDxCX9+wUQ=;
 b=xb28Ss0a9a5XqkFHwJAYosXGT8lfDug7Tnb+jSVY97w7KnUp+B2zJ7pCXsv6bcGTgkn8MC
 BBmdPgtYGpUJEmARd2SZ/noezKhShRCiyePOUIckaun5S3TU9dXMA8lO6orw8DLfGbh18+
 v7CI0hDulZ+UCDdMxQGwz25PbZsqCmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765369793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5NfoHDhR+g9oZZJa/Gvy8eRGnC/tbeDDvjDxCX9+wUQ=;
 b=1kSByzr4vwCuP1JNWLxQigtIoxLdRQINp1pe5oyvthWdRmswIurn9MdM9ieOPhSLqP6m05
 hCD26T4ayX8OdyBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sVqCHPvk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FAa9vosL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765369792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5NfoHDhR+g9oZZJa/Gvy8eRGnC/tbeDDvjDxCX9+wUQ=;
 b=sVqCHPvk780XVmxY4OtWhJ+Cp4CZOy+5ca07E9onPuIzFvyzIvyKCHcdoOnU7RUlndTG3J
 HXpl5W/UkYFC1yYC+lwRxDT90fdmcveDafG9MTS0boVV9SeaVbV82/kMqt/FxpI3W92IVB
 9DG3ITgsbzS7MjzUujaCVAOGZuHT8DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765369792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5NfoHDhR+g9oZZJa/Gvy8eRGnC/tbeDDvjDxCX9+wUQ=;
 b=FAa9vosLyffpKeV4k+ZvxX49XILi3RApAaBGo1mgyhfPnl//B6R2q1GUvpUlWgGL/o8wn6
 KqzdfOQ0SgEPaMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FB013EA63;
 Wed, 10 Dec 2025 12:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EcbXDcBnOWmvdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Dec 2025 12:29:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Dec 2025 13:29:51 +0100
MIME-Version: 1.0
Message-Id: <20251210-kirk_v3-1-v1-1-d610538666f9@suse.com>
X-B4-Tracking: v=1; b=H4sIAL5nOWkC/x3MQQqAIBBA0avErBOckTZdJSLMxhoECwUJxLsnL
 R98foXMSTjDPFRIXCTLHTtwHMBdNp6s5OgG0jQhoVZBUtiKUai82ckiOW0NQe+fxF7e/7WsrX0
 DwsqbWwAAAA==
X-Change-ID: 20251210-kirk_v3-1-f3b2a12c0a32
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765369792; l=661;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=8oVwv47sLtyY884ARE+D2rOxU4OSMCy/9Rtoy6DwpFw=;
 b=AE/AdOOSgU0cqDk+eZtO7b+P4B+T5dodT5aE3QzalKmngj58iXYo3Ay8XgpLoYzcnpDyNdRyE
 m7wF56B6SkzCIdzwnYIoWJm0rf1wd39Q7t1rJgykYhdpgMNidiUB+mr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5A7B73388E
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: version 3.1
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
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index e0ef9f28bcf15d00cf8a03915df894bb38a5d8ea..526f81d43e711b8a2f1ccc7a89e82b96fe090e96 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit e0ef9f28bcf15d00cf8a03915df894bb38a5d8ea
+Subproject commit 526f81d43e711b8a2f1ccc7a89e82b96fe090e96

---
base-commit: 63259ec17cd33a5033c1a65af7b541834c85f4d5
change-id: 20251210-kirk_v3-1-f3b2a12c0a32

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
