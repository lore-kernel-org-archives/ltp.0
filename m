Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978EAC3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BD363D1AC1
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:30:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 927053D1AB2
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:30:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E427B208D28
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:30:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D76A1FB63;
 Wed, 17 Jul 2024 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721205040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4XgbLSCNwV6zQ/7rdRnd5d4ULdKbeK3vrqpUAc96Ks=;
 b=ymxyseBR3M0GEeyLKSoN8LFPDSYv0jdx7rAvg2N9APJd8SctymTKS8gUhI39XP7Mxk8WRD
 vliBCbEruvk+E/wxOBa22S8itpPk+alpyc+D1H+ZWC5HagMcmJ3jch8UtIZGMd1imX7bI0
 NPTZ5EjUUbnm1lG3IZ8KNodDNlfli1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721205040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4XgbLSCNwV6zQ/7rdRnd5d4ULdKbeK3vrqpUAc96Ks=;
 b=3hUJcujQb0LFcyorHkufs+am4yyk89vBSKT/KxYjxotRyRaYwgH12bZAtafrqZpSeEz4RO
 /+hK4fNhs2c/GkDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721205039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4XgbLSCNwV6zQ/7rdRnd5d4ULdKbeK3vrqpUAc96Ks=;
 b=mFiY8xs+Clvsvkk5mRvAPJ2GkRbpnf1y347wQ0zDugkSoMeA9PO244Hs5riulkqE1Nin+I
 eC7xNaXEYKoxbyujS/HhJKhQs6gmn5qgtpkwZB1oTTXopT/z2RIVDdBfa1BE3zFodFYFb3
 5p7bIqA/67j4Mv5IOvA2x++ZhlyiqAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721205039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4XgbLSCNwV6zQ/7rdRnd5d4ULdKbeK3vrqpUAc96Ks=;
 b=lFYTXVWIDDWok+TNhC7BFDNZ63uDJzILJ9We0rtDryYuvtl+IbQ2nhzt+BlNsx6+8noY+Z
 Ok9SO+A1zozDeqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242241368F;
 Wed, 17 Jul 2024 08:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IWLVBy+Bl2b1EwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 08:30:39 +0000
Date: Wed, 17 Jul 2024 10:33:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZpeByAbSHABP01E1@rei>
References: <20240712134412.30853-1-chrubis@suse.cz>
 <20240717082547.GA584952@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240717082547.GA584952@pevik>
X-Spamd-Result: default: False [-3.80 / 50.00]; REPLY(-4.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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
> > + *
> > + * @return A newly allocated path. The memory is freed automatically at the end
> and here 'return:' as well
> 
> It's always safer to generate docs and check it.

Argh, sorry I keep using the doxygen syntax, will fix that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
