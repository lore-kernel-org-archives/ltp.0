Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE763CEBF7F
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 07:51:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB3763C4FA2
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:51:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7460E3C2D8F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:51:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F165714098CC
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:51:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06FFC21B8B;
 Fri, 27 Sep 2024 07:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727423459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s00uUKisKPwwxfNMKre3Apet2bvgMTteWLeikJcW490=;
 b=UmaWEGIZYz6Ca72pwVRapnWEWhpSUl1/hXdowiuMfqlt1jXY49tdN1J50k/xdMWgrtqNzg
 XIGaX5i1MMCvIovo+PL0tRINv583XZhaFBkgSWriLngKpE1UlQUNf9RSTxunpzb7TbpPbD
 +dgi/vMdvlU4lZD5ILP/RWPw0gZJ4Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727423459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s00uUKisKPwwxfNMKre3Apet2bvgMTteWLeikJcW490=;
 b=L8RyVXrYZqHGtKPZvELpKc6mFTdzDCZzUn9/2Zf58HhgptutTAu6i2D1E/NDMe482PUZ5k
 s+3/tpDEcwkw9TDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UmaWEGIZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L8RyVXrY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727423459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s00uUKisKPwwxfNMKre3Apet2bvgMTteWLeikJcW490=;
 b=UmaWEGIZYz6Ca72pwVRapnWEWhpSUl1/hXdowiuMfqlt1jXY49tdN1J50k/xdMWgrtqNzg
 XIGaX5i1MMCvIovo+PL0tRINv583XZhaFBkgSWriLngKpE1UlQUNf9RSTxunpzb7TbpPbD
 +dgi/vMdvlU4lZD5ILP/RWPw0gZJ4Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727423459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s00uUKisKPwwxfNMKre3Apet2bvgMTteWLeikJcW490=;
 b=L8RyVXrYZqHGtKPZvELpKc6mFTdzDCZzUn9/2Zf58HhgptutTAu6i2D1E/NDMe482PUZ5k
 s+3/tpDEcwkw9TDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA52C13A73;
 Fri, 27 Sep 2024 07:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G58nOOJj9ma2KAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Sep 2024 07:50:58 +0000
Date: Fri, 27 Sep 2024 09:49:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZvZjpIJKIJkeTIHW@yuki.lan>
References: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
 <ZvVMJQhI_4tTFfYB@yuki.lan>
 <e28fb881-d48b-4390-997e-a366574b2ea2@suse.com>
 <ZvWAXq2Uodu9sUVQ@yuki.lan>
 <992df85a-9e44-48a4-bb89-be1be0a6a813@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <992df85a-9e44-48a4-bb89-be1be0a6a813@suse.com>
X-Rspamd-Queue-Id: 06FFC21B8B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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
> >> I'm not sure if it makes sense to add this feature if we already have
> >> .needs_cmd and .min_kver. It's better to keep things simple in this case.
> > That will obvioiusly not work because we need to skip just a single
> > filesystem not the whole test...
> >
> Right, so the discussion turns into what mkfs.* commands we want to 
> support, because we need to create a parser for each one of them and at 
> the moment I see mkfs.ext4 only.

I would write the code "on demand" so I would implement xfs parser
beacause it's needed now.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
