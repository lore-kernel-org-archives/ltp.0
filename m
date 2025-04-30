Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E4FC369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 08:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31B2E3CBC63
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 10:51:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EB763C9D85
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:51:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B63A1A00CCB
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:51:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29D581F898;
 Wed, 30 Apr 2025 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746003086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZwfHw1CCVS4jH5a679yfECdhQMQT2tuNwaz9pTG2b8=;
 b=LJCQPdw7K7Fdi5WABhg+3a1TrJAeul5pBSonz/MSDmP5jWS7aRn1tmx/b72tqyh7fcD+V1
 KlhLGrcjDB/lNs/J11GTNQxFDZ8fvNRHu0Z3E/AocYwUx6DaRU458xzwqOOKxdBXr3eM/f
 oGM4659NaxIC8G+CfhP4Ci1cY43/GRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746003086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZwfHw1CCVS4jH5a679yfECdhQMQT2tuNwaz9pTG2b8=;
 b=POM8AhegV4L28+mwPSZ1x+5PENuEPuDSoUWSOyII+zrlsRc7B/NOx6A15eea51mykYQX3E
 J1jB85Lj+h6e6VDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LJCQPdw7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=POM8Aheg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746003086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZwfHw1CCVS4jH5a679yfECdhQMQT2tuNwaz9pTG2b8=;
 b=LJCQPdw7K7Fdi5WABhg+3a1TrJAeul5pBSonz/MSDmP5jWS7aRn1tmx/b72tqyh7fcD+V1
 KlhLGrcjDB/lNs/J11GTNQxFDZ8fvNRHu0Z3E/AocYwUx6DaRU458xzwqOOKxdBXr3eM/f
 oGM4659NaxIC8G+CfhP4Ci1cY43/GRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746003086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZwfHw1CCVS4jH5a679yfECdhQMQT2tuNwaz9pTG2b8=;
 b=POM8AhegV4L28+mwPSZ1x+5PENuEPuDSoUWSOyII+zrlsRc7B/NOx6A15eea51mykYQX3E
 J1jB85Lj+h6e6VDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E69413A25;
 Wed, 30 Apr 2025 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3n5zAo7kEWjYFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Apr 2025 08:51:26 +0000
Date: Wed, 30 Apr 2025 10:52:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aBHkswcLfiC7sXSz@yuki.lan>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-5-pvorel@suse.cz>
 <Z8shfrkfVkwsCOTw@yuki.lan> <20250425183345.GA79209@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250425183345.GA79209@pevik>
X-Rspamd-Queue-Id: 29D581F898
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test
 cleanup
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
> tst_exec.sh added in this v1 contains:
> 
> . tst_env.sh
> 
> . "$1"
> 
> if [ -n "$TST_CLEANUP" ]; then
> 	trap $TST_CLEANUP EXIT
> fi
> 
> if [ -n "$TST_SETUP" ]; then
>     $TST_SETUP
> fi
> 
> tst_test
> ---
> 
> The most important part is:
> 
> . "$1"
> 
> which is to source the script. This cannot be added into tst_loader.sh
> (it would create indefinite loop), this must be somehow added to tst_run_shell.c

So the problem seems to be that if shell parses the script before we
define aliases they are not expanded in the code shell already parsed.


This works:

alias tst_res="..."

tst_res TINFO "foo"


This does not:

tst_res TINFO "foo"

alias tst_res="..."

The tst_loader.sh has to be sourced first after all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
