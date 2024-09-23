Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6B5CF9C5B
	for <ltp@archiver.kernel.org>; Mon, 23 Sep 2024 08:17:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AF783C31F7
	for <ltp@archiver.kernel.org>; Mon, 23 Sep 2024 10:17:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 793FC3C31AD
 for <ltp@lists.linux.it>; Mon, 23 Sep 2024 10:17:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA9246001E0
 for <ltp@lists.linux.it>; Mon, 23 Sep 2024 10:17:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAD9421EB6;
 Mon, 23 Sep 2024 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727079456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAD+fQE8CYWWeqVG7F3gmjOSsfkUJwlFuQZ+VcqRgR0=;
 b=dxq7y6IJDJs/633LdVLsWGj3DD+ZmeyiY2v8hRPfnLVBonSg2lxD7FcZMTxMeEvvF1bEtu
 kH1pC40/+QtVvYyenwdzo7mqLL3LYz/hvyURntdzV2HZQ2UX5CdkUyN84OkoJXWDDnj5aH
 4RgTVmRhISq+uQ1Aek9pQNTW/dSvo2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727079456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAD+fQE8CYWWeqVG7F3gmjOSsfkUJwlFuQZ+VcqRgR0=;
 b=5ry6HpfX5lDSwvfHYymKe/nFOtsHgbfgwmbS1bT8aEy1GfjgefE/ZbhdNDzjTriMpOnGOQ
 jBnxnCQrWiJImBDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727079456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAD+fQE8CYWWeqVG7F3gmjOSsfkUJwlFuQZ+VcqRgR0=;
 b=dxq7y6IJDJs/633LdVLsWGj3DD+ZmeyiY2v8hRPfnLVBonSg2lxD7FcZMTxMeEvvF1bEtu
 kH1pC40/+QtVvYyenwdzo7mqLL3LYz/hvyURntdzV2HZQ2UX5CdkUyN84OkoJXWDDnj5aH
 4RgTVmRhISq+uQ1Aek9pQNTW/dSvo2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727079456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAD+fQE8CYWWeqVG7F3gmjOSsfkUJwlFuQZ+VcqRgR0=;
 b=5ry6HpfX5lDSwvfHYymKe/nFOtsHgbfgwmbS1bT8aEy1GfjgefE/ZbhdNDzjTriMpOnGOQ
 jBnxnCQrWiJImBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B905A13A64;
 Mon, 23 Sep 2024 08:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zfweLSAk8WbhawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Sep 2024 08:17:36 +0000
Date: Mon, 23 Sep 2024 10:16:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: =?utf-8?B?5p2o5pmT?= <ice_yangxiao@163.com>
Message-ID: <ZvEj2GHW8komVKfX@yuki.lan>
References: <20240809025825.4055-1-ice_yangxiao@163.com>
 <ZuljrzDTzU3VtI5O@yuki.lan>
 <5886c6f2.1ce6.19213255e77.Coremail.ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5886c6f2.1ce6.19213255e77.Coremail.ice_yangxiao@163.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.997];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[163.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[163.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/{fanotify17,
 getxattr05}: simplify code by using save_restore
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
> If more than 10 user namspaces is currently used on system, it is still successfully to set
> max_user_namespaces to 10.  However, these tests fail with ENOSPC. for example:
> # lsns -t user -l -n | wc -l
> 17
> 
> root@fedora40:~/ltp/testcases/kernel/syscalls/fanotify# ./fanotify17
> ...
> fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
> fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
> fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
> fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> tst_test.c:452: TBROK: Invalid child (6958) exit value 1
> 
> 
> 
> Just try to fix the issue by increasing the setting of max_user_namespaces.
> BTW, it may be better to get the number of user namespaces in use and then add 10.

Such change should be ideally in a separate patch with this explanation
and not hidden in a patch that is supposedly just moving the code that
restores the original value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
