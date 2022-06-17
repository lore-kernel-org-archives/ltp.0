Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9642C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 15:07:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95EAF3C8D96
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:07:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF08E3C759A
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 17:07:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51460200DF3
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 17:06:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB7221C54;
 Fri, 17 Jun 2022 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655478419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aUfc2BlBeLq48GzXjmSDXBS4CdXqe/Z8yflbg0Fv4Y=;
 b=y91QROJ9lB5PVN0tcPHtQFrzgACIr+euOR1Z+X1i68qhCsPTcUZWmceAfoyj+2jpTzvQbn
 b5wMkKbcRGbNAdFkqRNJWrZ8bXMJSu/wjqCZeACeAC1Taup6hd4ARa9Wdu3wIz0GEJWwRg
 8W2M7GBIcT6FSKzSRytvUJFA3YZhAps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655478419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aUfc2BlBeLq48GzXjmSDXBS4CdXqe/Z8yflbg0Fv4Y=;
 b=ATaDf1BvKrFRfBmuzk4fVKY35RkuRMWd/aB7jhdxUH3vkRZRDVqRJCRTNYZjmZx0o+HWxQ
 UQ0xs9Ksg3UBFiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 756BC1348E;
 Fri, 17 Jun 2022 15:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fM1wG5OYrGLYPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 15:06:59 +0000
Date: Fri, 17 Jun 2022 17:09:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YqyZFXpsGsJvsHGn@yuki>
References: <20220616162339.19322-1-pvorel@suse.cz> <YqxFo1iFzHatNRIl@yuki>
 <YqyDtBC3++fGQGdp@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqyDtBC3++fGQGdp@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] nfs05_make_tree: Restore 5 min
 timeout
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
> > I guess that it would probably implement main() in the nfs05_make_tree.c
> > instead as we do for the various tools in testcases/lib/*.c. That would
> > at least make sure that we will not break anything with changes intended
> > for tests and not for helper binaries as this one.
> 
> Helper binaries does not use LTP C API. I'd like to keep it (to have SAFE_*()),
> I guess you're not against. Therefore just using TST_NO_DEFAULT_MAIN
> and adding main(), right?

I guess that would work, but I will have to double check the tst_test.c
library.

Also I'm not sure that this would be the best solution, mixing C and
shell code was always akward and maybe we can figure out how to make it
better.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
