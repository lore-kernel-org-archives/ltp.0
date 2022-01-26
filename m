Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9A1C28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 15:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1FE83C96E4
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 16:08:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5319F3C960F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 16:08:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D7261000479
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 16:08:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20FE121900;
 Wed, 26 Jan 2022 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643209708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+yceicfLclrW0iqUNQ32Mz5b3CTDRfBzV9kkTaWm+zc=;
 b=ldd2ZUWh6RXWh7X5FTDKtqEdk9TE47zctbUFR3iVaF5mSFtZwAITZEI9fOKwdRAcp9Isi5
 fT1mtzTQORsDECrM3ZSe2vikSOzMwBzPA1MM9PW4whAuDYV3vwl2ne9h+PW5lmeYWO8Gp9
 WG2mhx8AehzMm0QPb2jcNZuhnx4P6VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643209708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+yceicfLclrW0iqUNQ32Mz5b3CTDRfBzV9kkTaWm+zc=;
 b=h53494Krpz6M++XcNNm+2Evero0e3zM1z0QM+GvNXnUK4gdtjSZ1RzX+XkswgfcNtmGIjl
 uKYuq1WoUWH9Z7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E789413C53;
 Wed, 26 Jan 2022 15:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m2KiNutj8WGGFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 15:08:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 16:08:24 +0100
Message-Id: <20220126150824.19331-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_net.sh: Print help ASAP
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

This also allows not requiring printing help with root when using
TST_USE_NETNS:

    $ PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
    gre02 1 TCONF: Must be super/root for this test!

And with root setup was unnecessary things done just to print help:

    # PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
    gre02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    gre02 1 TINFO: add local addr 10.0.0.2/24
    gre02 1 TINFO: add local addr fd00:1:1:1::2/64
    gre02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    gre02 1 TINFO: add remote addr 10.0.0.1/24
    gre02 1 TINFO: add remote addr fd00:1:1:1::1/64
    gre02 1 TINFO: Network config (local -- remote):
    gre02 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    gre02 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
    gre02 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
    Usage: /opt/ltp/testcases/bin/gre02.sh [-6]
    OPTIONS
    -6      IPv6 tests
    -h      Prints this help
    -i n    Execute test n times

Now just help is printed, work for unprivileged user:

    $ PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
    Usage: /opt/ltp/testcases/bin/gre02.sh [-6]
    OPTIONS
    -6      IPv6 tests
    -h      Prints this help
    -i n    Execute test n times

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 4dc0fca926..047686dc39 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -937,7 +937,7 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
-[ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
+[ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
 
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
