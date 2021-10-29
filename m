Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C920C433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 09:39:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C216860F58
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C216860F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCE8E3C6EA0
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 11:38:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B066F3C5DD9
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 11:38:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7EFA6104AD
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 11:38:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0682A218A9;
 Fri, 29 Oct 2021 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635500328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfQ9H9wIU7EcSZClGvbTo00qnFbRlR8uUH/U6HrR5GI=;
 b=YG9at0mO337TzSM83KYYw4gBFPcCVe4iSMvx4ZLTHhVfpvsR+hfjPxASfJnUl+gaUgptSS
 06YMSvVa4WixA7PvSg1T7/Ul+4U12N+7DY+lW05e8waW8xYooU4SEP1nAZXRkm74fxMOnm
 TPbHpBcqp6yWXO013TA5avY24zGUV04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635500328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfQ9H9wIU7EcSZClGvbTo00qnFbRlR8uUH/U6HrR5GI=;
 b=gc+T82TbvhvS5kJuZ4vf+nj6d0ZWgTU7eFHcGh3zKc7vSEpurJ2i1q9DH/qSWTVl/pEJCZ
 iGbMmpXMcfFXiPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D64C813B8D;
 Fri, 29 Oct 2021 09:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id krV5MifBe2GBMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Oct 2021 09:38:47 +0000
Date: Fri, 29 Oct 2021 11:38:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YXvBJmtyWySs9knH@pevik>
References: <20211027092027.7124-1-pvorel@suse.cz> <YXkfDEFLUkOO+70q@pevik>
 <YXkhQ86Oal0KuI0K@yuki> <YXkmPU9/02Ickuso@pevik>
 <YXuvOmU3Q+n61eSn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YXuvOmU3Q+n61eSn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] CI: Reenable Tumbleweed
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

Hi Cyril,

> Hi!
> > > Looking at docker documentation it looks like --privileged disables much
> > > more than just the seccomp filtering. I do not think that this is a good
> > > idea. Let's go with just disabling seccomp for affected distros.
> > IMHO both are ok for just compilation (other projects use it as well for just
> > CI doing compilation), but sure, let's use the minimum.
> > FYI this disables seccomp for all machines. Is that ok for you?
> > IMHO that's not a big deal + we will not have to bother when Fedora also gets
> > new enough glibc (IMHO problem will periodically occurs on bleeding edge distros
> > when glibc starts to use new enough syscall).

> Anyways:

> Acked-by: Cyril Hrubis <chrubis@suse.cz>

> For the original patch that disables seccomp.

Thanks, pushed!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
