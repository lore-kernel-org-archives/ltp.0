Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845FAC433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 14:52:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59C193C9223
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:52:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A12CA3C6A74
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:51:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 362D5600A55
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:51:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54A3B210FE;
 Wed,  5 Jan 2022 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641394312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyG1OuhP7xn6OYEfgo6nqB216p1X3jlHpjtrto9urQ8=;
 b=zKqdrzR8DA06/4801xJvwU0FzdEk4UaCmIJ3sEiDb/oDhLgXWx6J0eOH02TadjZdjz2PO8
 kUlqkmAy5MK56ZIplTul7898MVFJ1kemwryE0f2BU35/7TdUE/JVt/bHodqklcWMOLt75Z
 RCKYrslxzHiViBstd+abNeHEtAnF33U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641394312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyG1OuhP7xn6OYEfgo6nqB216p1X3jlHpjtrto9urQ8=;
 b=2om+glnRxuqrAbbDQYMD4IkZwKk5+ftlTxkvSSOVgrE9RIgxCV8oST01P3tVfWdDXOCpoK
 oA8SWNvNp2GeZRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3764813BE7;
 Wed,  5 Jan 2022 14:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nLcUDYiw1WF8XAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jan 2022 14:51:52 +0000
Date: Wed, 5 Jan 2022 15:53:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YdWw4rza2wHGQqA9@yuki>
References: <YdWC0f+70TF6Eluk@yuki>
 <CAOQ4uxg4sv9otWKSJCvdtaJnQrgaXUqvgPtnydDp6V8jio3nUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4sv9otWKSJCvdtaJnQrgaXUqvgPtnydDp6V8jio3nUA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > As usuall it's time to start preparing for the next release.
> >
> > Given the amount patches waiting for the review I guess that we should
> > try to get reviewed and merged as much as possible in the next few days.
> > I would go for git freeze at 14. 1. as that would give us a week for
> > pre-release testing and the release would be, as usuall, finalized
> > around the 21. 1. Feel free to reply if you think that the schedulle
> > should be different.
> >
> > Also if there are patches that you think should be merged before the
> > release let me know ASAP so we can have a look soon enough.
> >
> 
> Maybe that's a good time to say I did not understand the resolution on the
> discussion [1] about timing of merging tests for new (i.e. v5.16) features.

I guess that's because we haven't ended up with one as the discussion
faded away before christmas break. I guess I will read that again and
try to do something about it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
