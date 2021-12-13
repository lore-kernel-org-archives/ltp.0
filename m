Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CE5C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83B043C8A99
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:40:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A6E3C8867
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:40:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 00B271000B5C
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:40:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2AC541F3B0;
 Mon, 13 Dec 2021 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639381207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0cQNQxR1IGgat95hjop3k74zXXFaofP5NUUK1tuinE=;
 b=VDkZ61WA6dYqG10vqMqxsOmhn6Cur1zHrq9lbzQo7FwOfCDh9uwO1uGdpf+AU0zC6969V3
 9RG9XrwDALBaPHPcW48JtqPbd6JodV0TMl46K43CrDZZfGjDwVWcEV5cBCW1/TqSty2Dx9
 ZqMlpI7rifhf0w1GkNPnxunlSLaW1vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639381207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0cQNQxR1IGgat95hjop3k74zXXFaofP5NUUK1tuinE=;
 b=M2A4CnLmDDqpCiDORAJ39fv8P6nRRkn70QDb/BiQHOHv2kFATbkaATVhYz3P8W8UT1Ij13
 ZHTdp8XBlj82B5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECC4E13310;
 Mon, 13 Dec 2021 07:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /1WcN9b4tmFldAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 07:40:06 +0000
Date: Mon, 13 Dec 2021 08:40:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Ybb41TwZ1vSiCAzO@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B31EA0.9020104@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Xu,

...
> >> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
> >> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
> > +1

We already have v3, but I got confused here in v1, thus asking.

> Since zram_lib.sh uses tst_needs_driver to search module in 
> modules.dep/modules.builtin. Maybe we can introduce a new macro 
> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?

> The difference between TST_NEEDS_MODULES and TST_NEEDS_DIRVERS is that 
> the former needs module, but the latter needs module or builtin.
Yes, and TST_NEEDS_DRIVERS is already used in zram_lib.sh.

Kind regards,
Petr

> But I am not sure whether have many shell case needs this(Like network.)
> Of course, kconfig shell api also can do this.

> Ok, I am back to this case and write my v2 patch.

> Best Regards
> Yang Xu
> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
