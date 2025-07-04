Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD721C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 11:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2063B3C9BFA
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 13:31:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 679B23C9D1D
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10A83600D20
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 699CB211A3;
 Fri,  4 Jul 2025 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xsTIQ4h50Y80lG7MBr0DFNdaiWuvdzN+0Bcx9lrSLT8=;
 b=q2H3lEqOWCv3m1U7OFJaVHUVfH68vEIoilvWSeQ85miT4cT6mLXymJvRh/8XCO21SGhs3m
 BMjjeh4O0/OBlIhriQxOcY+4+vnJiTOxiqZQl/II5PnIZc+b6FGLm0OP74kV5Z71f1Da15
 TOwbfhPZl4SfmHaAMsPvpIy/fg1v/0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xsTIQ4h50Y80lG7MBr0DFNdaiWuvdzN+0Bcx9lrSLT8=;
 b=0NqKBxaRh09DTia7VTopbEUHyAe6RHwa2IZXAzbUU0BrRI3LLuEXfS8wF+4dQGJ/w/DBLc
 w64yPLvA8/0t6eCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xsTIQ4h50Y80lG7MBr0DFNdaiWuvdzN+0Bcx9lrSLT8=;
 b=g2VPIyE4/+gQj6ECrtxnE51WRL4/fjzp5NWiHV4NPjR/ibTO7bwcgURbEJS+xQzVTBeSTi
 VYvV0+s7gJDEjXJjnZuV9WAAkiDQG7TsMvI6RpXpt2vBywpOTt0hXjg1i0gursbfKawt/b
 PHwFPV9U8RAfxjXWrU8GY+pyEpqCEE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xsTIQ4h50Y80lG7MBr0DFNdaiWuvdzN+0Bcx9lrSLT8=;
 b=22JL9EW13RtwPapkew8svP1k1/HP0ZSbVC8deO3ftyByyPBdzrDWGpY70mm4BqRnaG9dkF
 u4V1YR/IbIYC0gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1551F13757;
 Fri,  4 Jul 2025 11:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DANMOmK7Z2iTRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Jul 2025 11:30:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Jul 2025 13:30:38 +0200
Message-Id: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF67Z2gC/32NQQ6CMBBFr0JmbU0ZpAZX3MMQUsogkyglnUI0h
 LtbOYDL95L//gZCgUnglm0QaGVhPyXAUwZutNODFPeJATWW2qBR7F18tjP3Q9/KwpFUgWgtFtf
 SXRDSbg408Pto3pvEI0v04XNcrPnP/qutudIqN2VX2W7QWJlaFqGz8y9o9n3/AjtFa1WxAAAA
X-Change-ID: 20250626-ioctl_pidfd_suite-322aa2375c42
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751628642; l=1805;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=32Oog6ZT/hVRTNPcfL8V18HZhwmu3i4wGTnyTezx/ro=;
 b=uSuRFLTQEXGFZMnMV4Y0enRf8HrMA5FsSXrWsGmxWI5Cqi0qWMcyXUkYCT7o4VtCBuru9TJ9w
 H4YsHcJRxjWB6g2J+PEZ8MagF16PPuti9wdkBGHxNMprYJQfYAC4qDN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8] ioctl_pidfd testing suite
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
Changes in v2:
- ioctl_pidfd02: check all flags of info before and after process being
  reaped. Include a fork() test
- ioctl_pidfd03: verify process info before being reaped
- add more error tests
- Link to v1: https://lore.kernel.org/r/20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com

---
Andrea Cervesato (8):
      Provide pidfd parameter in tst_clone_args
      Fallback PIDFD_GET_INFO related definitions
      Add ioctl_pidfd01 test
      Add ioctl_pidfd02 test
      Add ioctl_pidfd03 test
      Add ioctl_pidfd04 test
      Add ioctl_pidfd05 test
      Add ioctl_pidfd06 test

 configure.ac                                    |  2 +
 include/lapi/pidfd.h                            | 37 +++++++++++
 include/tst_clone.h                             |  1 +
 lib/tst_clone.c                                 |  1 +
 runtest/syscalls                                |  7 +++
 testcases/kernel/syscalls/ioctl/.gitignore      |  6 ++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 82 +++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 57 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 65 ++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 58 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 59 ++++++++++++++++++
 12 files changed, 433 insertions(+)
---
base-commit: f6b76fe373d1932ce1d2248e83ff284085145797
change-id: 20250626-ioctl_pidfd_suite-322aa2375c42

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
