Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CAFC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:24:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F8AF3CA07A
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:24:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6E3A3C9E16
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:24:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DBDE26013AF
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:24:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C63A21F383;
 Wed, 16 Feb 2022 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645014257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCsku2Im7t1zz8HGMYnrWt6SRYNzA2p67O3a8iif0Wc=;
 b=hc0BGudJgDJoq19kUvWFb7jMdMHt3T5ztE72Nlwn1vqLTQznFvupF1062IRqw6CdiKWfvx
 LJEaLR6Ot9kYb0VtFeFy9s2eqs2lN2+q8bTBmlnzJFpOwjec5alf9cpDtJDZvQZ6S2EJqd
 uIU0wnUTTBVJgWU+qAsDGG7B4f8OSLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645014257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCsku2Im7t1zz8HGMYnrWt6SRYNzA2p67O3a8iif0Wc=;
 b=Tif6kC6T7UIKofxTBu6S0pCbVQf2w6Y8RPktrZQ/z4RJk7nyydZzCBLPtabMY514PeJXXz
 Tj/F0fP8mDl60cCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9595913AF3;
 Wed, 16 Feb 2022 12:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HL+VIvHsDGKoTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 12:24:17 +0000
Date: Wed, 16 Feb 2022 13:24:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: blezhepekov <blezhepekov@suse.de>
Message-ID: <Ygzs743J6wEufx61@pevik>
References: <20220216090708.29588-1-blezhepekov@suse.de>
 <YgzDPl1u6Nr9YqYI@pevik> <9eb2b9ccd6323684b2ce7916e0be5572@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9eb2b9ccd6323684b2ce7916e0be5572@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ltpfs/main.c: Initialize return variable
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

Hi Bogdan,

> > > LTP_fs_open_block_device returned initialized local
> >                                     ^ uninitialized ?

> Oops, it's a typo. Obviously should be "uninitialized".

> Want me to submit an update?
No need, I fixed it before merge.

Merged as d66c51d92c.
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
