Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5ADC25B7A
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 11:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4283B3D021A
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 13:39:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 312DF3D00E1
 for <ltp@lists.linux.it>; Fri, 24 May 2024 13:39:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 264E1625F79
 for <ltp@lists.linux.it>; Fri, 24 May 2024 13:39:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41EB333A81;
 Fri, 24 May 2024 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716550778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn7EMjVapUkliFNwtfzfFPTG26HM2UmmsJRoMQuwx5s=;
 b=Bgkof7brlBpdk9D02ZbEAkph0yv50qSqdJqSXqNtiF0fNieE3cwPw12RCOXg6972z0Q8gS
 vGSDeKFGyuuGZU7op5FYiuUcGhqcJCvXQXYC0mxZ/BJw67EhdryRMhNE31cmXR/CEULddj
 DeMSQqM0VUsLmQTQ7tDqYv7RAn9LhVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716550778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn7EMjVapUkliFNwtfzfFPTG26HM2UmmsJRoMQuwx5s=;
 b=rsRVLy0JZmC9VqFyJ/BHEH5/64Nnj1zUYZK+npLK9lrp3YfqXXiy0TM2MF1zuiFULPcaAg
 BCmqi8SiU/IpN1Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716550778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn7EMjVapUkliFNwtfzfFPTG26HM2UmmsJRoMQuwx5s=;
 b=Bgkof7brlBpdk9D02ZbEAkph0yv50qSqdJqSXqNtiF0fNieE3cwPw12RCOXg6972z0Q8gS
 vGSDeKFGyuuGZU7op5FYiuUcGhqcJCvXQXYC0mxZ/BJw67EhdryRMhNE31cmXR/CEULddj
 DeMSQqM0VUsLmQTQ7tDqYv7RAn9LhVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716550778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn7EMjVapUkliFNwtfzfFPTG26HM2UmmsJRoMQuwx5s=;
 b=rsRVLy0JZmC9VqFyJ/BHEH5/64Nnj1zUYZK+npLK9lrp3YfqXXiy0TM2MF1zuiFULPcaAg
 BCmqi8SiU/IpN1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F6E613A3D;
 Fri, 24 May 2024 11:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mdg8Bnp8UGYPcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 May 2024 11:39:38 +0000
Date: Fri, 24 May 2024 13:39:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240524113936.GA114626@pevik>
References: <20240523155932.26393-1-chrubis@suse.cz>
 <233cf26a-3b1a-47db-90a4-764a95601699@suse.cz>
 <ZlB6-BvuMMVfhr_t@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZlB6-BvuMMVfhr_t@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/msgstress01: Fix off by one in array
 access
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

> Hi!
> > I'd at least add a check that size == data.len + 1.

> Which is not true actually because we always send a 100 bytes of data
> regardless the message size, which is probably another oversight.

> So let's keep the test as it is for now and I will do more work on it
> after the release.

> To fix this we would have to do at least, but I do not want to change
> the test at this point just before the release:

Sounds reasonable, I'll check it. But now I'm going to tag the release.

> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> index b6a64cf4f..f0da595cd 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> @@ -109,7 +109,7 @@ static void writer(const int id, const int pos)
>         int iter = num_iterations;

>         while (--iter >= 0 && !(*stop)) {
> -               int size = msgsnd(id, &buff->msg, 100, IPC_NOWAIT);
> +               int size = msgsnd(id, &buff->msg, buff->msg.data.len + 1, IPC_NOWAIT);

>                 if (size < 0) {
>                         if (errno == EAGAIN) {
> @@ -160,6 +160,15 @@ static void reader(const int id, const int pos)
>                         return;
>                 }

> +               if (msg_recv.data.len + 1 != size) {
> +                       tst_res(TFAIL,
> +                               "Wrong message size have %i expected %i",
> +                               size, msg_recv.data.len+1);
> +                       *stop = 1;
> +                       *fail = 1;
> +                       return;
Very nit: tst_res(TFAIL and *stop and *fail assignments could be in some macro
(e.g. QUIT(msg, ...) ).

Kind regards,
Petr
> +               }
> +
>                 for (int i = 0; i < msg_recv.data.len; i++) {
>                         if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
>                                 tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
