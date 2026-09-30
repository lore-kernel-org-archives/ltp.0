Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0CFCA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:12:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65B5D3E5659
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 12:12:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED0513C5706
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 12:12:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F40710007C8
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 12:12:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C425421C2C;
 Wed, 30 Sep 2026 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790763124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkPonUqrOTTJveCIVGxtka7D5veu+PXKew5Iisk3Jeg=;
 b=wQqIHBJffTd05fguZwMzjuCuKMORghJxjuzm1g5Bx9cDdQGAIpMNngnbAt2tEGUldq8RD/
 Tsvto+JLayShW4leJLQp7639/1iQC5sUfjBSGCVCNPmX27XDvPaJKjT9EhQoyIU8b2ogSP
 yn6NTMJozsARorjB2Q40PtWVOkAhAbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790763124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkPonUqrOTTJveCIVGxtka7D5veu+PXKew5Iisk3Jeg=;
 b=Qc5cham8uyrGCZDLaGxtWvDHI/FRh/Lon4h7m1B6b3ZKiWWjgpbXAziKuA0J654E2tF9N7
 7BVTwz0CcbxMsMBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790763119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkPonUqrOTTJveCIVGxtka7D5veu+PXKew5Iisk3Jeg=;
 b=Ud+rnMGP9cTtMqf15EvVWG/wRi3aFLtDwwo/pEmxl0+c8WOjgTOS5yPIBbjRjWVso08S9P
 bdJDi8JCD7itPmNi+n2jlViNYvvtz8uVdA1K7Wscl4m1GP5AG3HHn9pu1vQ2ODwDNP+/M5
 ExsSN4CKOxsnztNdCfQItZwpv6S1dPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790763119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkPonUqrOTTJveCIVGxtka7D5veu+PXKew5Iisk3Jeg=;
 b=NtG00ovka/d1Xp6LBOPBv2KeJ9w+e/twzP3EDQmYUy5ut8Cp92NeZhAuEzI1o2UIshQHB/
 UtSrZuTP6usDihDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6AD13722;
 Wed, 30 Sep 2026 10:11:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F6I1EW/gvGr/ZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Sep 2026 10:11:59 +0000
Date: Wed, 30 Sep 2026 12:12:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arzgfgwBYk2ivB8a@yuki.lan>
References: <20260930073556.GA57146@pevik>
 <20260930084603.947906-1-avinesh.kumar@suse.com>
 <20260930091021.GB2623399@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930091021.GB2623399@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] openposix: timer_*/speculative: fork() to
 isolate the SIGSEGV on old glibc
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
> nit: I suggest before merge to mention the version:
> 
> "Recent POSIX versions leave" => "/Since POSIX 2016 Edition is"
> 
> (no need for v4). Why? In 5+ years we can hopefully delete those tests.
> Specifying the version saves somebody searching it again.
> 
> The code itself LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Agree, with that minor change:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I find this safe enough to be applied before release as this change
touches only a few speculative tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
