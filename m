Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7267CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 14:04:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5921B3CD472
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 16:04:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7DB83C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 16:04:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B47AD600A1E
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 16:04:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 383472185E;
 Thu, 12 Oct 2023 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697119478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t38alp2yrwiMIlxUACPi/WYy4bKyJ9q5CkSHPe/KIYo=;
 b=tVuw6ST0Bixg8MCxIughlOPCiw1lNe34y7yR8ERFtxteYVDg9r2PuZGx7n5DFN2XoYFrbP
 sQIIKYD5mhr+DyYMPrSDE90c6zfBzXHGz2phr7UlTD/RsnxQIIQZ+uWgSUE8eGJ0ra3mGX
 I84ag49Wgh22LAoCaOug2Qn4jXkr4Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697119478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t38alp2yrwiMIlxUACPi/WYy4bKyJ9q5CkSHPe/KIYo=;
 b=iCl7vZiIXgnDpmgXQg8dI17ho04rIr8kuYhmZwOG0bhL6d+mcqFpJyAkAhZLXDL7DkGMiI
 3Q05prp5xBRobCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17B71139ED;
 Thu, 12 Oct 2023 14:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 65hGAvb8J2U2CQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 Oct 2023 14:04:38 +0000
Date: Thu, 12 Oct 2023 16:05:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZSf9IdW9ciTDjkFm@yuki>
References: <20231012111333.32004-1-wegao@suse.com>
 <20231012112548.6887-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231012112548.6887-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.68)[98.59%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for UI_GET_NAME ioctl
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
> +static int check_ui_get_sysname_ioctl(int fd)
> +{
> +	char name[256];
> +
> +	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(name)), name, NULL);
> +
> +	DIR *test_dir;
> +
> +	struct dirent *ent;
> +
> +	test_dir = SAFE_OPENDIR(NULL, "/sys/devices/virtual/input/");
> +
> +	while ((ent = SAFE_READDIR(NULL, test_dir))) {
> +		if (!strcmp(ent->d_name, name))
> +			return 1;
> +		else
> +			continue;
> +	}

Why do we loop over the directory here? Can't we just directly check
that the path /sys/devices/virtual/input/$name/ exists?

I guess that we can as well read the
/sys/devices/virtual/input/$name/dev and match that against fstat() on
the fd.

> +	return 0;
> +}
> +
>  void create_device(int fd)
>  {
>  	int nb;
> @@ -202,7 +225,7 @@ void create_device(int fd)
>  	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
>  
>  	for (nb = 100; nb > 0; nb--) {
> -		if (check_device())
> +		if (check_device() && check_ui_get_sysname_ioctl(fd))

Maybe it would be a bit more readable if we did:

		if (check_device() {
			check_ui_get_sysname_ioctl(fd);
			return;
		}

>  			return;
>  		usleep(10000);
>  	}
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
