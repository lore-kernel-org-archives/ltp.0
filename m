Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9560FC0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4F403C9973
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 22:05:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B97B3C98F3
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:04:44 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4730101F0E5
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:04:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 073E82258A;
 Tue, 11 Feb 2025 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739307883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXF6niIBl9VCFnk0p1QibjdC9dGmec8FWELt6PwlJY4=;
 b=c85j5rdfVTv4CZIKFGgxKtDsbYa7KMUQav1cDUJ11LTsYNBsVeJs3uWP/TnSiYyQCTpZog
 S91zGRlZbJF8qu3IhAfPU3GKilaUBZYMi1V9Wb3dFEUnMv2+IyyuzlFyf/LQDQlX2kP7is
 u0h7v/V/19MABx+WYv3KVn6cV8bwrHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739307883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXF6niIBl9VCFnk0p1QibjdC9dGmec8FWELt6PwlJY4=;
 b=INAndNtzFnvQ94YBbr+GTiIzmRImSxAgzFdWNN3J67IHRdwlj8ORIzY/chuuo8mfd7zvrx
 SpJA9OP0nz6NuMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739307883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXF6niIBl9VCFnk0p1QibjdC9dGmec8FWELt6PwlJY4=;
 b=c85j5rdfVTv4CZIKFGgxKtDsbYa7KMUQav1cDUJ11LTsYNBsVeJs3uWP/TnSiYyQCTpZog
 S91zGRlZbJF8qu3IhAfPU3GKilaUBZYMi1V9Wb3dFEUnMv2+IyyuzlFyf/LQDQlX2kP7is
 u0h7v/V/19MABx+WYv3KVn6cV8bwrHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739307883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXF6niIBl9VCFnk0p1QibjdC9dGmec8FWELt6PwlJY4=;
 b=INAndNtzFnvQ94YBbr+GTiIzmRImSxAgzFdWNN3J67IHRdwlj8ORIzY/chuuo8mfd7zvrx
 SpJA9OP0nz6NuMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E9813782;
 Tue, 11 Feb 2025 21:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zkyvLGq7q2egTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 21:04:42 +0000
Date: Tue, 11 Feb 2025 22:04:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250211210441.GA1933342@pevik>
References: <20250211122354.18324-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211122354.18324-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fsplough: Implement runtime awareness
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

Hi Martin,

> Switch fsplough test to run for 30 seconds by default, with the option
> to set a fixed number of loops on command line instead. The test will
> always exit when runtime expires and a warning will be printed
> if there were too few iterations due to expired runtime.

+1
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +	if (i < loop_count / 2) {
> +		tst_res(TWARN, "Runtime expired, exiting early after %d loops",
> +			i);
> +		tst_res(TINFO, "If you are running on slow machine, "
> +			"try exporting LTP_TIMEOUT_MUL > 1");
> +	} else if (i < loop_count) {
> +		tst_res(TINFO, "Runtime expired, exiting early after %d loops",
> +			i);
> +	} else if (!loop_arg && i < 10) {
> +		tst_res(TWARN, "Slow sytem: test performed only %d loops!", i);
s/sytem/system/

I'll fix this before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
