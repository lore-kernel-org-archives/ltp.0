Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310B3C44508
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 23:07:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C513CA790
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 00:07:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61B193C1E06
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 00:06:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 632A610007B9
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 00:06:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 846F9336BE;
 Wed, 21 Jan 2026 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769036805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtgsKvkfwVnw+TibSG4na1zlG8QpvbuhC98QhGZuO8Y=;
 b=tZOEZ8z8mLXF0awTc3LWQr/lu5vW/ZwdAtPFZMuVlN0fwLi6jjoXdHpS6y5oXNSvYoFrJR
 HP7Uv2+jTA68iWt0kELCZsvQ1Jfj/boxHXKEQJZXXkyYgy4j32Fi2R3tOgy2dKRzwQTbm/
 dl4SdUMkDHlXKd99L9WJK2CHdbhZEt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769036805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtgsKvkfwVnw+TibSG4na1zlG8QpvbuhC98QhGZuO8Y=;
 b=vaksbgC2okSizCqb31P6TZGkFCf/bE5LNPeDaU1TGDUzKcmV7WCquTdM5pJBEgUZEIetwj
 NgN+rnE3TkodDQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769036805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtgsKvkfwVnw+TibSG4na1zlG8QpvbuhC98QhGZuO8Y=;
 b=tZOEZ8z8mLXF0awTc3LWQr/lu5vW/ZwdAtPFZMuVlN0fwLi6jjoXdHpS6y5oXNSvYoFrJR
 HP7Uv2+jTA68iWt0kELCZsvQ1Jfj/boxHXKEQJZXXkyYgy4j32Fi2R3tOgy2dKRzwQTbm/
 dl4SdUMkDHlXKd99L9WJK2CHdbhZEt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769036805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtgsKvkfwVnw+TibSG4na1zlG8QpvbuhC98QhGZuO8Y=;
 b=vaksbgC2okSizCqb31P6TZGkFCf/bE5LNPeDaU1TGDUzKcmV7WCquTdM5pJBEgUZEIetwj
 NgN+rnE3TkodDQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F1CF3EA63;
 Wed, 21 Jan 2026 23:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9HUTCAVccWk9XQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jan 2026 23:06:45 +0000
Date: Thu, 22 Jan 2026 00:06:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260121230639.GA10001@pevik>
References: <20260120144626.231614-2-piotr.kubaj@intel.com>
 <20260120193851.GB65442@pevik>
 <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> > I tried to run test under root:

> > # ./thermal_interrupt_events
> > tst_test.c:1856: TINFO: Overall timeout per run is 0h 03m 30s
> > thermal_interrupt_events.c:168: TBROK: Failed to close FILE
> > '/sys/class/thermal/thermal_zone1/trip_point_1_temp': EINVAL (22)

> > But later it worked:
> > tst_test.c:2028: TINFO: LTP version: 20250930-134-g02805b05a1
> > tst_test.c:2031: TINFO: Tested kernel: 6.17.12+deb14-amd64 #1 SMP
> > PREEMPT_DYNAMIC Debian 6.17.12-1 (2025-12-14) x86_64
> > tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-
> > 6.17.12+deb14-amd64'
> > tst_test.c:1856: TINFO: Overall timeout per run is 0h 03m 30s
> > thermal_interrupt_events.c:181: TPASS: x86 package thermal interrupt
> > triggered

> > I wonder what was wrong.
> Can you check if the test fails again the 1st time after a reboot? If
> I'm correct, it might be a reproduction of the bug due to be fixed in
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/patch/?id=39b1bd1613b8f73994f654988ad75a72b633f5e2

Yes, it's really affected only 1st run after reboot. Thanks for pointing out
the fix.

In that case once fix is merged to Linus' tree (so that the git commit hash will
not change) we should add it to the test [1]:

struct tst_test test = {
	...
	.tags = (const struct tst_tag[]) {
			{"linux-git", "39b1bd1613b8f"},
			{}

This info will be printed on the test failure. And also the fix will be in our
doc [2].

(The fix is not yet in the next tree, because thermal-fixes branch is not
configured for linux-next git, although other linux-pm git branches are
configured [3]).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#140-test-tags
[2] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees?h=next-20260121

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
