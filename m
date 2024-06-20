Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CADC2BA18
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 06:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C0DF3D0DBB
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 08:02:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FB033D081B
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 08:02:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A87A920EB26
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 08:02:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 971FC21AA1;
 Thu, 20 Jun 2024 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718863329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQHtxnfOsWGKQj97R/ReH82UizqPIazYKli9MGN51bY=;
 b=gU0USoEApEn7OXQYN8F1l6wu/DEiIciFg2vE5xOhSU9vkx7vgiINBA2X22otc5ps9T+zNq
 9UtUE/8bbjUylVKaVWS9WVWjbi8C4eGaIFI+1vujuI6eAKIE7TgkHhlT2Oiqnl3XVSqyHe
 /rR6YLkeLbkcfuulDq8XUs8CUdQWnPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718863329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQHtxnfOsWGKQj97R/ReH82UizqPIazYKli9MGN51bY=;
 b=ye2J4VSxnfAXMpW7QxOaYLw05NDvHPzxfFtM6Xt2e7AO5GFG3Zv2bM3ovjMclzqJJFLLW9
 MhZm7ka22xEGMGAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gU0USoEA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ye2J4VSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718863329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQHtxnfOsWGKQj97R/ReH82UizqPIazYKli9MGN51bY=;
 b=gU0USoEApEn7OXQYN8F1l6wu/DEiIciFg2vE5xOhSU9vkx7vgiINBA2X22otc5ps9T+zNq
 9UtUE/8bbjUylVKaVWS9WVWjbi8C4eGaIFI+1vujuI6eAKIE7TgkHhlT2Oiqnl3XVSqyHe
 /rR6YLkeLbkcfuulDq8XUs8CUdQWnPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718863329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQHtxnfOsWGKQj97R/ReH82UizqPIazYKli9MGN51bY=;
 b=ye2J4VSxnfAXMpW7QxOaYLw05NDvHPzxfFtM6Xt2e7AO5GFG3Zv2bM3ovjMclzqJJFLLW9
 MhZm7ka22xEGMGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7890113AC1;
 Thu, 20 Jun 2024 06:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y54IHOHFc2YSNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 06:02:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jun 2024 08:02:03 +0200
Message-ID: <20240620060203.558528-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 971FC21AA1
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test: Document @message, @scall, @sample
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

All undocumented members are in the library "undescribed",
better to document the purpose.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8dc20d110..20960e9b9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -428,6 +428,10 @@ struct tst_ulimit_val {
  *            can be set. May be executed several times if test was passed '-i'
  *            or '-d' command line parameters.
  *
+ * @scall: Internal only (timer measurement library).
+ *
+ * @sample: Internal only (timer measurement library).
+ *
  * @resource_files: A NULL terminated array of filenames that will be copied
  *                  to the test temporary directory from the LTP datafiles
  *                  directory.
@@ -642,6 +646,8 @@ int main(int argc, char *argv[])
 /**
  * TST_TEST_TCONF() - Exit tests with a TCONF message.
  *
+ * @message: Error message (the reason to skip test).
+ *
  * This macro is used in test that couldn't be compiled either because current
  * CPU architecture is unsupported or because of missing development libraries.
  */
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
