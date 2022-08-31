Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166ECECAAD4
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:19:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E65AF3CA6F9
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:19:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4ABB3C9413
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:19:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B2CE61400974
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:19:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B33922135;
 Wed, 31 Aug 2022 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661948361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuykU5H8ivn0AnlvC9ui3a+08GJ6Uoo1bVLGHwrWr9Q=;
 b=vm9X2BjZhKRJ1MKCZFGRPVYhQGC5/2lnIk5BarL4R8TtLi6OGebQcYpU7xlz04FFS6Er4T
 7u9mcR044o7OA2XVpnvgfcNniPzueeSk3vbFY3b/x+AVx0SDvsTwCnFNHnAWQaqk6MOG4K
 qMRISJ6MutLizw6HpGcSInp23YxhHCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661948361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuykU5H8ivn0AnlvC9ui3a+08GJ6Uoo1bVLGHwrWr9Q=;
 b=Khzuwii3BN9STccGBkhKaT0niMoCowYWNh/yVpQnGk+wIJjTlmVCgPcRHVg1x4G1Oc8b6+
 Q3kyDxvnqU/KKyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7258E1332D;
 Wed, 31 Aug 2022 12:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id laHbGclRD2MEFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 12:19:21 +0000
Date: Wed, 31 Aug 2022 14:19:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yw9Rx3gULJDKJHwO@pevik>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-7-mdoucha@suse.cz> <Yw8aBE5SNZmY+mrd@pevik>
 <256a2476-dff0-dfe0-8913-4cfdd38c8a6d@suse.cz>
 <Yw8o/igtdRCALl1x@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yw8o/igtdRCALl1x@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/10] copy_file_range01: Add max_runtime
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

> Hi!
> > > LGTM (test uses all_filesystems, but 20 for all possible filesystems should be OK).
> > Hmm, I've missed the .all_filesystems setting here. In that case the 
> > test should take ~2 seconds per filesystems and the patch is not needed. 
> > Feel free to discard it then.

> I would still vote for adding something as .max_runtime = 5 or something
> like this so that it's obvious that the test can run for a few seconds
> per run() call especially on slower disks.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
