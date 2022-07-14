Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA1AC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 13:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F33D3CA9B9
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 15:02:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650883CA491
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:01:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBDD6600D0F
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:01:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82A0B33E4D;
 Thu, 14 Jul 2022 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657803708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ydJLJNz+41oeHSDM1ARkiQ/HpgCIH/zx0NB3DnX2qko=;
 b=TqfYxRQBLtMarStlFq94hbn5jIvjum5QTDm6u9Fcf7c5QhW5lEpQsopTGqP+/VkRu9+sVi
 X/opiYIXvWQ6ft46xBDviTR0hpvC4kzNs5LP0F2SVpvLNZ5eKkwedFKBK8zfx1Vgamr7U5
 wok4YDG7jD6ZZwIDRNMj5oHE4BYZKD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657803708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ydJLJNz+41oeHSDM1ARkiQ/HpgCIH/zx0NB3DnX2qko=;
 b=oTlpuWHckn+GjwOUjzRZPaafwfUrbdV/R0P3ZZM8YCbhJ8BT07F8tycL23loVzQSXCDNGS
 ntdJQi7LqvFYHhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F92813A61;
 Thu, 14 Jul 2022 13:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A1xVGrwT0GJcDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 14 Jul 2022 13:01:48 +0000
Date: Thu, 14 Jul 2022 15:03:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YtAUMCRnpM1zHug1@yuki>
References: <20220620092146.7604-1-chrubis@suse.cz>
 <20220620092146.7604-8-chrubis@suse.cz>
 <0168e60b-9c56-af45-d754-75ce09b359fc@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0168e60b-9c56-af45-d754-75ce09b359fc@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] opeposix: pthread_barrierattr_getpshared/2-1:
 Simplify codeflow
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
> > +	} else {
> > +		return serial;
> 
> The return can be unconditional.

I changed the code a bit more in the end to make it even more readable,
now it's structured as:

	if (pid == 0)
		return serial;

	/* parent */
	if (wait(&status) != pid) {
		...
	}
	...

	printf("Test PASSED\n");
	return PTS_PASS;

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
