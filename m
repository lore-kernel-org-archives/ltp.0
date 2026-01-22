Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D5CD3EE96
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 17:13:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084D83CB801
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 18:13:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76DEA3CB964
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:13:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E5ECD1A00F77
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:13:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93140336C9
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769101971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZuTfbZolnJvtL8SrnI0IeI49Y4mXDsssRTaXXuZR98=;
 b=K6dqAxJMEiI0a8H3Ic0B+qE214jGubb5Fw6yB5D6D3I6qiieKj8eP7wdO8r9beG85Okact
 6dn/uOuOCXkUbISngkpwl4U6RMs8DCB+01dicPaPFx5R/VRoAM1beh1wt4LKiK0uuwPN1P
 x06jx4CDdSb2IY6HCm3SjivsWhQENw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769101971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZuTfbZolnJvtL8SrnI0IeI49Y4mXDsssRTaXXuZR98=;
 b=z2Atz189FBuPqmOgblMVKe4dZF5bI+JWG+TLdzABmz+v/2EBhLQI2EQdmFGi+xM+79f+25
 rgggI8DO/Z+tqZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769101970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZuTfbZolnJvtL8SrnI0IeI49Y4mXDsssRTaXXuZR98=;
 b=oYH6iIm3/aya4vI8d2tq7p4FPR4ZEJXq3wyifrIi9fDJAl1hyqbGAYyevXJ2NA1XEsQW+k
 mbTgdVZzcW/JpyUK3GUR0R2FDbYHAggEmLogUrqHTPZjkxqeVA5dWvcr2AyhATgGTVH3bW
 i9AGsBVei+3MmdfKMMDuJa6jSId+1tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769101970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZuTfbZolnJvtL8SrnI0IeI49Y4mXDsssRTaXXuZR98=;
 b=lmJgEx2BaAYfoLzDsjg8FY7W+7Ui8aFMXhFYzT+C6tLjfpC13mxNYO99dbqskjvnTsAlb5
 ICoWcvuqTuJL7ADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8188C139BB
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UKluH5JacmnWRgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 18:12:33 +0100
Message-ID: <20260122171249.31590-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122171249.31590-1-mdoucha@suse.cz>
References: <20260122171249.31590-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ioctl_sg01: Add git reference to USB data leak fix
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 9862d7324..3a8e0cf42 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -16,6 +16,12 @@
  *  Date:   Fri May 18 16:23:18 2018 +0200
  *
  *  scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
+ *
+ *  commit 41e99fe2005182139b1058db71f0d241f8f0078c
+ *  Author: Desnes Nunes <desnesn@redhat.com>
+ *  Date:   Fri Oct 31 01:34:36 2025 -0300
+ *
+ *  usb: storage: Fix memory leak in USB bulk transport
  */
 
 #include <sys/types.h>
@@ -167,6 +173,7 @@ static struct tst_test test = {
 	.timeout = 3600,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a45b599ad808"},
+		{"linux-git", "41e99fe20051"},
 		{"CVE", "2018-1000204"},
 		{}
 	}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
