Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4EFC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:05:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BFB601FF
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06BFB601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD5343C715D
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 13:05:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AECE53C697C
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:05:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C219D2013C0
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:05:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E22701FD75;
 Tue,  2 Nov 2021 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635854706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsBaYj527wRAXMOsPtfBnWTFCYJVkwmoeuE/y8s0Xtc=;
 b=RMa34w45l4yupFoXj9KvFqPXaRMjq5WlmvGtn7sfEsuf3BjzisLHJ9SVAuY4QQFDzWiJxp
 D/v89CY1a8Y/cksNE7CH/Ic63itR13qEAwdeAqfz4ZQIOse75dOtXqn6Gdpz7CtEqqjzD/
 i0nJpkIIEnJFvNFPV74S5wqF3r3X+OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635854706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsBaYj527wRAXMOsPtfBnWTFCYJVkwmoeuE/y8s0Xtc=;
 b=92yBDWeiIDS0bdP/58FoEI+Q9AaFjRWaeCwR0eJU/OPLbHNUno4y7uJLmwmMQgJ41HgmO1
 ykmtCz+yKn2ZTGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE0B713BF7;
 Tue,  2 Nov 2021 12:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 31KcLXIpgWHIXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 02 Nov 2021 12:05:06 +0000
Date: Tue, 2 Nov 2021 13:06:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YYEpqT904sn9eplM@yuki>
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-6-chrubis@suse.cz> <87k0hqojm3.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0hqojm3.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/7] docparse: Add type normalization
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
> > - This code makes sure that we get right value parsed and aborts the
> >   compilation if the parser got confused. This part is important since
> >   if the testrunners are going to use the metadata the data in there
> >   must be correct.
> 
> I can't resist saying this would likely be solved by Sparse and its
> understanding of C types. However in the present context it makes
> perfect sense.

We would still have to check if we got right results, but yes, this is
one of the places where a proper parser would make things easier.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
