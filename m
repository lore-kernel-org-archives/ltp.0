Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2692C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4957B3D099A
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 16:41:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A87803D0981
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:18 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03C6E10189A7
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C31B219D0;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UuOuqNVILg97C+CdNJAbocjC3KK7PLmvkqA2N9ypy7g=;
 b=B1dwYmArzlIDkCNjPJte7AibA54RcRAE0j9h6cdO/rcJT7jkNhE8sjc353bG14rZWFaWKm
 YCIgBF5fCE9DZB3kYl5wOU+DKWMxZhWmHEEgA/3PfhSKRvCQ2YEAiuUIpBLf6HgNeJcip+
 VZOY2RpKJkLeqRI7nJQerpMT46EItj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UuOuqNVILg97C+CdNJAbocjC3KK7PLmvkqA2N9ypy7g=;
 b=aMRB4dx2UDTpwAM2wS5HnkFqKeeCcHm0DBoY1yz9Xt1K/WxULuQJ06/HOpS90MwwpiXeSU
 fqI7kGfxl4OuKqBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0+s/I4IX";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TrIRmcBY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UuOuqNVILg97C+CdNJAbocjC3KK7PLmvkqA2N9ypy7g=;
 b=0+s/I4IX9+WD2DRwm8B/2oToDyvADTE2FiiWT57zLkYiQEJMKPD1Mz2JNBUi/fr4U2f1Y1
 sNMi2mIeGEnnbh/mcfIIWt8PKZRRe0ivr/Oz0ROlBvKnkGLsk7xct33a+i3hawRkEO35SY
 RX6bQ0tjBAPbxceooL3Ayxvtfruc1r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UuOuqNVILg97C+CdNJAbocjC3KK7PLmvkqA2N9ypy7g=;
 b=TrIRmcBYkLOp0E2/abQToT0L7WisqulSALrJKwvfxO5nriqhtDCv0rrdHsJOlnyv6OBK+d
 VnUSYm65si/5qeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 369A813A42;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PiEODAt5YGY/NwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Jun 2024 14:41:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Jun 2024 16:40:37 +0200
Message-Id: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOV4YGYC/23MQQ7CIBCF4as0sxYDSJS68h6mCwuDnahgGEs0D
 XcXu3b5v7x8CzBmQoZjt0DGQkwpttCbDtx0iVcU5FuDltrIvTRijneKN9kL74yVOtiDDj20+zN
 joPdKnYfWE/Er5c8qF/Vb/yBFCSV88BZ3qNyoxxPPjFuXHjDUWr+NzEBnnwAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=1ikCOTjCvdZadTce/WlujuSe1281KaTcyMG9UeDx6vc=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYHjt200ERjlFVWAECo0qqek3LSEI2rImBqB5a
 bBt+BHqifCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmB47QAKCRDLzBqyILPm
 RpMVC/9+oN5jPLDnyjHpXnXM6GC6YvmAo3SWFEb8OWCFxEDWO1IgOhWwQRa0wnWEnKf2ahJn1pT
 XZZsTCZn/tAbT+OJotfHnJigkthrSdSPp91mTGUIqUO4Kjv7Lgp+LThHhMrktD5BjEwerAjlWJr
 PnlEhlV3JUKcZsetFOgRHSV66L0UEyFCoQpz/SapFCeyrF+6o+tFhj+p5pIzbJ5wR3HFGIwCW1L
 j0I6Tk9RqivuhFzfKrKCx2JwfzmZh4Bj9N+IDB43VJRfIlhk/d6B7CVmAAGS6hB8Z+njjyVgnXX
 hvVKFowGJsRxizZL9ZKhspfPidSWwFtcXcriJvhn5egXrDo9JIDTzP89BIMiZwXJyFo/sg8Ofxw
 5ElTAoBdLfOiQOq7TWenSmij2H7OLrkI1b+GyfPzhrO5H/Eq9iFh9YgYNNUeWS4WjEOxaUSl8DA
 27SRBGCj79BBH6PbrXhL1R+fVRhy18Ru2xOaJgu6Te87XrF6iSR0MBDUAm1zQ6Lcd0VEc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4C31B219D0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Fix unlink09 test
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

This will fix the 2cf78f47a6 and resolve issues on filesystems
which are not supporting inode attributes. Split unlink09 read-only
check and move it into unlink10.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- moved read-only FS check out of unlink09 and created unlink10
- check when FS doesn't support inode attributes and print a TBROK
- simplified inode attributes setup by adding a common function
- added .all_filesystems support
- Link to v1: https://lore.kernel.org/r/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com

---
Andrea Cervesato (2):
      Fix unlink09 test
      Add unlink10 test

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/unlink/.gitignore |  1 +
 testcases/kernel/syscalls/unlink/unlink09.c | 94 +++++++++++++++--------------
 testcases/kernel/syscalls/unlink/unlink10.c | 33 ++++++++++
 4 files changed, 85 insertions(+), 44 deletions(-)
---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240604-unlink09-dc4802f872f9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
