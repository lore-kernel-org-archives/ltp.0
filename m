Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D20EEF8FF3
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:03:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E9613DC870
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:03:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADAF73DCACD
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CB1B2600AB4
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59BC45BE79;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM+yENtBQUxWVj3cv5dm1Ppw5lW/TIlz2sG1dvL0i/s=;
 b=BT9SmQgKfUTN4EgGxoh+q4AJB4ZQpIcFq3zmoeWqfH0/G9xLGcIgFdFQ/vQMWcr5auger6
 6+Fzhb6nV99XVntw08Sczsdkdjttm7Tvab1BMTITkDr201SEiEs7ffrKWiuo9bL/w2UnPR
 gTF9ZZJniLNuliCtNBxRZd44KJ5eBzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM+yENtBQUxWVj3cv5dm1Ppw5lW/TIlz2sG1dvL0i/s=;
 b=8I4P394/2azvoBR7zmvMfN0LO9NlaGpez41sRTqFku28A/qXZ2IMHZCdKFLuFJXSuBsJOt
 knOmswq4R6ZYRLAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F02W11VA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SWP5NSio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM+yENtBQUxWVj3cv5dm1Ppw5lW/TIlz2sG1dvL0i/s=;
 b=F02W11VA/3ekAvviR3dPcjdkVN3X3jr+/3Km6sepwpCZHniTqSyS4Ylbabj2xrllSqyLnJ
 GwLpQrho/MV5iGD6QEJP/QYsDFrHznZpbpVAaC69q5C5+W0c2Ed3Zwxs4ivuewkJ5N4qME
 omVQwFhZt6gY8ualH5/J5aEmOak1mPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM+yENtBQUxWVj3cv5dm1Ppw5lW/TIlz2sG1dvL0i/s=;
 b=SWP5NSiolICj+r7+cjkourO6Fa++lhETOsNKSHXGJVqT21RwWSw6gPTKiqwqjYqTjEjf6G
 pxElV5iK2+EO3gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A4513EA69;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6UQeDINJqGkJNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 15:02:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 16:02:25 +0100
Message-Id: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIFJqGkC/2WNQQrCMBBFr1JmbSSJIQmuvIcUqXWmHcREEg1Ky
 d2NBVcu35//3yyQMTFm2HcLJCycOYYGetPBOA9hQsGXxqCltlJpKyim6ykhDeMjJg6T8NI68sa
 QP1tos3s78mtVHvvGM+fWfK8fivqmP5n7lxUlpMAdakWkBkPukJ8Zt2O8QV9r/QC7tf47rwAAA
 A==
X-Change-ID: 20260126-fork_refactoring-8067f844f8b6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772636547; l=1059;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PksXQoZMADNZH9OJS9oOFm0OUhFAhXYywm3zX08et8A=;
 b=gJ+zlUrX8FqWAkIED3+mt7Sz6nYjv2iMUxCQXHB1IKxCsVpZ9t7ASP46/dldupKXwplSB1mlw
 3dVzQM1BQspBT8G6FQjcZ3eMFuhdbZgxIOr6Y3LCb8nbqn5EmNfLefx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 59BC45BE79
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Refactor tests which are verifying fork/vfork
 functionalities
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- _exit(0) to avoid undefind behavior after fork/vfork
- finished uncompleted vfork02
- release getcwd() memory
- use SAFE_MALLOC() instead of SAFE_MMAP() to share between parent and
  child
- missing fork_child in vfork01
- fix missing copyright
- Link to v1: https://lore.kernel.org/r/20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com

---
Andrea Cervesato (3):
      syscalls: refactor fork09 using new API
      syscalls: refactor vfork01 using new API
      syscalls: refactor vfork02 using new API

 testcases/kernel/syscalls/fork/fork09.c   | 215 ++++++-----------
 testcases/kernel/syscalls/vfork/vfork01.c | 375 ++++--------------------------
 testcases/kernel/syscalls/vfork/vfork02.c | 248 ++++----------------
 3 files changed, 165 insertions(+), 673 deletions(-)
---
base-commit: 23ea0f0f8064f68bbf4d5c5f4f037ef18a5848d8
change-id: 20260126-fork_refactoring-8067f844f8b6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
