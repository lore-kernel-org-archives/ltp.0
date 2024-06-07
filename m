Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EC7C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:39:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB6033D0A97
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 12:39:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B080D3D0A82
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 12:39:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0838F60FB23
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 12:39:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEFC321239;
 Fri,  7 Jun 2024 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717756746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnwjyuyLozSeFd+q45aLfVkz+sceklnI53p+gKU1Wmg=;
 b=PtW3Qu612HjQ0oXq+9Am6BXlvr1ahlfFQkDApQvi1GV4PEckvX8Qk+dU9vOL1PotQsoY9b
 XEhFIqQXsckJd+VIl4WrLwGAxmtIIr2dgpUjCka/NAvOOrSacg2YRfk7h29sM27QJEOLR+
 xnmqcUYfGKQU93sjBsCSUoKeCfP6bRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717756746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnwjyuyLozSeFd+q45aLfVkz+sceklnI53p+gKU1Wmg=;
 b=gphtioaR0mCWfeYnrf4XCgXpZVo1LXgl46rUwCd/J1bRsuH9RW5zUEZBF7vW3cnQBAFr7l
 gIemB1qi2SdmIYBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717756744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnwjyuyLozSeFd+q45aLfVkz+sceklnI53p+gKU1Wmg=;
 b=wDfZLAXtgZBdY/u+3erWzJhvFMF+0JWB7ipJnmyTqZwCIrKbLpOwVD0q5/ihYFAsCfDi6o
 k0EWQm6D7VPqqDatleb0J/AweS3o0YhyESp5KVe9JhH5YKWLmLFJ+Xl3bAaPjDpvbwmyly
 bJwk7G/QYVlXQQw1DQqMbOfRRo6h/zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717756744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnwjyuyLozSeFd+q45aLfVkz+sceklnI53p+gKU1Wmg=;
 b=ulIVy8mizsFpAh5f0VnTQwjaK015P6WurJcpQyhXQI9PJE8RcBav4dyH37xrE0JvtdESfH
 8Z93R+Sm1XdZGKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1A9133F3;
 Fri,  7 Jun 2024 10:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bsoGKUjjYmbxOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 10:39:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 12:39:02 +0200
Message-ID: <20240607103902.76903-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test: Document @scall, @sample.
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
 include/tst_test.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8dc20d110..63f707834 100644
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
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
