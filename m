Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA1AC04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 12:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463203CF2F7
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 14:09:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 042963CE1E4
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:15 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B2D9B14010D3
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B76A5FE0F
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wFAFraOGRZoSfjjbB9LswKAmarT4sd7g6wGm2CAxK0=;
 b=ZiZ0p3O/qQvwvJdxB1Jo3jR3qmUTRDpTRmnAa4CHJ1gFhYZUerm+IvCZl6s75dzGSUTjTn
 B56MbIMY+HcvVRzvPH+z853QHpvBrJFVIRb6paQSe61rKhqabr1D1fKz/zLd+xIqPfD+V/
 ntsfiWqnQGi+eOxUUwOhUPQFH3SKOhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wFAFraOGRZoSfjjbB9LswKAmarT4sd7g6wGm2CAxK0=;
 b=HswGVYhXbrbdNlzVh3NYUjdH4OE5lDiRLOC0gadik2+peZrC97hC44J4gJ6xwF/zZE7TWn
 xvFx/P2gI4M7FSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wFAFraOGRZoSfjjbB9LswKAmarT4sd7g6wGm2CAxK0=;
 b=ZiZ0p3O/qQvwvJdxB1Jo3jR3qmUTRDpTRmnAa4CHJ1gFhYZUerm+IvCZl6s75dzGSUTjTn
 B56MbIMY+HcvVRzvPH+z853QHpvBrJFVIRb6paQSe61rKhqabr1D1fKz/zLd+xIqPfD+V/
 ntsfiWqnQGi+eOxUUwOhUPQFH3SKOhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wFAFraOGRZoSfjjbB9LswKAmarT4sd7g6wGm2CAxK0=;
 b=HswGVYhXbrbdNlzVh3NYUjdH4OE5lDiRLOC0gadik2+peZrC97hC44J4gJ6xwF/zZE7TWn
 xvFx/P2gI4M7FSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39EE0137C3
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TrvrDSxUQ2bKEQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 14:07:07 +0200
Message-ID: <20240514120713.12308-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Add functional test for AMD VMSAVE/VMLOAD
 instructions
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

Thanks to a minor bug in LTP KVM library, LTP test kvm_svm02 found a kernel
bug in emulation of VMSAVE and VMLOAD instructions in nested VMs. Add
a thorough functional test for both instructions which can detect and pinpoint
emulation bugs.

Also implement basic printf-like formatting for tst_res() and tst_brk() so
that the test can print incorrect register values to simplify result analysis.
Only standard integer and character conversions are supported. Floating point
number conversions, field alignment and padding are not implemented.

Martin Doucha (4):
  KVM: Disable EBP register use in 32bit code
  KVM: Implement strchr() and basic sprintf()
  KVM: Implement printf-like formatting for tst_res() and tst_brk()
  KVM: Add functional test for VMSAVE/VMLOAD instructions

 configure.ac                             |   2 +
 include/mk/config.mk.in                  |   1 +
 runtest/kvm                              |   1 +
 testcases/kernel/kvm/.gitignore          |   1 +
 testcases/kernel/kvm/Makefile            |   4 +
 testcases/kernel/kvm/include/kvm_guest.h |  19 +-
 testcases/kernel/kvm/kvm_svm04.c         | 307 ++++++++++++++++++++
 testcases/kernel/kvm/lib_guest.c         | 348 ++++++++++++++++++++++-
 8 files changed, 675 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/kvm/kvm_svm04.c

-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
