Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E11C433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78DEB3CA93A
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 13:30:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F7A53C092F
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 13:30:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B241201150
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 13:30:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B6A22198E;
 Fri, 30 Sep 2022 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664537407;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6tzG58BlKDe5VxB4UFVt0mUPZDJC/09lEeCaCAJYH0=;
 b=RCu5jirdQaUQGG82n2nz1ZduCxbbrPvba3csY2USI+OYOQFzhCOvd7AxOGIfQWT/Uwh5Iy
 9TyUUDuzk18izZ4Vtce2etLoOFBx4nCqKTuU9OQcZ/IWK4UzJoeQHUSlgNAEgZem7l/qu/
 0zNcRn7ZSC+gnhZwEVMu0uGZ+I2h5fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664537407;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6tzG58BlKDe5VxB4UFVt0mUPZDJC/09lEeCaCAJYH0=;
 b=B0WBMG2LNvaX51YeJan+gGjY306FvXLoOlT8tejQXLi6bc2O92rJjJ/hOyqkKi3/0Zreua
 FHeZ3pvn8vR7tiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3C3313776;
 Fri, 30 Sep 2022 11:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x/IcOj7TNmNqDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 11:30:06 +0000
Date: Fri, 30 Sep 2022 13:30:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YzbTPONk9wuv5S97@pevik>
References: <20220930112434.13038-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220930112434.13038-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix missing cleanup run from
 setup
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

NOTE: we could add cleanup function call to at least one test
to have at least visual check that it's run and only once.

Kind regards,
Petr


diff --git lib/newlib_tests/shell/tst_mount_device.sh lib/newlib_tests/shell/tst_mount_device.sh
index 70f80f84a..4f387014f 100755
--- lib/newlib_tests/shell/tst_mount_device.sh
+++ lib/newlib_tests/shell/tst_mount_device.sh
@@ -6,8 +6,14 @@ TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_FS_TYPE=ext4
 TST_TESTFUNC=test
+TST_CLEANUP=do_cleanup
 TST_CNT=3
 
+do_cleanup()
+{
+	tst_res TINFO "run cleanup"
+}
+
 test1()
 {
 	EXPECT_PASS "cd $TST_MNTPOINT"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
