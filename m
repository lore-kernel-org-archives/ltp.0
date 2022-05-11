Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A7C433F5
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 11:45:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133813CA98C
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 13:45:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A4C3CA4FA
 for <ltp@lists.linux.it>; Wed, 11 May 2022 13:45:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E14F600425
 for <ltp@lists.linux.it>; Wed, 11 May 2022 13:45:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E5031F8FA;
 Wed, 11 May 2022 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652269541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtJJqncUcFfWtzI9g+8ma37RUET+hS/yIbjCeJjbrG0=;
 b=yMnV76UAtKPIcRu12745DCgVz6cDj2/MgGOGWg+9ocsUqaXaX3DSknmUPvlLug25E/b6po
 +tM9s8RZ8ojzT7lBkSajdRPAsvluw5vFZS2BUL/e6nzC6UwAXv3BtPJ9vO5fNT5/Sdq/vQ
 HFHMfkLa5IfTXIPhLB3qmObq3s0bt0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652269541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtJJqncUcFfWtzI9g+8ma37RUET+hS/yIbjCeJjbrG0=;
 b=Vq1wb7cWO3kWSeIHIqTk1i8jb+J30g59xscJTaPdXAJtOOEwkdbgRLKNP1fQ4Mbj3tF8Pp
 dYC6DjF55anyHnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B7A913A76;
 Wed, 11 May 2022 11:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ddZ6IeWhe2K7UAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 11 May 2022 11:45:41 +0000
Date: Wed, 11 May 2022 13:47:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ynuia7AsY/iW0j3L@yuki>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz> <87a6bwe7ps.fsf@suse.de>
 <YnOdXct59/QFXd1Z@yuki> <87fslocm83.fsf@suse.de>
 <CAEemH2feHOWW_vb89Z6bbsZEgnzxu7Wje3XKvST-zyBCHYFXbw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2feHOWW_vb89Z6bbsZEgnzxu7Wje3XKvST-zyBCHYFXbw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I suppose it is the innermost runtime, so I would vote for inner_runtime
> > or just runtime. However whatever it is called it will require
> >
> 
> I do really have the same feelings here. I'm even afraid 'iteration' will
> confused people who are not familiar with ltp-library.
> 
> From my comprehension, max_iteration_runtime takes effect on every
> onefold test iteration, or maybe just directly rename to 'max_test_runtime'
> (or max_runtime) with explanation in code comments.

Okay then, I guess that we will simply go with max_runtime then and
describe that it applies to a single call of the run() function in the
comments.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
