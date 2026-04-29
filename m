Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D1FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:12:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCB6F3E2D98
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:12:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B3453CEE87
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:11:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 776D910009FF
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:11:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 688E46A88B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777464698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hHUcFZteYBs6F9jNOhPOkjNj9eRCuac0yDH9FYbqYvg=;
 b=BRBHqQ2H08uoGhi3LRfEaebi1CnA/3exRcFNNKPEYCxqvaLdna6KYmL0ND4qROO59cq0JL
 bvj4ag7G7l5jQ9D4SczHPMJnhWfDZbL+1q6iN1Aw2HG7/M2ioXfqnJ540HPFZsmQtr0Hb9
 eNW8XMaHSf10GuCO1ICb+jJ+AJ606tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777464698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hHUcFZteYBs6F9jNOhPOkjNj9eRCuac0yDH9FYbqYvg=;
 b=8iyHSwMMmEi01/rUfpOtRG+DS9PpswMQz/g6/o9EwRlk8zoq4z4e0wtp4ykDqAnwzse/k8
 23XR1wkw5/JGmVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777464694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hHUcFZteYBs6F9jNOhPOkjNj9eRCuac0yDH9FYbqYvg=;
 b=CxZ0lSuV/0B0Nyg+T2peOo5ILt34m3bnV5xMXsWLI2Tc6hW40EFzfkismpwC1+XrDmr8XS
 9WFmJULz/4HqLw7xyky9FtBIIKVvxZnCRFgTDSjfE4ttWEI6W9JIRDrdePbzGOokehX7O/
 L0rMNuk3E8EX1QNgev1maeBeZqE0hmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777464694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hHUcFZteYBs6F9jNOhPOkjNj9eRCuac0yDH9FYbqYvg=;
 b=wQE89eoWcGUl8TQZXHncHtSOPo0d6ROlRx9VH0v7k4KS24JHFdJpYHe4XKLkSVDyWZF6tH
 4H6t8oZpN9yaxLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFD2593B0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pz4eF3b18WmdWgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:11:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 14:11:27 +0200
Message-ID: <20260429121129.21911-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] icmp_rate_limit01: Fix rate limit change on older
 kernels
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

The icmp_msgs_burst sysfile was added to non-root namespaces in kernel
v6.12. Older kernels allow changing the value only from the root
namespace. Set the global limit first, then change the test namespace
limit as well if needed.

Fixes: 3c4c712f1f9b ("cve: icmp_rate_limit: set icmp_msgs_burst within network namespace")
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/icmp_rate_limit01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 5193c5dfd..37bc71cb8 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -62,7 +62,12 @@ static void setup(void)
 	/* Do NOT close this FD, or both interfaces will be destroyed */
 	childns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
 
-	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
+	/*
+	 * Set namespace local rate limit if needed. The global limit might
+	 * be ignored otherwise.
+	 */
+	if (!access("/proc/sys/net/ipv4/icmp_msgs_burst", F_OK))
+		SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
 
 	/* Configure child namespace */
 	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
@@ -257,6 +262,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
