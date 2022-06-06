Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2102FC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 20:20:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D003C8D01
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 22:20:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 728EB3C051B
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 22:20:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5EAA110006DB
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 22:20:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8830E1F45B;
 Mon,  6 Jun 2022 20:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654546841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXXkgThpFeK0h1pAly7f481TOnNmRuO+IPizxSHpLr0=;
 b=Ymdo2tY573GuCTNfiGnV6OkzkfLcyh4GXPDksC8VjraiO5/Mui+OtJvttW5vh6q6x5Jmy6
 i3BRy+SHMULegu/BTOhJ/DBBpI6PQm93tBk7NMMkZVPCUskYVzTZVWgprFDzROlRtYTcZP
 2rtUkILSzW0t1YoKTZZKkVgDGxSU7b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654546841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXXkgThpFeK0h1pAly7f481TOnNmRuO+IPizxSHpLr0=;
 b=ATTz4Z1nITM/9Rg8U8elIvFXqvmC7BziDcmpabrKAkTD3RdLdsb6uFNd7hIeUQtr/dCia5
 7LkD/tiJWX7lkiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52A6413A5F;
 Mon,  6 Jun 2022 20:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O87gEZlhnmK8TAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jun 2022 20:20:41 +0000
Date: Mon, 6 Jun 2022 22:20:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yp5hlrqtwtE0r4Bj@pevik>
References: <20220606100034.169493-1-liwang@redhat.com>
 <20220606100034.169493-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606100034.169493-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: extend .request_hugepages to
 guarantee enough hpages
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

Hi Li,

> diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
...
>  static struct tst_test test = {
>  	.test_all = do_test,
> -	.request_hugepages = TST_NO_HUGEPAGES,
> +	.hugepages = {TST_NO_HUGEPAGES},

Also comment at the top should be renamed:

-Tests .request_hugepages = TST_NO_HUGEPAGES
+Tests .hugepages = {TST_NO_HUGEPAGES}

Unrelated to this change:
I wonder if we want to use docparse also for API tests.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
