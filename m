Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF71CAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 14:22:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630DE3CE151
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 16:22:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BD9C3C9BF2
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 16:22:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B23310007AC
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 16:22:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC7885534;
 Fri, 26 Sep 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 947F01373E;
 Fri, 26 Sep 2025 14:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LWhBIaWh1mi5agAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 14:22:29 +0000
Date: Fri, 26 Sep 2025 16:23:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aNahy5BN_nwd-yDB@yuki.lan>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <CAEemH2d_0eTYA+DtV5Dy16vTJ5s9a94mpKY6cp+Ofh2Ze1S68Q@mail.gmail.com>
 <20250926124122.GA163930@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250926124122.GA163930@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BC7885534
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi!
> > > It's about the time we start to prepare for the September release. As
> > > usuall I will go over the patches in the patchwork in the next week or
> > > two. If there is something that you think should be part of the release,
> > > please point it out so that I can have a look ASAP.
> 
> 
> 
> > LTP pre-release test looks good on our latest RHEL 9/10 series.
> > Just few minor errors that need the following two fix patches:
> 
> > https://patchwork.ozlabs.org/project/ltp/patch/20250922203927.14552-1-akumar@suse.de/
> > https://patchwork.ozlabs.org/project/ltp/patch/20250917075729.30093-1-liwang@redhat.com/
> 
> Thanks a lot for your testing. Both of these were fixed.
> 
> > Note:  Next week is our public holiday (7days), so I may not be able to
> > reply to emails in time.
> 
> Enjoy your free time :).
> 
> All: I guess that's all for the release.

I just merged to fixes from Martin and one from myself and there are a
few more fixes I'm going to check and possibly apply.

> I'd vote for applying LTP_QUIET patch:
> https://lore.kernel.org/ltp/20250922110611.duahjf4vqvwp4zs4@lida.tpb.lab.eng.brq.redhat.com/

That is stil in the queue as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
