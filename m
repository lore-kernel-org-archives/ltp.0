Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB78F483F8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 20:57:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C173E1712
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 21:57:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 533A43E6BC6
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 895C3600864
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38BF84D39E;
 Mon, 23 Mar 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icKdQExZ2yJZwwynYELLinaCsDfobSo9v0tt3M9suZY=;
 b=FTsgxj/GhMhUU1Bu91Oojkssdeq0ewAa6m/hz1srVZN6KrpLvmO7SAdChIooJb/eeZ7cQT
 K6l01SHKvRqtUyVXI5dpjxWmVPPL52gurcR87hug9DMHr6qwDrmCZ6FP+dg7IQCBrOIg1S
 ob1hV1McMzmtYvdI9+z6rKlLlg2Wnxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icKdQExZ2yJZwwynYELLinaCsDfobSo9v0tt3M9suZY=;
 b=ZPRvOxFW6uBQX9TqvOfizzHspX2KeyFQ2caBivtPPuOtiS70QuuslOp2GmxLkiWIwR//xI
 mY9cJAqBW/HLe7Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NweBBnWP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8u+sY3TF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icKdQExZ2yJZwwynYELLinaCsDfobSo9v0tt3M9suZY=;
 b=NweBBnWPzFPPX2jlXUCJwGb7sdVOOdYfG8QjiqIXOmUkwwBjkz/UqVdU6BvsBdLI9UoHBr
 VTyulIBLmYjV6L6EOXTZQvk2xxbF9JUti482lx2ufItOhlLxHcnCkAllOx2GnVYRu/USVT
 S59etfVyNwoh7+eWwwOv9ARs4QgJFnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icKdQExZ2yJZwwynYELLinaCsDfobSo9v0tt3M9suZY=;
 b=8u+sY3TFexJug22pla0Yw0k0AvArh/PjkyMoGhV6jqObu5mzvYDRaS/+V04MQh/iIbheM5
 kzO3tBXl/xx3xsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D897D43A8F;
 Mon, 23 Mar 2026 20:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YI/mM+KowWlqMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 20:56:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 21:55:45 +0100
