Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C7C3F6B0
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:32:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1914F3C91B1
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 16:32:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B60133C812E
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:32:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3BA79600781
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:32:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 407BE4DF26;
 Mon,  1 Aug 2022 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659364352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXL2hKrfG1fIEFc/jxz1HKxlm/WxAcAJihhm9RECypY=;
 b=pLBglkEGGUxs5xvk9N8tyH+Q++BwkSZn/q6VLj2zQcDlcjLGAAlNBDefdvl8UCkUC3MbAG
 DdgJCGKA4yie9rePodBGAKOw6/Tghk4yiWPM8Xagx8GWb9pf2nFuwXWPznazWxoqs8hwx3
 mQBmGK45JpGnJzYWLhMWK7ptDdCGQGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659364352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXL2hKrfG1fIEFc/jxz1HKxlm/WxAcAJihhm9RECypY=;
 b=iLWnjAp4KuXb61V0DKrgijt1HOiiTpqTT/XKYk73CSQSu0TQL1RZSIeMrY1EKo1SSgScKo
 tcdqOglBzN33lUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 206A513AAE;
 Mon,  1 Aug 2022 14:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zbc0BgDk52KjWgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 01 Aug 2022 14:32:32 +0000
Date: Mon, 1 Aug 2022 16:34:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Greg KH <greg@kroah.com>
Message-ID: <Yufkaye0BpsmU+Eo@yuki>
References: <YufZ1ZcIhkjLFEWM@kroah.com> <Yufetwojkjxzwl34@yuki>
 <YuffaiUfSlrD1iJv@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YuffaiUfSlrD1iJv@kroah.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Linux kernel development reports for the 5.10 release
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
> > Obviously the email ltp@lists.linux.it is a maling list for a Linux Test
> > Project. The project is run by developers of several companies so I have
> > no idea how to map that to a model where email belongs to a single
> > entity.
> 
> I'll just map it to the "Linux Test Project", ok?

Sure, sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
