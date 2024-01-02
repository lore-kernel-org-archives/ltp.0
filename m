Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E545EC46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 21:07:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7848C3CC7D0
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 22:07:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F173C9F00
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:07:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EDB1631D6D
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:07:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45B9121F12;
 Tue,  2 Jan 2024 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704229654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDVdJJvpoIbbajrXuQkJrj/PrimT11huPEDzZBcxJ+c=;
 b=Hwz9VcjjPBY3bRBTqNKm3HOD/rR5NH0jqMCkLDYx0iAolx+NHCzsIOtRJy/PWSSBqeskuM
 VhfZUKmlunPHUSsvrlidZ6/utGibILRjKDKCwUJpsHP3T37K51uGn4xER8Wukepa9ccHSV
 BuU9FCMCGDSl0Oi7R5rsl2hH5XYrfl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704229654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDVdJJvpoIbbajrXuQkJrj/PrimT11huPEDzZBcxJ+c=;
 b=+2IG8IDNRyzpIp3FijWJClyyH0j7pgh1BuT5W/A6AUyyTiPubxbnJF1AM2rCtc9QNez9Fm
 mV9/HhbZ+/mgBACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704229654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDVdJJvpoIbbajrXuQkJrj/PrimT11huPEDzZBcxJ+c=;
 b=Hwz9VcjjPBY3bRBTqNKm3HOD/rR5NH0jqMCkLDYx0iAolx+NHCzsIOtRJy/PWSSBqeskuM
 VhfZUKmlunPHUSsvrlidZ6/utGibILRjKDKCwUJpsHP3T37K51uGn4xER8Wukepa9ccHSV
 BuU9FCMCGDSl0Oi7R5rsl2hH5XYrfl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704229654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDVdJJvpoIbbajrXuQkJrj/PrimT11huPEDzZBcxJ+c=;
 b=+2IG8IDNRyzpIp3FijWJClyyH0j7pgh1BuT5W/A6AUyyTiPubxbnJF1AM2rCtc9QNez9Fm
 mV9/HhbZ+/mgBACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AE841340C;
 Tue,  2 Jan 2024 21:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BPnDBBZ7lGUSRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Jan 2024 21:07:34 +0000
Date: Tue, 2 Jan 2024 22:07:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240102210732.GB942817@pevik>
References: <ZZQHPkwg-W2R1ejJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZQHPkwg-W2R1ejJ@yuki>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hwz9Vcjj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+2IG8IDN
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.73 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[51.85%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 45B9121F12
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Kirk update [was Re:  LTP Release preparations]
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Andrea,

...
> If you have any patches that should be reviewed before the release,
> please let me know.

We use kirk c47d3d9311b1b429f385e8d2b35da96dd4330df5 (which is newer than the
only kirk release v1.1).

Andrea, how about release new kirk version and update it in LTP?
It could be either current HEAD (bcb2df815d3fdbca470c1ff6ab14ac9cb2f9e3b7) or
some older commit (there are several fixes).

We should update kirk in LTP before git freeze, to avoid last minute errors.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
