Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894F3C41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 11:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61D423CB4B3
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 12:43:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3638A3C98F7
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:43:02 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 355DE140009C
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:43:00 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C35642209F;
 Tue, 19 Dec 2023 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702986179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHS++6kp6r6POxqzQh90gtqMxtDU0tMa1Ap0wmZM9Dg=;
 b=wCb6xpAD+6qDNivWJzdHYMEmYFXzRUCOKd0ZCcVkiTgDadveE7gfSQMaQTNIfG6c+j6DT9
 3Xv4/Zrrts5xGorljbwbQww3lNK1MQrQ0z2CN4deo94D/vVhi2NwCFuTsW4eBZZzwsusy3
 hfXWIRoxg+8eCKBUMPLN6mR7QWdjOvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702986179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHS++6kp6r6POxqzQh90gtqMxtDU0tMa1Ap0wmZM9Dg=;
 b=bkIg1OXE+kVeZhd/hp7TozGx3Xlif4yDXUe4EgmeIG1AylZ/6mvTlmGzUNjT80TN/TaDcR
 gteUShiF2IVtjYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702986179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHS++6kp6r6POxqzQh90gtqMxtDU0tMa1Ap0wmZM9Dg=;
 b=wCb6xpAD+6qDNivWJzdHYMEmYFXzRUCOKd0ZCcVkiTgDadveE7gfSQMaQTNIfG6c+j6DT9
 3Xv4/Zrrts5xGorljbwbQww3lNK1MQrQ0z2CN4deo94D/vVhi2NwCFuTsW4eBZZzwsusy3
 hfXWIRoxg+8eCKBUMPLN6mR7QWdjOvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702986179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHS++6kp6r6POxqzQh90gtqMxtDU0tMa1Ap0wmZM9Dg=;
 b=bkIg1OXE+kVeZhd/hp7TozGx3Xlif4yDXUe4EgmeIG1AylZ/6mvTlmGzUNjT80TN/TaDcR
 gteUShiF2IVtjYBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FDED13B9B;
 Tue, 19 Dec 2023 11:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kz26JcOBgWXMTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 19 Dec 2023 11:42:59 +0000
Date: Tue, 19 Dec 2023 12:42:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231219114258.GA319509@pevik>
References: <20231214151954.840244-1-pvorel@suse.cz>
 <20231214151954.840244-5-pvorel@suse.cz>
 <CAEemH2dQpNrFj3JTMkzBG1byqrK9ZJRxTpcg_Jh8+bqLrgUK-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dQpNrFj3JTMkzBG1byqrK9ZJRxTpcg_Jh8+bqLrgUK-g@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[35.63%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 04/10] ioctl02: Rename option -D => -d
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

Hi Li, all,


> And, we need to correct the option info for -d.

Good catch. It looks this was the only test which mentioned -D.
I'll fix that before merge.

Kind regards,
Petr

> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -223,7 +223,7 @@ static void do_child(void)
>  static void setup(void)
>  {
>         if (!device)
> -               tst_brk(TBROK, "You must specify a tty device with -D
> option");
> +               tst_brk(TBROK, "You must specify a tty device with -d
> option");

>         int fd = SAFE_OPEN(device, O_RDWR, 0777);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
