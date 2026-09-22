Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD67C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 15:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5BC3E6D40
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 17:14:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B95393E6CA3
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:14:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43B48600A85
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:14:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C660E21A16;
 Tue, 22 Sep 2026 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790090059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P1/zrJQn/6AIWSYr3kRbP+HxWSiepPARvHWbsgP/1o=;
 b=qaliet7qGxVl2BinjK0omS1I4ikLbaZv2s955sky0DS2wZtAwj5ZIz+yzw00AXqaGHYSvf
 SCYTLAocoIm30n6Q3EFevn20vVudDtwMx456jOlA558zaJj4Kd/lR1DauDIEgpiy+8JHwM
 Q9PyVj7f0LaBs8DT9/HzKx4hzxaoL0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790090059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P1/zrJQn/6AIWSYr3kRbP+HxWSiepPARvHWbsgP/1o=;
 b=yqM0LJV/DEhzY/HP5KuvDHbsu+m2yy6LO63xNCaSBvfIF5Rbd1oLhcVnTixAy4WsSTp1O9
 zSGPDVF7zmp+cyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790090054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P1/zrJQn/6AIWSYr3kRbP+HxWSiepPARvHWbsgP/1o=;
 b=EbNy+wk1PXYJWbqFlsjmVGWizJhE1FIax354LyE8Nc0lIf/drRjpr9Aeyq/eclyxZSwV8G
 HHwIjPR8KvDqpOlx/IztWKOr5bmv9CTSZb8xFGq7PREZ2NfL5DVLDhjIWsqHUWYU3tifkl
 PcLgRN96Q0nGHun4ojgWB4HU/9AvHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790090054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P1/zrJQn/6AIWSYr3kRbP+HxWSiepPARvHWbsgP/1o=;
 b=W4GqHj9OuttfT2x4iyt5oPK9mZrb9eyrW5N7sNXP/+ac7YVqjDM6lpzkPRWsZWyoWRx/zj
 QOTC+TPacIhJS5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0562136D9;
 Tue, 22 Sep 2026 15:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dY33IkWbsmpEagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 15:14:13 +0000
Date: Tue, 22 Sep 2026 17:14:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260922151408.GC2205904@pevik>
References: <20260922095126.2169599-1-pvorel@suse.cz>
 <arKIz5Oygb57INup@yuki.lan> <arKKloQVzHXo4Vs_@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arKKloQVzHXo4Vs_@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] keyctl: Vendor struct keyctl_dh_params
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> >  #ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
> >  struct keyctl_dh_params {
> > -       int32_t priv;
> > +       union {
> > +               int32_t priv;
> > +               int32_t private;
> > +       };
> >         int32_t prime;
> >         int32_t base;
> >  };

> And of course we have to change the ->priv to ->private to get the
> tests compiled on older distributions as well.

Sure, working on it (+ removing libkeyutils dependency, which might be too much
before release).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
