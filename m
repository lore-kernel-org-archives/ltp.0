Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A693EFA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 21:39:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EA7E3CAC33
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 22:39:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85323CAADC
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:39:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CCA6600204
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:39:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE1C336AA;
 Mon, 31 Oct 2022 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667252363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEf1G+EBJKndsYC3NIRNegO3pf14cMmdoww3LrNkZUY=;
 b=smeD5OyljfwbExY38+ZthjVfcJ05OMhKXBBAIP6glfivWz6fTvMw7IyXs+dMMFN6rKtyK5
 RpKAYsYFBZJHY8AnNgVjH+Cs2wd9zAYmAa4GGe1uOc5e41tR/DHcas1gZGRwguaKqRLfNj
 VQ7lwneb7OGsSqG0rqd56CzlpSb6mEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667252363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEf1G+EBJKndsYC3NIRNegO3pf14cMmdoww3LrNkZUY=;
 b=nB6qWoMK5bppCGk+E592ZclkQTv3jUzVubb/ztxp5/WeYCVndkhVJC6Sd7r5VOBGFCdoqD
 vgHJWH8mJKhg4SCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F9613451;
 Mon, 31 Oct 2022 21:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5r8KK4pAYGMiQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 21:39:22 +0000
Date: Mon, 31 Oct 2022 22:39:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y2BAiPUPKS3gimLD@pevik>
References: <20221027140954.4094-1-akumar@suse.de> <Y1+zeo9kmWOl2yE3@pevik>
 <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz>
 <Y1/SkicyE3Mg9Fpc@pevik>
 <96b14089-f1bb-e634-d74b-75fe92e58efa@suse.cz>
 <Y1/iFIltC2RXfDpl@pevik>
 <7c3efc21-229f-5e76-21e4-3e778e7ba140@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c3efc21-229f-5e76-21e4-3e778e7ba140@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

> On 31. 10. 22 15:56, Petr Vorel wrote:
> > Ah, sure, I see current_uid is used for checking only. So what is your
> > suggestion to fix the problem on 16-bit?

> I guess using UID_T (defined in the LTP compat headers) instead of uid_t is
> the solution, then -1 will be cast to the correct bitsize.

Thank you, that worked.

Merged, with additional cast to long to keep compiler happy.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
