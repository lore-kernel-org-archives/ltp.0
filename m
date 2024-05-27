Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C62FC25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:31:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CFDA3D037E
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:31:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 922E83D0305
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E85B600C35
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:30:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 275C81FB61;
 Mon, 27 May 2024 06:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pX/tzr3SEm6FrCSlWF5wmEfgt8CIFG7rVR5bhsXDKPg=;
 b=ImI4S6atR/E0aC8afzc1SCT/8gofcrZjPui3IBMZL1QZQ8jaUPEED1iyFcVE4VsyMxTUk2
 43u1nsbZzynY/15H88ME1SDUWq/DBlPmXwJSoJQBAyIpGtQpX0wLBaj51JUWg+mxWyWPv+
 o5WvxCfXAlZa1fipijb1ZRn743Cg5jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pX/tzr3SEm6FrCSlWF5wmEfgt8CIFG7rVR5bhsXDKPg=;
 b=eMvtBF96JycB8CdyXEHSMLFms/BVKHsPrz+JxJeWwUpvyAoFzDFWF9BFRUFOxfyNHARAOk
 RVV80VfNqhk40tAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ImI4S6at;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eMvtBF96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716791446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pX/tzr3SEm6FrCSlWF5wmEfgt8CIFG7rVR5bhsXDKPg=;
 b=ImI4S6atR/E0aC8afzc1SCT/8gofcrZjPui3IBMZL1QZQ8jaUPEED1iyFcVE4VsyMxTUk2
 43u1nsbZzynY/15H88ME1SDUWq/DBlPmXwJSoJQBAyIpGtQpX0wLBaj51JUWg+mxWyWPv+
 o5WvxCfXAlZa1fipijb1ZRn743Cg5jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716791446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pX/tzr3SEm6FrCSlWF5wmEfgt8CIFG7rVR5bhsXDKPg=;
 b=eMvtBF96JycB8CdyXEHSMLFms/BVKHsPrz+JxJeWwUpvyAoFzDFWF9BFRUFOxfyNHARAOk
 RVV80VfNqhk40tAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED53E13A56;
 Mon, 27 May 2024 06:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ks+UNpUoVGbMUgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 27 May 2024 06:30:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 May 2024 08:30:15 +0200
Message-Id: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHcoVGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3eKM0pKU/PI83WSLFHNTC4NUS0OzRCWg8oKi1LTMCrBR0bG1tQA
 pQ03AWgAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=3NNPiZj6HhRbadWSdb4HFvXdJJnLnneMxoN4+MeXYI8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmVCh+sxItr5umoI83+zY0nkcHxdMvyltFhMvBi
 n8OZ6jaPziJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlQofgAKCRDLzBqyILPm
 RnymDACMx3huB3O19Xu+cKfG/T935QXKeunxR62yhh/RsJ7rzOegK7IEqbTrAxK3TAoqSZPxVI7
 FJg4kzSdlZtQS/V4bLcBJYIF4Gfxo1xYIlIpNyO7pZNXOG8VBimSTuikryV76rOtVWLHCDkljI/
 5yhrTBN0iPmvqqitX/lkRZ/Jo8vJMNzFa7u8hmhFa1JKElmm4x0PNcXfep2/lMA4BrAirFG6bwH
 cxZ8bEiH072vB/KrMg5PZPY6O4IRdexlTlIaZogiJ0qkF4setUt2fMoiY0kIe3u2FdWhr8qjkGi
 Nh4sWYA85/j9O/oxNw2m7hKJVZjmH703PGNvYKqLeNi5uEHLVQ3S+2r/ls7b8pOlUwetJMyKtLl
 2CgEovBEKcoMHrsyOe2LdeTb9/R2lz8Vy4e93NtQEFaSufGYEGirZmYkONOwpbquAgYdWCeuzih
 iFNWO8TDetJzg3a3BqE2IdbXWUe7W2PL03UUligBfXRGvaHg8bCGOjAY2onB0FJsUWDDI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 275C81FB61
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] shutdown testing suite
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

This testing suite is meant to test shutdown() syscall functionalities.
The current LTP version uses shutdown() inside many tests, but none of
them is specifically running unit tests for it.

This suite comes with both unit tests for shutdown() flags and error
codes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      Add shutdown01 test
      Add shutdown02 test

 runtest/syscalls                                |   3 +
 testcases/kernel/syscalls/shutdown/.gitignore   |   2 +
 testcases/kernel/syscalls/shutdown/Makefile     |   7 ++
 testcases/kernel/syscalls/shutdown/shutdown01.c | 136 ++++++++++++++++++++++++
 testcases/kernel/syscalls/shutdown/shutdown02.c |  75 +++++++++++++
 5 files changed, 223 insertions(+)
---
base-commit: 0358f7a2788eed0cbff7f8519b1a0f7f89d36c13
change-id: 20240524-shutdown-c8d7580e916a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
