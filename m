Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F2CA5FF0
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 13:03:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18FE83E4B91
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 15:03:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B416B3E4A17
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D6A910006CA
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 687B21FB08;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H7ts8+NLBD5wRpuYIINzNHz6s8qS6PrpKA6AmhFfN+Q=;
 b=wJzm4AWTt9+mzWSQQNuQsVRB9+5UqBC211IKNQhHr0pt6cRZSDVrn8M4mx44vGWGpXm73r
 WnbRD1lF42cxKxJ3qBR3YEJwGjugJReVwBWTYVb3aKfbEBJzx1No3+aI9xf9sh/lgIYVGO
 euf0+HEJq+MP/0DlgjJNFkUpJ0Nh0cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H7ts8+NLBD5wRpuYIINzNHz6s8qS6PrpKA6AmhFfN+Q=;
 b=oYmROahDBLdGH9SNkWzr9cPBh8i8I7u4QEVBG7Ay9aXf5ttimdAJCaS71ofZhTTYvYub//
 fPurr1iHIOS7aaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H7ts8+NLBD5wRpuYIINzNHz6s8qS6PrpKA6AmhFfN+Q=;
 b=YxM7+VyMbAMpb2SZZi94elpBhLxfgs7vCaQXxvD7wGxbdo2LXn7QsJI7nidkX9hT96mDpk
 3HS89dm8w5zmzx4bu9z9nD9RxHFl23ikG5CmB3vk1vS7qSk7f4VR20G7WfTPYbHSqnvYY6
 fQ+eaDrz9jLvCgC87AQjYJFmFs0sZd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H7ts8+NLBD5wRpuYIINzNHz6s8qS6PrpKA6AmhFfN+Q=;
 b=LiIQTbK7j+v8sKlEDULMeJI0D8yxm2Y4sYMvkxPuqKT369r3uaOMPeDHCxaPxDzpwdj9RX
 JPWPGN4ny+HhK/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DBB0133CF;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGTTAG/xxGqLRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 06 Oct 2026 13:02:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 06 Oct 2026 15:02:36 +0200
Message-Id: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGzxxGoC/yXMWQqEMBBF0a1IfRuIoVFxKyIhQ6klTqSMNIh7N
 3Z/HnjvXsAYCBma7IKAJzFta0KRZ+BGsw4oyCeDkqospCxFT1/NtOwzahsH1m4LqGeyQrnK16b
 /mEp5SPc9YNr+0m33N0c7oTveHtz3A2fpdzp8AAAA
X-Change-ID: 20261006-fix_simple_bugs_core_lib-2c7d8af4a72d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791291759; l=1190;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pimIlJWmQKDlaLKg+w3E5qBCxud03sFyCcYtUeHcE2U=;
 b=v12UXdnZIu2/Ukq1ve9aH0SXZcrVel8RZNdVx8Dx1aIX3G+9wzOf9uTTIScI6TYPsz1crayg1
 dcYdtss5I8zCm+rXJkQBM3KLey7U22bHDcI2OWJijzDOq+Xa1Glh6zs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Fix various minor bugs in core library
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

This series fixes three small bugs discovered in the LTP core library:

1. tst_timer_test: Check array bounds before accessing samples array in
   do_timer_test(), avoiding heap out-of-bounds reads when all samples
   are outliers or early wakeups.
2. tst_memutils: Use proper half-open interval overlap check in
   tst_mapping_in_range(), correctly identifying enclosed mappings and
   avoiding false positives on adjacent mappings.
3. tst_kconfig: Stop scanning at string termination in
   kconfig_parse_line(), avoiding stack buffer overreads when config
   lines do not end with whitespace.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      tst_timer_test: Fix out-of-bounds array access
      tst_memutils: Fix mapping overlap predicate
      tst_kconfig: Prevent stack buffer overread

 lib/tst_kconfig.c    | 2 +-
 lib/tst_memutils.c   | 6 +-----
 lib/tst_timer_test.c | 5 +++--
 3 files changed, 5 insertions(+), 8 deletions(-)
---
base-commit: 78e6353fdff663b2fc2f77704ceec6c3ca786b96
change-id: 20261006-fix_simple_bugs_core_lib-2c7d8af4a72d

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
