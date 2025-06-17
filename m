Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8270C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 12:45:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 524913CC26B
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 14:45:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C0AA3CB29D
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D4AA60085D
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61E4B211C6;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H6eSh8yTI2PAzYigkGzKFoE7V1ZrcoO4yQSuwOVaok=;
 b=0PwEqlRUuCiDxfH7opXhOF5VOimbESlv5im8Ya+ansODLlSoWGd1mXXX7Nj1sBZTqw1dih
 GQ3Ci7jEF9tF7L04s0/1vIouze5/ajWTWxPS+LA1tTrl9PwDD6R+Wl1+kNvPPjglzFPgvZ
 YlfGgcbmXTe5ypmO5B+zAX4ze2fTML8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H6eSh8yTI2PAzYigkGzKFoE7V1ZrcoO4yQSuwOVaok=;
 b=jNu7pktIyCnBJm282u9TvQ7qtsiDUfH4DvMiQ9TnWplhAWDWyvy+xmAru8rWdSIkRQNzAh
 3ldrjTF/ESkIn3Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H6eSh8yTI2PAzYigkGzKFoE7V1ZrcoO4yQSuwOVaok=;
 b=0PwEqlRUuCiDxfH7opXhOF5VOimbESlv5im8Ya+ansODLlSoWGd1mXXX7Nj1sBZTqw1dih
 GQ3Ci7jEF9tF7L04s0/1vIouze5/ajWTWxPS+LA1tTrl9PwDD6R+Wl1+kNvPPjglzFPgvZ
 YlfGgcbmXTe5ypmO5B+zAX4ze2fTML8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H6eSh8yTI2PAzYigkGzKFoE7V1ZrcoO4yQSuwOVaok=;
 b=jNu7pktIyCnBJm282u9TvQ7qtsiDUfH4DvMiQ9TnWplhAWDWyvy+xmAru8rWdSIkRQNzAh
 3ldrjTF/ESkIn3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4091F13A69;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hxN5DXFjUWhRSQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 12:45:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 14:45:33 +0200
Message-Id: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG1jUWgC/x2MMQqAMAwAvyKZLaitFfyKSAmaagarNFUE8e8Wh
 xtuuHtAKDIJ9MUDkS4W3kOWuixgWjEspHjODk3VtJWtOyUJ07afIbktE8TxrLwljcZog95CLo9
 Inu//Oozv+wE49N/2ZQAAAA==
X-Change-ID: 20250617-statmount_mnt_ns_id-f6e3a4434af6
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750164337; l=955;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=CfcKd/+Fs8LCI3LvhAamEElwWfYYqSITpjPsYMj7hWc=;
 b=oWkuheGUhVUeapCR+NvFAb0WiPR4yk8gO3lAapaSsW/sHWseOMZnRduIhah4D4V1rsCuJf+4W
 /U+voBo+jtmDLloxxoKF0APDS/0SOQ4lG9icY1tf1gEiD3SqJ/ZO+1t
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Add statmount09 test
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

Complete the "struct statmount" according to the new kernel versions,
adding new attributes into it. Add NS_GET_MNTNS_ID for ioctl() syscall
and create the statmount09 test.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      Update statmount fallback definitions
      Add ioctl() NS_GET_MNTNS_ID fallback definition
      Add statmount09 test

 include/lapi/ioctl_ns.h                           |  5 +-
 include/lapi/mount.h                              | 18 +++++-
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount09.c | 74 +++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)
---
base-commit: df591113afeb31107bc45bd5ba28a99b556d1028
change-id: 20250617-statmount_mnt_ns_id-f6e3a4434af6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
