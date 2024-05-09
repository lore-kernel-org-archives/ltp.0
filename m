Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A127C41513
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:17:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C413CE29E
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 16:17:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0596F3CE08A
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:17:14 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39B60601406
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:17:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98E6760133;
 Thu,  9 May 2024 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715264232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpOmUhkGXm+fBSjYKICjxLBXsZSr06wZzAFkdSDAb84=;
 b=UwWHPkj7guMhY0Oo6fP2uvUi2heHH/b+NyqYFlDJ2KSAbaRQMUTSxo3iO00cQA9G4EZBtM
 uJ7AaOKhxTWks+OBOaGnFq6sMHO35f/ETFffVA4AUmkNXacojcB63xLbNrYVimRNcEvpaI
 ufosYHu0wCy548O0Zi+w8fFPv9d9XCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715264232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpOmUhkGXm+fBSjYKICjxLBXsZSr06wZzAFkdSDAb84=;
 b=4qw1proqZbY5GN+2LSo/5aP6IKSR630jXjEbTU0X0lYTvgv1LTkf+Hq4bmfuf9CBk0VM6J
 aWkD9ZOHq8qHrfBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715264232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpOmUhkGXm+fBSjYKICjxLBXsZSr06wZzAFkdSDAb84=;
 b=UwWHPkj7guMhY0Oo6fP2uvUi2heHH/b+NyqYFlDJ2KSAbaRQMUTSxo3iO00cQA9G4EZBtM
 uJ7AaOKhxTWks+OBOaGnFq6sMHO35f/ETFffVA4AUmkNXacojcB63xLbNrYVimRNcEvpaI
 ufosYHu0wCy548O0Zi+w8fFPv9d9XCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715264232;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpOmUhkGXm+fBSjYKICjxLBXsZSr06wZzAFkdSDAb84=;
 b=4qw1proqZbY5GN+2LSo/5aP6IKSR630jXjEbTU0X0lYTvgv1LTkf+Hq4bmfuf9CBk0VM6J
 aWkD9ZOHq8qHrfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E2513941;
 Thu,  9 May 2024 14:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n+CKFOjaPGZ/fwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 14:17:12 +0000
Date: Thu, 9 May 2024 16:17:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240509141710.GA305046@pevik>
References: <20240201151357.110769-1-pvorel@suse.cz>
 <ZjzY1pR1WbYB3ec9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZjzY1pR1WbYB3ec9@yuki>
X-Spamd-Result: default: False [-3.37 / 50.00]; BAYES_HAM(-2.87)[99.43%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tree: Use TST_EXP_FAIL2() for wait{,id}
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

Hi Cyril,

> Hi!
> > Both wait() and waitid() returns PID, therefore (similarly as for file
> > descriptor) pass condition is >= 0, which is in TST_EXP_FAIL2().

> Actually waitid() returns whatever was waited for in the siginfo_t
> structure and returns just 0 on success.

Ah, thanks!  I guess I misread "waitpid()" in man wait(3p) as "waitid()".

I'll send v2 with just pidfd_open04.c and wait01.c changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
