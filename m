Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F7EC5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 13:14:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0B993CA4A4
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 15:14:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694233C9AF7
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 15:13:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1EC91A01943
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 15:13:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70E171FD96;
 Thu,  5 Jun 2025 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749129234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkJ8v023scEVXWP+vkh2CgwZruHWl8l9okuQE0C5gP8=;
 b=cUnTvz1rIFqSBkmMCM0eyvMAWU1PU3tM5xf0KJ0KxNuOA3YL9RmMuMlOiZUEHQ4r3X1S0n
 3pwn16TDXbfveB4KB6Rhkp3vDp2X9LkEPSBdoe89f3LJeeFG8o2/isKCC+t24t0F+7Iqla
 9FmJNThVePOZoMRguWKa7wmCrmlEQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749129234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkJ8v023scEVXWP+vkh2CgwZruHWl8l9okuQE0C5gP8=;
 b=yPNyIXXSmNSC3/TykYjvZ0HJtrne46vlY3Y10SMhhFU/tON5fIcygA5NWiXGxn5Tge2d5M
 N2ajf8ECqJTghXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749129234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkJ8v023scEVXWP+vkh2CgwZruHWl8l9okuQE0C5gP8=;
 b=cUnTvz1rIFqSBkmMCM0eyvMAWU1PU3tM5xf0KJ0KxNuOA3YL9RmMuMlOiZUEHQ4r3X1S0n
 3pwn16TDXbfveB4KB6Rhkp3vDp2X9LkEPSBdoe89f3LJeeFG8o2/isKCC+t24t0F+7Iqla
 9FmJNThVePOZoMRguWKa7wmCrmlEQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749129234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkJ8v023scEVXWP+vkh2CgwZruHWl8l9okuQE0C5gP8=;
 b=yPNyIXXSmNSC3/TykYjvZ0HJtrne46vlY3Y10SMhhFU/tON5fIcygA5NWiXGxn5Tge2d5M
 N2ajf8ECqJTghXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61A211373E;
 Thu,  5 Jun 2025 13:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d1rQFhKYQWg2LQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Jun 2025 13:13:54 +0000
Date: Thu, 5 Jun 2025 15:14:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aEGYLuTen03bfAvr@yuki.lan>
References: <20250605142943.229010-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605142943.229010-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
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
> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index b4d75bdcc..55516ec89 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -43,6 +43,12 @@ static void setup(void)
>  
>  	tp.type = tv->ts_type;
>  
> +	if (access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) {
> +		int pid = getpid();
> +
> +		SAFE_FILE_PRINTF("/sys/fs/cgroup/cgroup.procs", "%d", pid);
> +	}
> +

If we are going to fix more than one test it would make sense to put
this code somewhere in a common header in the top level include/.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
