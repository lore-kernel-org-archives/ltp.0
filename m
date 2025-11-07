Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E433CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05B983CEF5F
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 12:04:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 435663CD279
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 12:04:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 940EA1A000A4
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 12:04:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9136721204;
 Fri,  7 Nov 2025 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762513462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWTXPAxvmF++IQsPN1kZC+Jb/UvDet6fCV/6ftmMK3Y=;
 b=fIOZ030gU8Nf4DI9o28BsnklHm8YhjGWw88CYG8p5tb9th/wIGxk9YMlbpDWOFTP8rvU24
 acKqtP130//614xbmC8kcut0tOnmTrWwWYnZfCvz42s07SRjAv+DGe5tjeNy/cIg4pUg1n
 F+ADpOpAw06XbV3sM4Ip0grEKCU6EEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762513462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWTXPAxvmF++IQsPN1kZC+Jb/UvDet6fCV/6ftmMK3Y=;
 b=b4gQdztC6WvAepFTV63zd2UfPsBuCcvS45a9mgT4G7e7M4iwVsDropOm0/ND3h3YvhWXP6
 QrgLRAaAxS0t69BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762513462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWTXPAxvmF++IQsPN1kZC+Jb/UvDet6fCV/6ftmMK3Y=;
 b=fIOZ030gU8Nf4DI9o28BsnklHm8YhjGWw88CYG8p5tb9th/wIGxk9YMlbpDWOFTP8rvU24
 acKqtP130//614xbmC8kcut0tOnmTrWwWYnZfCvz42s07SRjAv+DGe5tjeNy/cIg4pUg1n
 F+ADpOpAw06XbV3sM4Ip0grEKCU6EEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762513462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWTXPAxvmF++IQsPN1kZC+Jb/UvDet6fCV/6ftmMK3Y=;
 b=b4gQdztC6WvAepFTV63zd2UfPsBuCcvS45a9mgT4G7e7M4iwVsDropOm0/ND3h3YvhWXP6
 QrgLRAaAxS0t69BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F63132DD;
 Fri,  7 Nov 2025 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yAIiFzbSDWl+YwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 11:04:22 +0000
Date: Fri, 7 Nov 2025 12:04:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251107110421.GA1116063@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
 <20251107003041.28929-4-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107003041.28929-4-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -78,21 +78,7 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)

>  static void verify_ioctl_loop(void)
>  {
> -	int ret;
> -	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> -					"primary", "ext4", "1M", "10M", NULL};
> -
...
>  static void setup(void)
>  {
> +	parted_sup = tst_cmd_present("parted");
> +
> +	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> +	                                  "primary", "ext4", "1M", "10M", NULL};
> +

dev_path => "test.img". With this you're effectively reverting your own fix from
ba605cc955 ("ioctl_loop01.c: Use proper device for partitioning"). Why?

'parted' with dev_path immediately fails (haven't found why). But with your
patch applied I'm able to trigger again the problem "TBROK: mkfs.vfat failed
with exit code 1".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
