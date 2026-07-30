Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F40DC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:06:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8503E744D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:06:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C9B13E2D30
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBC376008FD
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA44B7DAA6;
 Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zk60V9CrAu0qTy9mVMOsUfciUp0dIkJbImW0G3sxeXo=;
 b=LK5eAm7OYTjWCn3wZdTsh3heUlbbFDgAvrh8669iIhQoHToqzsTmEo3fGqROzmCKEb0Nv7
 3AkQx8JX6KfogKobBcMNFI96ppqe52TjWaRwsWsgvMJ/iIodC/p8tjlJ2zuutzeVyfY3PR
 4ju1hcB7IvXJ4e8JT29Q8E35GoVcWMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zk60V9CrAu0qTy9mVMOsUfciUp0dIkJbImW0G3sxeXo=;
 b=nAT6VeyYCmR91jYq9UP18a4yzukEIuPh0hEesEuIW7W3FvBmx7BndJDu89XEq7Oz/Nbmsr
 U7ZIRHwvJrZ4GDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zk60V9CrAu0qTy9mVMOsUfciUp0dIkJbImW0G3sxeXo=;
 b=XHNY3WavZG20SCyfp6tzVMZdgE2uLTIbYl+f5Ol6KTfOjkRIPnumxGrPtq4poswNFeEtYd
 En0PRyKh0eBcXXUHGPdkLPCWHPx/ElrH6iip76nztgfjXjXTU7JZUnW7Ua6IfEGe9VQQ/v
 x/N8MrI/G7jWmYkHg1wJoFL84oRjJ+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zk60V9CrAu0qTy9mVMOsUfciUp0dIkJbImW0G3sxeXo=;
 b=332xH0nEjgLeJ86vX2fJjDdzx4hMSSQdRY+jibsdHDWUveJLmy+CoEuiLy6YFLZGC0YGCx
 EDWnrVyhBsE6glCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1DA1779CC;
 Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WjvhKRNMa2qATQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Jul 2026 13:05:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Jul 2026 15:05:22 +0200
Message-Id: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABJMa2oC/4WNQQ6CMBBFr0JmbU07YEFX3sMQAjjaJsCQTiUaw
 t2tXMDl+8l7fwWh4Engkq0QaPHieUqAhwx6105PUv6eGFCj1aXJlTgahoZ5bObAkfqYBGURTdt
 VeELUkNQ50MO/9+ytTuy8RA6f/WUxv/VPcDFKq67MkSpblNW5uMpL6NjzCPW2bV+dIdjltwAAA
 A==
X-Change-ID: 20260713-shell_oom_protection-6221ab825220
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785416723; l=993;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=cirsr0yD9qnUFoB1mMfvirrB6iLbqB5WKloCbyI4ihE=;
 b=DnH0uSpnF0O5Di5ksFpbmQE/O/P6oXJhEXCGDsL9zuQB4xSvEDXO6N/K7wQdprnpf+EZ9KkfX
 6qZZ1VDP2qSDp+WG1kvK46jmqi+CQnQhE31sJZ9DpumUvqC6uDj1Jw3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] OOM protection for shell tests
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

Under Li's idea, implement a OOM protection mechanism for the shell
tests so we can avoid OOM for memcg stress tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- update shell OOM protection functional test
- Link to v1: https://lore.kernel.org/20260713-shell_oom_protection-v1-0-b732e8647894@suse.com

---
Andrea Cervesato (2):
      shell: add optional OOM protection
      memcg_stress: survive OOM by targeting the stressors

 doc/developers/writing_tests.rst                   |  3 ++
 .../controllers/memcg/stress/memcg_stress_test.sh  |  1 +
 testcases/lib/tests/shell_oom_protection.sh        | 42 ++++++++++++++++
 testcases/lib/tst_test.sh                          | 57 +++++++++++++++++++++-
 4 files changed, 102 insertions(+), 1 deletion(-)
---
base-commit: 4918812af24a0e06fa3a9ba6da2679cfea1f2126
change-id: 20260713-shell_oom_protection-6221ab825220

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
