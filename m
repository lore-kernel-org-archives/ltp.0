Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60901C001DE
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 08:45:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEB053CD625
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 10:45:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 837B43C8B1F
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:45:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 854F6140113E
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:44:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 759D8219A4;
 Fri, 28 Jul 2023 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690533898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3dMlcw/1XC3WV+ixpl/KpnMR8LY4qty4IMhZRNLtFw=;
 b=OmDY+guOLSlc3meGo0vGVDNd1JxQxWk8ZHurqunNBjQP7EIYiYkjLVSQgMLEG/ndUh0OLQ
 Sl09lWjLhXlO3LP9wD2iL/smOLTjUXml05nwOw2hc0+P5T+McwEIcb9+o6kq1VCWhTphX1
 weeM5a5WAqI6v3QOSnCqSpK1t8dbF/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690533898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3dMlcw/1XC3WV+ixpl/KpnMR8LY4qty4IMhZRNLtFw=;
 b=+vR2Db0yW+C1O6HQ4LyaFcVUFrNHF2Prhf3jQNpx0Ff8bVCUnapq2ObUj4BgWexMCZV654
 Zjxn5U1c8m2DqWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C191133F7;
 Fri, 28 Jul 2023 08:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6zs1CQqAw2TIcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jul 2023 08:44:58 +0000
Date: Fri, 28 Jul 2023 10:45:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZMOAQDXf6Wv4VEQZ@yuki>
References: <20230727150013.31835-1-mdoucha@suse.cz> <ZMNya4WWC3IP6FZZ@yuki>
 <97f281ba-4c7f-b1d9-19c9-71884e4c19bc@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97f281ba-4c7f-b1d9-19c9-71884e4c19bc@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_netdevice: Add missing rtnetlink context
 allocation checks
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
> The tst_brk_() gets called by the safe_*() functions deeper in the call 
> tree. But tst_netdevice functions may be called from cleanup() where 
> explicit return is necessary even after tst_brk_().

Ah, missed that. Checked once more and indeed it all ends up tst_brk_()
deeper in the call chain, or calls safe_malloc/safe_realloc.

For both patches:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
