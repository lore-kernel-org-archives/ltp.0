Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A1C3ABB2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 10:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33C0A3C2BDA
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 12:06:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8AB3C1BE2
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:06:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5E8860234F
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:06:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 268E421A11;
 Mon, 16 Sep 2024 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726481163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O0Sh+yR7eI/rp4Zct0Dutdacw7A4kTFLSU7i9azhic=;
 b=TCXSbFrvIxyMoKVPYxZtc6HkawtbwFC9c74tEI2HHljr0TGQFWrHG+ZfQsOrE+9oc4qfrz
 qgM8PJeUF+6T/trfhM+hSwkPG8KMzhri7oJyGpo4Wf4tiQyXa+P70SSgQj62SNv76y10sl
 x6XJUFwvmK4W5kPYkKe+EMoLR+Ytepo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726481163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O0Sh+yR7eI/rp4Zct0Dutdacw7A4kTFLSU7i9azhic=;
 b=cAclA7c5eP621q+UwsQLT/AR7kWssS/qo7H9bMIV4nxraYTNbD6UIQtV7bkrgzzrzghaAX
 iU8GgekCEK+CG0Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TCXSbFrv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cAclA7c5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726481163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O0Sh+yR7eI/rp4Zct0Dutdacw7A4kTFLSU7i9azhic=;
 b=TCXSbFrvIxyMoKVPYxZtc6HkawtbwFC9c74tEI2HHljr0TGQFWrHG+ZfQsOrE+9oc4qfrz
 qgM8PJeUF+6T/trfhM+hSwkPG8KMzhri7oJyGpo4Wf4tiQyXa+P70SSgQj62SNv76y10sl
 x6XJUFwvmK4W5kPYkKe+EMoLR+Ytepo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726481163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O0Sh+yR7eI/rp4Zct0Dutdacw7A4kTFLSU7i9azhic=;
 b=cAclA7c5eP621q+UwsQLT/AR7kWssS/qo7H9bMIV4nxraYTNbD6UIQtV7bkrgzzrzghaAX
 iU8GgekCEK+CG0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 089DA1397F;
 Mon, 16 Sep 2024 10:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z8TvAAsD6GYoXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Sep 2024 10:06:03 +0000
Date: Mon, 16 Sep 2024 12:04:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZugCv08Io4PGpnue@yuki.lan>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-5-chrubis@suse.cz>
 <90cf8a7d-7c93-470d-a33d-816b513730cd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90cf8a7d-7c93-470d-a33d-816b513730cd@suse.com>
X-Rspamd-Queue-Id: 268E421A11
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] testcaes/lib: Add shell loader
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void extract_metadata(void)
> > +{
> > +	FILE *f;
> > +	char line[4096];
> > +	char path[4096];
> > +	enum parser_state state =3D PAR_NONE;
> > +
> > +	if (tst_get_path(shell_filename, path, sizeof(path)) =3D=3D -1)
> > +		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
> > +
> > +	f =3D SAFE_FOPEN(path, "r");
> > +
> > +	while (fgets(line, sizeof(line), f)) {
> > +		switch (state) {
> > +		case PAR_NONE:
> > +			if (!strcmp(line, "# ---\n"))
> What if user defines "#---" or "#=A0=A0 ---" ? IMHO it would be better to =

> parse it following shell comments standards. In particular, "^#\s+---" =

> using a *scan function.

If user sets the line any differently the test will end up with pretty
clear error message that metadata are missing, so I do not see this as
an issue.

> > +				state =3D PAR_ESC;
> > +		break;
> > +		case PAR_ESC:
> > +			if (!strcmp(line, "# env\n"))
> Same apply here and to the others.

Same here as well.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
