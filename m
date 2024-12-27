Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB3AE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 08:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A587A3E4E21
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 09:05:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95DB3E11D3
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 09:05:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B056C62096E
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 09:05:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4754E33748;
 Fri, 27 Dec 2024 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735286734;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTkCYBW6NS3f8yOCP+7AZZdp0O4vMbgeBmyfW1tQtbY=;
 b=uCmKr3VOBMPDtz2T+tD8rRM7utF7yTjjMv6ZGVSyyGYm9bVwYMcvIYGeivHiE7mQ7jwKcp
 SOlL8LKzXjYbwwTS7ihz4LKWh9/gzK5KzzTxKkQFsBKCyJEF+h6UZVQkW7ebzZWA4uP5KJ
 16V9X82BtV5ciYsKcnU5pfljAoZKdsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735286734;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTkCYBW6NS3f8yOCP+7AZZdp0O4vMbgeBmyfW1tQtbY=;
 b=UHVworj+U7dXmzEf8POeWHKhvn/H2olsuxIczy1UiJam1T0Ta35BeSITwQqzAegnJN95AB
 tEc5Ev9oMpEyg8Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uCmKr3VO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UHVworj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735286734;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTkCYBW6NS3f8yOCP+7AZZdp0O4vMbgeBmyfW1tQtbY=;
 b=uCmKr3VOBMPDtz2T+tD8rRM7utF7yTjjMv6ZGVSyyGYm9bVwYMcvIYGeivHiE7mQ7jwKcp
 SOlL8LKzXjYbwwTS7ihz4LKWh9/gzK5KzzTxKkQFsBKCyJEF+h6UZVQkW7ebzZWA4uP5KJ
 16V9X82BtV5ciYsKcnU5pfljAoZKdsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735286734;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTkCYBW6NS3f8yOCP+7AZZdp0O4vMbgeBmyfW1tQtbY=;
 b=UHVworj+U7dXmzEf8POeWHKhvn/H2olsuxIczy1UiJam1T0Ta35BeSITwQqzAegnJN95AB
 tEc5Ev9oMpEyg8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9F513A30;
 Fri, 27 Dec 2024 08:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJd/LM1fbmfhMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 08:05:33 +0000
Date: Fri, 27 Dec 2024 09:05:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20241227080528.GA302443@pevik>
References: <20241227073921.GB290415@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241227073921.GB290415@pevik>
X-Rspamd-Queue-Id: 4754E33748
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux-test-project.readthedocs.io:url,docs.readthedocs.io:url,suse.cz:replyto,suse.cz:dkim,readthedocs.io:url];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Convert test catalog (docparse) from asciidoc to
 readthedocs.io (sphinx)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi

> I suggest to convert test catalog ("docparse") generated by docparse/testinfo.pl
> and asciidoc/asciidoctor to sphinx generator (readthedocs.io).
> asciidoc/asciidoctor was a good choice at the time, but now it looks to me
> better to use sphinx for everything.

> I volunteer to do the work, but I would like to have a general agreement before
> I do it.

> Pros:

> * We already have attempt to show tested syscalls [1]. Printing test catalog would
> have more info.
> * No need to install dependencies.
> * Automatic. If we add also doc for stable releases, it would replace the need

NOTE: stable release doc was already active. One can switch via floating box on
bottom right.

Kind regards,
Petr

> to install dependencies and upload file to LTP release on GitHub [2]. Then only
> link to page to test coverage on linux-test-project.readthedocs.io of particular
> release (or link to whole doc on particular release) would be added in release
> mail announcement (or we might keep adding generated pdf/epub/zipped html also
> to LTP releases [2]).
> * Unified look and feel.

> Work needed:

> * Convert docparse/testinfo.pl to doc/conf.py, obviously change from asciidoc
> to spinx.
> * Adding stable releases (not sure if it can be created automatically for all
> tags).
> * Adding offline formats [3] so that users can download the docs (that would be
> useful anyway).

> Kind regards,
> Petr

> [1] https://linux-test-project.readthedocs.io/en/latest/users/stats.html
> [2] https://github.com/linux-test-project/ltp/releases
> [3] https://docs.readthedocs.io/en/stable/downloadable-documentation.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
