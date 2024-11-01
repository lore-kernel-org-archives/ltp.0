Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B76E6B243
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 241233CD3B3
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 12:30:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39CA33CD186
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 12:30:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9EA87604824
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 12:30:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C96D21C09;
 Fri,  1 Nov 2024 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730460626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrfApiX9anj3XPwBNdmZOMluRrN7UpzyynRJxwirMps=;
 b=bdOE7opTCq9QvRxyI2nm4BVDfSwHnUV7HEr2zrAb58fM2egAaxwE/5cmqrKoVJ4xIO0BO5
 1J4NU/3SFMMUv/bdlF/sU1CFz8LIFOLE/9ATlmPNoHmWmNt4SVLdG3YDwmH7/+enlvR87l
 xxXgNc/LT9HmRgtJU2o57J7PHj/MmUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730460626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrfApiX9anj3XPwBNdmZOMluRrN7UpzyynRJxwirMps=;
 b=xVjv68IwOYjWy+Q9r8M1Q/9VnCWcPILK/l7bNPveiubces0khIVHbyjz5djJw/u73paEF7
 m+Ucu2xNisEYo9CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730460625;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrfApiX9anj3XPwBNdmZOMluRrN7UpzyynRJxwirMps=;
 b=k2rRqZSVRZvAlzAC5PIwmZRZ7iY7GS44XA1AyrE4OS4YbcNPvHQEblImNzlaklvH3u29Hn
 wyp8adWN5CClA4a/6NTQWVAGSWjqGk41W5aI/kVujOD2QXLA8RCZHaFJT6E9CzvBM6cKE0
 rhnXOq46kkKqfSLtHpxnN8E3Xn708dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730460625;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrfApiX9anj3XPwBNdmZOMluRrN7UpzyynRJxwirMps=;
 b=yeI0UM0IXGIIL58YCQcASf14uXKUPeGwwWO05XMD3hNBBPaMCmsdb8PQJwV75P3YD9Gicw
 112D1vNkMPOXKFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4518136D9;
 Fri,  1 Nov 2024 11:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a8v0H9C7JGdCWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 11:30:24 +0000
Date: Fri, 1 Nov 2024 12:30:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241101113019.GA1264676@pevik>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
 <20241101-generate_syscalls-v9-2-d2c3820b0323@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101-generate_syscalls-v9-2-d2c3820b0323@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,tst_test.sh:url,stackexchange.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/5] Add script to generate arch(s) dependant
 syscalls
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

Hi Andrea,

...
> +		for syscall in $(cat ${TEMP}/syscall-names.txt); do
> +			printf "
> +		#ifdef __NR_$syscall
> +			printf(\"$syscall %%d"
> +			# i know the following print is ugly, but dash and bash
> +			# treat double quoted strings in a different way and we
> +			# really need to inject '\n' character in the C code
> +			# rather than carriage return
> +			printf '\\n'
> +			printf "\", __NR_$syscall);

How about using heredocs? IMHO more compatible way of echo/printf "" for new
lines:
cat << EOF
...
EOF

I should have noted that at previous version.
Hint: looking into tst_test.sh can sometimes help.

Also there is echo/printf '' variant:
cat << 'EOF'
EOF
https://unix.stackexchange.com/questions/462593/how-to-escape-a-character-in-a-heredoc-bash-script/462595#462595

There is also ~EOF - ignore leading whitespace, even for terminating EOF.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
