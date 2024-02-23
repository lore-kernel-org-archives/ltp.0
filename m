Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43EC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 15:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42E5E3D0073
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 16:41:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D67523CE7BD
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:40:47 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5977B10124A8
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:40:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DC991FC31;
 Fri, 23 Feb 2024 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708702846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT2axqVhAmCoN841byezTgCileWkbY3JDaUgpohXNgY=;
 b=sSAwb6MhZKYdOP1pau5C0A1cyyP8eK/JBzXJzgRdrQkw9dyydDdhQ2fVpEdcHH8wfmeISp
 uzcgNscV5HN4cC27QPOUSzbFR4MY6xk5Bt1iUzxHHeNPN7B81VWfdN+IdpzYIhsrfqHkx9
 2FMi3W8EDRGTPW5Ms2umsm3XWzl4dBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708702846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT2axqVhAmCoN841byezTgCileWkbY3JDaUgpohXNgY=;
 b=fh1y2P5+cmogVtFZsk8XykJh3neugbpb/nxUx0/+mS8pLlIuuVo8uOTdrE5Kf9EOdezY2G
 uuKA2MhJ3Pn/B7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708702846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT2axqVhAmCoN841byezTgCileWkbY3JDaUgpohXNgY=;
 b=sSAwb6MhZKYdOP1pau5C0A1cyyP8eK/JBzXJzgRdrQkw9dyydDdhQ2fVpEdcHH8wfmeISp
 uzcgNscV5HN4cC27QPOUSzbFR4MY6xk5Bt1iUzxHHeNPN7B81VWfdN+IdpzYIhsrfqHkx9
 2FMi3W8EDRGTPW5Ms2umsm3XWzl4dBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708702846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT2axqVhAmCoN841byezTgCileWkbY3JDaUgpohXNgY=;
 b=fh1y2P5+cmogVtFZsk8XykJh3neugbpb/nxUx0/+mS8pLlIuuVo8uOTdrE5Kf9EOdezY2G
 uuKA2MhJ3Pn/B7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39430132C7;
 Fri, 23 Feb 2024 15:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qde6DH682GWaJQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 15:40:46 +0000
Date: Fri, 23 Feb 2024 16:39:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zdi8NN-jwhz-eAxP@yuki>
References: <20240207160628.125908-1-pvorel@suse.cz>
 <20240207160628.125908-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240207160628.125908-2-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[40.01%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lib/tst_tmpdir: Normalize user defined TMPDIR
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
> +	if (env_tmpdir[strlen(env_tmpdir)-1] == '/') {
> +		env_tmpdir[strlen(env_tmpdir)-1] = '\0';
> +		fixed = 1;
> +	}
> +
> +	while ((p = strstr(env_tmpdir, "//")) != NULL) {
> +		memmove(p, p + 1, strlen(env_tmpdir) - (p - env_tmpdir));
> +		fixed = 1;
> +	}
> +
> +	if (fixed) {
> +		tst_resm(TINFO, "WARNING: Remove double or trailing slashes from TMPDIR,"
> +			 " please fix your setup to: TMPDIR='%s'",
> +			 env_tmpdir);
> +	}
> +

This whole thing can be just a single loop (beware untested):

	size_t s = 0, d = 0;
	char prev_c = 0;

	for (;;) {
		switch (env_tmpdir[s]) {
		case '/':
			if (prev_c != '/')
				d++;
			s++;
		break;
		case '\0':
			if (d && prev_c == '/')
				env_tmpdir[d-1] = '\0';
			break;
		break;
		default:
			env_tmpdir[d++] = env_tmpdir[s++];
		}
	}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
