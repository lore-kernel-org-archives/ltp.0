Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F1CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:26:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 875753E627B
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:26:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC1353CD6A4
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:25:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3B8B1400C7B
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:25:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24A8576102;
 Wed, 24 Jun 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782303948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5t3S2wzX/y9tW9izRbwaCkvGfokeQV3kS0RuRc5we9o=;
 b=tkmC+cofyrSjgZzeKT9h28GtwpQNe748ujie+CHPQsjSJmmw0/CJFv7uMabE6uTTRiuJKw
 +sAZSS19elpOEPAJV/zJtPznN/1jBya+lrQ1D8rANUzk7ubt9rQPCO5kxII6vh0ug8Cerv
 6ZkjCnq7aWAcQQtGSCM82ftRPNUX6kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782303948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5t3S2wzX/y9tW9izRbwaCkvGfokeQV3kS0RuRc5we9o=;
 b=Ozvye6HT3dCRFtrycYcwzYKKfDjDa89wXW02EfCihssy22IJUT50r6LKhCptzfg2wlgJVc
 gZ3zpTKezUEFOgCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="dpFHy/bB";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="la28sB/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782303947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5t3S2wzX/y9tW9izRbwaCkvGfokeQV3kS0RuRc5we9o=;
 b=dpFHy/bBhCy7uC30+USQtjfg4TqACs+6v0IHgRcWm82Q2oPfsxY+MqH92Ru6CyYq29eCTv
 pF/fY+PozXE8Cn1REq74wvk3Pmb5/6uq++jwc9rOvjRO9Uvoaj3SJWhjTTKuw6YUXnx6mK
 fwHdRG/GqsQOwNFBfOsys5c+/FcqFRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782303947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5t3S2wzX/y9tW9izRbwaCkvGfokeQV3kS0RuRc5we9o=;
 b=la28sB/2hHI+xU9idytfXqebkzwNOK7goenSkhLC0ZJGUTIYWHgFFyssO3BxREgI1TtGHb
 Tsr4q0jfDZJwvfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 105A5779A8;
 Wed, 24 Jun 2026 12:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HYNKAsvMO2oKSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 12:25:47 +0000
Date: Wed, 24 Jun 2026 14:25:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajvMxpufvaJe3M_w@yuki.lan>
References: <20260624091900.4107041-14-chrubis@suse.cz>
 <6a3bca17.95d0a0ea.2222d.1271@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3bca17.95d0a0ea.2222d.1271@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 24A8576102
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, yuki.lan:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/13] metadata: Add runtest file generator
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
> this is a bit controversial, because we would like to get rid of
> runtest files.

Eventually yes, but we will need this for the transition period. There
are a lot of systems out there using runtest files, including openQA. We
will have to keep the runtest files for a deprecation period, which will
last at least a year or two, before we can drop them. During that period
generating the runtest files is in my opinion the best option.

> Also, we should start thinking about moving tests variants inside the
> tst_test struct first, otherwise we will always generate runtest files
> which re not taking into account tests parameters.

One step at a time. There are quite a lot of test that does not have any
parameters. And quite a few that shouldn't have any parameters. I would
say that the -I parameter for CVE reproduces is a hack, because the test
is "broken" without any parameters, since the chances it triggers a bug
is really small.

There are test where the test variants needs to be encoded in the test
structure, these are mostly the I/O stress test where we encode
different offsets/sizes in the parameters. But that shouldn't stop us
from automating what can be automated already.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
