Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88A606A328
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iClYCQVV;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=q6uGa+Ks;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dFYWK8rO;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rVy5pdB2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93E813CE1B0
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 09:58:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345AC3C0069
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 09:58:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04592600045
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 09:58:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DF0722160;
 Fri,  6 Nov 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793955502;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HrLhGPbJ+wSzh8rUMZxKziVYfp5OFEvgbGtPnI/qRw=;
 b=iClYCQVV0xyYrd67iO+uUuu2q6Ef3Z6reGJyBfe6pj/VrCIPIc+863ZIFzjjrN24pWzewz
 l/UYdzk4DCs5mW7dtmRiCYesjnZwjqTb892DRaUrAkikiW1mdO1Q1WRukrLUxbcqHb8/gy
 uuTkEwm9c0EjctG7x9mMXueQiplRmtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793955502;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HrLhGPbJ+wSzh8rUMZxKziVYfp5OFEvgbGtPnI/qRw=;
 b=q6uGa+KsbInzgpCScoUvPpLl0V7Bg7lp6YHl2UDOle4jBDLZ+0ffC/8ZbkCUf/FXAat2Ns
 uw+1/Z3k/er7HICA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793955501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HrLhGPbJ+wSzh8rUMZxKziVYfp5OFEvgbGtPnI/qRw=;
 b=dFYWK8rON9y9qO5U40LLU0LHE4ihe0X52B2N1bu6ZDdMB0sswaVHdf+Bt2psttzyNIz5O3
 luvc/Iwj5tgauRXkrFSSu5S40RVmXs/nqIbncIDFushCIIugfJm0SO+b3U0MhagAhtg5kc
 jlf8ErnQFSwiyIM8QHRFCjaJ2yMwMqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793955501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HrLhGPbJ+wSzh8rUMZxKziVYfp5OFEvgbGtPnI/qRw=;
 b=rVy5pdB2swdiak78SKIRY1Hm1RXRUEr2G0PD4LwYIZzkMxzb1VRX+07Y8ZnnaNnFi5j1zd
 sztnEsEZ+Z7T1GCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01206134E9;
 Fri,  6 Nov 2026 08:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ChxmMqyW7WpZGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Nov 2026 08:58:20 +0000
Date: Fri, 6 Nov 2026 09:58:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20261106085815.GA561900@pevik>
References: <20261104221453.1076748-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104221453.1076748-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl_loop0[23]: TCONF when
 LOOP_CHANGE_FD is not supported
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> LOOP_CHANGE_FD was removed by d4fabede1da0 ("loop: remove support for
> swapping loop fds") n v7.4-rc1 and it fails with EOPNOTSUPP.

> ioctl_loop02.c:85: TFAIL: LOOP_CHANGE_FD failed: EOPNOTSUPP (95)
> ioctl_loop02.c:97: TFAIL: LOOP_CHANGE_FD failed expected EINVAL got: EOPNOTSUPP (95)

> ioctl_loop03.c:34: TFAIL: LOOP_CHANGE_FD failed expected EINVAL got: EOPNOTSUPP (95)

> Report TCONF for these checks.

Thanks, merged!

> -	TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_fd_invalid));
> -	if (TST_RET) {
> -		if (TST_ERR == EINVAL)
> -			tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
> -		else
> -			tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed expected EINVAL got");
> -	} else {
> -		tst_res(TFAIL, "LOOP_CHANGE_FD succeeded");
> +		TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_change_fd));
> +		if (TST_RET) {
> +			tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed");
> +		} else {
> +			tst_res(TPASS, "LOOP_CHANGE_FD succeeded");
> +			TST_ASSERT_INT(loop_ro_path, 1);
> +			TST_ASSERT_STR(backing_path, backing_file_change_path);
> +		}
> +
> +		TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_fd_invalid));
> +		if (TST_RET) {
> +			if (TST_ERR == EINVAL)
> +				tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
> +			else
> +				tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed expected EINVAL got");
> +		} else {
> +			tst_res(TFAIL, "LOOP_CHANGE_FD succeeded");
> +		}
>  	}

>  	SAFE_CLOSE(file_fd);
> @@ -134,6 +140,13 @@ static void setup(void)
>  		tst_res(TINFO | TERRNO, "LOOP_CONFIGURE is not supported");
>  		loop_configure_sup = 0;
>  	}
> +
> +	ret = ioctl(dev_fd, LOOP_CHANGE_FD, -1);
> +	if (ret && errno == EOPNOTSUPP) {
> +		tst_res(TINFO | TERRNO, "LOOP_CHANGE_FD is not supported");
I dared to remove this TINFO | TERRNO message. Since there is only one errno,
it's not important to print it, later TCONF is enough.

Kind regards,
Petr

> +		loop_change_fd_sup = 0;
> +	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
