Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169C5C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 15:41:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8722B3C91B1
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 16:41:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1223C5A8A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 16:41:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6FDAE6019AD
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 16:41:40 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 672FE1F38D;
 Fri, 25 Mar 2022 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648222899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4WDZf9c+Pr7c+xCTilgHXPiH1xx/qDrHXcfPfsgEVDs=;
 b=XBx7o1QBT0FLV0rK4ebBMNEosxQL8bTmiYSy1n9XdXzdR70vjpf8PqMjj3CoP+8tgzjIsX
 MjoLDg9El0kjamWJPkQw12UPz9jCmEAvM+Q1RLIwykiz7Qhx64zv8ngkVvFonjg+nKH46v
 Ky36ly3i1d8I93FVQyalsABThe/b8v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648222899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4WDZf9c+Pr7c+xCTilgHXPiH1xx/qDrHXcfPfsgEVDs=;
 b=VOAWmfVKvsDot3ZnVqM9llT46VW9UBWRL7ZhLHjUVt3Ai2UaO0c1PGZpItWif5WyLXS/P4
 iI07BWDujz3fDQCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 453A51339C;
 Fri, 25 Mar 2022 15:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id HqGTD7PiPWK5IwAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Fri, 25 Mar 2022 15:41:39 +0000
Date: Fri, 25 Mar 2022 16:43:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yj3jPw3KRwneB2Hr@yuki>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325093626.11114-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] Rewrite userns01.c using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with one small change.

diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 460c20a8d..67708f10e 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -93,6 +93,10 @@ static struct tst_test test = {
        .setup = setup,
        .test_all = run,
        .needs_root = 1,
+       .caps = (struct tst_cap []) {
+               TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
+               {}
+       },
        .needs_kconfigs = (const char *[]) {
                "CONFIG_USER_NS",
                NULL,

This ensures that at least one capability is not set in the effective
and permitted set before we call clone(). Otherwise we will have the
full capability set before the clone() and we would inherit a full set
of the capabilities regardless of the CLONE_NEWUSR.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
