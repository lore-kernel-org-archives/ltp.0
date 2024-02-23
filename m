Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D9DC54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EF003CF774
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:09:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 958EF3CCBE3
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:09:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D323206C20
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:09:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE1EA1FBB5;
 Fri, 23 Feb 2024 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708693772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W94aYqMt8qwV4zhOhoJNixk8P3tBw35HceVCIuZfZ8Y=;
 b=qFqFfkX0IrwExcXDu2EJ3nlNWOMTqXULwq5TjQfynbwGnL0GUs3g113F9m1jdmzuqjBXIw
 oJbUILvglG7COEFVFLcIDzdD9305zOt/DHy+TC+z2QTPcoqdWIHMKl1FGOc7sZgQAs8fLd
 m5gikhWdJcYCtC+c6QySC0TPKOAqoSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708693772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W94aYqMt8qwV4zhOhoJNixk8P3tBw35HceVCIuZfZ8Y=;
 b=k9LuhhAI31xYorynx1MVjUzoThJdCAoiXFGjyQc9MEtvYxpCzPJOjB3A3dmmM1g/Yne/1q
 ptpWrikZI8ck+sAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708693772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W94aYqMt8qwV4zhOhoJNixk8P3tBw35HceVCIuZfZ8Y=;
 b=qFqFfkX0IrwExcXDu2EJ3nlNWOMTqXULwq5TjQfynbwGnL0GUs3g113F9m1jdmzuqjBXIw
 oJbUILvglG7COEFVFLcIDzdD9305zOt/DHy+TC+z2QTPcoqdWIHMKl1FGOc7sZgQAs8fLd
 m5gikhWdJcYCtC+c6QySC0TPKOAqoSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708693772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W94aYqMt8qwV4zhOhoJNixk8P3tBw35HceVCIuZfZ8Y=;
 b=k9LuhhAI31xYorynx1MVjUzoThJdCAoiXFGjyQc9MEtvYxpCzPJOjB3A3dmmM1g/Yne/1q
 ptpWrikZI8ck+sAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3353C133DC;
 Fri, 23 Feb 2024 13:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ogieCwyZ2GV/fgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 13:09:32 +0000
Date: Fri, 23 Feb 2024 14:08:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdiYya4ZvOY4j5UX@yuki>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-7-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-7-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[34.90%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static inline bool item_is_str_list_member(struct data_node *self)
> +{
> +	if (self->type != DATA_STRING)
> +		return false;
> +
> +	return self->string.val[0] == '*' && self->string.val[1] == ' ';

The lists in asciidoc may also start with '-' and I tend to use it
instead of asterisk because it's easier to see inside the C style
comments.

> +}
> +
> +static inline bool item_is_str_empty(struct data_node *self)
> +{
> +	if (self->type != DATA_STRING)
> +		return false;
> +
> +	return !strlen(self->string.val);

This is fancy way of doing !self->string.val[0]

> +}
> +
> +static inline bool missing_space_for_list(struct data_node *cur, struct
> +						data_node *prev)
> +{
> +	return item_is_str_list_member(cur) && !item_is_str_empty(prev) &&
> +	    !item_is_str_list_member(prev);
> +}
> +
>  static inline void data_node_print(struct data_node *self)
>  {
>  	printf("{\n");
> @@ -357,6 +381,16 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
>  	case DATA_ARRAY:
>  		data_fprintf(f, do_padd ? padd : 0, "[\n");
>  		for (i = 0; i < self->array.array_used; i++) {
> +
> +			if (i > 0 &&
> +			    missing_space_for_list(self->array.array[i],
> +						   self->array.array[i-1])) {
> +				fprintf(stderr,
> +					"%s:%d: WARNING: missing blank line before first list item, add it\n",
> +					__FILE__, __LINE__);
> +				data_fprintf(f, padd+1, "\"\",\n");
> +			}
> +
>  			data_to_json_(self->array.array[i], f, padd+1, 1);
>  			if (i < self->array.array_used - 1)
>  				fprintf(f, ",\n");

I'm not sure if we should add the asciidoc validation into the metadata
parser. It feels like this could have been done easier in a perl script,
especially if we are going to add more checks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
