Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97539C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 15:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CF83CF944
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327E73CB8A4
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:04:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10C0114052D3
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:04:37 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF083220F5;
 Fri, 23 Feb 2024 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708700676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05GXuM2eMqFfiKkXH6wCiJJZKxmVTdYZyJfpXDFxbwA=;
 b=h/zI/pbgpFYwdabLOfhJsMGou555jPizVAESi8uDJh4vck1QXWeOukWRhiNYiE84tOL6VF
 txV2pdgvHbKYjIyN0KM9DiGlMsDpw8YGOLuGYz04MHuWHYNiK01FcwkHT0RoaY66RSVIAa
 Caqqa+qWne48+iLOvAWfFQ/MZeJcMpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708700676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05GXuM2eMqFfiKkXH6wCiJJZKxmVTdYZyJfpXDFxbwA=;
 b=yLGtxCgRnwz0Gc+Xq8s4wogXqARSY+sF53tgb5SSGgivrERhw2Sl1JOmW3mt4cn7+43h2b
 TRXq/w0s17KqnkBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708700675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05GXuM2eMqFfiKkXH6wCiJJZKxmVTdYZyJfpXDFxbwA=;
 b=hHsbqUVsq3YhuCp0c6ZuDRlFj6bWsrZTltupAzDIYAWvqEXhbQCQy2qpT5Y9LP8GblbROh
 7RYq2P38wAaHQSrfJ2IwCkRqxYcdCYZQqQsxCKskVuYQTpEDMKScdg/wujab9XZ7cVupEk
 nq290uQlsbmKE0fXHkoSfxf8H0KGhCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708700675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05GXuM2eMqFfiKkXH6wCiJJZKxmVTdYZyJfpXDFxbwA=;
 b=Fli/1X+g2SL2ta9iER5548qG984fPTo7Q1ftrGZt7Pzaho3iIXMZUrIKA+Q5EY/b/ZkmjL
 tM0VkUeVvZO96bCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C87ED13776;
 Fri, 23 Feb 2024 15:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id bcLBLgO02GV9DQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 15:04:35 +0000
Date: Fri, 23 Feb 2024 16:04:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240223150433.GC1486515@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-7-pvorel@suse.cz> <ZdiYya4ZvOY4j5UX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdiYya4ZvOY4j5UX@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.52 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[53.53%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/9] metaparse: Add missing blank line on the list
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
> > +static inline bool item_is_str_list_member(struct data_node *self)
> > +{
> > +	if (self->type != DATA_STRING)
> > +		return false;
> > +
> > +	return self->string.val[0] == '*' && self->string.val[1] == ' ';

> The lists in asciidoc may also start with '-' and I tend to use it
> instead of asterisk because it's easier to see inside the C style
> comments.

+1

> > +}
> > +
> > +static inline bool item_is_str_empty(struct data_node *self)
> > +{
> > +	if (self->type != DATA_STRING)
> > +		return false;
> > +
> > +	return !strlen(self->string.val);

> This is fancy way of doing !self->string.val[0]

+2 (thanks for teaching me proper C :))

...
> >  		for (i = 0; i < self->array.array_used; i++) {
> > +
> > +			if (i > 0 &&
> > +			    missing_space_for_list(self->array.array[i],
> > +						   self->array.array[i-1])) {
> > +				fprintf(stderr,
> > +					"%s:%d: WARNING: missing blank line before first list item, add it\n",
> > +					__FILE__, __LINE__);
> > +				data_fprintf(f, padd+1, "\"\",\n");
> > +			}
> > +
> >  			data_to_json_(self->array.array[i], f, padd+1, 1);
> >  			if (i < self->array.array_used - 1)
> >  				fprintf(f, ",\n");

> I'm not sure if we should add the asciidoc validation into the metadata
> parser. It feels like this could have been done easier in a perl script,
> especially if we are going to add more checks.

You're right. I thought it'd be out of context in perl script, but we works with
arrays there as well, detection should be as easy as here in metadata parser.

I'll change this in v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
