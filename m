Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D3BC433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 538FC3C92D6
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:28:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 520CE3C908E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:27:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9F822005E0
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:27:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE3F321101;
 Wed,  5 Jan 2022 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641396477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1JZuEXz3Q67rtTOm0gUkiDm74087DsNVQt2df+MUQk=;
 b=gPygor5U2bSG0akj2XNSpSidvF+7MUw4cq/5eXnwx25qFzstWYBmCR833kY8WDC63IeQQU
 lR2dFAVWN+73gbnqnSB5Pp0UXPxI1cs4Pd+M6zBGnHhHP2s/MQzbqmDrFSCuJ4jWfxyy0x
 dPmpHhAyQKeBpnoQsZ2sBkJoVje1H+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641396477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1JZuEXz3Q67rtTOm0gUkiDm74087DsNVQt2df+MUQk=;
 b=c0CLoqWp0tmtPE9KnvHdhQuZXJhOVjF50eIQ2jNelnlfl8vZEPIoFp+X4gBmHUZPcqI6dg
 9tRxOjNvA6thlsBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D87EB13BF0;
 Wed,  5 Jan 2022 15:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TrFRM/241WGsbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jan 2022 15:27:57 +0000
Date: Wed, 5 Jan 2022 16:29:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YdW5WEXgrotentzM@yuki>
References: <87tufcao8l.fsf@suse.de> <YbcM8xKx7G0KQxWU@yuki>
 <61B70DE2.4040402@fujitsu.com> <87lf0oaeui.fsf@suse.de>
 <Ybc5QJSZM3YIji70@yuki> <87h7bca7vu.fsf@suse.de>
 <YbnI83sr26q+naFd@pevik> <874k7a9j5p.fsf@suse.de>
 <YboX0x4X05tMmUkE@pevik> <87lf0ffw1y.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lf0ffw1y.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
Cc: pvorel@suze.cz, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes. Although we could add "next" and "rc" flags to tst_test (or
> similar). Then require an environment variable to be set (or check the
> kernel version) otherwise the test will return TCONF.
> 
> For LTP releases we just need to check if the flags are still needed or
> if the feature has been merged. The metadata parser can generate a list
> of tests to check.
> 
> This seems like quite little work to me. In fact we don't even have to
> implement it until someone wants it. We can just add it to the policy.

I was thinking of this and if we really want this feature it would make
sense to add "remove_before_use" flag to the test structure what would
render the test resultless. Ideally it would include the kernel version
the functionality is going to be included into, then we can
automatically check in the CI the test metadata against latest release
kernel version and either remove the flag or bump it in case it didn't
get in.

Maybe just .remove_after_release = "5.9"

@Ritchie feel free to go ahead if you want to implement and maintain
         something like this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
