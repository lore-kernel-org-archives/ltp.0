Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB1E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 10:14:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4854F3E78F3
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 11:14:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341483E2D26
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 11:13:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28C6C1BD98CB
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 11:13:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ADE121170;
 Mon,  9 Dec 2024 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733739234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rChwW86U2+E76l3WdSbBWCuAk7ZCnqu7QYTeI0IO+A=;
 b=FsV/2mOgBTFyf5/62gd9PVBNYKj/kc5ReN+z1e/n5ZsTw+92s50CmQPSCCVQGqBdzj9LCm
 5zE8SfIcaKlXgWYsRoUeL22xYbsifWsDCr7dpPLFgOa0T8XcUvrP8U4dL9vXgIpiySTKZq
 zLsmhxicp8U9XhIdDlgQjnOc3p/piNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733739234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rChwW86U2+E76l3WdSbBWCuAk7ZCnqu7QYTeI0IO+A=;
 b=0lyCHusXemsAXjKkQp5HpDb4AOOJY8Zdo9J9N+V2il1sh31yGf9ceaEsD9UA1eYYtHNL+u
 uQQA2ZH7OSO+xSCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="FsV/2mOg";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0lyCHusX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733739234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rChwW86U2+E76l3WdSbBWCuAk7ZCnqu7QYTeI0IO+A=;
 b=FsV/2mOgBTFyf5/62gd9PVBNYKj/kc5ReN+z1e/n5ZsTw+92s50CmQPSCCVQGqBdzj9LCm
 5zE8SfIcaKlXgWYsRoUeL22xYbsifWsDCr7dpPLFgOa0T8XcUvrP8U4dL9vXgIpiySTKZq
 zLsmhxicp8U9XhIdDlgQjnOc3p/piNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733739234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rChwW86U2+E76l3WdSbBWCuAk7ZCnqu7QYTeI0IO+A=;
 b=0lyCHusXemsAXjKkQp5HpDb4AOOJY8Zdo9J9N+V2il1sh31yGf9ceaEsD9UA1eYYtHNL+u
 uQQA2ZH7OSO+xSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4939E138D2;
 Mon,  9 Dec 2024 10:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ad2AD+LCVmesLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Dec 2024 10:13:54 +0000
Date: Mon, 9 Dec 2024 11:13:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241209101348.GA206052@pevik>
References: <20241206094938.92895-1-pvorel@suse.cz>
 <20241206094938.92895-2-pvorel@suse.cz>
 <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
X-Rspamd-Queue-Id: 6ADE121170
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected
 results
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

Hi Li, all,

...
> We could add a blank line print here to make the output better readable.

>   echo ""

> +               echo "*** Running '$test' (exp: $(tst_mask2flag $exp)) ***"

+1


> > +               $test
> > +               rc=$?
> > +               if [ $rc = 127 ]; then
> > +                       echo "Test '$test' not found, maybe out-of-tree
> > build and unset builddir?" >&2
> > +                       exit 1
> > +               elif [ $rc = 2 -a $WHITELIST_GITHUB = 1 -a
> > "$GITHUB_ACTIONS" ]; then


> If one or more variables used in the conditional test are
> either unset or empty, that will lead to invalid syntax.

> So I would suggest using [ ... ] and &&:

>   elif [ $rc = 2 ] && [ $WHITELIST_GITHUB = 1 ] && [ -n "$GITHUB_ACTIONS"
> ]; then

Good point. Or maybe just quote?

elif [ "$rc" = 2 -a "$WHITELIST_GITHUB" = 1 -a "$GITHUB_ACTIONS" ]; then

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
