Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9DAC982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 11:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 242F33EA173
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 13:52:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD1DE3E546A
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:51:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1E5451000D45
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:51:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B247A1F750;
 Fri, 18 Sep 2026 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789732307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjPQIIS61RHRlJsfIvTRLTGzZ1+J7Piuo5W3WQnNxg8=;
 b=TKkC1HgfST2xV793BYLlb02aEWHtXA6df6ljd+Xlvciqh0Yw7ryeB/rI8W/VQQMnZlgaG1
 oAdWDAMT2h1rz0WXl9Gnj5NsCv9c791RrLURLbe2xZ3WWTlvT2smy0J+fpjcgFuXLRN8XZ
 T+o8yRclWbrt+AElOfd04nv6Ua5KamU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789732307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjPQIIS61RHRlJsfIvTRLTGzZ1+J7Piuo5W3WQnNxg8=;
 b=BTFBABYWyG1dPbN1VhuTDtuOqhfs0tVl0qCWxSLR7AKg0UD9UuyU8SBGyvPBW9+Fy67ksX
 vk+yOhb/DDvXt0DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789732303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjPQIIS61RHRlJsfIvTRLTGzZ1+J7Piuo5W3WQnNxg8=;
 b=emJDm4yCYn08/uTlpYqc9LytJeLUoEjaqDaaqp5//zVi5mx2cHTqVwfikTisjRBK6KfvUj
 ICuHcU9MO202UUw3rvx/AUDREIoH3nHGz9KuTe03sxS/Gjs8CFSOXvDcbLC9rpb/eF6Hgo
 o81b9rZZVVHP3b4ln9v2KYZU9FHd57g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789732303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjPQIIS61RHRlJsfIvTRLTGzZ1+J7Piuo5W3WQnNxg8=;
 b=t1O4Mt4LxqCFX4yH6J1+h2RFuipcLBQPuljivAhfnb4TCFpmBqlQMVORh30dcGEEjP42Qi
 iX31UKULXoZX82Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 866B013927;
 Fri, 18 Sep 2026 11:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TZdgGM8lrWqcVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 11:51:43 +0000
Date: Fri, 18 Sep 2026 13:51:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq0l11xvfQzkntA-@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-19-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-19-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 18/36] keyctl23: Test KEYCTL_RESTRICT_KEYRING
 builtin_trusted
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
> +static key_serial_t ring_builtin;
> +static key_serial_t user_key;
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	tst_modprobe("x509_key_parser", NULL);

This is probably worth of adding .needs_kconfigs with
"X509_CERTIFICATE_PARSER".

Otherwise it looks fine:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
