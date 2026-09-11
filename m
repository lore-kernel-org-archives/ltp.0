Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF0CC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7FE33E9224
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:48:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9F563CD382
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:48:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D1411400DEF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:48:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 668F91FEEE;
 Fri, 11 Sep 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789127290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BUnU45xwptz0ziZb621aTaV2Che6XX5IVHgtR7v7mKM=;
 b=MXxS9MGW+wbir426A1GdOJxFtCnA3C/pfXEBzCpY/q5/rfOjvT9WwYbQ7MkEozr8r7Qxfm
 jGNwm90uz3AShNN3Aoe+hfINWONWGswEfL4ZjeBkBVbyLeknsq4aEWWZgM6FhgKftibsXr
 ff6gnjHAGGp1D52nmqFUq53DCKdt/DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789127290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BUnU45xwptz0ziZb621aTaV2Che6XX5IVHgtR7v7mKM=;
 b=Tq3WFmynSXjK6a+CtKw8XPH/UPJV4KKe0g8APqbaau/seE+ZSe6AXz0NlqrpnZa405Mrf9
 7Vt/l3sat/QZV4CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NhPoc8vT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=arhqVYlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789127286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BUnU45xwptz0ziZb621aTaV2Che6XX5IVHgtR7v7mKM=;
 b=NhPoc8vTpmP3csa5pWDJZOIOvmw4W2AyAOKLw7rSbXkplInGOGeRJO/1mvHDIFBB3qdSM9
 uNqZ/XnRpi8bLJEerzSzUQ6oL/pUXY+M3//sdp8sL7kM4N9ANxwAYdkLoAJX+e5ZpucnRN
 0y6eH4sEoiY+6NkXoCeBcHeHbVrT7+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789127286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BUnU45xwptz0ziZb621aTaV2Che6XX5IVHgtR7v7mKM=;
 b=arhqVYlP2HcZn1jwIxatpahQ5B59xiEl+jsTZrq6yvRWRkrxucQv/m3QN1siv3PUPIQLgy
 mY0yTVmhUzm6RNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302B413715;
 Fri, 11 Sep 2026 11:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w4a+C3bqo2oLVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 11:48:06 +0000
Date: Fri, 11 Sep 2026 13:48:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqPqgBuvcjZE4F6g@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-10-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-10-43b78b15ef9f@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 668F91FEEE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 10/33] keyctl18: Test basic KEYCTL_MOVE
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
> +static key_serial_t ring_a, ring_b;
> +static key_serial_t key;
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	ring_a = new_ring(RING_A_DESC);
> +	ring_b = new_ring(RING_B_DESC);
> +	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
> +}
> +
> +static void reset_state(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_LINK, key, ring_a, 0, 0);
> +	TEST(keyctl(KEYCTL_UNLINK, key, ring_b, 0, 0));
> +	if (TST_RET == -1 && TST_ERR != ENOENT)
> +		tst_brk(TBROK | TTERRNO, "failed to unlink key from ring_b");

We are trying to avoid hypotetical TBROK here in the case that the MOVE
didn't work right? I'm not sure it's worth the trouble.

> +}
> +
> +static void run(void)
> +{
> +	reset_state();
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring_a, ring_b, 0));
> +	if (!TST_PASS)
> +		return;
> +
> +	TST_EXP_EQ_LI(search_ring(ring_b, "user", KEY_DESC), key);
> +
> +	TST_EXP_FAIL2(search_ring(ring_a, "user", KEY_DESC), ENOKEY,
> +		      "key no longer found in the source keyring");

Here the search_string() function actually hides the syscall being
used. I would prefer having the keyctl() call in these two.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.min_kver = "5.3",
> +};
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
