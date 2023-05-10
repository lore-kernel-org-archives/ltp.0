Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69869C77B7D
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 13:04:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07EC03CD687
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 15:04:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA9803CB0E3
 for <ltp@lists.linux.it>; Wed, 10 May 2023 15:03:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F5D31400B8A
 for <ltp@lists.linux.it>; Wed, 10 May 2023 15:03:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85D86219D9;
 Wed, 10 May 2023 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683723829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pYXeL3NkT0IQSOWCoxF4nEx+xs+9KMTKN0WdMsWO20M=;
 b=PFyExWbxEKH4CjQPhryT3L/vCt59xSzi6oZWE1Ii+uAx4MsnPU512aAnZGCye8q5r7t+kl
 tZI7kYCetXkxHPjH/JuaVWMDeiyZVOBB783yKSzJjHjQ8MjUKll4ZIUxzwS5mSdypj3KUC
 3xDUm/dCBCS4rylVntEqDV9M7txgOw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683723829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pYXeL3NkT0IQSOWCoxF4nEx+xs+9KMTKN0WdMsWO20M=;
 b=PP4H3l4gyDYy7YIhXYLHY29vD4j/G2/xLRcf98cunMWrNlMMv+1oUSvUqmJ7fTuEq7bYpM
 KtVY2xxhtOsA0bCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 555AD13519;
 Wed, 10 May 2023 13:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AClfEzWWW2SoBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 May 2023 13:03:49 +0000
Date: Wed, 10 May 2023 15:03:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 Jan Stancek <jstancek@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230510130347.GA225439@pevik>
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
 <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
 <ZFoSZkkjVXQhdEpe@yuki>
 <CAEemH2fycnWnsMe7sKZn357zj5QZr_Y7+ML0GAAWeQGkASu47g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fycnWnsMe7sKZn357zj5QZr_Y7+ML0GAAWeQGkASu47g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Hi Cyril, Li, others,

I see we're still discussing hugemmap test issues with FILE_PRINTF().
Do we want to solve these before release?

Because if we want to release on Friday, we should start writing release notes
and announcement. We're on a LABS conference next week. But not sure if it's a
good idea to postpone (Cyril is and will be even more busy, I'll be away for few
weeks before the end of the month).

From the list we agreed previously [1]:

    - announcement email,
    - collecting patch lists for a new release,
    - writing release notes, or paperwork,
	- new release commit and tag and create release in github from it (not in [1], but obvious)
    - uploading tarballs
    - pre-testing against different Linux distribution

I'll can do, what I did previously:
	- new release commit and tag and create release in github from it
    - uploading tarballs
	- release notes for shell API (mostly network shell API)

It'd be big help if Cyril managed to do release notes and the announcement.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
