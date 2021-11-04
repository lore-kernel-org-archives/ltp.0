Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D8C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 20:46:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B30B6120E
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 20:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B30B6120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C423A3C7399
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 21:46:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44C583C559D
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 21:46:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D03261001165
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 21:46:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08B31218B2;
 Thu,  4 Nov 2021 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636058798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxoqIf53yjgo0kLsVTiK5AM+SlsSwgyUIkuZpHlckVw=;
 b=pile729gzsH5hgODUg6Q1qxdH0dNFXkxLbTFM/XhPK/WwFlGSyJ6cYEZZWbWDo4FnounVF
 HySXxh0iyhlo5gWdBceI2yfFjZk96wABEzV+c1Vyi+HIHGw3EPlFXWpZRhAthiKFANAcKb
 BDRj0Gy9iLrul8rj9m0BHXUEO2ov2o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636058798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxoqIf53yjgo0kLsVTiK5AM+SlsSwgyUIkuZpHlckVw=;
 b=MWSfQlw89D2ntnRPm9jLrk5JY1NNUkK3T8WGH+JXrENCVj0b8NlZ+x3QYc7fWGJZg1+F/A
 w1hjmqRA6bHm/lCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C774C13FD0;
 Thu,  4 Nov 2021 20:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JAVYLq1GhGF+dgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 20:46:37 +0000
Date: Thu, 4 Nov 2021 21:46:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYRGrBaCefpAtz6x@pevik>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-6-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211103120233.20728-6-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/7] docparse: Add type normalization
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> For now just for .test_variants.

> There are two reasons for this:

> - This code makes sure that we get right value parsed and aborts the
>   compilation if the parser got confused. This part is important since
>   if the testrunners are going to use the metadata the data in there
>   must be correct.
Very good idea.

> - And much less important it makes the resulting json nicer to read

...
> +static void convert_str2int(struct data_node *res, const char *id, const char *str_val)
> +{
> +	long val;
> +	char *endptr;
> +
> +	errno = 0;
> +	val = strtol(str_val, &endptr, 10);
> +
> +	if (errno || *endptr) {
> +		fprintf(stderr,	"Cannot convert %s value %s to int!", id, str_val);
=> missing \n.
> +		exit(1);
> +	}
> +
> +	if (verbose)
> +		fprintf(stderr, "NORMALIZING %s TO INT %li", id, val);
And here.
> +
> +	data_node_hash_del(res, id);
> +	data_node_hash_add(res, id, data_node_int(val));
> +}
> +
> +static void check_normalize_types(struct data_node *res)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; tst_test_typemap[i].id; i++) {
> +		struct data_node *n;
> +		struct typemap *typemap = &tst_test_typemap[i];
> +
> +		n = data_node_hash_get(res, typemap->id);
> +		if (!n)
> +			continue;
> +
> +		if (n->type == typemap->type)
> +			continue;
> +
> +		if (n->type == DATA_STRING && typemap->type == DATA_INT) {
> +			convert_str2int(res, typemap->id, n->string.val);
> +			continue;
> +		}
> +
> +		fprintf(stderr, "Cannot convert %s from %s to %s!",
And here.
> +			typemap->id, data_type_name(n->type),
> +			data_type_name(typemap->type));
> +		exit(1);
> +	}
> +}

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
