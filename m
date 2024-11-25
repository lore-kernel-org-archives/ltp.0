Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B221D3B7F6
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 09:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AC963DA9AE
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 10:28:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 767193D71AD
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 10:28:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 265F4630CB5
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 10:28:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AEDC1F381;
 Mon, 25 Nov 2024 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732526895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHaT0R69sqfuSMpGDhaY6fHVuEK0777LYZEzqXnloPc=;
 b=ppeChh8VDgGk3kutDJGLNckw/vKXtC56zogteHzVP/Pi86HAXzeDL1UqhibyNSEfzW08gG
 ZgPF4TMJI4f1mvmdr01bdTCDo67KSu30Y6hHYFEiwY/JSdMHJ4r2daDP0O3I+nE4p2ez2f
 jTlaHG/Gbny23/eKutLjO3N1gmSgT0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732526895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHaT0R69sqfuSMpGDhaY6fHVuEK0777LYZEzqXnloPc=;
 b=+OvNJ+1VvFEgydj1oB4xx35s3Em+WQY2Wplwr5DqRx8rKBz+uMq6wcTsV1OMFpoTa5bvi0
 FRjq5bLrRbeTSJCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732526895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHaT0R69sqfuSMpGDhaY6fHVuEK0777LYZEzqXnloPc=;
 b=ppeChh8VDgGk3kutDJGLNckw/vKXtC56zogteHzVP/Pi86HAXzeDL1UqhibyNSEfzW08gG
 ZgPF4TMJI4f1mvmdr01bdTCDo67KSu30Y6hHYFEiwY/JSdMHJ4r2daDP0O3I+nE4p2ez2f
 jTlaHG/Gbny23/eKutLjO3N1gmSgT0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732526895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHaT0R69sqfuSMpGDhaY6fHVuEK0777LYZEzqXnloPc=;
 b=+OvNJ+1VvFEgydj1oB4xx35s3Em+WQY2Wplwr5DqRx8rKBz+uMq6wcTsV1OMFpoTa5bvi0
 FRjq5bLrRbeTSJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F71513890;
 Mon, 25 Nov 2024 09:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3LEIGi9DRGf8YQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 25 Nov 2024 09:28:15 +0000
Date: Mon, 25 Nov 2024 10:28:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20241125092814.GA298526@pevik>
References: <20241114144029.349559-1-pvorel@suse.cz>
 <20241114144029.349559-4-pvorel@suse.cz>
 <CAASaF6z3quzaFkgo47SZgpPxK=Ny_2f3C07LR7=8eVFrTa6CfQ@mail.gmail.com>
 <20241115140005.GD1718754@pevik>
 <CAASaF6xC-PJC79cSbH_NVGYcTTkApYuOkyXDL8p8GQa0k=-vgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xC-PJC79cSbH_NVGYcTTkApYuOkyXDL8p8GQa0k=-vgw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] mq_timedsend01: Workaround segfault on libc
 variant on 32 bit
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

Hi Jan,

...
> > > > +       if (tc->bad_ts_addr) {

> > > Would it make sense to run bad_msg_addr/EFAULT test also in child?

> > First, thanks a lot a review.
> > I'm not sure myself. So far it's not needed (problem is only with struct
> > timespec *abs_timeout not with const char msg_ptr[]). But OTOH it does not
> > harm. Doing this might prevent some failure in the future.

> It was only as a precaution. Either way, feel free to add to series:
> Acked-by: Jan Stancek <jstancek@redhat.com>

Thanks a lot for your review. Merged with changing bad_msg_addr/EFAULT being
tested also in child.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
