Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE00D462A4
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B00A3D6731
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 15:04:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D270E3D671D
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:03:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 82DD66002FF
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:03:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01D761F443;
 Wed, 13 Nov 2024 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731506637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyNrpqScJFZaprWNXYeBU6HxRW1pCPBZ5VcnY+Q/voo=;
 b=r8WsOaTRpz0EASXDXSt2hZOmkb/1JcmdpnR09ZldVFs7gnAHk/ZqB9pPkMSlOF1NQu9LEj
 /9qoAPbAOcZmKY55BZdgPSgf77IU5HjZ8ajpBW+RIHz8kJWofgAw94nWwMVN4bRsd1EiM2
 HAaTDnMjo7hdlbHs4AlQJgoFc+1pzFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731506637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyNrpqScJFZaprWNXYeBU6HxRW1pCPBZ5VcnY+Q/voo=;
 b=iTZimgc1sS+LS7Ctys7iBbGf8ongWGgAo5QltKi7G25ZRM0QGkHnrCdlw7e8Cfsgb3cOhs
 0kA7mJxopCy7ITDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r8WsOaTR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iTZimgc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731506637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyNrpqScJFZaprWNXYeBU6HxRW1pCPBZ5VcnY+Q/voo=;
 b=r8WsOaTRpz0EASXDXSt2hZOmkb/1JcmdpnR09ZldVFs7gnAHk/ZqB9pPkMSlOF1NQu9LEj
 /9qoAPbAOcZmKY55BZdgPSgf77IU5HjZ8ajpBW+RIHz8kJWofgAw94nWwMVN4bRsd1EiM2
 HAaTDnMjo7hdlbHs4AlQJgoFc+1pzFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731506637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyNrpqScJFZaprWNXYeBU6HxRW1pCPBZ5VcnY+Q/voo=;
 b=iTZimgc1sS+LS7Ctys7iBbGf8ongWGgAo5QltKi7G25ZRM0QGkHnrCdlw7e8Cfsgb3cOhs
 0kA7mJxopCy7ITDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25B813A6E;
 Wed, 13 Nov 2024 14:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1T0DNsyxNGdOZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Nov 2024 14:03:56 +0000
Date: Wed, 13 Nov 2024 15:04:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZzSxqtWz-FxX8-NO@yuki.lan>
References: <20241113105925.295697-1-pvorel@suse.cz>
 <79ac6cc7-33f7-4b24-ab00-8b396025d901@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79ac6cc7-33f7-4b24-ab00-8b396025d901@suse.cz>
X-Rspamd-Queue-Id: 01D761F443
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] select03: Fix false positive on TCONF
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
Cc: Dominique Leuenberger <dleuenberger@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> As long as all errors are reported by the child through 
> tst_res()/tst_brk(), we don't need to care about the exit code since 
> it'll be recorded in the shared result buffer. I vote for removing the 
> WEXITSTATUS() check and adding a comment above the condition that it's 
> not needed.

I think that doing exit(TTYPE_RESULT(type)) in the tst_vbrk_() for the
child processes was a mistake that needs to be corrected either way. I
will send a patch for the test library to finally fix that and then
there will be no cases where the child exits with anything but 0.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
