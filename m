Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277AD374A9
	for <ltp@archiver.kernel.org>; Thu, 17 Oct 2024 15:28:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B24E3C4D53
	for <ltp@archiver.kernel.org>; Thu, 17 Oct 2024 17:28:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0F63C065E
 for <ltp@lists.linux.it>; Thu, 17 Oct 2024 17:28:37 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F6F2652687
 for <ltp@lists.linux.it>; Thu, 17 Oct 2024 17:28:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE7021FD34;
 Thu, 17 Oct 2024 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729178914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCryCTp/hgu4b4AH4AgcKqo9JY9gLLgV/l2F70grhu8=;
 b=zxNzWB6Ad0znG0amasNzJg9mVNuJOd/4xG8oUOHmRFFfF/OsivmUK7NmuuAdzfu/iGzjkD
 H3qp3qrMazWpFU+hQEV5ehHLexoFrcIVkRxKbZ30dXUoUyXq1gD167Hf2UdbCzkwvEdWlZ
 4ZXwQJ6hsLehqWH8JJWK72wao5tX3Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729178914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCryCTp/hgu4b4AH4AgcKqo9JY9gLLgV/l2F70grhu8=;
 b=K9pCKzVXlwcWW2oZ1vOGpYxiYUx/dJDY95DWa+7ukBD1VI1U0QSA/64AGny+Vjp8fLjynv
 FAbR+FVJJdK6bSBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wNfTuC6L;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WFBMHzHo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729178913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCryCTp/hgu4b4AH4AgcKqo9JY9gLLgV/l2F70grhu8=;
 b=wNfTuC6LwYnDaOna7klCaJGPojH2keerdSlqFyNI6AlvqpbDcOzv4lMuTj1zNqW1wZaiLg
 sABKvX5uTzhYNmTPxDReO2a1TTD5YNyYU6BH66m4DAPdKl+bOEB9lJuEsOzt5+8raHHK/U
 Z9uczxZ1GU5DmmgMD+blXxnXiBhNBWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729178913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCryCTp/hgu4b4AH4AgcKqo9JY9gLLgV/l2F70grhu8=;
 b=WFBMHzHoIuuh84kQdN41K6kt4ArPYNvG6pLa987ksENvAvuj69a+8OEYrnhukZk+2QDI/O
 VSQzttCvw9jOtqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE4E13A42;
 Thu, 17 Oct 2024 15:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SXW4NCEtEWeUOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 17 Oct 2024 15:28:33 +0000
Date: Thu, 17 Oct 2024 17:27:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <ZxEs5E4vwvRr7DTN@yuki.lan>
References: <20241008135934.2491333-1-david@redhat.com>
 <20241008135934.2491333-4-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241008135934.2491333-4-david@redhat.com>
X-Rspamd-Queue-Id: EE7021FD34
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] move_pages04: convert to new test API
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
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.max_runtime = 120,

This seems to be a bit excessive, generally tests that do run in less
than a second are not supposed to set this field.

Is there any reason for this to be there? If not I can remove this line
along with fixing the typo found by Jan and fix a bit of the formatting
for the documentation comment that is actually parsed by asciidoc before
applying the changes.

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d899844e9c98"},
> +		{"linux-git", "7dff875c9436"},
> +		{}
> +	}
> +};
> -- 
> 2.46.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
