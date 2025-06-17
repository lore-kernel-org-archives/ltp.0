Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED25C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 12:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB3D23CC26C
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 14:46:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F123CC2A8
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 191141A00985
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C757F211CC;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWLm0NhY+kMGbVsjuc1kCXCb720RBsEF/GMHK8hXiZM=;
 b=WMe2qaiNuvLsREQSO0PXaKQcIPN9gYCNSL90J89ghgcdBRUX0O9hMCu62bayyVvJdWuaVx
 hVBcuAMhKCNZjWwS4L1+1S4JTmK/Vy0hqldsP2EOT9wfOh9aE2p4ZCK9Ef9K45izs+U8SQ
 ivdhfNu2bvdoO2PqS+5G1j275sL+vSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWLm0NhY+kMGbVsjuc1kCXCb720RBsEF/GMHK8hXiZM=;
 b=lon5w5PUbXb7KrJ5j4eEGoE52IszJXEDNGZskqEvR4wZkdNS4CP8iOQ+8brLZ/vKRH5z/B
 bjHdcpb00CrPEgDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WMe2qaiN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lon5w5PU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWLm0NhY+kMGbVsjuc1kCXCb720RBsEF/GMHK8hXiZM=;
 b=WMe2qaiNuvLsREQSO0PXaKQcIPN9gYCNSL90J89ghgcdBRUX0O9hMCu62bayyVvJdWuaVx
 hVBcuAMhKCNZjWwS4L1+1S4JTmK/Vy0hqldsP2EOT9wfOh9aE2p4ZCK9Ef9K45izs+U8SQ
 ivdhfNu2bvdoO2PqS+5G1j275sL+vSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWLm0NhY+kMGbVsjuc1kCXCb720RBsEF/GMHK8hXiZM=;
 b=lon5w5PUbXb7KrJ5j4eEGoE52IszJXEDNGZskqEvR4wZkdNS4CP8iOQ+8brLZ/vKRH5z/B
 bjHdcpb00CrPEgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A044813A69;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iKvZJHFjUWhRSQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 12:45:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 14:45:35 +0200
MIME-Version: 1.0
Message-Id: <20250617-statmount_mnt_ns_id-v1-2-d8d81637d73e@suse.com>
References: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
In-Reply-To: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750164337; l=759;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=eYDYDEdtovdaPZiJcfrtQQTCDRYQ8AcmIiEFOvV5AhI=;
 b=Rg22DqfnB/dg++nnF94Ue6T+xWD49fmpgi2bKRheJV2aihw8bvNwS//ui14p3yOoN1lvxaxdL
 qxF5BjnBjt6ABF7QfShvKlJqVEgYotDZ6lOlwU5iDOCmEepPxhiK5u5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C757F211CC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Add ioctl() NS_GET_MNTNS_ID fallback definition
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/ioctl_ns.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
index 9c81d5ce20f299e8e8d6565317c608f805dc74c9..37fc5371681995fad5d955838b80153d5dd227f1 100644
--- a/include/lapi/ioctl_ns.h
+++ b/include/lapi/ioctl_ns.h
@@ -6,6 +6,7 @@
 #ifndef LAPI_IOCTL_NS_H__
 #define LAPI_IOCTL_NS_H__
 
+#include <stdint.h>
 #include <asm-generic/ioctl.h>
 
 #ifndef NSIO
@@ -23,6 +24,8 @@
 #ifndef NS_GET_NSTYPE
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 #endif
-
+#ifndef NS_GET_MNTNS_ID
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, uint64_t)
+#endif
 
 #endif /* LAPI_IOCTL_NS_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
