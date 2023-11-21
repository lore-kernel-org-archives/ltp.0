Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE12CC54FB9
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 10:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326843CC2EB
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 11:41:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE7533C8AE1
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 11:41:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C62060020A
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 11:41:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96EF71F8B5;
 Tue, 21 Nov 2023 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700563305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9KQsw1mrrJB0qOA+bAGlLhlIffsjMEdDtFpVkn3nPk=;
 b=gIaz2zNb45LI0LiTb5uYMRW/0+Qce3BxloMT+t+Knelj0EzEv4Xw88NfxSjk8CJvCWeokm
 8Q3mkvhrHT6p89wJALNqX/Q6DTHHgg5WKkTFOqVUlj7RKkv3HDlBoIdkUj9SQe7h+mFizA
 If7U+3pSPRhcYK7Kt1jktvtIy3CdPUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700563305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9KQsw1mrrJB0qOA+bAGlLhlIffsjMEdDtFpVkn3nPk=;
 b=0R2EbrjdmOOLlfTXyrrxuB3SamLjuh+sLDyZ6ozkkavYlhylB9kk9pYrO5cP/u2PhnCLhd
 H7UZB8obZn89uEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C159139FD;
 Tue, 21 Nov 2023 10:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q9SdF2mJXGUgUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Nov 2023 10:41:45 +0000
Date: Tue, 21 Nov 2023 11:41:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231121104143.GB90328@pevik>
References: <20231116164723.4012-1-mdoucha@suse.cz>
 <20231116164723.4012-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231116164723.4012-2-mdoucha@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.52 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[53.54%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] tst_netlink: Add helper functions for
 handling generic attributes
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

Hi Martin,

> Refactor struct tst_rtnl_attr_list for generic use and add helper
> functions for handling generic struct nlattr message attributes.

There is still tst_rtnl_attr_list mentioned at doc/C-Test-Network-API.asciidoc,
could you please update that?

...
> -/* Add arbitrary attribute to last message */
> +/* Add arbitrary nlattr attribute to last message */
> +int tst_netlink_add_attr(const char *file, const int lineno,
> +	struct tst_netlink_context *ctx, unsigned short type, const void *data,
> +	unsigned short len);
> +#define NETLINK_ADD_ATTR(ctx, type, data, len) \
> +	tst_netlink_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
> +
> +/* Add string nlattr attribute to last message */
> +int tst_netlink_add_attr_string(const char *file, const int lineno,
> +	struct tst_netlink_context *ctx, unsigned short type, const char *data);
> +#define NETLINK_ADD_ATTR_STRING(ctx, type, data) \
> +	tst_netlink_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))

FYI NETLINK_ADD_ATTR_STRING() is not used anywhere. I suppose you plan to use it
in some of the following CVE tests, right?

...
> +int tst_netlink_add_attr_list(const char *file, const int lineno,
> +	struct tst_netlink_context *ctx,
> +	const struct tst_netlink_attr_list *list)
> +{
> +	int i, ret;
> +	size_t offset;
> +
> +	for (i = 0; list[i].len >= 0; i++) {
> +		if (list[i].len > USHRT_MAX) {
> +			tst_brk_(file, lineno, TBROK,
> +				"%s(): Attribute value too long", __func__);
> +			return -1;
Here (and on other function working on more items) is return -1 on error and >=
0 on success.  The other functions return 0 on error and 1 on success.
While this is logic, it would still be nice to describe return in tst_netlink.h.

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
