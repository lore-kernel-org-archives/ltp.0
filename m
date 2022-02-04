Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A278C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 19:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A164C3C9B4F
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 20:47:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2693C3C6FE5
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 20:47:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E5831A010ED
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 20:47:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81A5A1F382;
 Fri,  4 Feb 2022 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644004026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOSasExV6TCfNueKFRKvvTGuJN7ULxNR3480D5sNus0=;
 b=IgyFUDxJ7ibFP7Dk8U56VTIPxZgODE9IVirlB3ZpkWm8Z9yBHm+puGgDQvTC1jxFa3Vogb
 kKIlkIxIA+GhVyHr7as8ul6a5hrLBH4BSR6jPHBOoktrJeusTGcRlE8Nga3t7wK0HYBDu8
 FVBwE289Fl1Zjtmnqdt8SVWr0XtQq8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644004026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOSasExV6TCfNueKFRKvvTGuJN7ULxNR3480D5sNus0=;
 b=ElGybGba86IukV52ICnNBLiYEzJmOMbUDT60RNTYd3uepUgw7vp/9yka8kslswlzILmHH3
 G52ea0FYMyzSt8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E1DA13A91;
 Fri,  4 Feb 2022 19:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WDl4ALqC/WHtEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 04 Feb 2022 19:47:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Feb 2022 20:46:47 +0100
Message-Id: <20220204194648.32165-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204194648.32165-1-pvorel@suse.cz>
References: <20220204194648.32165-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] broken_ip-nexthdr.sh: Check IPv6 support
 before forcing it
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/broken_ip/broken_ip-nexthdr.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
index ec6643af66..cb4a3dd399 100755
--- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
@@ -11,6 +11,7 @@ TST_TESTFUNC="do_test"
 do_test()
 {
 	# not supported on IPv4
+	tst_net_require_ipv6
 	TST_IPV6=6
 	TST_IPVER=6
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