Message-ID: <20260323205547.19058-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323205547.19058-1-pvorel@suse.cz>
References: <20260323205547.19058-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,udp_ipsec.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,udp_ipsec_vti.sh:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38BF84D39E
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] network: Remove outdated UDP stress tests
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests are very old, ugly and were not part of any runtest file.
Some of them covered IPsec, which is tested via more up to date tests
which use udp_ipsec{_vti,}.sh added in runtest/net_stress.ipsec_udp.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/udp/Makefile         |   5 +-
 .../udp/multi-diffip/00_Descriptions.txt      |  56 ---
 .../network/stress/udp/multi-diffip/Makefile  |  29 --
 .../udp/multi-diffip/udp4-multi-diffip01      | 418 ------------------
 .../udp/multi-diffip/udp4-multi-diffip02      |  66 ---
 .../udp/multi-diffip/udp4-multi-diffip03      |  67 ---
 .../udp/multi-diffip/udp4-multi-diffip04      |  66 ---
 .../udp/multi-diffip/udp4-multi-diffip05      |  67 ---
 .../udp/multi-diffip/udp4-multi-diffip06      |  67 ---
 .../udp/multi-diffip/udp4-multi-diffip07      |  66 ---
 .../udp/multi-diffip/udp6-multi-diffip01      |  56 ---
 .../udp/multi-diffip/udp6-multi-diffip02      |  66 ---
 .../udp/multi-diffip/udp6-multi-diffip03      |  67 ---
 .../udp/multi-diffip/udp6-multi-diffip04      |  66 ---
 .../udp/multi-diffip/udp6-multi-diffip05      |  67 ---
 .../udp/multi-diffip/udp6-multi-diffip06      |  67 ---
 .../udp/multi-diffip/udp6-multi-diffip07      |  66 ---
 .../udp/multi-diffnic/00_Descriptions.txt     |  56 ---
 .../network/stress/udp/multi-diffnic/Makefile |  29 --
 .../udp/multi-diffnic/udp4-multi-diffnic01    | 350 ---------------
 .../udp/multi-diffnic/udp4-multi-diffnic02    |  66 ---
 .../udp/multi-diffnic/udp4-multi-diffnic03    |  67 ---
 .../udp/multi-diffnic/udp4-multi-diffnic04    |  66 ---
 .../udp/multi-diffnic/udp4-multi-diffnic05    |  67 ---
 .../udp/multi-diffnic/udp4-multi-diffnic06    |  67 ---
 .../udp/multi-diffnic/udp4-multi-diffnic07    |  66 ---
 .../udp/multi-diffnic/udp6-multi-diffnic01    |  56 ---
 .../udp/multi-diffnic/udp6-multi-diffnic02    |  66 ---
 .../udp/multi-diffnic/udp6-multi-diffnic03    |  67 ---
 .../udp/multi-diffnic/udp6-multi-diffnic04    |  66 ---
 .../udp/multi-diffnic/udp6-multi-diffnic05    |  67 ---
 .../udp/multi-diffnic/udp6-multi-diffnic06    |  67 ---
 .../udp/multi-diffnic/udp6-multi-diffnic07    |  66 ---
 .../udp/multi-diffport/00_Descriptions.txt    |  56 ---
 .../stress/udp/multi-diffport/Makefile        |  29 --
 .../udp/multi-diffport/udp4-multi-diffport01  | 343 --------------
 .../udp/multi-diffport/udp4-multi-diffport02  |  66 ---
 .../udp/multi-diffport/udp4-multi-diffport03  |  67 ---
 .../udp/multi-diffport/udp4-multi-diffport04  |  66 ---
 .../udp/multi-diffport/udp4-multi-diffport05  |  67 ---
 .../udp/multi-diffport/udp4-multi-diffport06  |  67 ---
 .../udp/multi-diffport/udp4-multi-diffport07  |  66 ---
 .../udp/multi-diffport/udp6-multi-diffport01  |  56 ---
 .../udp/multi-diffport/udp6-multi-diffport02  |  66 ---
 .../udp/multi-diffport/udp6-multi-diffport03  |  67 ---
 .../udp/multi-diffport/udp6-multi-diffport04  |  66 ---
 .../udp/multi-diffport/udp6-multi-diffport05  |  67 ---
 .../udp/multi-diffport/udp6-multi-diffport06  |  67 ---
 .../udp/multi-diffport/udp6-multi-diffport07  |  66 ---
 .../stress/udp/uni-basic/00_Descriptions.txt  |  55 ---
 .../network/stress/udp/uni-basic/Makefile     |  29 --
 .../stress/udp/uni-basic/udp4-uni-basic01     | 331 --------------
 .../stress/udp/uni-basic/udp4-uni-basic02     |  66 ---
 .../stress/udp/uni-basic/udp4-uni-basic03     |  67 ---
 .../stress/udp/uni-basic/udp4-uni-basic04     |  66 ---
 .../stress/udp/uni-basic/udp4-uni-basic05     |  67 ---
 .../stress/udp/uni-basic/udp4-uni-basic06     |  67 ---
 .../stress/udp/uni-basic/udp4-uni-basic07     |  66 ---
 .../stress/udp/uni-basic/udp6-uni-basic01     |  56 ---
 .../stress/udp/uni-basic/udp6-uni-basic02     |  66 ---
 .../stress/udp/uni-basic/udp6-uni-basic03     |  67 ---
 .../stress/udp/uni-basic/udp6-uni-basic04     |  66 ---
 .../stress/udp/uni-basic/udp6-uni-basic05     |  67 ---
 .../stress/udp/uni-basic/udp6-uni-basic06     |  67 ---
 .../stress/udp/uni-basic/udp6-uni-basic07     |  66 ---
 65 files changed, 2 insertions(+), 5200 deletions(-)
 delete mode 100644 testcases/network/stress/udp/multi-diffip/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffip/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip02
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip03
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip04
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip05
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip06
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip07
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip01
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip02
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip03
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip04
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip05
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip06
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip07
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic02
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic03
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic04
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic05
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic06
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic07
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic01
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic02
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic03
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic04
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic05
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic06
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic07
 delete mode 100644 testcases/network/stress/udp/multi-diffport/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffport/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport02
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport03
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport04
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport05
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport06
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport07
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport01
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport02
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport03
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport04
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport05
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport06
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport07
 delete mode 100644 testcases/network/stress/udp/uni-basic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/uni-basic/Makefile
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic01
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic02
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic03
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic04
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic05
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic06
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic07
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic01
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic02
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic03
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic04
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic05
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic06
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic07

