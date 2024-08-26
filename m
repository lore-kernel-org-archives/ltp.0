Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DA7C5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 15:11:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9DAB3D1E5D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 17:11:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90CDC3D1BF1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 17:11:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE1971A00643
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 17:11:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C08921AC7;
 Mon, 26 Aug 2024 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724685071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9k8lsF7yrtpMx4OSsXTgPcUQ/xSIxKSnhh4CajtJ0Rs=;
 b=mutaPcHAP4AGSuDaulQ3CJwu2YBQo2N9Vxq88uepbrlBiYQjRh5/clBF3CaVOh55bZhHNC
 qE0wp24dkiujLWy/rO7gTdBt13I/5VB49VA2QbTW3fz0CXawD96dgenTHL37qyG+1rQ+Rs
 8ymwoDfVhMj8zGfnppO93KdCIZej84k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724685071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9k8lsF7yrtpMx4OSsXTgPcUQ/xSIxKSnhh4CajtJ0Rs=;
 b=KTU3hSl3mhmOBdYGW7c+d0BgssuYGp9A9l+EYB5Iy6P4KummSspCY2GBgJ5FBsE7/sfthC
 BaxOMU2Fdzbb4oAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fwvn6dtx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JsdxfslS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724685070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9k8lsF7yrtpMx4OSsXTgPcUQ/xSIxKSnhh4CajtJ0Rs=;
 b=fwvn6dtxKw7Jk9XDYD3SVEV5mo7wrxRowJghsufL0tApGVtoub1YnLNw+wzu/4IM+WBEmV
 xLmORgohva77zSpvUEgYlM/euLIIL3ScWweZrinDQyNrxGdyom3uzDkS15O47z8qp6JEpY
 TJLKZYuzAnHpui2x4BzgKLSC7UK025Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724685070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9k8lsF7yrtpMx4OSsXTgPcUQ/xSIxKSnhh4CajtJ0Rs=;
 b=JsdxfslSaOUnpMteNXJSRngMTz3om8KeVIyIo8mxcwbRt8mG0GlZ69bVhXeU1txu37sfBq
 ZJw9aJI7OrdatKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1965113724;
 Mon, 26 Aug 2024 15:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJE2BQ6bzGZRZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Aug 2024 15:11:10 +0000
Date: Mon, 26 Aug 2024 17:10:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <io@richiejp.com>
Message-ID: <ZsyayckEVEsf0qaG@yuki.lan>
References: <20240731092017.8267-1-chrubis@suse.cz>
 <20240731092017.8267-4-chrubis@suse.cz>
 <87o75ws8kz.fsf@richiejp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o75ws8kz.fsf@richiejp.com>
X-Rspamd-Queue-Id: 2C08921AC7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] testcaes/lib: Add shell loader
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
> > +static void metadata_append(const char *line)
> > +{
> > +	size_t linelen = strlen(line);
> > +
> > +	if (metadata_size - metadata_used < linelen + 1) {
> > +		metadata_size += 128;
> 
> This seems like a very small amount to bother allocating.

That is what I have left there after the testing phase where I wanted to
trigger the reallocation. I will change this to 4k.

> > +		metadata = SAFE_REALLOC(metadata, metadata_size);
> > +	}
> > +
> > +	strcpy(metadata + metadata_used, line);
> > +	metadata_used += linelen;
> > +}
> > +
> > +static ujson_obj_attr test_attrs[] = {
> > +	UJSON_OBJ_ATTR("all_filesystems", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("dev_min_size", UJSON_INT),
> > +	UJSON_OBJ_ATTR("filesystems", UJSON_ARR),
> > +	UJSON_OBJ_ATTR("format_device", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("min_cpus", UJSON_INT),
> > +	UJSON_OBJ_ATTR("min_mem_avail", UJSON_INT),
> > +	UJSON_OBJ_ATTR("min_kver", UJSON_STR),
> > +	UJSON_OBJ_ATTR("min_swap_avail", UJSON_INT),
> > +	UJSON_OBJ_ATTR("mntpoint", UJSON_STR),
> > +	UJSON_OBJ_ATTR("mount_device", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_abi_bits", UJSON_INT),
> > +	UJSON_OBJ_ATTR("needs_devfs", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_device", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_hugetlbfs", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_rofs", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_root", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("needs_tmpdir", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("restore_wallclock", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("skip_filesystems", UJSON_ARR),
> > +	UJSON_OBJ_ATTR("skip_in_compat", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("skip_in_lockdown", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("skip_in_secureboot", UJSON_BOOL),
> > +	UJSON_OBJ_ATTR("supported_archs", UJSON_ARR),
> > +};
> > +
> > +static ujson_obj test_obj = {
> > +	.attrs = test_attrs,
> > +	.attr_cnt = UJSON_ARRAY_SIZE(test_attrs),
> > +};
> > +
> > +/* Must match the order of test_attrs. */
> 
> You could use the index syntax like [ALL_FILESYSTEMS] = UJASON_OBJ_ATTR...
> IIRC.
> 
> Then the order can't be messed up

Good idea, will do. Maybe it makes sense to embedded this into the
UJSON_OBJ_ATTR() macro as a second parameter so that we have better
syntax too.

> > +	while (fgets(line, sizeof(line), f)) {
> > +		if (in_json)
> > +			metadata_append(line + 2);
> > +
> > +		if (in_json) {
> > +			if (!strcmp(line, "# }\n"))
> > +				in_json = 0;
> > +		} else {
> > +			if (!strcmp(line, "# TEST = {\n")) {
> > +				metadata_append("{\n");
> > +				in_json = 1;
> > +			}
> > +		}
> 
> This is maybe a little bit too rigid, even if you want this exact
> formatting to be the only valid one. People will get frustrated when
> parsing fails due to whitespace and don't see a clear indication why
> it failed.
> 
> Alternativey you could adopt the standard markdown meta-data format
> where the meta-data is enclosed with three dashes like
> 
> ---
> "meta": "data"
> ---

That may be better, but we would need some markers for the asciidoc
documentation as well, so we need some kind of identifier too.

So maybe:

# ---
# doc
#
# [Description]
#
# This test does bla bla.
# ---
#
# ---
# env
#
# {
#  "needs_root": 1,
# }
# ---

Getting the delimiters right when embedding data is
hard...

> at the top of the file. I suppose you could change it to have comments
> if you want the script to run outside LTP's runner.

We actually need it to be in the comments, because we run the script by
bash first, which bootstraps the enviroment from the shell script we
source first, then reexecutes the script in the right environment.

> In any case using three dots removes any whitespace between tokens which
> is harder to trim.
> 
> The whole patchset looks good though.

Thanks a lot for the review, I will work on the small bits and send v3.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
