Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE55C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:45:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF89D3C7BCC
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:45:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FC243C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:45:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A4DD142CBDB
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:45:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE7792117B;
 Fri, 17 Jan 2025 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737121513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84uE/lf375cQD61nmebNhXViOHHlzuzA84kSdqxYBIc=;
 b=RCa4K7DoYT0281WrOYKJqwSI381++cl10idbgizfHGEWN1mhG+G4+tiXFO8olNBLDeKhnM
 mFlVBbDr+NGCGeGtwO8+KdsoRy/ndaGqBDvLBetJ8YWQwGesSMCYCIRt9T6l/z7EMVRit5
 E/RwljAk05tCgdIL2LfQMK3jbwY8j0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737121513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84uE/lf375cQD61nmebNhXViOHHlzuzA84kSdqxYBIc=;
 b=0HQRlcnmQamgfhlpf5yKae20Ii+SsfLzmmwYlQXS2a4Gf4B361hs07wJYRdSLitg9riXoU
 F8Z50YOeUM5WTtBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737121513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84uE/lf375cQD61nmebNhXViOHHlzuzA84kSdqxYBIc=;
 b=RCa4K7DoYT0281WrOYKJqwSI381++cl10idbgizfHGEWN1mhG+G4+tiXFO8olNBLDeKhnM
 mFlVBbDr+NGCGeGtwO8+KdsoRy/ndaGqBDvLBetJ8YWQwGesSMCYCIRt9T6l/z7EMVRit5
 E/RwljAk05tCgdIL2LfQMK3jbwY8j0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737121513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84uE/lf375cQD61nmebNhXViOHHlzuzA84kSdqxYBIc=;
 b=0HQRlcnmQamgfhlpf5yKae20Ii+SsfLzmmwYlQXS2a4Gf4B361hs07wJYRdSLitg9riXoU
 F8Z50YOeUM5WTtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C3BA139CB;
 Fri, 17 Jan 2025 13:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /XDHJeleimf6MQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 13:45:13 +0000
Date: Fri, 17 Jan 2025 14:45:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4pe3estBHBQ0RTm@yuki.lan>
References: <20250117122455.7989-1-chrubis@suse.cz>
 <20250117122455.7989-2-chrubis@suse.cz> <Z4pOAZJATd73M02O@yuki.lan>
 <20250117132753.GA766927@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117132753.GA766927@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] testcases/lib: tst_net.sh: Do not use stderr
 in tst_rhost_run()
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
> I'm not sure about this. Maybe it's safe, because stderr gets to the output.
> But in case some network test need to verify something which is defined on
> stderr it will fails (when tst_rhost_run is run with -s).

That's why I send the first patch that I know is 100% safe.

> FYI *without* this patch:
> 
> 	# route-redirect.sh
> 	...
> 	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
> 	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': 'sh: 1: ns-icmp_redirector: not found'
> 	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': 'ns-icmp_redirector: no process found'
> 	ns-icmp_redirector: no process found
> 
> and *with* this patch:
> 
> 	# route-redirect.sh
> 	...
> 	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
> 	sh: 1: ns-icmp_redirector: not found
> 	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': ''
> 	ns-icmp_redirector: no process found
> 	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': ''
> 
> Info is there, but not on the same line (second '').
> 
> Also with the change below it would be more meaningful (fixing first empty ''):
> 
> route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on NETNS: 'sh: 1: ns-icmp_redirector: not found'
> route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on NETNS: 'ns-icmp_redirector: no process found'
> ns-icmp_redirector: no process found
> 
> I also wrote conditional quiet on stderr (not sent to ML), but actually if we
> merge this and need sometimes to parse stderr, the opposite would be needed.

I supose that we would need to explicitly tell the tst_rhost_run() if we
want stderr included or not. That's probably something to be done after
the release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
