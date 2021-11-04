Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9509DC433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 20:24:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE6561186
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 20:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEE6561186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AF423C740D
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 21:24:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951F83C7269
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 21:23:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E06AC200ADB
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 21:23:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 420CE218B2;
 Thu,  4 Nov 2021 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636057433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEAbTEAXNusmlQvVvekHF5W9wvoR3gu/PmsXtpenqaA=;
 b=D/C6Z/56UHzK1v2Odk7lKgIvdI4DRyovaAzzdc9hj9Auk8p4TJINtxswqQhcdUC/CPkrT+
 G1SFryUW3ovzjz9X14W1n3rhHVkdgH92EJR1JHhKEEphqCIztzlbFEKy3QfwcaF8UdZXgD
 +JbQly0wYg3GyZI2bN9nmWQyDpcLcA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636057433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEAbTEAXNusmlQvVvekHF5W9wvoR3gu/PmsXtpenqaA=;
 b=X+MUkVyJXQXP5ErY4VJT6KFi1b62fH3JLwYQfrrBt0qUbJeJj7NzvtMFxb7nOdGZME03hf
 Jc4jCqm4Z8p/cFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0690113F9F;
 Thu,  4 Nov 2021 20:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DJZoO1hBhGE1bgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 20:23:52 +0000
Date: Thu, 4 Nov 2021 21:23:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYRBVuS+GunT5j9U@pevik>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-5-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211103120233.20728-5-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/7] docparse: Implement ARRAY_SIZE()
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

> Adds a special handlingn for ARRAY_SIZE() macro.
typo: s/handlingn/handling/

While code LGTM

Not related to this change (it's also in code in current master): return value
of parse_test_struct() is not used.

...
> +static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **res)
> +{
> +	const char *token;
> +	char buf[2][2048] = {};
> +	int cur_buf = 0;
> +	int prev_buf = 1;
> +
> +	for (;;) {
> +		if (!(token = next_token2(f, buf[cur_buf], 2048, NULL)))
nit: there could be sizeof(buf[cur_buf]) instead of hardwiring 2048.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
