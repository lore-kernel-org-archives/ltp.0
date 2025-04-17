Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8394CC369B2
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 11:16:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23FF43CBA26
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 13:16:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BE273CB124
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 13:16:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A01F1206516
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 13:16:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F20B61F74A;
 Thu, 17 Apr 2025 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744888576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNy/5bz2kvvpcNX54Utyg4q4NXib7I7+ZCWkFeYQttI=;
 b=S9TgxxHHnAVHOvlYuhEvgxYuNUcUJL30qaiyjcs0R3f8WQHpcpw4CdpITRkvgESkYnHkrP
 A+Io3KUnuzoPk0tKnkHtX8oyr7utr3cdGbuFiJUVIlPdFwjwtsZ2yv9k2VjB9JwtRKjkLJ
 j9QG+1oVbGct2PTaynqJwbbBmUP2rXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744888576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNy/5bz2kvvpcNX54Utyg4q4NXib7I7+ZCWkFeYQttI=;
 b=dLEX6aPrshk2+T1HxsK7xbq0+9vRoPnuzA4q+hJWV/HMBisEboybBQJHgjc3qR5+DJmrQw
 RLy/lUhtFncEW1BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744888574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNy/5bz2kvvpcNX54Utyg4q4NXib7I7+ZCWkFeYQttI=;
 b=hNJh0awPuMot3G661GyUrKh2LOC/GfngQuw1/hOxLlfiuuHn5XoCvW6eb8j7RIa0M0WxdE
 k2afKzeMFVCvROELIOYLu6a0xPlFd3bSb8S3fWlsW/vBiznqaKmgwXP5+ww0ge0jUGFLpF
 bpiXQvLSaHeCXE8YOhrViabZLDpeKgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744888574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNy/5bz2kvvpcNX54Utyg4q4NXib7I7+ZCWkFeYQttI=;
 b=v31odvOQGH47sU0DBcLUKvBpyNc3ghsPaNp11pxCJOIOZSfMfk5ukEhtpxBq9Mvis+AeyX
 tGAl1XDmN1JUrbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 884B11388F;
 Thu, 17 Apr 2025 11:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U/AqGv7iAGjjGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Apr 2025 11:16:14 +0000
Date: Thu, 17 Apr 2025 13:16:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250417111611.GB655134@pevik>
References: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt10: handle explicit disallow
 of disconnect
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

Hi Jan,

> Since commit 5071a1e606b3 ("net: tls: explicitly disallow disconnect") in
> 6.15 kernel, disconnect is now explicitly disallowed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for fixing it!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
