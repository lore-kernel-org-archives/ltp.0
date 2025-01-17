Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5459FC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 15:01:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E563C7BCB
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 16:01:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B45723C4CED
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 16:01:29 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6E5C62EF73
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 16:01:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98DFC1F38C;
 Fri, 17 Jan 2025 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737126086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++6fXuqutzNnad3s4iLukz5UNXm7adFE0v2poefzB/A=;
 b=t+6JpQinfH3K2NM+GEdgi1lI/u6h7Lk0J8dsIc6dNs31zaTfUPpUtnQcsYw5LoY65xPb/r
 1rvomSajv7NSayAKYs51UfIN3ymM5/+k2K3ywEXtbjSseaNhjxkD+W5jun1n+SmyabJPHp
 8eImrERJxNSY9ZGTwjkI7zdMHHegiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737126086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++6fXuqutzNnad3s4iLukz5UNXm7adFE0v2poefzB/A=;
 b=KxW+TGwDIpaJIaL3l282cqIrW7xT9Jhpinm1fC3L4Bt5EmhufT6Eoumu+ZxZNjVEtq2RwT
 AqK0XFOxLmwfuDCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t+6JpQin;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KxW+TGwD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737126086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++6fXuqutzNnad3s4iLukz5UNXm7adFE0v2poefzB/A=;
 b=t+6JpQinfH3K2NM+GEdgi1lI/u6h7Lk0J8dsIc6dNs31zaTfUPpUtnQcsYw5LoY65xPb/r
 1rvomSajv7NSayAKYs51UfIN3ymM5/+k2K3ywEXtbjSseaNhjxkD+W5jun1n+SmyabJPHp
 8eImrERJxNSY9ZGTwjkI7zdMHHegiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737126086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++6fXuqutzNnad3s4iLukz5UNXm7adFE0v2poefzB/A=;
 b=KxW+TGwDIpaJIaL3l282cqIrW7xT9Jhpinm1fC3L4Bt5EmhufT6Eoumu+ZxZNjVEtq2RwT
 AqK0XFOxLmwfuDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5977513332;
 Fri, 17 Jan 2025 15:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hnbpDMZwimdnTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 15:01:26 +0000
Date: Fri, 17 Jan 2025 16:01:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Z4pwtePCSqhe0hfF@yuki.lan>
References: <Z3vJ6zXDVPACBIGd@yuki.lan> <Z4pj78casC9Ioyga@yuki.lan>
 <eeb77003-5e8f-4c33-8357-9400bef071b0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eeb77003-5e8f-4c33-8357-9400bef071b0@suse.cz>
X-Rspamd-Queue-Id: 98DFC1F38C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
> > Can we freeze git today? There are some fixes that are still
> > work-in-progress but these can go in after the freeze.
> > 
> > If there are any patches that add new functionality and should be
> > reviewed before the release please let me know now.
> 
> Hi,
> I've just sent a trivial fix for cgroup_core02 SIGBUS errors on older 
> arm64 kernels. It'd be nice to include it in the release.
> 
> https://patchwork.ozlabs.org/project/ltp/patch/20250117144855.50127-1-mdoucha@suse.cz/

I will have a look, however fixes like this can go in even after the
freeze.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
