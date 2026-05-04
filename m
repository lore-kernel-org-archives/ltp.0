Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B99ECD3423
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 08:07:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4063E2C86
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:07:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 979AC3C4C09
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AAA960074E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E39A66A93A;
 Mon,  4 May 2026 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzrNVROQLaN4v+TfOOUgljqxK6D/ZysfiY1u6fBGAZk=;
 b=0Eu93CzSpmn8dFn6X87irI+S4IzWKAOqOLaVI9LRhHK+6Spp8+66C2Vl0nQrpK2KIYseMj
 TrWsjeoyJ+LimYJ15l/co47crmG0rk09HRDtZgeIUCQqFoO+6r0ipuLZggEhzQ6Blp0Gmo
 sVaW7YoRrfQ3MIH7auUWYSqG+Hl78M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzrNVROQLaN4v+TfOOUgljqxK6D/ZysfiY1u6fBGAZk=;
 b=rkp/AH+vGpgZJTqsqwaMvbSrm2SI2aC6xjhH9Vb4SGnrtNghG0N/bgiQJnIDIgXocf/XVP
 Ysb56esVV1o2geAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzrNVROQLaN4v+TfOOUgljqxK6D/ZysfiY1u6fBGAZk=;
 b=2Fus2qmCSWQQ9wCj9ZicgPGK1hRJ0KVF9kJdNizjPbscNMnCaxy3Ic3qmR6//PIA6uXVGD
 dAavRhBxFnNUOM5AU6jIVfY9ffE8ENYxHWv94a3WphJ5pIi5AyzAxuL2N4/RGFTiAupONE
 CKEUsyaTFvY4s2tZ2bjuKRfNYDP7ItM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzrNVROQLaN4v+TfOOUgljqxK6D/ZysfiY1u6fBGAZk=;
 b=V24X+pXCkXIlcgMs+nqrYgu7lqGbyJAfbwv9/uJ3Cb6gPQUSMCIXfCp/Whq8FUvAxmF6HM
 2x9PZiXBBy0qa5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA0C593A3;
 Mon,  4 May 2026 08:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLwyMJBT+GktTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 08:06:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 10:04:53 +0200
Message-Id: <20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACVT+GkC/23MywrCMBCF4VcpszaSSynEle8hRUIysQPalIwGS
 8m7N3bt8j9wvg0YMyHDpdsgYyGmNLfQpw785OYHCgqtQUs9yN5IwS7inZcneRTOhKGXJlrrA7T
 HkjHS99BuY+uJ+J3yeuBF/db/TlFCiqCCVTZG7Yy78ofx7NMLxlrrDgrJokGlAAAA
X-Change-ID: 20260430-safe_splice-a3d6403f99cd
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777882000; l=912;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=S/GqcAXwfk+VtBMjFdQRsWkfwGsTGDsuonuaCuNduGg=;
 b=h+1x1cCxAC/LUJOQVD2rSUBSfoVYM+NRkAyJo8PaugEFiXYjUTUWXIDQLcHA+f0Qb4I2LyZyc
 WIl6Q6KktFdBMP4KKECuWOYeFglM+5v22oZjCngpt5ZWiwGc6HZhOLt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Introduce SAFE_SPLICE()
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

- add SAFE_SPLICE()
- update tests to use the new macro

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- fix compile issues by moving SAFE_SPLICE in lapi/splice.h
- Link to v1: https://lore.kernel.org/r/20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com

---
Andrea Cervesato (2):
      lib: Add SAFE_SPLICE() macro
      tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()

 include/lapi/splice.h                           | 28 +++++++++++++++++++++++++
 testcases/kernel/crypto/af_alg08.c              |  9 ++------
 testcases/kernel/syscalls/tee/tee01.c           | 10 +++------
 testcases/kernel/syscalls/vmsplice/vmsplice01.c |  5 +----
 4 files changed, 34 insertions(+), 18 deletions(-)
---
base-commit: 72ca484cca53710b956ba2fcc1ff203fe9c9b73b
change-id: 20260430-safe_splice-a3d6403f99cd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
