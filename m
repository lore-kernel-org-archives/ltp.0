Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A365C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 09:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28B4A3CC7C9
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:55:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659363CC7A7
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:55:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8C19601937
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:55:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 153B8208FF;
 Wed, 21 May 2025 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747821329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJKNHmK95b4d8Z280hfHk0aR01Ril0rM4wb65l3xQQg=;
 b=qQQ8cBO85UGwDjriCPsi/dsjiP18su8SVrq+nGBLmdEDe9yJjy31I2XmUp85StVgqdOj+o
 I6VfwnUbMfcNIUtFA8T+qNaViAudSLgaGqO95r2136AXAXGWTBzEZhs2/gDbwg+3mq/y9S
 FbNMiku1kjhHT44Pw+incAkpBxOFi4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747821329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJKNHmK95b4d8Z280hfHk0aR01Ril0rM4wb65l3xQQg=;
 b=lv2vfqc5ZZivMT5mN8JS2IlPglfbVBkqvAM4B6StenYyBkEFh4A3yQbUy7eQGgGj7xBRAK
 ZUVaQfnwBQeFYACQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qQQ8cBO8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lv2vfqc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747821329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJKNHmK95b4d8Z280hfHk0aR01Ril0rM4wb65l3xQQg=;
 b=qQQ8cBO85UGwDjriCPsi/dsjiP18su8SVrq+nGBLmdEDe9yJjy31I2XmUp85StVgqdOj+o
 I6VfwnUbMfcNIUtFA8T+qNaViAudSLgaGqO95r2136AXAXGWTBzEZhs2/gDbwg+3mq/y9S
 FbNMiku1kjhHT44Pw+incAkpBxOFi4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747821329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJKNHmK95b4d8Z280hfHk0aR01Ril0rM4wb65l3xQQg=;
 b=lv2vfqc5ZZivMT5mN8JS2IlPglfbVBkqvAM4B6StenYyBkEFh4A3yQbUy7eQGgGj7xBRAK
 ZUVaQfnwBQeFYACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0542813888;
 Wed, 21 May 2025 09:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4qH3ABGjLWgYRwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 May 2025 09:55:29 +0000
Date: Wed, 21 May 2025 11:55:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aC2jBIAHCHGpDM-f@rei>
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-2-japo@linux.ibm.com> <aC2e24S2FzFRM5-N@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aC2e24S2FzFRM5-N@rei>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 153B8208FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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
> > diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> > index 6946cc5bcb94..1270b17af8f4 100644
> > --- a/lib/safe_macros.c
> > +++ b/lib/safe_macros.c
> > @@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
> >  	 */
> >  	if (possibly_fuse(filesystemtype)) {
> >  		char buf[1024];
> > +		const char* mount_fmt;
> > 
> >  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> > -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> > -			filesystemtype, source, target);
> > +		if (!strcmp(filesystemtype, "ntfs") && mountflags & MS_RDONLY)
> 
> Do we need to limit this to "ntfs"? I suppose that for other FUSE
> filesystems would have the same problem, e.g. exfat.
> 
> Other than this the patch looks good.

Also if my patch that fixes the fuse blacklist gets applied we need to
remove the fuse from the blacklist from statmount02 to get the test
enabled after this fix.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
