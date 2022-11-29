Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C48C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:47:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473103CC5B1
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:47:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EAE23C0162
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:47:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5404B60024C
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:47:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D05321B23;
 Tue, 29 Nov 2022 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669722422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BiIR0dLm6++9xnxIyc1lAlwp1dxO6759P7essKp53QE=;
 b=pGOgP6USSFvMcpjx6dbwSdOOh8yBEAhBFh6UmbXCiG9mej0PORt1CJgH8SkCQXDJWOhInX
 061xlmpqkERJdOaqELx28HUw2FeybUaypAbuZwdLH7N0LPq8EM8tgLd/YYGIWp5gVi9R7L
 uGFRquuHieSm+P1DEmxX5l1Q9Me2bmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669722422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BiIR0dLm6++9xnxIyc1lAlwp1dxO6759P7essKp53QE=;
 b=1cdZHOYHfiXkm5ddMOiv9P522AT/ecgwI8OYE1fxzgWyyBXO1h6SXxdoAWkKLmyY0oteen
 zYTc3OXKyUtR1oBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 778F213428;
 Tue, 29 Nov 2022 11:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i8PzGzbxhWOTcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Nov 2022 11:47:02 +0000
Date: Tue, 29 Nov 2022 12:48:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Y4XxhXsTrD2AA+WS@yuki>
References: <20221123144746.590890-1-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221123144746.590890-1-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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
> Accessing elements in an empty va_list results in undefined behaviour[0]
> that can include accessing arbitrary stack memory. While typically this
> doesn't raise a fault, some new more security-oriented architectures
> (e.g. CHERI[1] or Morello[2]) don't allow it.

Looking at how glibc handles this, the code looks like:

	int mode = 0;

	if (__OPEN_NEEDS_MODE(oflag)) {
		..
		mode = va_arg(arg, int);
		..
	}

That sounds much easier than messing with the macros and should avoid
undefined behavior.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
