Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0C5C36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 14:00:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54DEA3CB313
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 16:00:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0F83CB2D3
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:00:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FA67200DA5
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:00:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A92D2116C;
 Fri,  4 Apr 2025 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743775221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV4nUo87qey4XScGIEe6AJ7VDUYQsZIxkmhHgXCsAtg=;
 b=yIKz8IACbPlLUiKx5A6dpRqsPDyIcw93bSyNfcqFPKI0JH0soo0JAMscfrHEPb0vyDWGi+
 ytF1jXX/mG+UWiRqSOlayTMJxmYEIhuoTMueCqPHtOQV4CekiRgC8D4pE62m4zeiKP72Pd
 d0wpkT73edG2mFANqV4DuoyRndAlZrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743775221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV4nUo87qey4XScGIEe6AJ7VDUYQsZIxkmhHgXCsAtg=;
 b=vbqKpFgwWkqh09vBGPDMOo5yWZfOHXnfNF8eSGVGfxevnWsS5NEMM3grTntP7qd0kqnpqG
 74LBUFEKMqNortCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yIKz8IAC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vbqKpFgw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743775221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV4nUo87qey4XScGIEe6AJ7VDUYQsZIxkmhHgXCsAtg=;
 b=yIKz8IACbPlLUiKx5A6dpRqsPDyIcw93bSyNfcqFPKI0JH0soo0JAMscfrHEPb0vyDWGi+
 ytF1jXX/mG+UWiRqSOlayTMJxmYEIhuoTMueCqPHtOQV4CekiRgC8D4pE62m4zeiKP72Pd
 d0wpkT73edG2mFANqV4DuoyRndAlZrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743775221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV4nUo87qey4XScGIEe6AJ7VDUYQsZIxkmhHgXCsAtg=;
 b=vbqKpFgwWkqh09vBGPDMOo5yWZfOHXnfNF8eSGVGfxevnWsS5NEMM3grTntP7qd0kqnpqG
 74LBUFEKMqNortCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E37551364F;
 Fri,  4 Apr 2025 14:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QsdENvTl72drZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 04 Apr 2025 14:00:20 +0000
Date: Fri, 4 Apr 2025 16:00:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-_mD_6airOIpMNF@yuki.lan>
References: <20250403113053.20040-1-chrubis@suse.cz>
 <20250403123610.GA465253@pevik> <Z-6XSwc9Rbu2RIzm@yuki.lan>
 <Z-_K0zj30GOhxYS8@yuki.lan> <20250404125517.GA527835@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250404125517.GA527835@pevik>
X-Rspamd-Queue-Id: 0A92D2116C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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
> Interesting, I never noticed lib_pid :). It's assigned in tst_run_tcases() -
> library gets initialized there. As that's the very first call in main(), this
> really applies for helpers in testcases/lib/ which define TST_NO_DEFAULT_MAIN.
> 
> I suppose this is the part of the fix for core dumped helpers.

The tst_run_shell.c needs to fill in the tst_test structure first and
that is done before the test library was initialized. If we happen to
call tst_brk() in that phase we have to make sure that we do not touch
the results structure, which wasn't mapped yet and that we exit() with
right exit value. After these changes, once the test library has been
initialized all processes but the test library has to exit with success
and the final exit value is produce by the test library process.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
