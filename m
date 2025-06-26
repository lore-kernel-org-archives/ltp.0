Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CA9C7EE30
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:35:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B21703CCB95
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:35:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 728FE3CAB13
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 793ED6008D6
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5443211A7;
 Thu, 26 Jun 2025 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NE0rST/CyOwyO/mzSeLD7d7ISsOE+olkk7MttQx0pak=;
 b=fqSAuQiUVqWAZ23bq3dYLCwGchyU+mCmOgEZtlSUY2qOwjUKm3k+wn8zieMEFR1bb9Lc5a
 lQ9Nu1W2YC5b01pgvkJey+PMkXCRyv1f+UL/TjMIEkgkN/7QAUBMVErpNwyA0g7qlQPJZh
 c98yr4dzx4tmZmKUiSd1ODsqdn5XbM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NE0rST/CyOwyO/mzSeLD7d7ISsOE+olkk7MttQx0pak=;
 b=mW5bwaJ0/ToTH3F5axP6vI1Yufudfsn0OfvHE6xPH6b3niBNYCuLBvft2LPV80P8D8X2Yv
 Y1qVbFMUt/DtqKBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fqSAuQiU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mW5bwaJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NE0rST/CyOwyO/mzSeLD7d7ISsOE+olkk7MttQx0pak=;
 b=fqSAuQiUVqWAZ23bq3dYLCwGchyU+mCmOgEZtlSUY2qOwjUKm3k+wn8zieMEFR1bb9Lc5a
 lQ9Nu1W2YC5b01pgvkJey+PMkXCRyv1f+UL/TjMIEkgkN/7QAUBMVErpNwyA0g7qlQPJZh
 c98yr4dzx4tmZmKUiSd1ODsqdn5XbM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NE0rST/CyOwyO/mzSeLD7d7ISsOE+olkk7MttQx0pak=;
 b=mW5bwaJ0/ToTH3F5axP6vI1Yufudfsn0OfvHE6xPH6b3niBNYCuLBvft2LPV80P8D8X2Yv
 Y1qVbFMUt/DtqKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56850138A7;
 Thu, 26 Jun 2025 12:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QyRoE2g+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:37 +0200
Message-Id: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF0+XWgC/x3MQQqAIBBA0avIrBNsyoKuEhGiYw1EiVYE0t2Tl
 m/xf4ZEkSnBIDJEujnxsRfUlQC7mn0hya4YUKFWHXaSD3tuc2Dn3ZwuPkk2iMZg02vbIpQuRPL
 8/M9xet8P7/ebKWMAAAA=
X-Change-ID: 20250626-ioctl_pidfd_suite-322aa2375c42
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=1301;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=9bGVrBxhgqTW5Cnf6DW2InZIOyPT/rMoJ07L/bx5GaQ=;
 b=51iYqBxZiXU8C++N9NgUrAcXG3JPyJSXOeiQkEn3xOWIZtNuSz2qyIq9+OI2EHbG2Ww/C4dgc
 WfikEVVvLWxCWEYP2aCo9BaLKRqlom+ywCSzlYos/B4vJD6Nam2vg6i
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B5443211A7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] ioctl_pidfd testing suite
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

The testing suite has been created to cover the new feature
PIDFD_INFO_EXIT provided by kernel 6.15.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (6):
      Provide pidfd parameter in tst_clone_args
      Fallback PIDFD_GET_INFO related definitions
      Add ioctl_pidfd01 test
      Add ioctl_pidfd02 test
      Add ioctl_pidfd03 test
      Add ioctl_pidfd04 test

 configure.ac                                    |  2 +
 include/lapi/pidfd.h                            | 37 ++++++++++++++
 include/tst_clone.h                             |  1 +
 lib/tst_clone.c                                 |  1 +
 runtest/syscalls                                |  5 ++
 testcases/kernel/syscalls/ioctl/.gitignore      |  4 ++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 62 ++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 50 ++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 68 +++++++++++++++++++++++++
 10 files changed, 288 insertions(+)
---
base-commit: 0c99c7915f029d32de893b15b0a213ff3de210af
change-id: 20250626-ioctl_pidfd_suite-322aa2375c42

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
