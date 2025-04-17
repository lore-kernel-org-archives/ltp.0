Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C27C369B2
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 06:52:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C301B3CB9D8
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 08:52:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1904A3C0E7E
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:52:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07C37600D37
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:52:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73FA51F457;
 Thu, 17 Apr 2025 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744872728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGug7RyJvxJfljC3yO/uRw+MuSDWH9M4SmnCYuhT9YM=;
 b=CHj9H1edSTXk1g/rFJ+Ecv4ORRM13Wr5OXt+FU2K6FLbzmVKGF+7TQd3o/7QNOxOxiqp0m
 xgDb3WesLMaUIzVswhQwpKYqxiCfCmOLvZSf5gOcxpjYdz2W2RR6fC1lyOva11E69+LkQ4
 r/W8myraY5+OqmvJHlWgOPo+zyyiFuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744872728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGug7RyJvxJfljC3yO/uRw+MuSDWH9M4SmnCYuhT9YM=;
 b=xDQTRPXnevKXQ3RR7KFDK5yofrh18lAjmA2LGDhzPyLwCKEGM/BD/7htZUNam0qasJghds
 ChoxzMXAitN6/WDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CHj9H1ed;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xDQTRPXn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744872728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGug7RyJvxJfljC3yO/uRw+MuSDWH9M4SmnCYuhT9YM=;
 b=CHj9H1edSTXk1g/rFJ+Ecv4ORRM13Wr5OXt+FU2K6FLbzmVKGF+7TQd3o/7QNOxOxiqp0m
 xgDb3WesLMaUIzVswhQwpKYqxiCfCmOLvZSf5gOcxpjYdz2W2RR6fC1lyOva11E69+LkQ4
 r/W8myraY5+OqmvJHlWgOPo+zyyiFuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744872728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGug7RyJvxJfljC3yO/uRw+MuSDWH9M4SmnCYuhT9YM=;
 b=xDQTRPXnevKXQ3RR7KFDK5yofrh18lAjmA2LGDhzPyLwCKEGM/BD/7htZUNam0qasJghds
 ChoxzMXAitN6/WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46BAB1388F;
 Thu, 17 Apr 2025 06:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5WQVBRilAGgvRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Apr 2025 06:52:08 +0000
Date: Thu, 17 Apr 2025 08:52:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250417065206.GA638986@pevik>
References: <20250416072113.573818-1-pvorel@suse.cz>
 <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
 <20250416084057.GB577362@pevik> <12664748.O9o76ZdvQC@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12664748.O9o76ZdvQC@thinkpad>
X-Rspamd-Queue-Id: 73FA51F457
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

Hi Li, Avinesh,

> On Wednesday, April 16, 2025 10:40:57 AM CEST Petr Vorel wrote:
> > Hi Li,

> > > > +++ b/testcases/kernel/controllers/cgroup_lib.sh
> > > > @@ -119,12 +119,12 @@ cgroup_require()
> > > >         ret=$?

> > > >         if [ $ret -eq 32 ]; then
> > > > -               tst_brk TCONF "'tst_cgctl require' exited. Controller is
> > > > probably not available?"
> > > > +               tst_brk TCONF "'tst_cgctl require $ctrl' exited. $ctrl
> > > > controller not available?"


> > > s/exited/existed

> > I understood that "exited" which was used previously was meant to be "exited
> > with non-zero" (I can improve it this way to be more precise). Do you really
> > think it's in TCONF related to controller existed?  I actually mean the opposite
> > - one wants controller which does not exist due not configured in the kernel.

> I was also writing the same.
> I think we should just change it to 'failed' as you did below.

Merged, with this change. Thank you both for your review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
