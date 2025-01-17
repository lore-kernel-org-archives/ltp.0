Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57353C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:54:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C073B3C2531
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:54:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36E203C2531
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:53:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C06C7BC267
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:53:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA9ED1F37C
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737107626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pgt20fcI4/76epcDZ9ZAnOrSp01zWzgP3VcMh8Xlgk4=;
 b=I5qqzQWzX9x4RaDPMevwfuHGtFPbM27uHoK8Uyz7bhknwpVgP+ob7Ji52rmTHlHHigCQEP
 ZNAmMP9tC6NZF8XaDGGuo2XdYutMhAm7jkfM9KHmoHj2wMhRJY0vMeHMS/BWvGV+vYndAM
 TJ7RWUkxDnd4BdaKgVHOAz7xhA5lGpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737107626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pgt20fcI4/76epcDZ9ZAnOrSp01zWzgP3VcMh8Xlgk4=;
 b=G4/tLG6nkHPm/URE04n27hHwBperhcOSYTO5Who4NW/zn2BEeSbAhZDe6xRv9X9KJxsw67
 sA+ibGxUb3KF8TDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XDg6eCcs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J0nRCX0Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737107625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pgt20fcI4/76epcDZ9ZAnOrSp01zWzgP3VcMh8Xlgk4=;
 b=XDg6eCcsMK5CugSkogwn97DW/J4JbYaFF/D8WsPWKYv/ryVdIUPSABkOJl0jOYLeiyKni9
 wSn4dV+5rnZMtx6SOJ4MV4r1PYYlj6BfmS+2oGaVm3KHqp8Mi4XenmrhKKHLRwkyuaG6i1
 4LgakiFOeW29r0RIWgNUCtkdZs/4Xb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737107625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pgt20fcI4/76epcDZ9ZAnOrSp01zWzgP3VcMh8Xlgk4=;
 b=J0nRCX0QcYjrCuPr3lPCBkJOzkGxom+qv+heI1VtSfsgscp3lTsa1vMDloaKHWAKw63ZQa
 1Ae0cgM4n9/DW6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0680139CB
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fUvXMqkoimcMJgAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:53:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 10:53:41 +0100
Message-ID: <20250117095345.10259-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: DA9ED1F37C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] acct01: NULL terminate .needs_kconfigs
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

Fixes: 6fe8aa186 ("fix make check warning: using .needs_kconfigs instead
of ENOSYS")

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/acct/acct01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index cfd25c665..781d62261 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -149,5 +149,6 @@ static struct tst_test test = {
 	},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_BSD_PROCESS_ACCT=y",
+		NULL,
 	}
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
