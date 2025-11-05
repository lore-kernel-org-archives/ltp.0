Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737ACCCFA0D
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 10:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0873D3CE3EB
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 11:54:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718A23C2026
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 11:54:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E34096002B0
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 11:54:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F0C221182;
 Wed,  5 Nov 2025 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762340071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys4YcbJAfG9yUtzwSZ7NCrBPGSak6kYLyj60C8bFTPs=;
 b=X3pnJjHzIJdwb11JfjaeTQNR/GbL95UbfPWoLY1DpvWzmyIipsTqGwEHHW1OyorQDGcn4F
 uqBqSAEZZ/7Ge9uLAr2FMG4f7//AX5vzFhn2exmeU5k0VMkep4QQ7g2rkqsjhpI1Gx/UIM
 FvmzciGEDJNbscT1vPnOEc8mdtgLLhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762340071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys4YcbJAfG9yUtzwSZ7NCrBPGSak6kYLyj60C8bFTPs=;
 b=c/UaT7lKrHTFaPWHY3TIeNIV/52ySCqxiSqcp7MBTRoub24KpzpOnynf6CY2KEAIGr3Aqa
 HcmQR4q1W+UftmDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762340070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys4YcbJAfG9yUtzwSZ7NCrBPGSak6kYLyj60C8bFTPs=;
 b=PhO2x6G1wf/8rPDqyNyObNhDwAqY8YOK5NV51FRrpIfkMJCWff8ITNeCMZVSQ1PhYXnZwi
 prrT/iPSAAnw5SzkLcB6em/WDFK1b/L88ErJwVxf5rUOa65PtOHLjr8ZKrV4vAcA39jEbL
 CIhM/AX5t7yqpdyrPCxAf1bm9xQicmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762340070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys4YcbJAfG9yUtzwSZ7NCrBPGSak6kYLyj60C8bFTPs=;
 b=ChD/683InUeIWreUhqYLDZzpYHjojCboHUpJP6JvxVsS1FG50XR0V9GdQrc3wFSwKQlrff
 QJS7RzgJJl6nQUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48963132DD;
 Wed,  5 Nov 2025 10:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w//MEOYsC2mCcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 05 Nov 2025 10:54:30 +0000
Date: Wed, 5 Nov 2025 11:55:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <aQstFByWQ6Zkz6ZP@yuki.lan>
References: <20251104193942.4080083-1-sbertram@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251104193942.4080083-1-sbertram@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add config check for systems that do not
 support CONFIG_XFS_FS.
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
There was a bug in the test library filesystem availability check,
should have been fixed by:

commit 5e1e0e2d81e564df09542b7caa2a66928c05dd3a
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Oct 27 16:09:24 2025 +0100

    lib/tst_test: Fix FS kernel supported check


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
