Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2941C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 11:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C19CC3CAAD5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 13:48:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC0CB3CAAD5
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:48:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D8B86013B4
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:48:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2C251FA03;
 Tue, 13 Sep 2022 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663069712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8U1d95qmkAllCW9pXffd032tn0bn4MY/KTo9aMIOzjA=;
 b=GuFmH7WM2FsrBDoe2qYiJfv0jr0NHfHesSGdWPvG38T8YtfMT4Udyq0cBcD76Qx24KPnf1
 S0h8a4N/sGrBHNPXXglQTyDRskMhJcm+nBHOQ71zAK6PqbJaYI7RxLmuSmoJR0CM6uDyJ0
 BIVqeWsEILsxk6OUOsMKneyDka8Q8Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663069712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8U1d95qmkAllCW9pXffd032tn0bn4MY/KTo9aMIOzjA=;
 b=n4eHJVW9ylgD8WxfXnnT70GrgZtsXEkbCVR+sMytEqd+9WkZaxf/czHv64ZK6sAk3/P4QS
 EOGaciWKvyOq9jDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C15E013AB5;
 Tue, 13 Sep 2022 11:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0SPYLRBuIGNcbgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 11:48:32 +0000
Date: Tue, 13 Sep 2022 13:50:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyBuhAed+rlLDYGd@yuki>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Well, if more than three people are involved in the release work,
> I think that the release workflow should be arranged in time order,
> otherwise, we're easily going to fall into chaos. e.g.
> 
> Assumption work starting from the second week of the release month:
> 
> 1. Collecting the patch list for a new release, like this email does (Cyril)
> 
> 2. Reviewing and merging the patch list of step1 (All maintainers,
> LTP-users)
> 
> 3. Pre-release widely testing, we need to explicitly post results in step1
> email (Petr, Li Wang)
> 
> 4. Tiny fix according to pre-release testing result (All maintainers, users)
> 
> 5. Writing release note (Cyril)
> 
> 6. Uploading tarballs (Petr)
> 
> 7. Announcement email of LTP release (Cyril)
> 
> 
> Does this look useful? or anything else?

Thanks a lot for writing this down. Agree on all points, lets get to
work so that we actually manage to produce the release at the end of the
month.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
