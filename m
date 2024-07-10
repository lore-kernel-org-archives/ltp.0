Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F7C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:57:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72953D386F
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:57:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86573D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3028F600CFC
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:56:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D76221BED;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lgu9hk3gPxLkQi0Zuw82pFaWlZnuPWM27JAuK767e2Q=;
 b=OGpwYZq/8N+kJIyVF5ZsyN0RWtesXna0WhtXYr5uCRGEV7NmvNSLvgZdIRyjQSlqbNoCFi
 J3OpZ3VzXYMbDkHx0wvvyUvxvQh9mhVPqIlc2pUyFTkQLwoVPe6DOrdp49PXB4i02u+UZq
 TIvnloDFTxZpZj/GkdoTNUbG0DaQ4wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lgu9hk3gPxLkQi0Zuw82pFaWlZnuPWM27JAuK767e2Q=;
 b=uk7bQ2/1vyW8iOygl8wMLq998vF75KiLCdU7bDntz0wOPx3xYWQJHb+TMzduSBCKITO4o1
 6MKV3dG0rb4OlpCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OGpwYZq/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uk7bQ2/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lgu9hk3gPxLkQi0Zuw82pFaWlZnuPWM27JAuK767e2Q=;
 b=OGpwYZq/8N+kJIyVF5ZsyN0RWtesXna0WhtXYr5uCRGEV7NmvNSLvgZdIRyjQSlqbNoCFi
 J3OpZ3VzXYMbDkHx0wvvyUvxvQh9mhVPqIlc2pUyFTkQLwoVPe6DOrdp49PXB4i02u+UZq
 TIvnloDFTxZpZj/GkdoTNUbG0DaQ4wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lgu9hk3gPxLkQi0Zuw82pFaWlZnuPWM27JAuK767e2Q=;
 b=uk7bQ2/1vyW8iOygl8wMLq998vF75KiLCdU7bDntz0wOPx3xYWQJHb+TMzduSBCKITO4o1
 6MKV3dG0rb4OlpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21F2137D2;
 Wed, 10 Jul 2024 17:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zi8VNWrLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:38 +0200
Message-Id: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFbLjmYC/0XMQQ7CIBCF4as0sxYDiNC68h6miwmdWmKFBpRoG
 u4u1oXL/+XlWyFRdJTg1KwQKbvkgq8hdw3YCf2VmBtqg+RScS0Mm9EPc7A3ZlWLSssDKmWg3pd
 Io3tt1KWvPbn0CPG9yVl81x9iuPgjWTDOji11OGrVoZHn9Ey0t+EOfSnlAz6hFmKfAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Me4wbEFcFM3iap67qqcL0FwMpBEQHYR3xjRZgITds8E=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjstYB6+61pGkdmjDt6XbrleiL3puMWEovHE5J
 +fW5C0ZiXGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LWAAKCRDLzBqyILPm
 RnxDDACp5b33HR7k2C2yyoA7DlFgK2d9zhbiCa9IbJy6VOMxV4OPLNh1x0NBhDqbwQBPh9Q2iqc
 mK4o0NtnG/Dhg4mjR6JkyVNum0kyqpBwReOLlli2Wfb47g2Dge+HkNDn0d3f50GoRnqeROqSLfx
 w9QWnKYPADOJ72XmuRvx1A0XqtO+FkiI8eeWX6Fd5Tr6mr5QfZahG0TzKhyoFpIaQ+NJ2JONFnR
 oAo6QJFrXY+ON8iOLPp8C7XKdxq5fXslQeybCpK57n5UbnwKCLQvuiSz5vm4hAzRSn6Wj/u8Ojd
 GUWbKxqqVSuUNqzc8ZIDJRwPupvZ30N3wt7oGStCUQ5Tf/MKCciiO2KdJjBy6aodnjXxJRqb6Ay
 NHZLlc/yFz04MLWwxZwwIiDUCApsEQEavyrBwZX7WBHQezGAzvRgzqchqWKTuKS38s4p46W7p2A
 kpcsCrWKs+mVmpFPriO2hqGXrtwI7nD2dF7LOP9XXeKa8pUywwPHP98laZNDnWvBYGFf8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0D76221BED
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] landlock testing suite
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

This testing suite is meant to test the following syscalls:

- landlock_create_ruleset
- landlock_add_rule
- landlock_restrict_self

Documentation can be found in kernel manuals and inside the official
kernel documentation at

https://www.kernel.org/doc/html/latest/userspace-api/landlock.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- remove -lc unused dependency from Makefile
- move SAFE_LANDLOCK_* macros in lapi/landlock.h
- define CAP_MKNOD in the lapi/capability.h
- fix landlock fallback in order to let LTP build properly
- fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
  too small
- fix landlock05 for -i2
- skip exfat from landlock04 filesystems
- Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com

---
Andrea Cervesato (7):
      Add landlock01 test
      Add landlock02 test
      Add landlock03 test
      Add CAP_MKNOD fallback in lapi/capability.h
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 include/lapi/capability.h                          |  12 +-
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/landlock/.gitignore      |   7 +
 testcases/kernel/syscalls/landlock/Makefile        |   7 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  92 ++++++
 testcases/kernel/syscalls/landlock/landlock02.c    | 153 +++++++++
 testcases/kernel/syscalls/landlock/landlock03.c    | 119 +++++++
 testcases/kernel/syscalls/landlock/landlock04.c    | 176 +++++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 114 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 110 +++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  74 +++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
 13 files changed, 1226 insertions(+), 4 deletions(-)
---
base-commit: a3ebad6faf126347e3cbbd5a112f0853f159a914
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
