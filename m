Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA5C47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 10:06:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 210BD3C8B1F
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 11:06:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02D7D3C2674
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:06:41 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEE6F60035A
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:06:40 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 717CA2214C;
 Thu, 11 Jan 2024 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704967585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=npiM+Moa5HzdAQVlzmPI1H7xZ9pFUazv5s/MdvQN8a0=;
 b=zwS/WqAzsQvu4FF8Vdtlwv163iWylgYQ7kE8WjJhAg+2DpVcL6TiO4i49Rsr4HCBX5h6QW
 oz0XBEHLRpSGTy3bZbXEHIq7UZbtC6nbMJfqRIIdGk+0O0QsZtHzEklz03GQIE9UE6KStx
 b7BzR3pH81oy3uOqT0JnOGM3WYD9f6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704967585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=npiM+Moa5HzdAQVlzmPI1H7xZ9pFUazv5s/MdvQN8a0=;
 b=tr1766kL5kPmNSCn1NKGi66RwXCnyf7n1Bh4e9OoKIBt5/xUx+dadnMJ2IVwhL5HVVklr1
 YRIHgnBRpMq0BiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704967585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=npiM+Moa5HzdAQVlzmPI1H7xZ9pFUazv5s/MdvQN8a0=;
 b=zwS/WqAzsQvu4FF8Vdtlwv163iWylgYQ7kE8WjJhAg+2DpVcL6TiO4i49Rsr4HCBX5h6QW
 oz0XBEHLRpSGTy3bZbXEHIq7UZbtC6nbMJfqRIIdGk+0O0QsZtHzEklz03GQIE9UE6KStx
 b7BzR3pH81oy3uOqT0JnOGM3WYD9f6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704967585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=npiM+Moa5HzdAQVlzmPI1H7xZ9pFUazv5s/MdvQN8a0=;
 b=tr1766kL5kPmNSCn1NKGi66RwXCnyf7n1Bh4e9OoKIBt5/xUx+dadnMJ2IVwhL5HVVklr1
 YRIHgnBRpMq0BiAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D05DB138E5;
 Thu, 11 Jan 2024 10:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +RSZL1S9n2USNgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jan 2024 10:05:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 11:06:36 +0100
Message-ID: <20240111100636.1897637-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zwS/WqAz";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tr1766kL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-0.999];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[45.41%]
X-Rspamd-Queue-Id: 717CA2214C
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] keyctl05: Improve the dns_res_payload for
 boundary testing
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
Cc: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Pengfei Xu <pengfei.xu@intel.com>

kernel commit acc657692aed ("keys, dns: Fix size check of V1 server-list header")
from upcoming v6.8-rc1 (going to be backported to stable), which fixes
the add_key syscall incoming data boundary size issue, 6 bytes incoming
data is now enough.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
[ pvorel: add acc657692aed, reword commit message ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I would wait with this to at least v6.8-rc2. Ideally it should be
released, when the commit reaches any stable tree or when v6.8 is released.

Changes v1->v2:
* mention acc657692aed
* update doc (v6.8-rc1 and acc657692aed438e9931438f8c923b2b107aebf9)
* reword commit message

 testcases/kernel/syscalls/keyctl/keyctl05.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index f0e09fe5d..0c01fa034 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -201,11 +201,12 @@ static void do_test(unsigned int i)
 	/*
 	 * We need to pass check in dns_resolver_preparse(),
 	 * give it dummy server list request.
-	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
-	 * the incoming data for add_key syscall should be larger than 6 bytes,
-	 * because struct dns_server_list_v1_header without body is 6 bytes.
+	 * From v6.8-rc1 commit acc657692aed438e9931438f8c923b2b107aebf9:
+	 * the incoming data for add_key() sysdall should be not less than 6
+	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
+	 * The minimum payload will be tested here for boundary testing.
 	 */
-	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00, 0x00 };
+	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };
 
 	switch (i) {
 	case 0:
@@ -229,6 +230,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "63a0b0509e70"},
+		{"linux-git", "acc657692aed"},
 		{}
 	}
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
