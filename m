Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839FCC433F5
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 09:23:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9F123CA701
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 11:23:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF4733C889D
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 11:23:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EA1D60082D
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 11:23:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1636B21107;
 Fri, 22 Apr 2022 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650619388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmsD43ZsXj16JiYfD5ehMtC/eEhYeD8zAaFN0dS7EC8=;
 b=W/ZXBNVdr4ylAEIMM4C5OjNR8QwYSMYxOcz447nZQdF+1d+CFbrsWC244erVUL1s/DbiE1
 8+GucZk2x7yNPTQFCM3Q4+41YidOhlC7+nJmNs9WwQec+BpaahjNodsE+BCRVZAnaJavv2
 9FsXyXnh4gzgGr0MLfzRR9svertjmtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650619388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmsD43ZsXj16JiYfD5ehMtC/eEhYeD8zAaFN0dS7EC8=;
 b=f5ADQlFxDvA3AXaaJOlyo+Z3RcpUv4bpEZSzPFW/HxVxWDMXWT3CDufrPcfSXPzIRRcJnM
 +FzWZEqqcdF8iFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB2C0131BD;
 Fri, 22 Apr 2022 09:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eZsMNPtzYmK1DQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Apr 2022 09:23:07 +0000
Date: Fri, 22 Apr 2022 11:23:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>
Message-ID: <YmJz+odTX8Q8XV56@pevik>
References: <20220401215951.13976-1-pvorel@suse.cz>
 <20220401215951.13976-2-pvorel@suse.cz> <Ykd9CAXfi9FZ+iHB@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ykd9CAXfi9FZ+iHB@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Cleanup getopts usage
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

Hi all,

Martin spotted another error in zram01: setup() function in zram01.sh was not
called due being overwritten in zram_lib.sh. Replaced with conditional
expansion.

In case anybody wants to test this latest version is branch
tst_test.sh/cleanup-getopts.fixes in my fork:
https://github.com/pevik/ltp/commits/tst_test.sh/cleanup-getopts.fixes

Kind regards,
Petr

diff --git testcases/kernel/device-drivers/zram/zram_lib.sh testcases/kernel/device-drivers/zram/zram_lib.sh
index f2280334e8..6ce2ff1d4f 100755
--- testcases/kernel/device-drivers/zram/zram_lib.sh
+++ testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -12,7 +12,7 @@ sys_control=-1
 
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_SETUP="zram_load"
+TST_SETUP="${TST_SETUP:-zram_load}"
 TST_CLEANUP="zram_cleanup"
 TST_NEEDS_DRIVERS="zram"
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
