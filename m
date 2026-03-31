Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE79FF60D8
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 07:21:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEF233E2A40
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 09:21:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E69B3E21CD
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 09:20:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E6291000D99
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 09:20:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED8B65BEA1;
 Tue, 31 Mar 2026 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774941654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gGEdRBO3SVcmkNz9DtwnW+R30Fa+lT1cXws7BrLijNs=;
 b=ikrE/YR3jIv/7GGh/hI89xhHfoyUHpqvPCHgMHhtavOva+Y77HAAQ7vuEnc9w+NOlRHuQO
 X+xx5HKwL9SNPpwo6Dk92/nva5ndSGVvhy3fM0gvene9RR00zlLGIn167nmIPCKpE4uXbj
 l5oFxgC8pwvNj9WRZ4WUbBoilYbqSx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774941654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gGEdRBO3SVcmkNz9DtwnW+R30Fa+lT1cXws7BrLijNs=;
 b=3AcJLf37ismgbRPJzkTy3iEillSIg60UBu8OhDqN5xDbJU6J7kmozJvyHg0ogiOYfEQdKl
 BMLl+dn00n7LJ8BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1qHJ3T8N;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KU/+oPzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774941653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gGEdRBO3SVcmkNz9DtwnW+R30Fa+lT1cXws7BrLijNs=;
 b=1qHJ3T8NOAv6Tpy6BKCANFpzUXoVblOs6eRovRUpSN8wSlhWNyVmjPa4ZdhiZMNUvxKOdl
 uQZqtkcnWr3PCxkFHwGE3jKa1/iOfNn9IjbuuOihyW3QZigevdBt493Er71FLqAU1T+Akn
 Py6W7575LG6wt93zW80u381Ku5/NhEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774941653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gGEdRBO3SVcmkNz9DtwnW+R30Fa+lT1cXws7BrLijNs=;
 b=KU/+oPzJSoGxJePC4EvWUI633YDGkMJ7U0YFNK+nxEcyWb1L3LyNr8qFD07nKV0Erd1fjI
 +42UTn9l+xAA68Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD0744A0A2;
 Tue, 31 Mar 2026 07:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFsXLdV1y2nCUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Mar 2026 07:20:53 +0000
Date: Tue, 31 Mar 2026 09:20:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>
Message-ID: <20260331072051.GA5254@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[5]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: ED8B65BEA1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] linux-git: using whole sha1 hash
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

Hi all,

anything against starting to use whole sha1 hash in linux-git tag? i.e. 40 chars.
It can be shorten by the doc/conf.py script (use whole hash for URL, but shorten
the visible part of <a> tag).

We normally use only 12 chars 091d0d55b286, but some users during rewrite used
[1] really small hash (7 chars) from original test.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260331015538.53326-1-lufei@uniontech.com/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
