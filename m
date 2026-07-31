Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5188C5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E53A33E5A48
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:13:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD4C63E2D15
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:13:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFB14140026F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:13:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56A147DF07;
 Fri, 31 Jul 2026 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785496381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUiGI/xhrOFSzdus/psOgZK9yxmSwB+PJ2CMBXMk4bs=;
 b=hKWoUvnG3di1IpoyXcSm9OaWaCRn4r9wT6mgL88whA9DV2CLugxhe2HftOUqFAV5lFFTyE
 IIa8Uk2zItgqv++/bkTWn1t7wQpQORxqZcNIl3GZ+4TLnw5vSBw0vbZZb7TRg+8j/rns72
 CYJig2Xhkd0zVM7rMKCXGcfv1sJUnkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785496381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUiGI/xhrOFSzdus/psOgZK9yxmSwB+PJ2CMBXMk4bs=;
 b=n2g9FXEbh0ycfRe3h3wt4CEFazhxi3F72cMareldAKxKPsslOwCQqWuLyOUYEpeeGHC9dR
 sBRrsxhRmb+efjDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785496377;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUiGI/xhrOFSzdus/psOgZK9yxmSwB+PJ2CMBXMk4bs=;
 b=TVbaXD0C1DqH05abels0jLCsx48bWjBtQmkFBfzVuNnNJjuMt2t/LkBuz6DyjweTSsyc0z
 h6peE11fnycDqsi8fwdwgzA230e4PvkawkGV/ccko51p+CYUdMfnS2GqaG1EuvgvFCc8zh
 41yFHtBwtND+1WMTwzIiOjNHpRBuCxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785496377;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUiGI/xhrOFSzdus/psOgZK9yxmSwB+PJ2CMBXMk4bs=;
 b=PDuvw0Ptcpe1h45izF64Pb51bvop4V1xVLvuPoFFNB8YvudBlzTT61K7Y0el5y3dR2zFuj
 38I9MFZNDGwDOtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302D9779B0;
 Fri, 31 Jul 2026 11:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMWDCjmDbGpPPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 11:12:57 +0000
Date: Fri, 31 Jul 2026 13:12:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260731111255.GA192663@pevik>
References: <20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: reproducer for cve-2026-64600
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> diff --git a/testcases/cve/refluxfs b/testcases/cve/refluxfs
> deleted file mode 100755
> index 42441528e8bbe31ee745881fdf91aa29d5b38adb..0000000000000000000000000000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001

> literal 864544
> zcmeEvd0bW1`u+yxMr9o;E1IdO%$o%^X-RPuZim7`kuog-5yA-x4yN5o6zF;)ie|IP
> ztb4PW#>=rfVh(5{*<_<+(?%MoZf1Im-}Ag{uYDH7?%wa;zkB>__kP~J*1O*KUGG}!
...

I dared to remove this unrelated binary file separately, please repost rebased new version.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
