Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35728C54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 07:15:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 470443CFBB8
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:15:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1A043CD3F7
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:14:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FF8E6012A8
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:14:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB2B135278;
 Thu, 21 Mar 2024 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711005295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw3H5c+toP7PJaUjM/KOnY+fctOvg7aywWQ7Nn7MptM=;
 b=KR1fvN7c2A6Rfo4zmCI5HDcY//Z9vRat+4Wwl7RYoMAz9TCOemERIOYKmDZM012O/mU+eG
 UrBOPXJLzd9DvbMTvcyrPCaJDpKQ6/jcS0L1MWt6J3CCPJCGRGFnEb+LsE5b9U2lrbhR5M
 6lUV30qFxol5YO+kRpM6Ir5zHKSSHrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711005295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw3H5c+toP7PJaUjM/KOnY+fctOvg7aywWQ7Nn7MptM=;
 b=moQMEP3vdIFw5r8magsjAMgB58fvLTPZbnqzNy3d77GPmjpUccKyIchgHYUhZU9gvtz8mE
 ASzLGBw4IJZrQeBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711005295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw3H5c+toP7PJaUjM/KOnY+fctOvg7aywWQ7Nn7MptM=;
 b=KR1fvN7c2A6Rfo4zmCI5HDcY//Z9vRat+4Wwl7RYoMAz9TCOemERIOYKmDZM012O/mU+eG
 UrBOPXJLzd9DvbMTvcyrPCaJDpKQ6/jcS0L1MWt6J3CCPJCGRGFnEb+LsE5b9U2lrbhR5M
 6lUV30qFxol5YO+kRpM6Ir5zHKSSHrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711005295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw3H5c+toP7PJaUjM/KOnY+fctOvg7aywWQ7Nn7MptM=;
 b=moQMEP3vdIFw5r8magsjAMgB58fvLTPZbnqzNy3d77GPmjpUccKyIchgHYUhZU9gvtz8mE
 ASzLGBw4IJZrQeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B92C213976;
 Thu, 21 Mar 2024 07:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1q+YLG/e+2V7WwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 07:14:55 +0000
Date: Thu, 21 Mar 2024 08:14:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240321071454.GA529433@pevik>
References: <20240207160628.125908-1-pvorel@suse.cz>
 <20240207160628.125908-2-pvorel@suse.cz> <Zdi8NN-jwhz-eAxP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zdi8NN-jwhz-eAxP@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.67%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +	if (env_tmpdir[strlen(env_tmpdir)-1] == '/') {
> > +		env_tmpdir[strlen(env_tmpdir)-1] = '\0';
> > +		fixed = 1;
> > +	}
> > +
> > +	while ((p = strstr(env_tmpdir, "//")) != NULL) {
> > +		memmove(p, p + 1, strlen(env_tmpdir) - (p - env_tmpdir));
> > +		fixed = 1;
> > +	}
> > +
> > +	if (fixed) {
> > +		tst_resm(TINFO, "WARNING: Remove double or trailing slashes from TMPDIR,"
> > +			 " please fix your setup to: TMPDIR='%s'",
> > +			 env_tmpdir);
> > +	}
> > +

> This whole thing can be just a single loop (beware untested):

> 	size_t s = 0, d = 0;
> 	char prev_c = 0;

> 	for (;;) {
> 		switch (env_tmpdir[s]) {

NOTE you never set prev_c, it would have to be:

	if (s)
		prev_c = env_tmpdir[s-1];

> 		case '/':
> 			if (prev_c != '/')
> 				d++;
> 			s++;
> 		break;
> 		case '\0':
> 			if (d && prev_c == '/')
> 				env_tmpdir[d-1] = '\0';
> 			break;

And also you don't break for loop, because the break above is for case, goto or
return would have to be used).

> 		break;
> 		default:
> 			env_tmpdir[d++] = env_tmpdir[s++];
> 		}
> 	}

Also if TMPDIR is not set, env_tmpdir = TEMPDIR; will lead to segfault.
strdup() will need to be used:

	if (!env_tmpdir)
		env_tmpdir = strdup(TEMPDIR);

But even with these changes I was not able to find why / is eaten:


	char *env_tmpdir = getenv("TMPDIR");
	size_t s = 0, d = 0;
	char prev_c = 0;

	if (!env_tmpdir)
		env_tmpdir = strdup(TEMPDIR);

	for (;;) {
		if (s)
			prev_c = env_tmpdir[s-1];

		switch (env_tmpdir[s]) {
		case '/':
			if (prev_c != '/')
				d++;
			s++;
		break;
		case '\0':
			if (d && prev_c == '/')
				env_tmpdir[d-1] = '\0';
			goto end;
		break;
		default:
			env_tmpdir[d++] = env_tmpdir[s++];
		}
	}

end:
	return env_tmpdir;
}


So how about using for loop? It's not that compact, but maybe easily readable.

const char *tst_get_tmpdir_root(void)
{
	char *env_tmpdir = getenv("TMPDIR");
	char prev_c = 0;
	size_t k = 0;

	if (!env_tmpdir)
		env_tmpdir = strdup(TEMPDIR);

	if (env_tmpdir[0] != '/') {
		tst_brkm(TBROK, NULL, "You must specify an absolute "
				"pathname for environment variable TMPDIR");
		return NULL;
	}

	for (int i = 0; env_tmpdir[i] != '\0'; i++) {
		if (i)
			prev_c = env_tmpdir[i-1];

        if (env_tmpdir[i] != '/' || prev_c != '/')
            env_tmpdir[k++] = env_tmpdir[i];
	}

	env_tmpdir[k] = '\0';

	if (env_tmpdir[k-1] == '/')
		env_tmpdir[k-1] = '\0';

	return env_tmpdir;
}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
