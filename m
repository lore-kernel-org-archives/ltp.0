Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B816D3B985
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 11:23:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADC113DB0E9
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 12:23:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 834473DB0B3
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 12:23:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5CE122394A8
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 12:23:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF9171F747;
 Tue, 26 Nov 2024 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732620199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I61GP+vg/qDnVyUtkkY4y0PH/HgKPLvYMv6LJI+kaMQ=;
 b=ssCwyJNRjPgxjBjL37iwN30w02kIBdvryhE7Ht7QsMl5ED7Xf8o8d8n7T57nTeEPLap0s8
 It+wYHEW2hwPc2TJfPZnKgY991U71hEWOZgvt0fcGg5urVBjDk2R24GlPHmA4MN7zzcOll
 nqZNrFZoIaTMMqPsC6YuYx6KF7A+9S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732620199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I61GP+vg/qDnVyUtkkY4y0PH/HgKPLvYMv6LJI+kaMQ=;
 b=Tsk92KANzRms2500cXM3mE7s0mjbcm+C2QAswMI1k6+RIlCggVEHmfkVhdWBhfQ7xak/Xu
 2AAVdmdsC2m276AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="s8p47s/9";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8ZQ05a91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732620198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I61GP+vg/qDnVyUtkkY4y0PH/HgKPLvYMv6LJI+kaMQ=;
 b=s8p47s/9GuMhJHcT48zhH/Es04YG45TfSLwfGf90497ozgvwlO+Dnzt2HAWypldNEBSw/p
 HU9XjHcsCBG+E9JipI2uphNVWaJycg/uekWs1z5Fc8LosAkzJbWtGo+4BtEK9uNrk4Zjpz
 AqOGMDzOiiE0ysnBCs7sjWO+4Ox6OzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732620198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I61GP+vg/qDnVyUtkkY4y0PH/HgKPLvYMv6LJI+kaMQ=;
 b=8ZQ05a91wQ8ow6Jp3gmA7c8ie7xhwW9m5v7r36J1yI7K/KoKAfsTfY+QFx/TIIxi33alPe
 I/qhbQYm2NYUciDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D65B313890;
 Tue, 26 Nov 2024 11:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ws/yMqavRWfqOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Nov 2024 11:23:18 +0000
Date: Tue, 26 Nov 2024 12:23:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z0Wvsq571rTt46Ie@yuki.lan>
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
 <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
X-Rspamd-Queue-Id: EF9171F747
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Well, we have not achieved a reliable way to detect debug kernels in LTP.
> While I looking at our RHEL9 kernel config file. The general kernel also
> enables things like "CONFIG_DEBUG_KERNEL=y".

The slowdown is likely to be realated to a few specific debug options
such as debugging for mutexes, spinlocks, lists, etc. I guess that the
most interesting information would be a difference in the debug options
between the general kernel and the debug kernel. Hopefully we can put
together a set of debug options that are cause the test to run over
slow.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
