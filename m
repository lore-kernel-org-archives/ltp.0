Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0227CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:03:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 748313EA844
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 13:03:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A4B23E6A6E
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:03:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9229610007CC
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:03:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 691641F7A1;
 Mon, 12 Oct 2026 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791803017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JpoeqqGhycL6d1TC6Wu92CNXmo2naa4hN4OrFx146Y=;
 b=FTP6RKMy5udz7ZqAZ62In9K42iCzd/Ey4XkWtdWggUwsLLOYFkvY0IFCVwSuIHV1bvhVOi
 8wighclOoN7OnlRot3y3mxYOHro155jamii3MFQUYnb5iyHHZ8UuB+VJUvWvf3B8w/Mzz2
 jmBivLCBL5YdjIRwQ1fSGiUwW7aYv1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791803017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JpoeqqGhycL6d1TC6Wu92CNXmo2naa4hN4OrFx146Y=;
 b=GfZZs1WfvaB9iuwkKEYwlYrTLepeamqVBR4iIzQUtdu3Ica6TZjtbotv9DHV4pIPVqyJmZ
 FQ0QOeZp4OIIh1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791803017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JpoeqqGhycL6d1TC6Wu92CNXmo2naa4hN4OrFx146Y=;
 b=FTP6RKMy5udz7ZqAZ62In9K42iCzd/Ey4XkWtdWggUwsLLOYFkvY0IFCVwSuIHV1bvhVOi
 8wighclOoN7OnlRot3y3mxYOHro155jamii3MFQUYnb5iyHHZ8UuB+VJUvWvf3B8w/Mzz2
 jmBivLCBL5YdjIRwQ1fSGiUwW7aYv1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791803017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JpoeqqGhycL6d1TC6Wu92CNXmo2naa4hN4OrFx146Y=;
 b=GfZZs1WfvaB9iuwkKEYwlYrTLepeamqVBR4iIzQUtdu3Ica6TZjtbotv9DHV4pIPVqyJmZ
 FQ0QOeZp4OIIh1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A3E613408;
 Mon, 12 Oct 2026 11:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /sUZBom+zGrcTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 Oct 2026 11:03:37 +0000
Date: Mon, 12 Oct 2026 13:03:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asy-l3cymtWrm_ss@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-7-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-7-57cceb68f927@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 07/16] fchroot04: test fchroot() into
 failfs as root
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
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	char buf[PATH_MAX];
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> +
> +	TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
> +		"absolute file open");
> +
> +	TST_EXP_FAIL(mkdir("/foo", 0700), EOPNOTSUPP,
> +		"absolute directory creation");
> +
> +	/*
> +	 * The libc getcwd() wrapper rejects the "(unreachable)"
> +	 * prefix produced by the kernel, so call the raw syscall.
> +	 */
> +	TEST(tst_syscall(__NR_getcwd, buf, sizeof(buf)));
> +	if (TST_RET > 0)
> +		TST_EXP_EQ_STRN(buf, UNR_TAG, sizeof(UNR_TAG) - 1);
> +	else
> +		tst_res(TFAIL | TTERRNO, "getcwd() failed");
> +
> +	exit(0);

Here as well, no need to add the exit(0)

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
