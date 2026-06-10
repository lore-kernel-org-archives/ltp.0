Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2439CD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 17:07:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E1543E6EA5
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:07:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 789F43E5E99
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:07:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9B991A0064E
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:07:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6EAB759E1;
 Wed, 10 Jun 2026 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781111225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FF6OdR1lPat37rkDoLOkGyC658fe1b3ZvpudoGAp21c=;
 b=JQN9Su8r6HBvieVAwvymoop4yOJLYjijqPckDWHW6KPHEKvpyFq7YN3tUPWFduerT4dUrQ
 qLkyYH/gfFmBVrs/DnEacCaVN9s69mACyrIQ2amRyMRNBe4aP9XgF5skslHAtpUWB15rnP
 z9eJeJ+Gz7+QboOwTMdP/EkoqwXzht8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781111225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FF6OdR1lPat37rkDoLOkGyC658fe1b3ZvpudoGAp21c=;
 b=kYJ3n+joipABQeMkBELFNScPRNFgXkhmvl5WbTVf4PSYmaIYBXXYeZPkHvPMNxR3V2YJmP
 XavQ0Ud0j88soMDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0h3ZjHmI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VBAw/vDB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781111224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FF6OdR1lPat37rkDoLOkGyC658fe1b3ZvpudoGAp21c=;
 b=0h3ZjHmI77+I5fNOMYjFRF/qiql0JjPgtxUFA1x6wBHleTeMg76u18uSp6G3xK0mBONbi6
 nPv1vEray76S4WgsL83mXLh2itx7PcJ1OfzjKxr8eDlg4afD8oJu0WagyRPMLi1mJRnxg8
 z1aR182C1LdAfi1k9kp5BFtzwotW0ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781111224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FF6OdR1lPat37rkDoLOkGyC658fe1b3ZvpudoGAp21c=;
 b=VBAw/vDB6Xbb1lxWPFgDAPbKOeGNojqsgDrrLk0CU6RDvIgCgkTv9YSO5s9V/DL4+AH5ZO
 /NN5WYeDev+Py1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C88A4779A7;
 Wed, 10 Jun 2026 17:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YuHfLriZKWrIAQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jun 2026 17:07:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 19:07:03 +0200
Message-Id: <20260610-fw_load-v3-0-eef32edfe8d5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALeZKWoC/3WMwQrCMBAFf6Xs2UiywZp68j9EJE02NqBNSTQqp
 f9uWkS8eJzHmxkhUfSUYFeNECn75ENfQK4qMJ3uz8S8LQzIseY1b5h7nC5BW4ZKIVeqJaMIynu
 I5PxzKR2OhTufbiG+lnAW8/ppCP5tZME4s66xUkmxIan26Z5obcIV5kTGPxoWzRldO61RbnX7o
 03T9AY2I0OW1AAAAA==
X-Change-ID: 20260609-fw_load-2882088bec8e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781111224; l=2096;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=5YS34CPtkgIil8+Z5LMSHdLI8EQY7wWkgahsr6r4LbU=;
 b=MxPOW19MPswQnJThqIFDG0rVdrT70W/iFUKRM7btpkEhaOkM4eRLXr8S+ch+4bWwVUY5/UpaD
 thlUgxtW4GsAkQcNA3dQYggQjBX57P0CUFyG7EpCsVgzROEQM3OwToo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6EAB759E1
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Rewrite fw_load test using new API
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

Support immutable distribution by splitting test in two:

- fw_load01 triggers request_firmware on /lib/firmware (read-only on
  immutable distributions) and it doesn't support read-only filesystems
- fw_load02 triggers request_firmware on custom path (always supported
  by any distribution)

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- fix bisecting
- fix algorithm op order
- Link to v2: https://lore.kernel.org/r/20260610-fw_load-v2-0-fca6faa237ab@suse.com

Changes in v2:
- fix fw_load.h define
- fix Makefile copyright position
- fix year in the firmware file
- Link to v1: https://lore.kernel.org/r/20260610-fw_load-v1-0-df9d38315e38@suse.com

---
Andrea Cervesato (3):
      fw_load: Modernize ltp_fw_load kernel module
      firmware/fw_load: rewrite firmware loading test using new LTP API
      firmware/fw_load: add fw_load02 for custom firmware path

 runtest/kernel_misc                                |   3 +-
 .../{fw_load_kernel => fw_load}/.gitignore         |   2 +
 testcases/kernel/firmware/fw_load/Makefile         |  25 +++
 testcases/kernel/firmware/fw_load/fw_load.h        |  18 ++
 testcases/kernel/firmware/fw_load/fw_load01.c      | 162 ++++++++++++++++
 testcases/kernel/firmware/fw_load/fw_load02.c      | 144 ++++++++++++++
 testcases/kernel/firmware/fw_load/ltp_fw_load.c    | 178 +++++++++++++++++
 testcases/kernel/firmware/fw_load_kernel/Makefile  |  35 ----
 testcases/kernel/firmware/fw_load_kernel/README    |  16 --
 .../kernel/firmware/fw_load_kernel/ltp_fw_load.c   | 164 ----------------
 testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
 testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
 testcases/kernel/firmware/fw_load_user/README      |  11 --
 testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
 14 files changed, 531 insertions(+), 461 deletions(-)
---
base-commit: c1b71bf7ebb6a58507e4998faf5c74154f595f96
change-id: 20260609-fw_load-2882088bec8e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
