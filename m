Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118F4C6FA82
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 21:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F6F93CAD64
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 23:09:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF52A3CA9D2
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 23:09:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA3A06001B1
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 23:09:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75AFF1F88B;
 Tue, 20 Sep 2022 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663708163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4xaNcRN1dlB10MJ1Xw/uVQKk+3Umc54LVUNtid7If0=;
 b=jBBe7r69686vxoN9MXhZjC/rNE2euiyJlRdyVBs1eGtljm4XqbkIihK89mt42mxVezxg8K
 W/oQAp7GltwNvVGHL9KT8KRaSATF5twId4zfVIjvayXJW0gLc9hC+fqssUAEs0iZR3Vs1I
 afNcuRdTYs50CmtIPGMWkMHIAqnUBHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663708163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4xaNcRN1dlB10MJ1Xw/uVQKk+3Umc54LVUNtid7If0=;
 b=QtbbBOMI8qMaK3+1mxvQnzZrqYz3+Rs84DXq87ZmppFqFMGe7pEKl4GlHY+AG5synAE+RA
 ZP9t4LCZqfzUYGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ADA113ABB;
 Tue, 20 Sep 2022 21:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pFy/DAMsKmPINAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Sep 2022 21:09:23 +0000
Date: Tue, 20 Sep 2022 23:09:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YyosAWUf7pbVMpBt@pevik>
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
 <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
 <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
 <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
