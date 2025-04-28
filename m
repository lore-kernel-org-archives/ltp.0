Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB2C369D5
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 14:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC9833CBBD3
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 16:50:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4B83C02B9
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:49:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15A7D10009BD
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:49:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AFFC211C9;
 Mon, 28 Apr 2025 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745851798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnEZcALCYLcjpWvvb0Rla8zGHWBUWxN4MR+MJ6TrStE=;
 b=iEu9fy+YAhZtJfSzi4kW1yXwmSyuvhTjASdoupE+Ccp+PxM/KwNV/V5JsJIxmsIre5DGln
 NN7csEznurYYqSN29oBc449f8Iod4P3GB0X+lv+2z0AG9v24cOuWsrMS3awjEOabKH60wW
 CvogWcjiSJ6NucHCVi4mnYvFIknYpTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745851798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnEZcALCYLcjpWvvb0Rla8zGHWBUWxN4MR+MJ6TrStE=;
 b=YlDtDqcgL07ZPiJUJJXbtEs7u/n8E6TGPr4g/8aiCdotAtXMZ+4LXTY3FyGkFDtBIxPinD
 BUS06Y8//xMdYwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745851798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnEZcALCYLcjpWvvb0Rla8zGHWBUWxN4MR+MJ6TrStE=;
 b=iEu9fy+YAhZtJfSzi4kW1yXwmSyuvhTjASdoupE+Ccp+PxM/KwNV/V5JsJIxmsIre5DGln
 NN7csEznurYYqSN29oBc449f8Iod4P3GB0X+lv+2z0AG9v24cOuWsrMS3awjEOabKH60wW
 CvogWcjiSJ6NucHCVi4mnYvFIknYpTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745851798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnEZcALCYLcjpWvvb0Rla8zGHWBUWxN4MR+MJ6TrStE=;
 b=YlDtDqcgL07ZPiJUJJXbtEs7u/n8E6TGPr4g/8aiCdotAtXMZ+4LXTY3FyGkFDtBIxPinD
 BUS06Y8//xMdYwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BB7413A25;
 Mon, 28 Apr 2025 14:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YwiDBZaVD2hnfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 28 Apr 2025 14:49:58 +0000
Date: Mon, 28 Apr 2025 16:50:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aA-Vu3YQHEbvUxeR@yuki.lan>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-4-bd38035f86bc@suse.com>
 <Z8b8CLkKbrRkkt9P@yuki.lan>
 <bd982369-c0bc-4952-9ff3-a3fd5181667e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd982369-c0bc-4952-9ff3-a3fd5181667e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] Add lsm_get_self_attr03 test
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
> >> +	count =3D TST_EXP_POSITIVE(
> >> +		lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
> >                                                            ^
> > 							  This does not
> > 							  look right.
> >
> >
> > Shouldn't we pass size initialized to size of the ctx->ctx[] there?
> >
> > You are mixing the size of the attr[] array and the size of the ctx
> > into a single variable which isn't right at all. The attr[] size can
> > also be much smaller, since it's just a single string.
> =

> This is how kselftests are working as well, so I'm a bit confused.
> According to the documentation of lsm_get_self_attr:
> =

>  =A0* @size: pointer to the size of space available to receive the data
> =

> I guess kselftests are giving a bare minimum size according to the =

> memory pages.

No the kselftests work, your code does not. The kselftests use the
struct lsm_ctx from /usr/include/linux/lsm.h:

struct lsm_ctx {
        __u64 id;
        __u64 flags;
        __u64 len;
        __u64 ctx_len;
        __u8 ctx[] __counted_by(ctx_len);
};

Where the ctx array is dynamically sized.

While your fallback declares the structure with the ctx to be statically
sized (lapi/lsm.h):

struct lsm_ctx {
       uint64_t id;
       uint64_t flags;
       uint64_t len;
       uint64_t ctx_len;
       uint8_t ctx[4096];
};


This is simply wrong because:

- the deifitiontions does not match
- the size of ctx->ctx in case from the system definition is 0
- and page_size !=3D 4k in all cases


So the only good solution is to:

- match the definition of the fallback to the system structure
- define the size in the header somewhere
- use the defined size both for allocation and size initialization

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
