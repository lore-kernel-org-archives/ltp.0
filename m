Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2838DC369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:32:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82E213CBC91
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:32:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68FC13CBC87
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:32:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36873100023A
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:32:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D987C21859;
 Wed, 30 Apr 2025 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746019956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NABV9tAGNWu2e3IFDaGi4AF0RFfGMwvuLUe8PgHwMYc=;
 b=bON1poBfd7cKCtIJuZzNba8+e9WMDcFk/65qggXdwf8gnGQ5TjFbAiUxjcyJibZYCoWgVL
 +vDw405M/GUik6c6W3F0iEtjqTiFy3qfDMhYT4+qTVKRisNIxgAgYG/3nxNCREg/TUD9Ha
 Xz2ns5eonkdpxs9vf+iSc7RemeMaGek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746019956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NABV9tAGNWu2e3IFDaGi4AF0RFfGMwvuLUe8PgHwMYc=;
 b=GlPVFXDN3vX2831X5xLfi8c4p1+5racRGVNQxZyUnPrSdmr9ArJHQ0AGmVS03dNbonvhwh
 FvO1rrYcxBgxBsDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746019955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NABV9tAGNWu2e3IFDaGi4AF0RFfGMwvuLUe8PgHwMYc=;
 b=iEOoHEtlpZcoQuQVMksmX2MM7FB9WmVDGXLQaLSUg8ISw/3yALBEtxnUWXsjYPm3FqCNYZ
 6fMyQJDxvmGF3DyWx8elYFx0+ujtsXNF1PQkefk7ic8EQ3Sy6npLDeoNjxdDBKDs6WO+OO
 yWdMWip/A81sma44KWI+rEaxvD6vcUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746019955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NABV9tAGNWu2e3IFDaGi4AF0RFfGMwvuLUe8PgHwMYc=;
 b=cGw50A2wVEQ+giuGD5HIhkysApIG4rBfwFmXd6cmYQ7y3SoDQC9Ptv9sI7NDE1ST6zTLVD
 r3OKuD1TRlUrrqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6A1F13A25;
 Wed, 30 Apr 2025 13:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sxc8L3MmEmiTdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Apr 2025 13:32:35 +0000
Date: Wed, 30 Apr 2025 15:33:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <aBImmTA4VxwvH8Xa@yuki.lan>
References: <20250408161745.9757-1-chrubis@suse.cz>
 <4650874.LvFx2qVVIh@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4650874.LvFx2qVVIh@thinkpad>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tlibio: Get rid of support for old UNIXes
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
> This is causing a regression in growfiles tests 
> (all variants of gf01, gf13, gf15 and gf18 in
> fs/doio/growfiles.c and fs/fs_readonly/test_robind.sh)
> 
> ./growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 -f glseek20 -S 2 -d /var/tmp/
> DEBUG tlibio.c/1187: No I/O method chosen
> growfiles(gf01): 140867 growfiles.c/2602: 1 CW 
> growfiles(gf01): 140867 growfiles.c/1765: 1 Hit max errors value of 1
> gf01        1  TFAIL  :  growfiles.c:134: Test failed

Found it, there was single "#ifndef CRAY" in the tlibio.c library that
got mistakenly removed with the "#ifdef CRAY" macros. I will send a fix
ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
