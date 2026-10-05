Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971FCA5FFC
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95313E9DB5
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 17:36:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1509A3E11F4
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:36:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B05B600047
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:36:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1D3D21ED1;
 Mon,  5 Oct 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1E5D132D3;
 Mon,  5 Oct 2026 15:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kiZJH+LDw2qXfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 05 Oct 2026 15:36:02 +0000
Date: Mon, 5 Oct 2026 17:36:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asPD8h8o2BBeLMUS@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-5-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-5-fec334ce8e80@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D1D3D21ED1
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/15] ujson: reader: Combine UTF-16 surrogate
 pairs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> RFC 8259 specifies that characters outside the BMP may be represented
> as a surrogate pair (\uD800-\uDBFF followed by \uDC00-\uDFFF).
> Currently, each \uXXXX escape is converted independently to UTF-8,
> producing invalid surrogate code point sequences instead of combining
> them into a single UTF-8 sequence. Lone surrogates are also improperly
> accepted. Combine valid surrogate pairs and reject unpaired surrogates.
> 
> Also return the UTF-8 length instead of the code point when no output
> buffer is given. The caller treats 0 as failure, so \u0000 made
> copy_str() fail without setting an error message.
> 
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_reader.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> index 2219c5801..0975ca1a1 100644
> --- a/libs/ujson/ujson_reader.c
> +++ b/libs/ujson/ujson_reader.c
> @@ -134,8 +134,34 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
>  	if (ucode < 0)
>  		return 0;
>  
> +	if (ucode >= 0xd800 && ucode <= 0xdbff) {
> +		int32_t low;
> +
> +		if (peekb(buf) != '\\' || peekb_off(buf, 1) != 'u') {
> +			ujson_err(buf, "Unpaired high surrogate");
> +			return 0;
> +		}
> +
> +		getb(buf);
> +		getb(buf);
> +
> +		low = parse_ucode_cp(buf);
> +		if (low < 0)
> +			return 0;
> +
> +		if (low < 0xdc00 || low > 0xdfff) {
> +			ujson_err(buf, "Invalid low surrogate in escape sequence");
> +			return 0;
> +		}
> +
> +		ucode = 0x10000 + (((ucode - 0xd800) << 10) | (low - 0xdc00));
> +	} else if (ucode >= 0xdc00 && ucode <= 0xdfff) {
> +		ujson_err(buf, "Unpaired low surrogate");
> +		return 0;
> +	}

I would put this code first, not in an elase branch.


        if (ucode >= 0xdc00 && ucode <= 0xdfff) {
		ujson_err(buf, "Unpaired low surrogate");
		return 0;
	}

	if (ucode >= 0xd800 && ucode <= 0xdbff) {
	    ...
	}

Also it's unlikely that we will hit this in LTP, unless someone adds
emojis or hieroglyphs in test strings.

>  	if (!str)
> -		return ucode;
> +		return ujson_utf8_bytes(ucode);

This is a good bugfix, should have gone in a separate patch. Without
this we may overshoot the required size for the buffer by order of a
magnitude.

>  	if (ujson_utf8_bytes(ucode) + 1 >= len - off) {
>  		ujson_err(buf, "String buffer too short!");
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
