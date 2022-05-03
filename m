Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE424C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 21:10:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78F983CA6FB
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 23:10:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03AB13C9378
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:10:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 731F6600691
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:10:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E389210ED;
 Tue,  3 May 2022 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651612217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qvqz1CofcemAp3XoHJTqkUtdwnBY5L1aPX3lCivbQk=;
 b=za4j8Cycjz+pak3+R0AJpdKJeLhAvN+Kd4OGi21/TzfUqJonkB90xxgMut6o3oujtnXUIZ
 gYx/7Ut5Ht8Q0jlvs2jsdD38h4CXstKg0QgPYkNH/RDcrVp40rrJNvYRkHiyCuyMalRcos
 f3AzRAwveG+eeNzpJn9NWNLVgSDPH34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651612217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qvqz1CofcemAp3XoHJTqkUtdwnBY5L1aPX3lCivbQk=;
 b=n0c3HM09mdsGQ8UFthUrXqDKEDH8nOuhlzVy40c7KQ6ncegaN2KLucn4yR6qPrDThj8U05
 OCYfqfLSqIyyZ2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F4E813AA3;
 Tue,  3 May 2022 21:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /fAcETmacWLdBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 21:10:17 +0000
Date: Tue, 3 May 2022 23:10:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnGaN0TpFQ6HtmM8@pevik>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220503174718.21205-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
>  doc/user-guide.txt                            |   4 +
>  include/tst_test.h                            |  27 ++++
>  lib/newlib_tests/.gitignore                   |   5 +-
>  lib/newlib_tests/test10.c                     |  22 ---
>  lib/newlib_tests/test12.c                     |  21 ---
FYI test12 is run in CI, need to be removed from runtest.sh.

Kind regards,
Petr

+++ lib/newlib_tests/runtest.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
-LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
+LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test15 test18
 tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
