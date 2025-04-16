Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB399C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74D533CB95A
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:41:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB31C3CB56D
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:41:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 101501000963
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:41:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3D51F461;
 Wed, 16 Apr 2025 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744792861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0E0Z+vWx6OUOKS1JEQkwVrhP2882TSMKHj+H1oAUFC0=;
 b=naAyw6UZO8eGvQktu4e9KlKhd65DNKiScMSorNok+5ttmX31vzoPr9K9k/OqugKJBQkUMt
 WNSDzEqOvdiAARtjqNQ7i0xx5BFjGF5xQt1D4xSQA9n4QmFA8/SFF55UQLxgQApMOWkLK2
 68p2qL5ouv6y1OiLAmEC+0sjwop8lnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744792861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0E0Z+vWx6OUOKS1JEQkwVrhP2882TSMKHj+H1oAUFC0=;
 b=E//UdAONFZ9hjZ5XguxIzoVYS36HCp1jhJpBmpTewbhq0pUrU4CW4dwNe/z8E+q8WhulTQ
 trfX+D+pGiqvZMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744792861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0E0Z+vWx6OUOKS1JEQkwVrhP2882TSMKHj+H1oAUFC0=;
 b=naAyw6UZO8eGvQktu4e9KlKhd65DNKiScMSorNok+5ttmX31vzoPr9K9k/OqugKJBQkUMt
 WNSDzEqOvdiAARtjqNQ7i0xx5BFjGF5xQt1D4xSQA9n4QmFA8/SFF55UQLxgQApMOWkLK2
 68p2qL5ouv6y1OiLAmEC+0sjwop8lnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744792861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0E0Z+vWx6OUOKS1JEQkwVrhP2882TSMKHj+H1oAUFC0=;
 b=E//UdAONFZ9hjZ5XguxIzoVYS36HCp1jhJpBmpTewbhq0pUrU4CW4dwNe/z8E+q8WhulTQ
 trfX+D+pGiqvZMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E092139A1;
 Wed, 16 Apr 2025 08:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3TdKFB1t/2dYYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 08:41:01 +0000
Date: Wed, 16 Apr 2025 10:40:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250416084057.GB577362@pevik>
References: <20250416072113.573818-1-pvorel@suse.cz>
 <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] cgroup_lib.sh: Improve error messages
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

Hi Li,

> > +++ b/testcases/kernel/controllers/cgroup_lib.sh
> > @@ -119,12 +119,12 @@ cgroup_require()
> >         ret=$?

> >         if [ $ret -eq 32 ]; then
> > -               tst_brk TCONF "'tst_cgctl require' exited. Controller is
> > probably not available?"
> > +               tst_brk TCONF "'tst_cgctl require $ctrl' exited. $ctrl
> > controller not available?"


> s/exited/existed

I understood that "exited" which was used previously was meant to be "exited
with non-zero" (I can improve it this way to be more precise). Do you really
think it's in TCONF related to controller existed?  I actually mean the opposite
- one wants controller which does not exist due not configured in the kernel.

Kind regards,
Petr


> >                 return $ret
> >         fi

> >         if [ $ret -ne 0 ]; then
> > -               tst_brk TBROK "'tst_cgctl require' exited"
> > +               tst_brk TBROK "'tst_cgctl require $ctrl' failed. LTP
> > missing $ctrl controller support?"
> >                 return $ret
> >         fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
