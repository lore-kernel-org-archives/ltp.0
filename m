Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F296DCCFA15
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 11:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58D13C4EE8
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 13:19:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D0283C2DAB
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:19:38 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 719AD14010EE
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:19:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 299A21F7FB;
 Thu, 26 Sep 2024 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727349576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6cHytHeqALeQ7Go6ZfvZZDiz9EueA5O8iQHGpZOYA=;
 b=DqiBSn3d8so4w0Hw8ZS32UtqMtE0Q/6ZezCu0Q43S7sLJ2r7TYfWW8OldBmDUt006tOGAb
 Btw16OK+jEPXpK3hYLchQQpZUMNe7dO1/N5MCgKw2TSXfCLocpegX9OqUQqIzNT9O2dbQH
 8hrJpUXepKJ+mbAAx240KR6HzqAaleA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727349576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6cHytHeqALeQ7Go6ZfvZZDiz9EueA5O8iQHGpZOYA=;
 b=j+1jVCf4rTgQcBnrArebPHcK9CY6rmWEGGOyEc3M2GUSIenwQCOx3td1NzsURX9shM5p8V
 h4UpHjFGGw42xKAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727349575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6cHytHeqALeQ7Go6ZfvZZDiz9EueA5O8iQHGpZOYA=;
 b=fg2/ycVx5SFrCqJtmmJycPY/PL6L/fQp/v452gbigdkCyuwK+GsERpt+V32qe416eC8jmT
 fGvMoIzsuMMRw+JShdsZQ9q4a+SS+3s2BYYMXQe8M95OSSakRM3dSLmIXcAI0kFPhwSfuH
 LA87LQOVyXgRvmAg9YrPm/23JhanV4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727349575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6cHytHeqALeQ7Go6ZfvZZDiz9EueA5O8iQHGpZOYA=;
 b=X35SwtH5nzTD/hIIyU3C3p9YB7MEJ8LR1M3tVj1BusT6ATR2ReuNanLzDa4+TLFwsySQ9h
 3I+M62Cdw0nxy3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EFDE13793;
 Thu, 26 Sep 2024 11:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9/6TAkdD9WbfPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Sep 2024 11:19:35 +0000
Date: Thu, 26 Sep 2024 13:18:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <ZvVDCJfV931oLIe2@yuki.lan>
References: <20240925084921.16352-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240925084921.16352-1-ice_yangxiao@163.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.997];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[163.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[163.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> If the value of max_user_namespaces is set to 10 but more than
> 10 user namspaces are currently used on system.  In this case,
> these tests fail with ENOSPC. for example:
> 
> # lsns -t user -n | wc -l
> 17
> 
> # ./fanotify17
> ...
> fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
> fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
> fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
> fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> tst_test.c:452: TBROK: Invalid child (6958) exit value 1

That's strange the test seems to work for me even if it's over the
limit.

$ lsns -t user -n | wc -l
14

I suppose that since the test is executed as a root since it has
.require_root the limits does not apply. It's strange that they apply in
your case. Which kernel is this?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