diff --git a/testcases/network/stress/udp/Makefile b/testcases/network/stress/udp/Makefile
index cdd4fb4668..55a4499761 100644
--- a/testcases/network/stress/udp/Makefile
+++ b/testcases/network/stress/udp/Makefile
@@ -6,7 +6,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= udp_ipsec.sh \
-			   udp_ipsec_vti.sh
+INSTALL_TARGETS		:= *.sh
 
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/udp/multi-diffip/00_Descriptions.txt b/testcases/network/stress/udp/multi-diffip/00_Descriptions.txt
deleted file mode 100644
index 11b65bf21a..0000000000
--- a/testcases/network/stress/udp/multi-diffip/00_Descriptions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending UDP datagram
-at the different IP addresses(aliases)
-
-udp4-multi-diffip01
-	IPv4
-
-udp4-multi-diffip02
-	IPv4
-	IPsec [ AH / transport ]
-
-udp4-multi-diffip03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-udp4-multi-diffip04
-	IPv4
-	IPsec [ ESP / transport ]
-
-udp4-multi-diffip05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-udp4-multi-diffip06
-	IPv4
-	IPcomp [ transport ]
-
-udp4-multi-diffip07
-	IPv4
-	IPcomp [ tunnel ]
-
-udp6-multi-diffip01
-	IPv6
-
-udp6-multi-diffip02
-	IPv6
-	IPsec [ AH / transport ]
-
-udp6-multi-diffip03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-udp6-multi-diffip04
-	IPv6
-	IPsec [ ESP / transport ]
-
-udp6-multi-diffip05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-udp6-multi-diffip06
-	IPv6
-	IPcomp [ transport ]
-
-udp6-multi-diffip07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/udp/multi-diffip/Makefile b/testcases/network/stress/udp/multi-diffip/Makefile
deleted file mode 100644
index 2592c71b13..0000000000
--- a/testcases/network/stress/udp/multi-diffip/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/udp/multi-diffip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= udp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
deleted file mode 100644
index c0d50efaf2..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
+++ /dev/null
@@ -1,418 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-udp4-multi-diffip01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending UDP datagram at the different IP addresses(aliases) with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of IP address (alias)
-IP_TOTAL_FOR_TCPIP=${IP_TOTAL_FOR_TCPIP:-100}
-
-#The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the udp traffic server
-    killall_udp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-tst_resm TINFO "- Target number of the connection is $IP_TOTAL_FOR_TCPIP"
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-# name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the local host"
-    exit $TST_TOTAL
-fi
-
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Loop to assign IP addresses
-ipaddr_pair_num=0
-while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
-    # Add new IP addresses
-    x=`expr $ipaddr_pair_num \/ 255 % 255`
-    y=`expr $ipaddr_pair_num % 255`
-    if [ $x -ge 255 ]; then
-	tst_resm TINFO "This script cannot add more than $ipaddr_pair_num addresses"
-	break
-    fi
-
-    case $IP_VER in
-	4)
-	network_part="10.${x}.${y}"
-	network_broadcast=${network_part}.255
-	network_mask=24
-	lhost_addr="${network_part}.2"
-	rhost_addr="${network_part}.1"
-
-	# Set IPv4 addresses to the interfaces
-	ip addr add ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname
-
-	### delete before setting
-	if [ $? -eq 2 ]; then
-	ip addr del ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname  2>&1
-	ip addr add ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname
-	fi
-
-	if [ $? -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the local"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the local host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname' ; echo $?'`
-	if [ $ret -eq 2 ]; then
-	$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr del ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname' ; echo $?'`
-	fi
-	if [ $ret -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the remote"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the remote host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-	;;
-
-	6)
-	hex_x=`printf %x $x`
-	hex_y=`printf %x $y`
-
-	network_part="fd00:1:${hex_x}:${hex_y}"
-	network_mask=64
-	lhost_addr="${network_part}::2"
-	rhost_addr="${network_part}::1"
-
-	# Set IPv6 addresses to the interfaces
-	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
-
-	if [ $? -eq 2 ]; then
-	ip addr del ${lhost_addr}/${network_mask} dev $lhost_ifname  2>&1
-	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
-	fi
-
-	if [ $? -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the local"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the local host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} dev $rhost_ifname' ; echo $?'`
-
-	if [ $ret -eq 2 ]; then
-	LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr del ${rhost_addr}/${network_mask} dev $rhost_ifname
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} dev $rhost_ifname' ; echo $?'`
-	fi
-
-	if [ $ret -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the remote"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the remote host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-	;;
-    esac
-
-    # Set SAD/SPD
-    if $DO_IPSEC ; then
-	ipsec_log=`mktemp -p $TMPDIR`
-	output_ipsec_conf src \
-	    $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-		| setkey -c 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any SAD/SPD"
-		exit 1
-	    else
-		tst_resm TINFO "The number of SAD/SPD seems to reach the maximum at the local host."
-	    fi
-	    break
-	fi
-	rm -f $ipsec_log
-
-	$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any SAD/SPD"
-		exit 1
-	    else
-		tst_resm TINFO "The number of SAD/SPD seems to reach the maximum at the remote host."
-	    fi
-	    break
-	fi
-	rm -f $ipsec_log
-    fi
-
-    # Check the connectivity
-    case $IP_VER in
-	4)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "No IPv4 connectivity among ${ipaddr_pair_num}th IP a
-	    ddress pair"
-	    exit 1
-	fi
-	;;
-
-	6)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "No IPv6 connectivity among ${ipaddr_pair_num}th IP a
-	    ddress pair"
-	    exit 1
-	fi
-	;;
-    esac
-
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "There is no connectivity."
-	exit 1
-    fi
-
-    ipaddr_pair_num=`expr $ipaddr_pair_num + 1`
-done
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Find the available consecutive ports
-server_port=`find_portbundle udp 1025 1`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-# Run a UDP traffic server
-info_file=`mktemp -p $TMPDIR`
-ns-udpserver -b -f $IP_VER -p $server_port -o $info_file
-if [ $? -ne 0 ]; then
-    tst_resm TFAIL "Failed to run a UDP traffic server"
-    exit 1
-fi
-
-# Collect the information of the server
-while true ; do
-    if [ -s $info_file ]; then
-	break
-    fi
-done
-server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
-rm -f $info_file
-
-# Make connections
-connection_num=0
-while [ $connection_num -lt $ipaddr_pair_num ]; do
-    # IP addresses
-    x=`expr $connection_num \/ 255 % 255`
-    y=`expr $connection_num % 255`
-
-    case $IP_VER in
-	4)
-	lhost_addr="10.${x}.${y}.2"
-	;;
-
-	6)
-	hex_x=`printf %x $x`
-	hex_y=`printf %x $y`
-	lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
-	;;
-    esac
-
-    # Run a client
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run any client"
-	    exit 1
-	else
-	    tst_resm TINFO "$connection_num seems the maximum number of the client"
-	fi
-	break
-    fi
-    connection_num=`expr $connection_num + 1`
-done
-
-
-# Watch the UDP traffic server
-start_epoc=`date +%s`
-while true ; do
-    current_epoc=`date +%s`
-    elapse_epoc=`expr $current_epoc - $start_epoc`
-
-    if [ $elapse_epoc -ge $NS_DURATION ]; then
-	break
-    else
-	ps auxw | fgrep ns-udpserver | fgrep -l $server_pid >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "udp traffic server is dead in $elapse_epoc [sec]"
-	    exit 1
-	fi
-    fi
-    sleep 1
-done
-
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip02 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip02
deleted file mode 100644
index 010915e850..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip03 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip03
deleted file mode 100644
index 1de52bee14..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip04 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip04
deleted file mode 100644
index e321096abe..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip05 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip05
deleted file mode 100644
index f6cdeeabe1..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip06 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip06
deleted file mode 100644
index f601385cac..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip07 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip07
deleted file mode 100644
index 4997ec2032..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffip07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffip07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip01
deleted file mode 100644
index dcd5d15345..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip01
-
-# The version of IP
-IP_VER=6
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip02 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip02
deleted file mode 100644
index ea26ffac58..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip03 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip03
deleted file mode 100644
index b7f810f5cd..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip04 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip04
deleted file mode 100644
index 0bdba0b25b..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip05 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip05
deleted file mode 100644
index c659c79cd8..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip06 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip06
deleted file mode 100644
index f84ed3d602..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip07 b/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip07
deleted file mode 100644
index 6c7e38aaf0..0000000000
--- a/testcases/network/stress/udp/multi-diffip/udp6-multi-diffip07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffip07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffip07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffip01
diff --git a/testcases/network/stress/udp/multi-diffnic/00_Descriptions.txt b/testcases/network/stress/udp/multi-diffnic/00_Descriptions.txt
deleted file mode 100644
index cf39ea0add..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/00_Descriptions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending UDP datagram
-at the different NICs with the following conditions
-
-udp4-multi-diffnic01
-	IPv4
-
-udp4-multi-diffnic02
-	IPv4
-	IPsec [ AH / transport ]
-
-udp4-multi-diffnic03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-udp4-multi-diffnic04
-	IPv4
-	IPsec [ ESP / transport ]
-
-udp4-multi-diffnic05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-udp4-multi-diffnic06
-	IPv4
-	IPcomp [ transport ]
-
-udp4-multi-diffnic07
-	IPv4
-	IPcomp [ tunnel ]
-
-udp6-multi-diffnic01
-	IPv6
-
-udp6-multi-diffnic02
-	IPv6
-	IPsec [ AH / transport ]
-
-udp6-multi-diffnic03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-udp6-multi-diffnic04
-	IPv6
-	IPsec [ ESP / transport ]
-
-udp6-multi-diffnic05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-udp6-multi-diffnic06
-	IPv6
-	IPcomp [ transport ]
-
-udp6-multi-diffnic07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/udp/multi-diffnic/Makefile b/testcases/network/stress/udp/multi-diffnic/Makefile
deleted file mode 100644
index 5bc2107a7a..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/udp/multi-diffnic testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= udp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
deleted file mode 100644
index f94e834b79..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
+++ /dev/null
@@ -1,350 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-udp4-multi-diffnic01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending UDP datagram at the different NICs with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-#The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the udp traffic server
-    killall_udp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    link_num=0
-    while [ $link_num -lt $link_total ]; do
-	# Initialize the interfaces
-	initialize_if lhost ${link_num}
-	initialize_if rhost ${link_num}
-	link_num=`expr $link_num + 1`
-    done
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-link_total=`echo $LHOST_HWADDRS | wc -w`
-rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
-if [ $link_total -ne $rhost_link_total ]; then
-    tst_resm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
-    exit 1
-fi
-if [ $link_total -lt 2 ]; then
-    tst_resm TBROK "This test case requires plural NICs."
-    exit 1
-fi
-tst_resm TINFO "- Target number of the connection is $link_total"
-
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Loop for NIC configuration
-link_num=0
-lhost_addrs=""
-while [ $link_num -lt $link_total ]; do
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $link_num`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-    rhost_ifname=`get_ifname rhost $link_num`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remtoe host"
-	exit $TST_TOTAL
-    fi
-
-    # Set the IP address to each interface
-    case $IP_VER in
-	4)
-	network_part="10.0.${link_num}"
-	network_mask=24
-	lhost_host_part="2"     # local host
-	rhost_host_part="1"     # remote host
-	set_ipv4addr lhost $link_num $network_part $lhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv4 address at the local host"
-	    exit 1
-	fi
-	set_ipv4addr rhost $link_num $network_part $rhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv4 address at the remote host"
-	    exit 1
-	fi
-
-	# IPv4 address of the local/remote host
-	lhost_addr="${network_part}.${lhost_host_part}"
-	rhost_addr="${network_part}.${rhost_host_part}"
-	lhost_addrs="${lhost_addrs} ${lhost_addr}"
-	;;
-
-	6)
-	network_part="fd00:1:0:`printf %x ${link_num}`"
-	network_mask=64
-	lhost_host_part=":2"     # local host
-	rhost_host_part=":1"     # remote host
-	add_ipv6addr lhost $link_num $network_part $lhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv6 address at the local host"
-	    exit 1
-	fi
-	add_ipv6addr rhost $link_num $network_part $rhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv6 address at the remote host"
-	    exit 1
-	fi
-	lhost_addr="${network_part}:${lhost_host_part}"
-	rhost_addr="${network_part}:${rhost_host_part}"
-	lhost_addrs="${lhost_addrs} ${lhost_addr}"
-	;;
-
-	*)
-	tst_resm TBROK "Unknown IP version"
-	;;
-    esac
-
-    # Configure SAD/SPD
-    if $DO_IPSEC ; then
-	ipsec_log=`mktemp -p $TMPDIR`
-
-	# Set SAD/SPD according to the variables
-	output_ipsec_conf src \
-	    $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-		| setkey -c 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	    exit 1
-	fi
-
-	$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	    exit 1
-	fi
-	rm -f $ipsec_log
-    fi
-
-    # Make sure the connectivity
-    case $IP_VER in
-	4)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "There is no IPv4 connectivity on Link${link_num}"
-	    exit 1
-	fi
-	;;
-
-	6)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "There is no IPv6 connectivity on Link${link_num}"
-	    exit 1
-	fi
-	;;
-    esac
-
-    link_num=`expr $link_num + 1`
-done
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Find the available consecutive ports
-server_port=`find_portbundle udp 1025 1`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-# Run a UDP traffic server
-info_file=`mktemp -p $TMPDIR`
-ns-udpserver -b -f $IP_VER -p $server_port -o $info_file
-if [ $? -ne 0 ]; then
-    tst_resm TFAIL "Failed to run a UDP traffic server"
-    exit 1
-fi
-
-# Collect the information of the server
-while true ; do
-    if [ -s $info_file ]; then
-	break
-    fi
-done
-server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
-rm -f $info_file
-
-# Main loop
-connection_num=0
-while [ $connection_num -lt $link_total ]; do
-    field=`expr $connection_num + 1`
-    lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
-
-    # Run a client
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TFAIL "Failed to run client on Link${connection_num}"
-	exit 1
-    fi
-    connection_num=`expr $connection_num + 1`
-done
-
-
-# Watch the UDP traffic server
-start_epoc=`date +%s`
-while true ; do
-    current_epoc=`date +%s`
-    elapse_epoc=`expr $current_epoc - $start_epoc`
-
-    if [ $elapse_epoc -ge $NS_DURATION ]; then
-	break
-    else
-	ps auxw | fgrep ns-udpserver | fgrep -l $server_pid >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "udp traffic server is dead in $elapse_epoc [sec]"
-	    exit 1
-	fi
-    fi
-    sleep 1
-done
-
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic02 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic02
deleted file mode 100644
index b4fc4d46b7..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic03 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic03
deleted file mode 100644
index 719f92ee2a..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic04 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic04
deleted file mode 100644
index e603972db2..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic05 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic05
deleted file mode 100644
index 35637068fc..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic06 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic06
deleted file mode 100644
index 8bc360e180..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic07 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic07
deleted file mode 100644
index 1dbb4b9925..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffnic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffnic07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic01 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic01
deleted file mode 100644
index d0830b10c1..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic01
-
-# The version of IP
-IP_VER=6
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic02 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic02
deleted file mode 100644
index 021e835abf..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic03 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic03
deleted file mode 100644
index 27642378ae..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic04 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic04
deleted file mode 100644
index 9fc8a57f26..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic05 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic05
deleted file mode 100644
index 2eaf9313bb..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic06 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic06
deleted file mode 100644
index 86ca2be61e..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic07 b/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic07
deleted file mode 100644
index 304572ff9d..0000000000
--- a/testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffnic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffnic07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffnic01
diff --git a/testcases/network/stress/udp/multi-diffport/00_Descriptions.txt b/testcases/network/stress/udp/multi-diffport/00_Descriptions.txt
deleted file mode 100644
index 5644af116d..0000000000
--- a/testcases/network/stress/udp/multi-diffport/00_Descriptions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending UDP datagram
-at many different ports with the following conditions
-
-udp4-multi-diffport01
-	IPv4
-
-udp4-multi-diffport02
-	IPv4
-	IPsec [ AH / transport ]
-
-udp4-multi-diffport03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-udp4-multi-diffport04
-	IPv4
-	IPsec [ ESP / transport ]
-
-udp4-multi-diffport05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-udp4-multi-diffport06
-	IPv4
-	IPcomp [ transport ]
-
-udp4-multi-diffport07
-	IPv4
-	IPcomp [ tunnel ]
-
-udp6-multi-diffport01
-	IPv6
-
-udp6-multi-diffport02
-	IPv6
-	IPsec [ AH / transport ]
-
-udp6-multi-diffport03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-udp6-multi-diffport04
-	IPv6
-	IPsec [ ESP / transport ]
-
-udp6-multi-diffport05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-udp6-multi-diffport06
-	IPv6
-	IPcomp [ transport ]
-
-udp6-multi-diffport07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/udp/multi-diffport/Makefile b/testcases/network/stress/udp/multi-diffport/Makefile
deleted file mode 100644
index 118e54cb6a..0000000000
--- a/testcases/network/stress/udp/multi-diffport/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/udp/multi-diffport testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= udp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
deleted file mode 100644
index 5c501c3000..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
+++ /dev/null
@@ -1,343 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-udp4-multi-diffport01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending UDP datagram at many different ports with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# Quantity of the connection for multi connection test
-CONNECTION_TOTAL=${CONNECTION_TOTAL:-4000}
-
-#The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the udp traffic server
-    killall_udp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-tst_resm TINFO "- Target number of the connection is $CONNECTION_TOTAL"
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-# name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the local host"
-    exit $TST_TOTAL
-fi
-
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Configurate IP addresses
-case $IP_VER in
-    4)
-    # Network portion of the IPv4 address
-    network_part=${IPV4_NETWORK:-"10.0.0"}
-
-    # Netmask of the IPv4 network
-    network_mask=24
-
-    # Host portion of the IPv4 address
-    lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-    rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-    set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${network_part}.${lhost_host_part}"
-    rhost_addr="${network_part}.${rhost_host_part}"
-    ;;
-
-    6)
-    # Network portion of the IPv6 address
-    network_part="fd00:1:1:1"
-
-    # Netmask of the IPv6 network
-    network_mask=64
-
-    # Host portion of the IPv6 address
-    lhost_host_part=":2"     # local host
-    rhost_host_part=":1"     # remote host
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${network_part}:${lhost_host_part}"
-    rhost_addr="${network_part}:${rhost_host_part}"
-    ;;
-
-    *)
-    tst_resm TBROK "Unknown IP version"
-    ;;
-esac
-
-# Configure SAD/SPD
-if $DO_IPSEC ; then
-    ipsec_log=`mktemp -p $TMPDIR`
-
-    output_ipsec_conf src \
-	$IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-	    |  setkey -c 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	rm -f $ipsec_log
-	exit 1
-    fi
-
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	rm -f $ipsec_log
-	exit 1
-    fi
-    rm -f $ipsec_log
-fi
-
-# Make sure the connectvity
-case $IP_VER in
-    4)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-    ;;
-
-    6)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-    ;;
-esac
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Find the available consecutive ports
-portbundle=`find_portbundle udp 1025 $CONNECTION_TOTAL`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-start_port=`echo $portbundle | cut -f 1 -d '-'`
-end_port=`echo $portbundle | cut -f 2 -d '-'`
-
-
-# Run the pair of server and client
-connection_num=0
-current_port=$start_port
-while [ $current_port -le $end_port ]; do
-    # Run a UDP traffic server
-    ns-udpserver -b -f $IP_VER -p $current_port
-    if [ $? -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run a server"
-	    exit 1
-	fi
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $current_port'; echo $?'`
-    if [ $ret -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run a client"
-	    exit 1
-	fi
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-    current_port=`expr $current_port + 1`
-    connection_num=`expr $connection_num + 1`
-done
-
-
-# Watch the UDP traffic server
-start_epoc=`date +%s`
-while true ; do
-    current_epoc=`date +%s`
-    elapse_epoc=`expr $current_epoc - $start_epoc`
-    if [ $elapse_epoc -ge $NS_DURATION ]; then
-	break
-    else
-	ps auxw | fgrep -v grep | fgrep -l ns-udpserver >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "All udp traffic servers are dead in $elapse_epoc [sec]"
-	    exit 1
-	fi
-    fi
-    sleep 1
-done
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport02 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport02
deleted file mode 100644
index 0ce757bfc5..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport03 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport03
deleted file mode 100644
index 44fdc07060..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport04 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport04
deleted file mode 100644
index 41d933f154..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport05 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport05
deleted file mode 100644
index 31a59375f8..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport06 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport06
deleted file mode 100644
index 50666e08d7..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport07 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport07
deleted file mode 100644
index 74a908b7d2..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-multi-diffport07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp4-multi-diffport07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport01 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport01
deleted file mode 100644
index fdebb2bc5e..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport01
-
-# The version of IP
-IP_VER=6
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport02 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport02
deleted file mode 100644
index c7c948eed6..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport03 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport03
deleted file mode 100644
index 69266e3b2b..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport04 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport04
deleted file mode 100644
index 5022393d8b..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport05 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport05
deleted file mode 100644
index 4c7f97eba4..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport06 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport06
deleted file mode 100644
index e85453866c..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport07 b/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport07
deleted file mode 100644
index f0896dd253..0000000000
--- a/testcases/network/stress/udp/multi-diffport/udp6-multi-diffport07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-multi-diffport07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram at many different ports with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffport testcase
-#
-
-# The test case ID
-TCID=udp6-multi-diffport07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-multi-diffport01
diff --git a/testcases/network/stress/udp/uni-basic/00_Descriptions.txt b/testcases/network/stress/udp/uni-basic/00_Descriptions.txt
deleted file mode 100644
index 38ac52df57..0000000000
--- a/testcases/network/stress/udp/uni-basic/00_Descriptions.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending UDP datagram with the following conditions
-
-udp4-uni-basic01
-	IPv4
-
-udp4-uni-basic02
-	IPv4
-	IPsec [ AH / transport ]
-
-udp4-uni-basic03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-udp4-uni-basic04
-	IPv4
-	IPsec [ ESP / transport ]
-
-udp4-uni-basic05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-udp4-uni-basic06
-	IPv4
-	IPcomp [ transport ]
-
-udp4-uni-basic07
-	IPv4
-	IPcomp [ tunnel ]
-
-udp6-uni-basic01
-	IPv6
-
-udp6-uni-basic02
-	IPv6
-	IPsec [ AH / transport ]
-
-udp6-uni-basic03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-udp6-uni-basic04
-	IPv6
-	IPsec [ ESP / transport ]
-
-udp6-uni-basic05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-udp6-uni-basic06
-	IPv6
-	IPcomp [ transport ]
-
-udp6-uni-basic07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/udp/uni-basic/Makefile b/testcases/network/stress/udp/uni-basic/Makefile
deleted file mode 100644
index 7f6ae674d2..0000000000
--- a/testcases/network/stress/udp/uni-basic/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/udp/uni-basic testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= udp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic01 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic01
deleted file mode 100644
index a15c32f4fc..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic01
+++ /dev/null
@@ -1,331 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-udp4-uni-basic01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending UDP datagram with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the udp traffic server
-    killall_udp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-# name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the local host"
-    exit $TST_TOTAL
-fi
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Configurate IP addresses
-case $IP_VER in
-    4)
-    # Network portion of the IPv4 address
-    network_part=${IPV4_NETWORK:-"10.0.0"}
-
-    # Netmask of the IPv4 network
-    network_mask=24
-
-    # Host portion of the IPv4 address
-    lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-    rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-    set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${network_part}.${lhost_host_part}"
-    rhost_addr="${network_part}.${rhost_host_part}"
-    ;;
-
-    6)
-    # Network portion of the IPv6 address
-    network_part="fd00:1:1:1"
-
-    # Netmask of the IPv6 network
-    network_mask=64
-
-    # Host portion of the IPv6 address
-    lhost_host_part=":2"     # local host
-    rhost_host_part=":1"     # remote host
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${network_part}:${lhost_host_part}"
-    rhost_addr="${network_part}:${rhost_host_part}"
-    ;;
-
-    *)
-    tst_resm TBROK "Unknown IP version"
-    ;;
-esac
-
-# Configure SAD/SPD
-if $DO_IPSEC ; then
-    ipsec_log=`mktemp -p $TMPDIR`
-
-    output_ipsec_conf src \
-	$IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-	    |  setkey -c 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	rm -f $ipsec_log
-	exit 1
-    fi
-
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	rm -f $ipsec_log
-	exit 1
-    fi
-    rm -f $ipsec_log
-fi
-
-# Make sure the connectvity
-case $IP_VER in
-    4)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-    ;;
-
-    6)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-    ;;
-esac
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Find the available consecutive ports
-server_port=`find_portbundle udp 1025 1`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-# Run a UDP traffic server
-info_file=`mktemp -p $TMPDIR`
-ns-udpserver -b -f $IP_VER -p $server_port -o $info_file
-if [ $? -ne 0 ]; then
-    tst_resm TFAIL "Failed to run a UDP traffic server"
-    rm -f $info_file
-    exit 1
-fi
-
-# Collect the information of the server
-while true ; do
-    if [ -s $info_file ]; then
-	break
-    fi
-
-done
-server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
-rm -f $info_file
-
-# Run a client
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TFAIL "Failed to run a client"
-    exit 1
-fi
-
-# Watch the UDP traffic server
-start_epoc=`date +%s`
-while true ; do
-    current_epoc=`date +%s`
-    elapse_epoc=`expr $current_epoc - $start_epoc`
-
-    if [ $elapse_epoc -ge $NS_DURATION ]; then
-	break
-    else
-	ps auxw | fgrep ns-udpserver | fgrep -l $server_pid >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "udp traffic server is dead in $elapse_epoc [sec]"
-	    exit 1
-	fi
-    fi
-    sleep 1
-done
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic02 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic02
deleted file mode 100644
index 4f69347531..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic03 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic03
deleted file mode 100644
index 8f0d43a76f..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic04 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic04
deleted file mode 100644
index 8197e05f56..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic05 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic05
deleted file mode 100644
index 027123906e..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic06 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic06
deleted file mode 100644
index 848aa237b0..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp4-uni-basic07 b/testcases/network/stress/udp/uni-basic/udp4-uni-basic07
deleted file mode 100644
index 336a213ebc..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp4-uni-basic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp4-uni-basic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp4-uni-basic07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic01 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic01
deleted file mode 100644
index 7222aa7286..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic01
-
-# The version of IP
-IP_VER=6
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic02 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic02
deleted file mode 100644
index 9e91be6640..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic03 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic03
deleted file mode 100644
index 7c6efa06d2..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic04 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic04
deleted file mode 100644
index abfb6032ef..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic05 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic05
deleted file mode 100644
index 75a4d224f3..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic06 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic06
deleted file mode 100644
index ef844c4b0c..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. udp4-uni-basic01
diff --git a/testcases/network/stress/udp/uni-basic/udp6-uni-basic07 b/testcases/network/stress/udp/uni-basic/udp6-uni-basic07
deleted file mode 100644
index d4d0dc0b3a..0000000000
--- a/testcases/network/stress/udp/uni-basic/udp6-uni-basic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   udp6-uni-basic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending UDP
-#   datagram  with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each uni-basic testcase
-#
-
-# The test case ID
-TCID=udp6-uni-basic07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. udp4-uni-basic01
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
