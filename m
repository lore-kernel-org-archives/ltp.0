Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73E3C52D71
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 07:20:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80DB3D1F35
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 09:20:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83503D1EC1
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 09:20:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36A961400F80
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 09:19:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2BD31FB98;
 Fri,  2 Aug 2024 07:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722583198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJy0NEHga6HO6ajFj1YHnPCF6nMNpmhG3jW8yyYVdp8=;
 b=B5OyiGo8DplaS4CBtlAyNJIPHyX6hl/2P9zSKnWd+bpvpoLDVN91eah2p/2m778Kqf+VcB
 dCGW8Vhc+oxbpbqu6OKPh2AWLCfYFwwOOgoVfGHWpHrqTESNJmNjmchcj7HA7GIVJ5RjCN
 uOWXMoIpQWAA85/1nCRm4HKBfkE/Hy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722583198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJy0NEHga6HO6ajFj1YHnPCF6nMNpmhG3jW8yyYVdp8=;
 b=UoMh7W8aE23OdvrTarkafwyKFWtUe2YSOuEdFNxYgD0K3Y1erwW3x5ucNMyrPEgE16Alpq
 uMxOUcrLc018lABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722583198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJy0NEHga6HO6ajFj1YHnPCF6nMNpmhG3jW8yyYVdp8=;
 b=B5OyiGo8DplaS4CBtlAyNJIPHyX6hl/2P9zSKnWd+bpvpoLDVN91eah2p/2m778Kqf+VcB
 dCGW8Vhc+oxbpbqu6OKPh2AWLCfYFwwOOgoVfGHWpHrqTESNJmNjmchcj7HA7GIVJ5RjCN
 uOWXMoIpQWAA85/1nCRm4HKBfkE/Hy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722583198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJy0NEHga6HO6ajFj1YHnPCF6nMNpmhG3jW8yyYVdp8=;
 b=UoMh7W8aE23OdvrTarkafwyKFWtUe2YSOuEdFNxYgD0K3Y1erwW3x5ucNMyrPEgE16Alpq
 uMxOUcrLc018lABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663D513AED;
 Fri,  2 Aug 2024 07:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZKjdF56IrGYgBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 07:19:58 +0000
Date: Fri, 2 Aug 2024 09:19:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
 Alexey Gladkov <legion@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Cyril Hrubis <chrubis@suse.cz>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 =?iso-8859-2?Q?Ga=EBl?= PORTAY <gael.portay@rtone.fr>,
 linux-kernel@vger.kernel.org
Message-ID: <20240802071959.GA1593427@pevik>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802054252.GA1582980@pevik>
X-Spamd-Result: default: False [-0.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
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

Hi all,

...
> @Andrea, I guess we want something like this:

> +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
>  	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>  	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);

> -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
> -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
> +	if (tst_kvercmp(6, 6, 0) >= 0) {
> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
> +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
> +	}
>  }

Actually, this has been backported to all stable/LTS trees (up to 4.19).
Thus there should not be a version check, but instead suggesting a missing
5d1f903f75a8 commit.

	.tags = (const struct tst_tag[]) {
		{"linux-git", "5d1f903f75a8"},
		{}
	}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
