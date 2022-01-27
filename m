Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A1C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 14:04:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 144563C9742
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 15:04:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D1393C2AE9
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 15:04:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F7392009A6
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 15:04:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE4C3218B8;
 Thu, 27 Jan 2022 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643292251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ykiwOKoV12pVsVsGBCsxlCEM18Y1Y2sHQoAMM3IzCc=;
 b=q3ybRmZGf+2+2ei8KEcXNiZA8WTekHh51qHfzlGqvD+GL9wjyAd7HtWkUZtNDSq+MTplAW
 V31Vzw1eQmXEtu/bzg1F00bcKRWP/iYj34cacZ0pQVjyY/aKhbWv7DGJuSU9lFYqidxAHu
 dOBp+Vn930Uy79DpHwCLTcAvTOIVhnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643292251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ykiwOKoV12pVsVsGBCsxlCEM18Y1Y2sHQoAMM3IzCc=;
 b=9UKLAaTTJIKUqZT0xlqTYpMgJh2gPF3PtVVGodomftRSpDi57FvunP3/Gm8Dn4C2ER9hir
 5JL+U6GW5WjFsoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8526B13BE5;
 Thu, 27 Jan 2022 14:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b1qvHlum8mGaMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Jan 2022 14:04:11 +0000
Date: Thu, 27 Jan 2022 15:04:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YfKmWdNN+G/hjphN@pevik>
References: <a0733b841c7867ca6af1feb033b691c9f72ce0ec.1643291588.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0733b841c7867ca6af1feb033b691c9f72ce0ec.1643291588.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mkdir09: rewrite in new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> 'jump' variable is not initialized, which I suspect is behind
> rare failures of this test. The original test is using longjmp,
> processes and signals to sychronize couple processes that
> exercise mkdir/rmdir calls.

> Rewrite it using threads and new LTP API, drop all parameters,
> because no runtest is using them, and make new default test time
> just 1 second.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> It's based on original test, but I question its usefulness,
> since it's just mkdir/rmdir in loop over same directory.
> So, I decided to port it with just 1 second test time, but
> I'm not opposed to dropping this test entirely. Thoughts?

Not sure about usefulness. Also how about use .all_filesystems to have smoke
test for all supported filesystems?

Kind regards,
Petr

+++ testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -14,9 +14,10 @@
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
+#define MNTPOINT "mntpoint"
 #define MODE_RWX	07770
-#define DIR_NAME	"./X.%d"
-#define DIR_NAME_GROUP	"./X.%d.%d"
+#define DIR_NAME	MNTPOINT "/X.%d"
+#define DIR_NAME_GROUP	MNTPOINT "/X.%d.%d"
 #define NCHILD		3
 
 static int child_groups = 2;
@@ -166,4 +167,7 @@ static struct tst_test test = {
 	.test_all = verify_mkdir,
 	.needs_tmpdir = 1,
 	.setup = setup,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
