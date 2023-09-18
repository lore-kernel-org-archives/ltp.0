Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EF0CD13D2
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:08:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93B993CB491
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:08:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04FE63CA3D7
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:07:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F22C1A00617
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:07:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 160C01FDA1;
 Mon, 18 Sep 2023 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695031671;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EupYHCBp/MVH5uD6m5w1p9BJhLrIlSB1T2auBBEXh08=;
 b=E/8BAid5GFWeqTT5gvAuCidSkj9jubfKoiYmzaZa4dwV1PQG4iVmPOPA9H0+HRxzeYMG0+
 Cek2PYrO99vnAZdf+0Y51HzfV4lkpaVkD6b5ZzMExhm7MUi0p+x2IXUPnPatCaGZklRKHA
 qNqe8SxymewFL+l+X7X42KNk6da5YQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695031671;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EupYHCBp/MVH5uD6m5w1p9BJhLrIlSB1T2auBBEXh08=;
 b=NY8CjvbecyfhPaDYkUiALdr+RJwOfJZHscgchNrNbSUmW59bjbbyCNJfe/ntxCzWcSsyQZ
 pFZt522jV3u8vJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE7FC1358A;
 Mon, 18 Sep 2023 10:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fGz0OHYhCGXcLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 10:07:50 +0000
Date: Mon, 18 Sep 2023 12:07:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20230918100749.GC30304@pevik>
References: <20230918085502.17091-1-mkittler@suse.de>
 <20230918085502.17091-2-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918085502.17091-2-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Refactor ioctl02.c to use the new test API
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

Hi Marius,

Could you please fix formatting and other common errors?
$ make check-getxattr01
CHECK testcases/kernel/syscalls/getxattr/getxattr01.c
getxattr01.c:81: WARNING: Missing a blank line after declarations
getxattr01.c:83: WARNING: Missing a blank line after declarations
getxattr01.c:106: WARNING: braces {} are not necessary for single statement
blocks
getxattr01.c:127: WARNING: Missing a blank line after declarations
make: [../../../../include/mk/rules.mk:56: check-getxattr01] Error 1 (ignored)
getxattr01.c:50:3: warning: Symbol 'tcases' has no prototype or library ('tst_')
prefix. Should it be static?

Also (very nit), backticks (`) are good for github formatting, but they look
strange in git commits. Could you avoid using it in git subject?
(e.g. "Port `getxattr01.c` to new test API" should be "Port getxattr01.c to
new test API").

> Related issue: https://github.com/linux-test-project/ltp/issues/583
We use:
Fixes: #583

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
