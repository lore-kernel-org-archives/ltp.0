Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B842EC433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 06:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D263CA96C
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 08:51:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3FD03CA80D
 for <ltp@lists.linux.it>; Tue, 10 May 2022 08:51:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B97C10008EC
 for <ltp@lists.linux.it>; Tue, 10 May 2022 08:51:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FB5F21C48;
 Tue, 10 May 2022 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652165474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9ur3la4JojMO0jGleKzsD67RfJF6ctajiupaERmOTc=;
 b=q7L0zvn/KrBS0JZImdOSiLvWCMupkfyy3PxVAS2llHUfFZeCzBD5dh5GEN2hMucErgaf/S
 n0whTUqEbFyNoDk5plTL2iSb8MoJvuPZNy0S8LJPlJ8qrKR9HbVHPIn73hHNCH+HRKlRFS
 VlPy0qr0chFUo+58kyqsbztma32I4XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652165474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9ur3la4JojMO0jGleKzsD67RfJF6ctajiupaERmOTc=;
 b=874rT4srttlDoW9soTzVGdXAvF2099eTk3c0MQlXchRZ+njtwI8Do5t4q54OS0YX/HFRMg
 MNRCXNSxUBM8zTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9A6C13ACD;
 Tue, 10 May 2022 06:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ePHtL2ELemIOZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 06:51:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 May 2022 08:51:04 +0200
Message-Id: <20220510065104.1199-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510065104.1199-1-pvorel@suse.cz>
References: <20220510065104.1199-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] netns: Rename netns_helper.sh -> netns_lib.sh
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP shell libraries are called *_lib.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 testcases/kernel/containers/netns/netns_breakns.sh              | 2 +-
 testcases/kernel/containers/netns/netns_comm.sh                 | 2 +-
 .../kernel/containers/netns/{netns_helper.sh => netns_lib.sh}   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename testcases/kernel/containers/netns/{netns_helper.sh => netns_lib.sh} (100%)

diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
index 0b2eb319c..a5cec0953 100755
--- a/testcases/kernel/containers/netns/netns_breakns.sh
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -22,5 +22,5 @@ do_test()
 	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK
 }
 
-. netns_helper.sh
+. netns_lib.sh
 tst_run
diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
index 6570f386e..c7c2ae07a 100755
--- a/testcases/kernel/containers/netns/netns_comm.sh
+++ b/testcases/kernel/containers/netns/netns_comm.sh
@@ -34,5 +34,5 @@ do_test()
 	EXPECT_PASS $NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $ip_lo 1>/dev/null
 }
 
-. netns_helper.sh
+. netns_lib.sh
 tst_run
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_lib.sh
similarity index 100%
rename from testcases/kernel/containers/netns/netns_helper.sh
rename to testcases/kernel/containers/netns/netns_lib.sh
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
