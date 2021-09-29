Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD9C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:12:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304F8610CC
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 304F8610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DDE03C8199
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:12:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 367B13C6DFD
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:12:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9454A600F2C
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:12:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9423E223CE;
 Wed, 29 Sep 2021 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632903161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmQRPHaZsKEeXYT4H7R9Qv+G4NzTmq+cFM5cs6sadN4=;
 b=nfGulso7p0kT+EGV9CcIidZ3s+EzLbXiiUOPY08SH0iV17pkKTZJlINUr+PCgvrjQEk64J
 MaYajpP/HVhaARGZrBAYprjgd3bEaOpcL5/P0xi3ChloDDDUg5BoFjiiOz4JRaOj16fc4e
 pMUxa8kaduK2osPAuawUo02c5B9jBqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632903161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmQRPHaZsKEeXYT4H7R9Qv+G4NzTmq+cFM5cs6sadN4=;
 b=rVSvGNQewOuVmWKUMvjHmGlXFO23eHOFpX8IPNIZZbURUw2/PaJBu+SzVXNUR6yIWxyEgG
 tcCarBQazO9XWtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EC4913A81;
 Wed, 29 Sep 2021 08:12:41 +0000 (UTC)
Received: from dovecot-director1.suse.de ([192.168.254.64])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2bh7FfkfVGHTDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 29 Sep 2021 08:12:41 +0000
Date: Wed, 29 Sep 2021 10:12:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YVQf9xSxrXjobBM9@pevik>
References: <linux-test-project/ltp/releases/50325863@github.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <linux-test-project/ltp/releases/50325863@github.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
Cc: Sandeep Patil <sspatil@google.com>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

from 20210927 LTP release:
> * Testcases were fixed not to expect certain users and groups to be present on the system
>   - some tests were expecting bin, daemon and similar groups and users to exist on the system
>   - now LTP depends only on user 'nobody' and group 'nogroup'

At least some tests (e.g. fchmod02.c, chmod07.c) require other groups ('users',
fallback to 'daemon' which is on AOSP):
ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");

@Sandeep: is 'nobody' on AOSP or do we still need SAFE_GETGRNAM_FALLBACK()?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
