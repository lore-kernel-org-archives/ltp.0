Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11BAC61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:55:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4A8C3D753B
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:55:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E2CE3D666E
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 381BC1A000B5
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBC9121C14;
 Thu, 27 Aug 2026 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gv6emOXx1BcvcBvQAL10HY5nBmXXCLx7GQOodIbYWiw=;
 b=lxNy9b/fsHzqscxkRh7TI0z7uJI6ucetcr7fWPgA+m4LOokLAiW9RS2gQC95SalMZYd1GM
 C6cr+e2+uX8EVqzjHSOYnqHuMGjdbG7HcjVV8czXiqqAFJweJjpYJFI+v8cQSBQR/Z84CY
 +t8s6hPXEEKwFYxGfJ2XMq6YO4Q4w4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gv6emOXx1BcvcBvQAL10HY5nBmXXCLx7GQOodIbYWiw=;
 b=XEYPkY9P8R4BFPH3eRLtnLcb1qmadkUcAIKS1Xw6u1MZJDatI3zu3fls4HPPIbC3Re/2KX
 TzPjuF6nZFtoLqDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gv6emOXx1BcvcBvQAL10HY5nBmXXCLx7GQOodIbYWiw=;
 b=KFxFIfqOkMrqxKkeY4e6oUewoB23eTrXltJLSB3wwDC2/VkQth+AXtoBItIdFvgrtca5Gs
 My4aENgMHXhdIsFM8baEx2KP0R62ZbciRLZ8by1wMNgNhADXnyTyYwb+Ii23nKH1eoWjPa
 tmauktyiQKwcJHqlruj/Wj6xYBv7VfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gv6emOXx1BcvcBvQAL10HY5nBmXXCLx7GQOodIbYWiw=;
 b=32sc3qQim1hVLq/qYiTl7iHljmfzknkH5uNivEKMzUD2ic/LWoiuJ58BoAjWJQJ68JAnLh
 Foseey5UKEZqquCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C39501352C;
 Thu, 27 Aug 2026 11:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /UMSLmIlkGq6DAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 11:54:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 13:54:03 +0200
Message-Id: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFwlkGoC/yXMQQqDMBCF4avIrCtorFG8ShFJJ2MdF4nM2LQg3
 r1pu/zgvf8AJWFSGIoDhBIrx5BRXwrAxYUHleyzwVTGVr3pSn25LYbJs6ITP2FMJC7Pmmtva2+
 bGdsW8nsTmvn9K9/Gv/V5Xwn3bw7O8wPkIDP9ewAAAA==
X-Change-ID: 20260827-swapon_discard_coverage-34861d63fc55
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787831650; l=910;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=0w+V+bLJt8usz5BQElvC0fKOSRLOaEdYVHcm3d8QutE=;
 b=q3ALYilCD43upP8tSWWHH1wvuW4maFAiPAOOA26pUmro9TliIKiOrFyuUCKBX8jV3flf9p6J+
 sD2rOMuPRKoDL1zXjlNGy1GYdmrlQ6qsLVXg1zDhpGdnSdvtJARW9sI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Increase coverage for swapon syscall
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

Complete the EINVAL coverage on invalid input data and create a new test
to verify discarding pages functionalities.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      lapi: fallback definitions for swapon syscall
      swapon04: Add test for discard flags
      swapon02: Add test cases for invalid swapflags

 include/tse_swap.h                          |  16 +++
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/swapon/.gitignore |   1 +
 testcases/kernel/syscalls/swapon/swapon02.c |  58 +++++---
 testcases/kernel/syscalls/swapon/swapon04.c | 197 ++++++++++++++++++++++++++++
 5 files changed, 257 insertions(+), 16 deletions(-)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260827-swapon_discard_coverage-34861d63fc55

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
