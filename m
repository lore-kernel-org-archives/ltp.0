Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EB6C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 14:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4303D3C9C8F
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 15:33:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8D2E3C9A38
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:33:11 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B0D6235652
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:33:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7F021F387
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCXwQu/icU/2XB0CKZLqNMJTru7wpWUQwXzghn4nJV4=;
 b=htk7KO5/pHJOr+2v9160F7FrrIY6JnkE7patXPugeFCJ6Brm7y/PwEqVmcxmkbBh7OVNQb
 CPN6UhbwvO1EwYPVxz6BksWCljAVFlexDnaPhr8mwrV0wRfhMEcP6wc49nf/E9jcn+vhdK
 jdbukty9CQscPZDA/uuVOjxNzRCCCIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCXwQu/icU/2XB0CKZLqNMJTru7wpWUQwXzghn4nJV4=;
 b=e+K1c6uDr6WOOAQ/sJQdIwuc3OnDVMLZA5eh4hwLEhTgzS2aKcixACge+qIcW3XlA62n/E
 uFTzJmuxlrXYIqCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="htk7KO5/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e+K1c6uD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCXwQu/icU/2XB0CKZLqNMJTru7wpWUQwXzghn4nJV4=;
 b=htk7KO5/pHJOr+2v9160F7FrrIY6JnkE7patXPugeFCJ6Brm7y/PwEqVmcxmkbBh7OVNQb
 CPN6UhbwvO1EwYPVxz6BksWCljAVFlexDnaPhr8mwrV0wRfhMEcP6wc49nf/E9jcn+vhdK
 jdbukty9CQscPZDA/uuVOjxNzRCCCIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCXwQu/icU/2XB0CKZLqNMJTru7wpWUQwXzghn4nJV4=;
 b=e+K1c6uDr6WOOAQ/sJQdIwuc3OnDVMLZA5eh4hwLEhTgzS2aKcixACge+qIcW3XlA62n/E
 uFTzJmuxlrXYIqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F9981377F
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 14:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CSLvByUmv2dARgAAD6G6ig
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 14:33:09 +0000
Date: Wed, 26 Feb 2025 15:33:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250226143303.GA3016635@pevik>
References: <20250226143113.3016480-1-pvorel@suse.cz>
 <20250226143113.3016480-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250226143113.3016480-2-pvorel@suse.cz>
X-Rspamd-Queue-Id: A7F021F387
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/3] tst_test: Allow test to suggest reboot
 via $TST_REBOOT
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Frameworks/tooling which run LTP can schedule reboot based on
> environment variable.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> If useful, I should probably add it to C API as well
> (at least swapoff01.c and swapon01.c print also "reboot recommended").

>  doc/users/setup_tests.rst | 3 +++
>  testcases/lib/tst_test.sh | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index ddcf00f027..0cdb86715f 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -85,6 +85,9 @@ users.
>     * - LTP_ENABLE_DEBUG
>       - Enable debug info (value ``1`` or ``y``). Equivalent of ``-D`` parameter.

> +   * - TST_REBOOT
> +     - Environment variable set by LTP test to signalize that SUT should be rebooted.

Obviously TST_REBOOT would be then used by frameworks (kirk, openQA, ...).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
