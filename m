Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F3FC433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 10:08:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB8983C98C4
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 11:07:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F893C987E
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:07:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 74F05600D92
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:07:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A742321101;
 Wed,  2 Feb 2022 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643796469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HoZuM62OXSh29JBCtS2G4d7cIhjRIJUYelIsnlHr8zE=;
 b=xkjzeoGpw0Qjo7F0KL6XYdDRehmMQx9pEKcw7j4P68OzJjFucajlqcnMegdE8q3XJxpVPO
 uqVNlvWSvO7Aifkjtkmh52p4SNsdmXnAFTYPhH/s9R5QLHaI4gDVILmxNl/80Bt31pzSwQ
 41wL/+177mDHZfqXrsWTjORy89YAnl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643796469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HoZuM62OXSh29JBCtS2G4d7cIhjRIJUYelIsnlHr8zE=;
 b=AEc0YwRxzcAED3tsZLzKePE/Ft7mOAppH7WXwQzV8bcd/SLN5oJPXCwe90mk4GSY4uGnm2
 8CupYqFQWFMBh+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 803C413DFF;
 Wed,  2 Feb 2022 10:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JnGlHfVX+mF1WgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 10:07:49 +0000
Date: Wed, 2 Feb 2022 11:07:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YfpX86K/z064Wpz3@pevik>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

...
> > Yep, ack this one, works well. Will you please send a proper patch?

> Sure, but I'd hold this until Xu Yang review. In case I have
> something thoughtless.
Sure

> Ps. He might reply late since now is on China NewYear holidays.
Enjoy the New Year and your vacation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
