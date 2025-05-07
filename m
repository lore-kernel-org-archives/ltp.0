Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8075FC3ABBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBA3C3CC00D
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 19:57:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 165F73CBC35
 for <ltp@lists.linux.it>; Wed,  7 May 2025 19:57:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 168DA60035A
 for <ltp@lists.linux.it>; Wed,  7 May 2025 19:57:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ED381F393;
 Wed,  7 May 2025 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746640634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ax7RChMe9BBof+HOdQJzfQqmEGT2Rw43/5ISXT65y0=;
 b=Cx5vi0ZyoIOkJybg4QcorIL6terWSvIClKnSQoWQfrEURK0DfiuMtYwd8Hrs0Ebfugo0lj
 pQHxNKm/tNh+cG1E3i3eCTIXTlQtNZoFXv9Ux6w559xbriLoI5j4cJuUAEbZ534+QukWZy
 Lh9Kg/czE/5B/AWKRcCyjA6SvfS3hG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746640634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ax7RChMe9BBof+HOdQJzfQqmEGT2Rw43/5ISXT65y0=;
 b=UwZjwUDQPuXSk0+w18XB89y167XYwWV3f23TESrkwVynVujGDg1GoGP75T4V0ubsHlsDGl
 5qwvLcRDMa8ABQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746640634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ax7RChMe9BBof+HOdQJzfQqmEGT2Rw43/5ISXT65y0=;
 b=Cx5vi0ZyoIOkJybg4QcorIL6terWSvIClKnSQoWQfrEURK0DfiuMtYwd8Hrs0Ebfugo0lj
 pQHxNKm/tNh+cG1E3i3eCTIXTlQtNZoFXv9Ux6w559xbriLoI5j4cJuUAEbZ534+QukWZy
 Lh9Kg/czE/5B/AWKRcCyjA6SvfS3hG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746640634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ax7RChMe9BBof+HOdQJzfQqmEGT2Rw43/5ISXT65y0=;
 b=UwZjwUDQPuXSk0+w18XB89y167XYwWV3f23TESrkwVynVujGDg1GoGP75T4V0ubsHlsDGl
 5qwvLcRDMa8ABQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A97E139D9;
 Wed,  7 May 2025 17:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aeOGOPmeG2jiEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 May 2025 17:57:13 +0000
Date: Wed, 7 May 2025 19:57:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250507175707.GC182617@pevik>
References: <aBSURzY2zu2HGI2x@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aBSURzY2zu2HGI2x@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> As usuall we are going to produce a release at the end of the May, let's
> start with pointing out patches that should be reviewed before we freeze
> the git. If there is anything I should have a look on please let me
> know.

It'd be nice also this macros doc related patchset merged:

https://patchwork.ozlabs.org/project/ltp/list/?series=439525&state=*

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
