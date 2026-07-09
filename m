Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7C4C44501
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 14:04:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D993E5C6E
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:04:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070E73CE45A
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:04:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A7671A00A2F
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:04:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4237622F;
 Thu,  9 Jul 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783605849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcynFwIsRBKPjo535/+JdW6dolGw3gYmbNliKkU6C1s=;
 b=zUv+zlkM7u5y3aIqewie2pnh1dhM2qydVxj88XBb82uJTawh3FbuJNvBT/6KVl1TlCEQDd
 zpyEU5pk+H+JNIJYRW5pDf1NHjrNTiUs6xb6Zz7yB9hZPrD2o3IyzSy2IkVQ/JY9OkcGd9
 d0/f2lBHQfEXlS8O5qKpEPXIuVexCpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783605849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcynFwIsRBKPjo535/+JdW6dolGw3gYmbNliKkU6C1s=;
 b=AqjzfnnPI9yHlWGTLx4x9t86TnRpn6eGMAHI5nuG+jU050uYpgjAOS+zj1xFHkUELwd0G5
 L7mveTYQYrTcfMAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783605848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcynFwIsRBKPjo535/+JdW6dolGw3gYmbNliKkU6C1s=;
 b=DomPBFU5NXazw4AVtL8pXa8qxw9WzBALh+EbQoC/nouSwAR3ZhTTtZvI8leujRaw8dbKv2
 WRtZesUCGwBbYN+LC82pGF4KVgR/LiuQcprS3+EEX/IMBc5G6GxHGy310IaRjIHh1o7TA3
 v+V8Bv5Wo8oT+IfO2kyffVLazFDfV0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783605848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcynFwIsRBKPjo535/+JdW6dolGw3gYmbNliKkU6C1s=;
 b=7SPmfL95uNZJIjCV8fm4fTtZs0uuBuI84jKTUR482RRNPIyKZhAbf+fJSoMpyDTsQ59IM9
 lvcxeWrPYbRsVOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CBEB779AC;
 Thu,  9 Jul 2026 14:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OxnuAViqT2o5VAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 14:04:08 +0000
Date: Thu, 9 Jul 2026 16:03:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <ak-qSU7nffOqkjQ9@yuki.lan>
References: <20260709085353.345957-2-chrubis@suse.cz>
 <20260709104403.4345-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709104403.4345-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_create03
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
> --- [PATCH 7/9] ---
> 
> > 	rval = poll(fds, nfds, timeout);
> > 	if (rval == -1) {
> > 		tst_brk_(file, lineno, TBROK | TERRNO,
> > 			"poll(%p, %li, %i) failed", fds, (long)nfds, timeout);
> > 	} else if (rval < -1) {
> > 		tst_brk_(file, lineno, TBROK | TERRNO,
> > 			"Invalid poll(%p, %li, %i) return value %i",
> > 			fds, (long)nfds, timeout, rval);
> > 	}
> 
> poll() returns -1 on error or >= 0 on success; it cannot return a
> value less than -1. The else-if branch is dead code.
> 
> The nearby safe_statvfs() uses "else if (rval)" to catch unexpected
> non-zero returns for a function that is 0 on success. poll() returns
> 0 (timeout) and positive values (events ready) as normal outcomes, so
> no such secondary check applies here. The body should just have the
> rval == -1 guard and return rval.

I will ignore this one since we are guarding againts kernel bugs with
this code. I.e. if kernel returns impossible value we want the test to
report it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
