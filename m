Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC09C4167D
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:21:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23CA63CF4AD
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:21:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 756D93CF4BA
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EEADC1400E61
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:08 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 622712210A;
 Thu, 14 Dec 2023 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW2gqeZC1Yns7/rn9qAsCSCMIpJWL/K5UnKZj5Hi/Dk=;
 b=nHnTJyuS08dnEq7D2yRzosQsf2KIWX7DLL23pRk/81t5+5WohUdeOHsmjKF0vw9o2TE9Jn
 q0veMisESjeMiZja+6Gqst9YVpVdoQ7Q/k2mCeeW+t3wsktB4rfE9G4HZbVzupTteUP2FX
 ZdOFNaxjKEkrO9Sbl1Gk07bAbrGFAps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW2gqeZC1Yns7/rn9qAsCSCMIpJWL/K5UnKZj5Hi/Dk=;
 b=ukm+vwRPajfOgOHaNW69n395riqrVPO+3Wjx83DpyTfX1HI/35jmNBUrs6uEUN1o58aP8S
 gkosftEp5eKidmBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW2gqeZC1Yns7/rn9qAsCSCMIpJWL/K5UnKZj5Hi/Dk=;
 b=nHnTJyuS08dnEq7D2yRzosQsf2KIWX7DLL23pRk/81t5+5WohUdeOHsmjKF0vw9o2TE9Jn
 q0veMisESjeMiZja+6Gqst9YVpVdoQ7Q/k2mCeeW+t3wsktB4rfE9G4HZbVzupTteUP2FX
 ZdOFNaxjKEkrO9Sbl1Gk07bAbrGFAps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW2gqeZC1Yns7/rn9qAsCSCMIpJWL/K5UnKZj5Hi/Dk=;
 b=ukm+vwRPajfOgOHaNW69n395riqrVPO+3Wjx83DpyTfX1HI/35jmNBUrs6uEUN1o58aP8S
 gkosftEp5eKidmBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F149913AB3;
 Thu, 14 Dec 2023 15:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id uBA1OScde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:52 +0100
Message-ID: <20231214151954.840244-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLbscyhnm3p7um4yytan3x3843)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.976]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[13.85%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 08/10] netstress: Rename option -D => -d
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

-D will be used for enabling debug info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                | 6 +++---
 testcases/network/netstress/netstress.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 0718a8ad1..e47ee9676 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -766,7 +766,7 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		D) [ "$TST_NETLOAD_BINDTODEVICE" = 1 ] && cs_opts="${cs_opts}-D $OPTARG "
+		D) [ "$TST_NETLOAD_BINDTODEVICE" = 1 ] && cs_opts="${cs_opts}-d $OPTARG "
 		   bind_to_device=0 ;;
 		*) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
@@ -776,8 +776,8 @@ tst_netload()
 	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
 
 	if [ "$bind_to_device" = 1 -a "$TST_NETLOAD_BINDTODEVICE" = 1 ]; then
-		c_opts="${c_opts}-D $(tst_iface) "
-		s_opts="${s_opts}-D $(tst_iface rhost) "
+		c_opts="${c_opts}-d $(tst_iface) "
+		s_opts="${s_opts}-d $(tst_iface rhost) "
 	fi
 
 	local expect_ret=0
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index fb6281cd0..5958150cc 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -1009,7 +1009,7 @@ static struct tst_test test = {
 		{"T:", &type, "Tcp (default), udp, udp_lite, dccp, sctp"},
 		{"z", &zcopy, "Enable SO_ZEROCOPY"},
 		{"P:", &reuse_port, "Enable SO_REUSEPORT"},
-		{"D:", &dev, "Bind to device x"},
+		{"d:", &dev, "Bind to device x"},
 
 		{"H:", &server_addr, "Server name or IP address"},
 		{"l", &client_mode, "Become client, default is server"},
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
