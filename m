Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC2C4332F
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 09:59:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0252960F94
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0252960F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A0823C12A9
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 11:59:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C56DF3C0E8A
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 11:59:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02542200985
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 11:59:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CFA41FD7B;
 Wed, 13 Oct 2021 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634119170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOr/1EZGCv5v0nrntDqU5Za6rZts2B5hlsxLlTWB/HA=;
 b=zD1mEjM1jQ7PP1v5aGRDACmIq4/KorrhD2qggGpS8PCQjWNdiNmiiqNDpotyTxzxaJOtb5
 dHH/VuWHIonMxnZpuxTOJtsgLzxHdptno+fNhb8zjqYN4JtBCN63pAVSPm7B5HTIQJqXnI
 jjNm/OKfumOpl0h3vCBppcpuGMGedm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634119170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOr/1EZGCv5v0nrntDqU5Za6rZts2B5hlsxLlTWB/HA=;
 b=tS4c5t/czY0l7oYJQtzpFhFECK6inY2UYX6bgjXXPpoWAV5un3v4PMl9f5OUGHL3EmVMhF
 eiUCdisF8Vr/OXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF62E13CEC;
 Wed, 13 Oct 2021 09:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +i03MgGuZmFwPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Oct 2021 09:59:29 +0000
Date: Wed, 13 Oct 2021 12:00:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YWauKx1QIWx5g4yn@yuki>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <20210923085224.868-5-zhanglianjie@uniontech.com>
 <YWVXZ5X/7PFkgvBx@yuki>
 <2a7ff8ae-49f3-bdd8-c5c2-4e6731922978@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a7ff8ae-49f3-bdd8-c5c2-4e6731922978@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] syscalls/clone07: Convert to new API
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
> > I do not get why we need this complicated handler setup.
> > 
> > Why can't we just SAFE_WAITPID() for the child, check the status and
> > fail the test if the status is anything else than:
> > 
> > WIFEXITED(status) && WEXITSTATUS(status) == 0
> > 
> The processing here is to accurately determine whether a segment fault 
> signal has occurred in the child process. Of course, can also use the 
> method you provide, but you can only judge that the child process exits 
> abnormally.

Well I do not think that the SEGFAULT needs to have special treatement
here, as long as the child does anything else than exit with 0 it's a
bug, that's why I think that we should fail the test in all other cases.

I guess that we can add special check for the regression with
WIFSIGNALED() && WTERMSIG() == SIGSEGV and produce slightly different
TFAIL message, but we should really fail all the other cases as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
