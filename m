Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B57C433F5
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 09:46:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B93A3C9DFD
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 11:46:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DB693C089F
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:46:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 090FF1000451
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:46:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BB8621603;
 Wed, 30 Mar 2022 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648633600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCmDpJEIy4VVJeloMOkLe5NBrLCBE5tj4DKQPLpOMLs=;
 b=LaSM45e8C8jiaKLD/Z6WaZnd5/W2Zc2M06lgXEwpnJW2zT6vxWURZWM81Kdtc5zzg1n6mH
 DAzZeB17ZffRmY6oWHO5uhJUSTd0bOqSUrqezk6zKrdSZb3bnyKRbPXtNlXT2CmwnU0xye
 gYLuGnrgH32EXThxWDjaV7C7HFWrOKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648633600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCmDpJEIy4VVJeloMOkLe5NBrLCBE5tj4DKQPLpOMLs=;
 b=XHb2Jj5P8/0c7+uJt+cxQjYRuuhk0qrMurZlOQ/nnjPJSJnqBFqoHxYfk9gBh8Uy6icD9f
 WZ3MSLGHbXBHR9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03F0C13A60;
 Wed, 30 Mar 2022 09:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7fWCAAAnRGIrZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Mar 2022 09:46:39 +0000
Date: Wed, 30 Mar 2022 11:49:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YkQnjMOadd/hbRBI@yuki>
References: <20220329050351.688432-1-liwang@redhat.com>
 <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
 <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_gettime04: set threshold based on the
 clock resolution
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
Cc: Waiman Long <longman@redhat.com>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, ltp@lists.linux.it,
 Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Thierically that's right, we only make the resolution as additional value
> to tolerate.
> 
> But I'm afraid this is the part we can not guarantee especially for VM.
> As from Eirik's test history, the KVM guest ever failed with "150ms" delay:
>   clock_gettime04.c:163: TFAIL: CLOCK_BOOTTIME(vDSO with old kernel spec):
> Difference between successive readings greater than 50 ms (2): 150

I do agree that on VMs all bets about timer precisions are off but I
still think that it makes more sense to run the test with greater deltas
there. As long as the VM has acces to high resolution timers we will
will have smaller delta for these clocks using them.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
