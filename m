Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907FCCD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:53:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBA083E56D1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 119CA3E4B69
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8003B1A0064C
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2A906B89D;
 Mon,  1 Jun 2026 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=phKbVqehAUf+6ugdK/zvq1q/sKG3Z4vu6o0K7vEssiA=;
 b=CJnFU7jsvwzIT33VMeIcI7uEAvJY1hVbY6e32ka+rFBw5zratWWCQyDQAn3JY/y8JvYB/i
 KBiEh9xiQBrOmLLWS5DZTtlx2pF9+ooyvXkl+teEINrNPIkt0Hgr/JQzKfgVJwx5T1a10h
 SBCwpGToctur6s2QntVJUixfbVPvYN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=phKbVqehAUf+6ugdK/zvq1q/sKG3Z4vu6o0K7vEssiA=;
 b=i9jfbUmG/NVh6nWgQq4wOAlYbq+o1ELGs7c3JXNXcBHC9ViNRqSvn7fmApCO2u2o40qUgy
 V2X4AjPiTLJTvyAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z5p80INy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6tVd4NS7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=phKbVqehAUf+6ugdK/zvq1q/sKG3Z4vu6o0K7vEssiA=;
 b=z5p80INyDgPgAbhVRroZK1jvWy46/KWvhI+X+eAX3dIpPoXLtSrWoW1RhUFujGqshwNa0v
 xu8oRCq4kz2LupFzbDfdeFKAUotEstJ0YnytJIWD9kdzFtFGo+gEKgXIUqZR+eHzWQ9Oy5
 rb2YEMODgtUiqKzVtdd3szEOfrXAi+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=phKbVqehAUf+6ugdK/zvq1q/sKG3Z4vu6o0K7vEssiA=;
 b=6tVd4NS7Yd0WckmXQBDL0ez1l7usfEKWEAz9heNSY+YV9kpQvWMVi7WbViZU8FKYqenFld
 Mr5KWdPjL4FNoIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95EA5779A7;
 Mon,  1 Jun 2026 09:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7p3+InhWHWrqZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 09:52:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 11:52:53 +0200
Message-Id: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHZWHWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwND3ZT85PjSgpTEklTdRGPDVLNEM+MUI/MkJaCGgqLUtMwKsGHRsbW
 1ABnR0yhcAAAA
X-Change-ID: 20260601-doc_update-a31e6a63d27b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780307576; l=1846;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=GKRTbOJlkJAntWrUNADgKcJ3lxBqRnS6nGWWhToZ6sY=;
 b=fDARdeHU1RrC77b1ju35KmIjTXrqdi+nV0ATZoao2Y3YxQcofSBSU6Tq1LcmTqaegSN0bwfCw
 jv0mnCMlSGuBpCX3O31nDh+9L+RKhvSnlgnMAAMO39RkRpKAmL9geo1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B2A906B89D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Fix documentation issues
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

- fixed typos in the text
- fixed warnings during build
- fixed errors during build
- fixed incorrect struct usage

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (4):
      doc: Fix broken references and outdated content
      doc: Fix typos and grammar
      include: Fix kernel-doc warnings in header comments
      doc: Fix incorrect struct tst_test field references

 doc/developers/api_c_tests.rst            |  2 +-
 doc/developers/api_shell_tests.rst        |  4 ++--
 doc/developers/build_system.rst           |  6 ++---
 doc/developers/documentation.rst          |  6 ++---
 doc/developers/ground_rules.rst           | 16 ++++++-------
 doc/developers/setup_mailinglist.rst      |  2 +-
 doc/developers/test_case_tutorial.rst     | 23 ++++++++-----------
 doc/developers/todo.rst                   |  4 ++--
 doc/developers/writing_tests.rst          | 38 +++++++++++++++----------------
 doc/index.rst                             |  2 +-
 doc/maintainers/ltp_release_procedure.rst |  6 ++---
 doc/maintainers/patch_review.rst          | 12 +++++-----
 doc/users/quick_start.rst                 | 10 ++++----
 doc/users/setup_tests.rst                 |  2 +-
 doc/users/supported_systems.rst           |  6 ++---
 doc/users/testers_guide.rst               |  6 ++---
 include/tst_capability.h                  |  2 +-
 include/tst_cmd.h                         |  4 ++--
 include/tst_kvercmp.h                     |  2 +-
 include/tst_test.h                        | 16 ++++++-------
 include/tst_test_macros.h                 |  8 +++----
 21 files changed, 87 insertions(+), 90 deletions(-)
---
base-commit: 5ccf816f5d0e6c0ec3d808be456dd9ffa2a7736d
change-id: 20260601-doc_update-a31e6a63d27b

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
