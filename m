Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71AFC3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:43:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EEC63D1ADE
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:43:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557EB3D0C9E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:42:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53CDC2001D1
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:42:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1BC91FD05;
 Wed, 17 Jul 2024 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721238164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SVowOqtw1c6nfq1vOgzcn/I5f66rkZ71nwx1Viu/KZ0=;
 b=1a72YFWSxBu4d4Fd7li9XwNV1BUTJ1VXn5YPRWwRM//I0v2f+i7vPJVzLOlWM4Ft8rSwTx
 QPcvYlhGoSChV32XXOaKbYOUdC3Suu66nI5Zk6XPMzJUw/RQ4rrqIDh77jKQsnkEb6+dLW
 mzowylzodVZfdOce2B/zggueT/V05u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721238164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SVowOqtw1c6nfq1vOgzcn/I5f66rkZ71nwx1Viu/KZ0=;
 b=hJe5U9q3+0qd7cO0QQkevoT1aEOAjGJ0vF8eYZzEQePLVWOpEI3ecCohKXJySoayjBCqgS
 SSlhA4Yv/IDGyOCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zST0YDMf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qp5UvRBN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721238163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SVowOqtw1c6nfq1vOgzcn/I5f66rkZ71nwx1Viu/KZ0=;
 b=zST0YDMfY4ZNYGbSL0WpP4cC7ICKkPI93RVFBmAyWIcGNBjS3+IuOdwhe2wDD1xI5nP/uO
 nenyCjn9IY6OcPPAJS11mBg8twR3Yjpwpe5tnNi9cqK/gtbNETTgcg2mGFunjQ35zjF0+3
 l5QuWKpnfANUBDkF9te5+/LFPdnpLEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721238163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SVowOqtw1c6nfq1vOgzcn/I5f66rkZ71nwx1Viu/KZ0=;
 b=Qp5UvRBNoBVNREA4sFz8SYA7WOeambmR8TuKulQL+nMgMsEnKZ4KEErHSnqUzp6slpAS0f
 lTDiwbdHi8WFjYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD61A136E5;
 Wed, 17 Jul 2024 17:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pP2sMJMCmGbsPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:42:43 +0000
Date: Wed, 17 Jul 2024 19:42:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Jan Stancek <jstancek@redhat.com>
Message-ID: <20240717174242.GA687454@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F1BC91FD05
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Realtime testsuite
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

we have ticket about realtime testsuite evaluation [1].
I put there some old investigation made by Mel Gorman.
At the time we wanted to migrate everything to rt-tests.

Cyril considered sched_football useful enough also for regular non-RT systems,
thus I ported it to new library in 43dc52fafa ("sched_football: Rewrite into new
API"). And there is a followup patchset [3] [4] which among other things always
enables realtime and put sched_football also to runtest/sched.

But we should decide what to do with the rest. Would you have time to have look
if something else is good enough to be kept in LTP?

I suggest to contribute pi_perf and prio-wake to rt-tests and ask also
linux-rt-users community to have look on the tests (specially
realtime/stress/pi-tests and testcases/realtime/perf/latency which Mel did not
reviewed) and act based on their investigation (port or remove).

BTW Mel reported about sched_football:

	Interesting, might be worth reimplementing. The
	concept is interesting as a test but it has
	weaknesses. The sched_yield usage is one thing
	but also, it only works if the number of players
	equals the number of CPUs and small changes in
	sched_yield semantics would break the test.

IMHO we should remove -n option, so that ncpu is always used. I also wonder,
what breaks -i2.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/1078
[2] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
[3] https://patchwork.ozlabs.org/project/ltp/list/?series=415662&state=*
[4] https://lore.kernel.org/ltp/20240717171713.687339-1-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
