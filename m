Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83BBCD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:36:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D96F93CF086
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:36:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A0363C5E6E
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:36:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 140B460087F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:36:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04C8D75DD2;
 Thu, 11 Jun 2026 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781188587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wQ/hxp03biTcrWwJFVXQjOube2Pvh72j1YjmqaQn2M=;
 b=NFM087Kq63sK8GdfwoUNIqI8KZY73GGC/9xROkrDUlr42LBckF+slRZB00aEfJy1MryHCf
 csl/iL8sUCkqRAfXVRO2nlOQ8ewuoJpIkhuj8HNabbkSOCqwoXGu5YAXzbKs5sql1xlw3C
 v5gdYy3yMNqBn6zSQqpM450SVSU8v+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781188587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wQ/hxp03biTcrWwJFVXQjOube2Pvh72j1YjmqaQn2M=;
 b=RBraBeBjL8gf0R0Geghhj3PXeiE/hiYlcv+QKJnH+fUS3+bADdTLovBzz6caphrbKkyFHi
 Eog3IfTfjIngLNDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781188587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wQ/hxp03biTcrWwJFVXQjOube2Pvh72j1YjmqaQn2M=;
 b=NFM087Kq63sK8GdfwoUNIqI8KZY73GGC/9xROkrDUlr42LBckF+slRZB00aEfJy1MryHCf
 csl/iL8sUCkqRAfXVRO2nlOQ8ewuoJpIkhuj8HNabbkSOCqwoXGu5YAXzbKs5sql1xlw3C
 v5gdYy3yMNqBn6zSQqpM450SVSU8v+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781188587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wQ/hxp03biTcrWwJFVXQjOube2Pvh72j1YjmqaQn2M=;
 b=RBraBeBjL8gf0R0Geghhj3PXeiE/hiYlcv+QKJnH+fUS3+bADdTLovBzz6caphrbKkyFHi
 Eog3IfTfjIngLNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58B8779A7;
 Thu, 11 Jun 2026 14:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2sjANurHKmpwVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jun 2026 14:36:26 +0000
Date: Thu, 11 Jun 2026 16:36:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <airH4bO0NGqpGXMc@yuki.lan>
References: <20260610133048.115931-2-piotr.kubaj@intel.com>
 <airDiOvy7Ojw9hRF@yuki.lan>
 <afc5209a57b7b3db804275d41f2121e6cd6e20dc.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afc5209a57b7b3db804275d41f2121e6cd6e20dc.camel@intel.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16] high_freq_hwp_cap_cppc.c: new test for
 testing acpi_cppc/highest_perf
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Oh, I was under impression that the whole test should be ifdefed. After
> all, there's just no possibility it will ever run on another
> architecture.

If we do that the tst_test structure with the real metadata will be
hidden inside these ifdefs as well (along with the supported
architectures field) so the better way to do this is to ifdef only what
needs to be ifdefed. We could as well ifdef out all the
setup/cleanup/run functions and define dummy functions for non-x86
targets however in this case it was easier just to ifdef the cpuid code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
