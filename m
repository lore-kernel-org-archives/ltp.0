Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63F7C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 16:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C3CB3D0196
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 18:20:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A9503D0153
 for <ltp@lists.linux.it>; Thu, 23 May 2024 18:19:47 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBFF120A6D9
 for <ltp@lists.linux.it>; Thu, 23 May 2024 18:19:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2862022981;
 Thu, 23 May 2024 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716481186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vhpy/KaAPfIydBIgSZl2vophOkHJSRWLCXo0miXWP+I=;
 b=i1j5ecfk2Yx+49aEyg5TWOOrn5oEgjNkRc51flHovAOPzFVzv9UnAHsV3Zv5qrzFCJm/F2
 zBbJzjBBBYqqf88P+SVyLbkeptpWNvRIhkb7RhPJzKmcVckzzJDnA25k6T6oGO6aGqZNlj
 h/vAYdHXk0Va1OVZ0xrlfxRSPVT6OQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716481186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vhpy/KaAPfIydBIgSZl2vophOkHJSRWLCXo0miXWP+I=;
 b=zOiPpcIJNOLk0ILz3fdsParaHE0S70G4U5R0j0nlMyy+ITqh2OsHXWWpEwvaLdHjW1sx5Q
 Qw4kmfidREN22yCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716481186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vhpy/KaAPfIydBIgSZl2vophOkHJSRWLCXo0miXWP+I=;
 b=i1j5ecfk2Yx+49aEyg5TWOOrn5oEgjNkRc51flHovAOPzFVzv9UnAHsV3Zv5qrzFCJm/F2
 zBbJzjBBBYqqf88P+SVyLbkeptpWNvRIhkb7RhPJzKmcVckzzJDnA25k6T6oGO6aGqZNlj
 h/vAYdHXk0Va1OVZ0xrlfxRSPVT6OQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716481186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vhpy/KaAPfIydBIgSZl2vophOkHJSRWLCXo0miXWP+I=;
 b=zOiPpcIJNOLk0ILz3fdsParaHE0S70G4U5R0j0nlMyy+ITqh2OsHXWWpEwvaLdHjW1sx5Q
 Qw4kmfidREN22yCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA73313A6C;
 Thu, 23 May 2024 16:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BeKgNqFsT2ayZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 May 2024 16:19:45 +0000
Date: Thu, 23 May 2024 18:19:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240523161944.GA29885@pevik>
References: <20240523155932.26393-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523155932.26393-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/msgstress01: Fix off by one in array
 access
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

Hi Cyril,

> -		for (int i = 0; i < size; i++) {
> +		for (int i = 0; i < msg_recv.data.len; i++) {
>  			if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
>  				tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
>  					msg_recv.data.pbytes[i],

Reviewed-by: Petr Vorel <pvorel@suse.cz>

And FYI (old, unimportant warning): musl 32bit complains about off_t being long
long int. Not sure if we bother (after the release) to %lld + cast to (long long int).

../../../../../include/tst_safe_macros.h:284:50: warning: format '%ld' expects argument of type 'long int', but argument 11 has type 'off_t' {aka 'long long int'} [-Wformat=]
  284 |                 "mmap(%p, %zu, %s(%x), %d, %d, %ld)",
      |                                                ~~^
      |                                                  |
      |                                                  long int
      |                                                %lld
  285 |                 addr, length, prot_buf, prot, flags, fd, offset);
      |                                                          ~~~~~~
      |                                                          |
      |                                                          off_t {aka long long int}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
