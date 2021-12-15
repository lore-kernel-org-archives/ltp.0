Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D977AC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D68593C8E4D
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:48:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD4553C81BE
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:48:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EE6C1001541
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:48:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 966091F382;
 Wed, 15 Dec 2021 09:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639561679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwP/31WU8cB/pDqJo9+rwmerFZE9xqn0gNRdzV6UMpw=;
 b=n5AuxJSCtPySi0UbowLi0Z5kGUQed2ZIf4l+V/PBg43bDBLbTOx5eZoXABtLAk22SsDnSm
 uUdA+rS7Vwt7FQHBNDiBVelmsxART76XIRSNNvqNH1J03lnN0LH0Vg58AJCM4xXSSOEILZ
 c2kxwrrxdUJuJOL4NzFl33Cu+CluXuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639561679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwP/31WU8cB/pDqJo9+rwmerFZE9xqn0gNRdzV6UMpw=;
 b=gXGArH/d6WNMHz93h5hmIBH/4dndjLiEJcPXkzYwMvdbS3LiUemeoN864a+18zuqShAUrN
 ExZ955b6volEYWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78CFE13B09;
 Wed, 15 Dec 2021 09:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bpKSHM+5uWFlXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Dec 2021 09:47:59 +0000
Date: Wed, 15 Dec 2021 10:49:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ybm6JHzG9TyUF3cS@yuki>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
 <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjKkic5F0j4c3bD@pevik> <YbjNExvj1vjnjb93@pevik>
 <BYAPR13MB250371A7DC839014B8219104FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjoeQ/lVsf01JJx@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbjoeQ/lVsf01JJx@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
> [ Cc Joerg, Li and Cyril, who were involved in shell timeout ]
> We spent quite a lot of time before we end-up with ceiling, I'd have to search
> for the reasons. We also didn't think that it's a big problem to not being
> precise on shell. But feel free to improve things. Just, generally we prefer to
> wrote small C code instead adding new dependencies (bc etc) or trying to make
> shell portable. Actually writing C parser would be few lines of code.

We even have tst_multiply_timeout() function in the C API that does all
the work. So this should be as simple as adding another C helper that
would take one number on commandline as a parameter and print the
result after calling the function.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
