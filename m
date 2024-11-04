Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EDFD1BDC5
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 16:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393953D0E2C
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 17:39:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86A9E3D0DC4
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 17:38:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9C9262D380
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 17:38:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4140D21B4F;
 Mon,  4 Nov 2024 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730738328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO8m8cBQAfXV6CXqAE8/bf4ynw5Cf3nT1N4WxCf0q0c=;
 b=yggwXDGit5k9u8/rzgaZDY3c3ZZqUiV675arh3W7lPWUEuamj+krABJ3LUlHIgvBG3XjIC
 UP6lroWexfOazGl6ES4W+QeIOBnbQ9AcwMhUL8vlPO/U7B4NuiUgAOIL7QFggv6oBa1NtX
 iAJUkWwskyJoMJix0R/gxeZ+rCcPDxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730738328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO8m8cBQAfXV6CXqAE8/bf4ynw5Cf3nT1N4WxCf0q0c=;
 b=PG0b/r7c6V50X6Lb+sCjUhophwHVkRoOFLNsmnYwwLm+rjgaHQ8CIXPylppyam9szBbety
 umHvv2oHJJS4g+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730738328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO8m8cBQAfXV6CXqAE8/bf4ynw5Cf3nT1N4WxCf0q0c=;
 b=yggwXDGit5k9u8/rzgaZDY3c3ZZqUiV675arh3W7lPWUEuamj+krABJ3LUlHIgvBG3XjIC
 UP6lroWexfOazGl6ES4W+QeIOBnbQ9AcwMhUL8vlPO/U7B4NuiUgAOIL7QFggv6oBa1NtX
 iAJUkWwskyJoMJix0R/gxeZ+rCcPDxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730738328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO8m8cBQAfXV6CXqAE8/bf4ynw5Cf3nT1N4WxCf0q0c=;
 b=PG0b/r7c6V50X6Lb+sCjUhophwHVkRoOFLNsmnYwwLm+rjgaHQ8CIXPylppyam9szBbety
 umHvv2oHJJS4g+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1269013736;
 Mon,  4 Nov 2024 16:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DnmUApj4KGd9LAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 16:38:48 +0000
Date: Mon, 4 Nov 2024 17:38:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241104163845.GA1417282@pevik>
References: <20240925084921.16352-1-ice_yangxiao@163.com>
 <ZvVDCJfV931oLIe2@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZvVDCJfV931oLIe2@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[163.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/{fanotify17,
 getxattr05}: Fix the ENOSPC error
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

Hi Cyril, Xiao Yang,

> Hi!
> > If the value of max_user_namespaces is set to 10 but more than
> > 10 user namspaces are currently used on system.  In this case,
> > these tests fail with ENOSPC. for example:

> > # lsns -t user -n | wc -l
> > 17

> > # ./fanotify17
> > ...
> > fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
> > fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
> > fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
> > fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > tst_test.c:452: TBROK: Invalid child (6958) exit value 1

> That's strange the test seems to work for me even if it's over the
> limit.

> $ lsns -t user -n | wc -l
> 14

I'm able to reproduce as well on VM.

I get problems with 9 for fanotify17 ...

# for i in {0..7}; do unshare -U & done

# lsns -t user -n | wc -l
9

# ./fanotify17
...
fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:452: TBROK: Invalid child (1916) exit value 1

and with 10 for getxattr05:

# unshare -U  &

# lsns -t user -n | wc -l
10

# ./getxattr05
getxattr05.c:88: TPASS: Got same data when acquiring the value of system.posix_acl_access twice
getxattr05.c:88: TPASS: Got same data when acquiring the value of system.posix_acl_access twice
getxattr05.c:88: TPASS: Got same data when acquiring the value of system.posix_acl_access twice

> I suppose that since the test is executed as a root since it has
> .require_root the limits does not apply. It's strange that they apply in
> your case. Which kernel is this?

Testing on 6.12.0-rc4-1.gf83465d-default and 6.11.5-1-default (both openSUSE
Tumbleweed) and 6.9.9-amd64 (Debian).

Yes, root access is required for rw to /proc/sys/user/max_user_namespaces:

getxattr05.c:159: TBROK: Failed to open FILE '/proc/sys/user/max_user_namespaces' for writing: EACCES (13)
getxattr05.c:167: TWARN: Failed to open FILE '/proc/sys/user/max_user_namespaces' for writing: EACCES (13)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
