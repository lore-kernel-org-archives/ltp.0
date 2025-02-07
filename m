Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B168BC0219B
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 17:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 314E33C93E4
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 18:15:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 082A23C9385
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:15:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 735326022B9
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:15:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 549191F385;
 Fri,  7 Feb 2025 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738948528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOrR9ICQo2MApu8fYbFZ20RlaNJSvYnj8u7jztMTyv0=;
 b=KKVTF2Mhi2QubvWFiQjTkrdQci0gYyWpPm9a+EgUIaERp/rH6XBBS3NZhq+Dm1Qdns7aPm
 RHxdzQH0dmjPoR+3Idv933n7H/dyQEYSVzC178+unSG4eWCazq/cjMFRFfXyJS39m+pcBG
 dpGxLyPsIyZazL2QA1EIxGEIkxRMcdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738948528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOrR9ICQo2MApu8fYbFZ20RlaNJSvYnj8u7jztMTyv0=;
 b=0G6hetqB3x/ma7J9jXZMlxV4ObXm03olR+sQrsfd9u2j1x/SaMyto09m3pM6AC/9rtRAvs
 6COfLC28UlhdVhDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2Q1V0hT5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QddhR7Um
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738948527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOrR9ICQo2MApu8fYbFZ20RlaNJSvYnj8u7jztMTyv0=;
 b=2Q1V0hT5QlvlrdW19+SQDB/Z6bhlnELTYDW97kmrpzJKTsJZAd5KifRzCPSeUzjFmi5Rbo
 5/QWUVgqMefNabhhxmqOhmdawu8pRJJU6Y1Sho+6LV6aZHqyU31s7C8J2D1eCYJxKNU/fb
 ZcO7t8QPxSlwgi4jJ/xL7BXRVTZtpHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738948527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOrR9ICQo2MApu8fYbFZ20RlaNJSvYnj8u7jztMTyv0=;
 b=QddhR7UmW7tdTcjief13ZkQyZc/Gn0tWMB56/d1TyMGkfm+Ofn2sjtnqNIY77E9NRjVasz
 Rpz1K/DoHbA50SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37F0F13694;
 Fri,  7 Feb 2025 17:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GjH2C68/pmeebAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 17:15:27 +0000
Date: Fri, 7 Feb 2025 18:15:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250207171510.GA1767469@pevik>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250207113726.GB1739723@pevik>
 <x498qqhel7f.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x498qqhel7f.fsf@segfault.usersys.redhat.com>
X-Rspamd-Queue-Id: 549191F385
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] tst_device: add support for overlayfs
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

Hi Jeff,

> Petr Vorel <pvorel@suse.cz> writes:

> > @Jeff: would it be too hard to parse /proc/self/mountinfo (I suppose
> > /proc/self/mounts is not enough)? I'm looking into libmount code E.e.

> Looking more closely, I think /proc/self/mounts will work just fine.  I
> was pointed to mountinfo originally and didn't consider mounts.  Thanks
> for the suggestion, that will make this much easier!

Great, thank you! Not dragging libmount as a hard dependency for base library
helps us a lot.

Kind regards,
Petr

> Cheers,
> Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
