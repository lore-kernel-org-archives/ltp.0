Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99AACAC5BE
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:57:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20D2F3CE1E0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 12:57:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9D273C4F80
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:57:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B60B1A006E8
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:57:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BB953243D;
 Mon, 29 Sep 2025 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759143454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gF2ymndufxLXF6l5Nd6un/VKJG4nVUSPy0roXoaogaQ=;
 b=2RtNynkkSsZQ1DibZgba8Ut6Lh1piMVckeKlyumS/Au1u2JeCRV+JaWQi9EZBPdANYNXH5
 WdZHR3Ds9MxT6U1GQ2fbfYwsIE0JYj71nOJlCHQKLYrGt3XVLMXHs3cKHSUpPrbkcBwtXa
 4wH9lwK+ViVUqkSxa27YhG4DvcIkrqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759143454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gF2ymndufxLXF6l5Nd6un/VKJG4nVUSPy0roXoaogaQ=;
 b=JzOVM1JaEDzQFefknL4Zkco1QJGgamQB1mX8exO5jgaIs/1ctRv1RIlSLIkkVE7IqSuJ7B
 GsXEilp3EzBPRvCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759143454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gF2ymndufxLXF6l5Nd6un/VKJG4nVUSPy0roXoaogaQ=;
 b=2RtNynkkSsZQ1DibZgba8Ut6Lh1piMVckeKlyumS/Au1u2JeCRV+JaWQi9EZBPdANYNXH5
 WdZHR3Ds9MxT6U1GQ2fbfYwsIE0JYj71nOJlCHQKLYrGt3XVLMXHs3cKHSUpPrbkcBwtXa
 4wH9lwK+ViVUqkSxa27YhG4DvcIkrqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759143454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gF2ymndufxLXF6l5Nd6un/VKJG4nVUSPy0roXoaogaQ=;
 b=JzOVM1JaEDzQFefknL4Zkco1QJGgamQB1mX8exO5jgaIs/1ctRv1RIlSLIkkVE7IqSuJ7B
 GsXEilp3EzBPRvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6312313782;
 Mon, 29 Sep 2025 10:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZHWEFh5m2migZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Sep 2025 10:57:34 +0000
Date: Mon, 29 Sep 2025 12:58:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <aNpmSc71aNmPoEDY@yuki.lan>
References: <20250926203502.1350861-1-jmorgan@naotchy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250926203502.1350861-1-jmorgan@naotchy.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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
Since we are nearing next release I pushed the patch with minor
adjustenments, thanks!

> statmount09.c: Enable mnt_ns_id for STATMOUNT_MNT_NS_ID

I've removed this duplicate line.

> When HAVE_STATMOUNT_MNT_NS_ID is defined, use mnt_ns_id
> for statmount09 test case. Otherswise, use mnt_id.
> 
> Fixes: #1260

Replaced this with a full link to the issue (it's easier to dig things
up that way).

> Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
> ---
>  testcases/kernel/syscalls/statmount/statmount09.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount09.c b/testcases/kernel/syscalls/statmount/statmount09.c
> index 20c76ba24..03f54f2b8 100644
> --- a/testcases/kernel/syscalls/statmount/statmount09.c
> +++ b/testcases/kernel/syscalls/statmount/statmount09.c
> @@ -39,7 +39,11 @@ static void run(void)
>  		return;
> 
>  	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_NS_ID);
> -	TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
> +#if !defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
> +    TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
> +#else
> +    tst_res(TCONF, "statmount.mnt_ns_id not available in current headers, skipping check");

Replaced the spaces with tabs, we use tabs in LTP (hint: 'make check'
will print errors and warnings to catch such issues).

And also shortened the line a bit, the ", skipping check" part is
redundand since the message type is TCONF already.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
