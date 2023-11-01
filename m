Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC26C4167B
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 12:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3EA3CE9BF
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 13:50:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 980113CC8DB
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 13:50:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3929A600847
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 13:50:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E13FE211B7;
 Wed,  1 Nov 2023 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698843000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZSl0bEgfEcUjnW1PwqhCD/zC0Q2j4HXioEujLC/T1g=;
 b=X7VFbGXZSXtSw+XQ9PqwTB3ZqDOFKTMzJQUps6KZ1amZ0DP8j4NOxZxCB7937o0u9GYieq
 SKJR2CAshuOS4477PkZOJGGG1G1MemRaU3GMQCLRmU6CeMftuDckF5KVBmFwZw9DbaFDkY
 mJyY2oPZsBLYwRxIYIBZcmRoPD31UAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698843000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZSl0bEgfEcUjnW1PwqhCD/zC0Q2j4HXioEujLC/T1g=;
 b=wdYc6I8iqoLnldCaYvank+LY1lJu4qBKdtHBqjdTcQXDddXtaMywgov1aUL57MYL/i12ni
 Gx9VgkC+dUHY81Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB1E1348D;
 Wed,  1 Nov 2023 12:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +CI/MXhJQmX0XQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Nov 2023 12:50:00 +0000
Date: Wed, 1 Nov 2023 13:50:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZUJJmPJYqumtFZxh@yuki>
References: <20230908102315.8163-1-andrea.cervesato@suse.de>
 <20230908102315.8163-3-andrea.cervesato@suse.de>
 <878r82yhyh.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878r82yhyh.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Refactor exit_group01 using new API
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
> This could fail due to PID reuse or maybe because state == 'Z'.
> 
> Perhaps instead we could check the threads are put into the Z state?
> 
> I guess that the child threads are reparented to init and it reaps
> them. So you will have to prevent that by setting PR_SET_CHILD_SUBREAPER
> on the main test process with prctl.
> 
> The man pages are not clear on this though. I guess this is how it works
> from reading the kernel code.

What about we:

1) allocate a piece of shared memory
2) each thread would run a loop that would increment a counter in that
   memory
3) the test process will wait() the main child
4) then monitor the shared memory to make sure that counters are not
   incremented anymore

Also child threads shouldn't be reparented to init, as long as at least
one of the threads runs the child process is technically alive and I
guess that wait() will not return until last thread in the group is
dead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
