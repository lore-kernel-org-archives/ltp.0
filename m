Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D00ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:19:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9DFD3CA6E3
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:19:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CC143C9413
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:19:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A25231A006BB
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:19:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87EDF1F893;
 Wed, 31 Aug 2022 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661948342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmROc7GxODkejqDk5Q5qatjF1NF/KK4lyGvn7pC9Gyg=;
 b=dDRLwMMABmh+0PcIT1IrGtVmoUwhiPlBOkerc1Em3SG2fmSSvJLKH5+VYEpxfoj3GvrhOQ
 7lGrZLmPAuqN4f3UwHhP64THoYkifufk0uzqVHBsmYDrSI11ehgj2FeqUC+y/vDkUrkxNw
 XumvKYkepLokNYfDBYVDnWFQKbVHNz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661948342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmROc7GxODkejqDk5Q5qatjF1NF/KK4lyGvn7pC9Gyg=;
 b=ycY24V/qUnxlPcp3KZ1lIzZPvol6M16cdGAtfrLWp82JvRU0C66+nRLn8ouFR764m6YPFo
 hWoQVgdQ8KTT4FAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56F5E1332D;
 Wed, 31 Aug 2022 12:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HvimE7ZRD2PZFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 12:19:02 +0000
Date: Wed, 31 Aug 2022 14:18:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yw9Rs6+EIaSRxw9D@pevik>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-7-mdoucha@suse.cz> <Yw8aBE5SNZmY+mrd@pevik>
 <Yw8kncHPdgBl7tB1@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yw8kncHPdgBl7tB1@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
> > LGTM (test uses all_filesystems, but 20 for all possible filesystems should be OK).

> The runtime applies per single call of the run() function.

Thanks for a hint Cyril. I didn't read the sources correctly before. Now I see
alarm(results->timeout) in fork_testrun() which is called for each filesystem.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
