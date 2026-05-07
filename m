Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153FCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7F03E24B3
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:22:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EE733C01E9
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:22:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F14C36002DC
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:22:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1977D5D8BF;
 Thu,  7 May 2026 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778152946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyk4oqpLayGGeQ3UMh52KukZK1TPMe6iqzrearilC4c=;
 b=byF24snbB6K4ZBc9YdfMxR84nF0QzB4lukgC7Sbd3ohN7uhgYURixxP7/Xk9bHlcki7uMX
 u3vve2KMaXw4jjsJxF/cDuupmd6+jODvy0tcDW5pa43e85MhlsoUe+Etm9p2dVBFoyvuu1
 hZyB9wVEkoDIOz1NyoR2YJi9Z9iX1Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778152946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyk4oqpLayGGeQ3UMh52KukZK1TPMe6iqzrearilC4c=;
 b=ZvKBWsbdtZwaDABE1yomeloNjkWbbpgynK+NNJ4/z976t+pomyWoHPcc+LY1oq8z8MZxSI
 /qKGCxqIeq9GIXBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778152946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyk4oqpLayGGeQ3UMh52KukZK1TPMe6iqzrearilC4c=;
 b=byF24snbB6K4ZBc9YdfMxR84nF0QzB4lukgC7Sbd3ohN7uhgYURixxP7/Xk9bHlcki7uMX
 u3vve2KMaXw4jjsJxF/cDuupmd6+jODvy0tcDW5pa43e85MhlsoUe+Etm9p2dVBFoyvuu1
 hZyB9wVEkoDIOz1NyoR2YJi9Z9iX1Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778152946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jyk4oqpLayGGeQ3UMh52KukZK1TPMe6iqzrearilC4c=;
 b=ZvKBWsbdtZwaDABE1yomeloNjkWbbpgynK+NNJ4/z976t+pomyWoHPcc+LY1oq8z8MZxSI
 /qKGCxqIeq9GIXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09292593A7;
 Thu,  7 May 2026 11:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 55hyAfJ1/GlndgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 11:22:26 +0000
Date: Thu, 7 May 2026 13:22:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <afx19byeP5HIL6YW@yuki.lan>
References: <20260507104815.12161-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507104815.12161-1-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND][PATCH v5 1/2] doc: Add CVE catalog to
 documentation
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
>  clean:
>  	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
> -		${abs_top_builddir}/metadata/ltp.json
> +		_static/cve.rst ${abs_top_builddir}/metadata/ltp.json

Hmm, so this rule to clean ltp.json was there before. I guess that I
will just send a patch to remove it after this has been merged.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
