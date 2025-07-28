Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB59C83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 10:03:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C9E3C9406
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 12:03:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C3D43C5364
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 12:03:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9870D600275
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 12:03:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A8F82123D;
 Mon, 28 Jul 2025 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753697009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtuWZiZpVYw44NDsDLL8Rg4W43ZxSW3nhYIgqxrN7vw=;
 b=a7ohxsfqHSlxprq3lHas7gVgY6iFX8pv/Raz+/vNmDf3YSVXczul9AB9/ecgKGdzf8JdHn
 rpOdME/8LpL4ETQUOA2EqzX3+UvzC06UhRXEt2DkWiBfNCz/+NHFse0PmmMMFBhJX6Y5wp
 l38lgEAj0sDNJ3D/iusJ1d/vx4yQ0zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753697009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtuWZiZpVYw44NDsDLL8Rg4W43ZxSW3nhYIgqxrN7vw=;
 b=IOyE3J8orLHHAiIxTpnfKbdZi148/DiG1/Rm3SiG08TtGNIV1XxXhdZuSPOjYTROvfe5Ey
 JC24PaZo2gh+P5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753697008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtuWZiZpVYw44NDsDLL8Rg4W43ZxSW3nhYIgqxrN7vw=;
 b=hdCt3MOlklLkNyvqNpa0yPlpiK3jWJav1DwjHWC2cnr8CEwLmJlqYMxwFRoWqdjPGTOoR1
 0zhxEt6cEiKs1VqiLc0Qb8PVq+4y9P2RUjKwJx4IRzI3Y0cbw7mifJi4s1LeAwtBsOzGBT
 2mr0dBkNaPvZWC0as3FpH2DCTI1iG7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753697008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtuWZiZpVYw44NDsDLL8Rg4W43ZxSW3nhYIgqxrN7vw=;
 b=GE5vqzppdA4ucDpFlKLGP++BqwoTOlbkm6xqrCeQhY/zRljZiTBNznKpVoAiryA57GqcGy
 MQ2rF2/DTizqr8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A14E1368A;
 Mon, 28 Jul 2025 10:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lC5jAfBKh2ggOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 28 Jul 2025 10:03:28 +0000
Date: Mon, 28 Jul 2025 12:04:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aIdLGf5Kx5NuAH98@yuki.lan>
References: <20250728212752.774436-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250728212752.774436-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linux.it:url,
 suse.cz:email, yuki.lan:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount08.c: SKIP test if selinux is running
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

The commit is missing why this has to be done. Please be more verbose
and explain the reasons in the commit message.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/mount/mount08.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
> index e2824ac55..1f97de182 100644
> --- a/testcases/kernel/syscalls/mount/mount08.c
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -41,6 +41,9 @@ static void run(void)
>  
>  static void setup(void)
>  {
> +	if (tst_selinux_enforcing())
> +		tst_brk(TCONF, "SKIP test since selinux is running");
> +
>  	SAFE_TOUCH(FOO, 0777, NULL);
>  	SAFE_TOUCH(BAR, 0777, NULL);
>  }
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
