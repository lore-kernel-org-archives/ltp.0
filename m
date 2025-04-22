Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBEC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 13:07:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDD6B3C20DA
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 15:07:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8E363C196B
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 15:06:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C17511A00CAF
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 15:06:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75D7D21172;
 Tue, 22 Apr 2025 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745327208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1CkdRHHSkcD2D+Q+toSfMhzL+rMie0cQ6yDImc/H0A=;
 b=Hi3vZvL6GVWQoeB4MSTkudkYPaS64JBofuyEQVXlcmi9kA+X0On8FqWw54Cd2NYzMu2XN2
 A1dzBfoWk8ymL0d7ojMFa+SgHLhilsiXlC82OFmIj2FtHiLqV6NlQRViqqJgc54wxtltsQ
 lfeC0xg6zOZDYTetXt/4352Durx2gGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745327208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1CkdRHHSkcD2D+Q+toSfMhzL+rMie0cQ6yDImc/H0A=;
 b=atNAB20ippQVKvNHv6cfUf9rf7+RMIebsT04Qv05rTb6X6lj7rzQ5YQfFFT5APC/aNg2C6
 GHBVMKJs/vzM5nBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745327207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1CkdRHHSkcD2D+Q+toSfMhzL+rMie0cQ6yDImc/H0A=;
 b=NCzdW5qGFQipzP1oqTl5nFrjBN/UYHXlm+IBbZccNhgH6l1TfmNV9SIvK43sCLOe4pQv+P
 wU+dOFvHRocLpTrI/829pP7vsXiTqDCYVwmHeC73BeQxGyxgruqZfVT6RxYZGyMkUTnH02
 hDsft9LljiWOh3SCbWrfAHreZwNjJBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745327207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1CkdRHHSkcD2D+Q+toSfMhzL+rMie0cQ6yDImc/H0A=;
 b=wTd4TJwJBr2fnqZF8A8dS1MtjfvCAx/j7LiBXMxuJOJtzlQtcc7owg0Zn2xkIytewt8u5Q
 S6TF+tj6VSrUlyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5245B137CF;
 Tue, 22 Apr 2025 13:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qbdaEmeUB2jvMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Apr 2025 13:06:47 +0000
Date: Tue, 22 Apr 2025 15:06:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250422130645.GA934527@pevik>
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-2-e08e7463bfaa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250414-conversions-mknod-v3-2-e08e7463bfaa@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/8] syscalls/mknod02: Use relative path to
 avoid use of SAFE_CHDIR
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo, all,

...
> +++ b/testcases/kernel/syscalls/mknod/mknod02.c
> @@ -20,7 +20,7 @@
>  #define MODE_SGID	02000

>  #define TEMP_DIR "testdir"
> -#define TEMP_NODE "testnode"
> +#define TEMP_NODE TEMP_DIR "/testnode"

>  static struct stat buf;
>  static struct passwd *user_nobody;
> @@ -37,14 +37,12 @@ static void setup(void)

>  static void run(void)
>  {
> -	SAFE_CHDIR(TEMP_DIR);
>  	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0), "mknod(%s, %o, 0)", TEMP_NODE, MODE1);

>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_gid, 0);

>  	SAFE_UNLINK(TEMP_NODE);
> -	SAFE_CHDIR("..");

I'm trying to figure out why the original test used SAFE_CHDIR().
IMHO mknod() should not be affected when called from an upper directory.
@Avinesh @Li did I overlook something obvious?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
