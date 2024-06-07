Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315ECC27C5F
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A8AD3D0AB4
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:25:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211BE3CFBD1
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4810E616620
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C326E1FBA4;
 Fri,  7 Jun 2024 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpOiMO4qlQdMNTQFARf9RHoS03JuONYEnMqujexpzKs=;
 b=QWePxkfZbfgqPIHg48YFwPXJSE/syJb39ffT44ReTLvvSOPOWl6GFR1eCcV+MlnGWYlLY+
 +6cBR1xxY6DwMgNiRd/wB1Kl6JsaYb2VWYPNs2EI5r2hrCXhN86m1MIvYG3OhOHCRssjPj
 Np1Sptk+JdAmPlBDdwZ+LwUTCaEQD8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpOiMO4qlQdMNTQFARf9RHoS03JuONYEnMqujexpzKs=;
 b=sPCMjN2sUK6bsmJvO81iHFA9Yk5zs5uZ2goNnHZl3BpKAil+qH8GrnZ9KlJDB+QyAMQaua
 8MM6wSIcRBXyqKCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QWePxkfZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sPCMjN2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpOiMO4qlQdMNTQFARf9RHoS03JuONYEnMqujexpzKs=;
 b=QWePxkfZbfgqPIHg48YFwPXJSE/syJb39ffT44ReTLvvSOPOWl6GFR1eCcV+MlnGWYlLY+
 +6cBR1xxY6DwMgNiRd/wB1Kl6JsaYb2VWYPNs2EI5r2hrCXhN86m1MIvYG3OhOHCRssjPj
 Np1Sptk+JdAmPlBDdwZ+LwUTCaEQD8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpOiMO4qlQdMNTQFARf9RHoS03JuONYEnMqujexpzKs=;
 b=sPCMjN2sUK6bsmJvO81iHFA9Yk5zs5uZ2goNnHZl3BpKAil+qH8GrnZ9KlJDB+QyAMQaua
 8MM6wSIcRBXyqKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D4AD133F3;
 Fri,  7 Jun 2024 14:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rcWlIB0YY2a0CAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 14:24:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 16:24:20 +0200
Message-ID: <20240607142423.116285-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C326E1FBA4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/3] Deprecate runltp (please use kirk)
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (3):
  runltp: Deprecate, add info about kirk
  ltpmenu: Remove legacy script
  doc/old: Remove man pages

 Makefile                         |   6 -
 doc/old/Makefile                 |  11 -
 doc/old/man1/Makefile            |  27 --
 doc/old/man1/doio.1              |  70 ----
 doc/old/man1/iogen.1             |  78 -----
 doc/old/man1/ltp-bump.1          |  80 -----
 doc/old/man1/ltp-pan.1           | 262 ---------------
 doc/old/man3/Makefile            |  27 --
 doc/old/man3/parse_opts.3        | 179 ----------
 doc/old/man3/parse_ranges.3      | 169 ----------
 doc/old/man3/random_range.3      | 114 -------
 doc/old/man3/random_range_seed.3 | 114 -------
 doc/old/man3/tst_res.3           | 313 ------------------
 doc/old/man3/tst_sig.3           | 141 --------
 doc/old/man3/tst_tmpdir.3        |  76 -----
 doc/old/man3/usctest.3           | 164 ---------
 ltpmenu                          | 548 -------------------------------
 runltp                           |  13 +
 18 files changed, 13 insertions(+), 2379 deletions(-)
 delete mode 100644 doc/old/Makefile
 delete mode 100644 doc/old/man1/Makefile
 delete mode 100644 doc/old/man1/doio.1
 delete mode 100644 doc/old/man1/iogen.1
 delete mode 100644 doc/old/man1/ltp-bump.1
 delete mode 100644 doc/old/man1/ltp-pan.1
 delete mode 100644 doc/old/man3/Makefile
 delete mode 100644 doc/old/man3/parse_opts.3
 delete mode 100644 doc/old/man3/parse_ranges.3
 delete mode 100644 doc/old/man3/random_range.3
 delete mode 100644 doc/old/man3/random_range_seed.3
 delete mode 100644 doc/old/man3/tst_res.3
 delete mode 100644 doc/old/man3/tst_sig.3
 delete mode 100644 doc/old/man3/tst_tmpdir.3
 delete mode 100644 doc/old/man3/usctest.3
 delete mode 100755 ltpmenu

-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
