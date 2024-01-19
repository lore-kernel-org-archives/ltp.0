Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D03C47DAF
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 15:33:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57C813CE2C0
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 16:33:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992ED3CAB18
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 16:33:11 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF51510185DC
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 16:33:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E13991F7F9;
 Fri, 19 Jan 2024 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705678390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs5b5cOV0qckeX/XZspqjvMa8hgW8nx6KjcntJmivmA=;
 b=3Blq9VrAb67neqE3tMIqyvonrxDzQDZsr+l3hSW2AZmGwekhZt5K3euvD2LyEVR5ctkVs5
 MN3MF+qzF/RC45H/e1RBo5mThlfAVk5+DkhxYkflWAjkgSKXrZGWVbbeG4WerdsoeMzORf
 WmQ2tcLdU77huMrQC+3rcDvy60l8XtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705678390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs5b5cOV0qckeX/XZspqjvMa8hgW8nx6KjcntJmivmA=;
 b=fL9cHlPO9C2T/mPwYFXNTvVloCe4y1EtA6EcdTkXhCYRyqKotyCgwtbRpPlbpxe7MeAQWZ
 r2SSVBSs+OwhXUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705678389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs5b5cOV0qckeX/XZspqjvMa8hgW8nx6KjcntJmivmA=;
 b=ORGdUBo2/9y971jfxM4gFnxA6pfuFbi4gRDZq4eJkxX+oToevVmgN/myU9uy9ppEuooQYF
 3Qi2xOOWCqEzTkKtA88rqsbUMjLdWfMqIlhuIvjkVH5UTgGmzA0dbLZhysO6UIDFWVine4
 P+gZp91CCCRW4HFl1N2wZtzFSpr5uc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705678389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs5b5cOV0qckeX/XZspqjvMa8hgW8nx6KjcntJmivmA=;
 b=YgMV+F7Xz+LcmRiesCcqnJMp/UzGWQRaa7vobgRS5Exxy3Mo41PHOhWAzwcDC0rkBIhxYK
 OLBy7vQVDFIx4XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D318B1388C;
 Fri, 19 Jan 2024 15:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7T6CMzWWqmUmRwAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 19 Jan 2024 15:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 6FDAEA0803; Fri, 19 Jan 2024 16:33:05 +0100 (CET)
Date: Fri, 19 Jan 2024 16:33:05 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240119153305.bzqn3ehrzgrgs3ud@quack3>
References: <20240118191353.2815915-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118191353.2815915-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.21 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:email,suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.41)[90.96%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] readahead01: Pass also on memfd secret
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 18-01-24 20:13:53, Petr Vorel wrote:
> It fixes failure on 6.6 kernels:
> 
> TFAIL: readahead() on memfd secret succeeded
> 
> Fixes: ecf81d729 ("syscalls: readahead01: Make use of tst_fd")
> Reported-by: Dominique Leuenberger <dimstar@opensuse.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Yes, memfd secret is standard tmpfs file in principle so readahead(2)
succeeds. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Hi,
> 
> I wonder if this is a bug or just changed functionality.
> 
> I also tested on 5.14 SLES and 5.10 Debian and both TCONF due ENOSYS:
> 
> tst_fd.c:260: TCONF: Skipping memfd secret: ENOSYS (38)
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/readahead/readahead01.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> index e86a73e3e..a1f313605 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -51,6 +51,7 @@ static void test_invalid_fd(struct tst_fd *fd)
>  	/* These succeed */
>  	case TST_FD_FILE:
>  	case TST_FD_MEMFD:
> +	case TST_FD_MEMFD_SECRET:
>  	case TST_FD_PROC_MAPS:
>  		return;
>  	default:
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
