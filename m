Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B04C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 16:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA45E3CAC5A
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 18:17:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6D8A3CAB59
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:17:00 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41F041000361
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:16:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 435E0211F9;
 Mon, 31 Mar 2025 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743437819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hs5/d793Z4IQYh2ulZKhyGKuXCoL2yG1Efq21A3RG+o=;
 b=aODWxUeZddb1GElb9zFR96OQBYWcXLq3/tgCjGZh4NG3mQue4MHyb31zYSqLCjGZ8zHQCT
 3E3uOEAzJHaMS+3TR8Bbd6djIGnlDPi/dFLifoQBdIHTIvN9MMKqOR9QZefK5Bq2tlz2e1
 8IsPqI5+jQUARc0UlQEGD0swWOUT1wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743437819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hs5/d793Z4IQYh2ulZKhyGKuXCoL2yG1Efq21A3RG+o=;
 b=Zu30YkrDE54CMhvh4BM4JqXeJhXf+wSSGnUZSilC02QSiQWqLIbjjNk53/j54xuqVIxMju
 7ybOQGA8GDB8hICQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743437819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hs5/d793Z4IQYh2ulZKhyGKuXCoL2yG1Efq21A3RG+o=;
 b=aODWxUeZddb1GElb9zFR96OQBYWcXLq3/tgCjGZh4NG3mQue4MHyb31zYSqLCjGZ8zHQCT
 3E3uOEAzJHaMS+3TR8Bbd6djIGnlDPi/dFLifoQBdIHTIvN9MMKqOR9QZefK5Bq2tlz2e1
 8IsPqI5+jQUARc0UlQEGD0swWOUT1wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743437819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hs5/d793Z4IQYh2ulZKhyGKuXCoL2yG1Efq21A3RG+o=;
 b=Zu30YkrDE54CMhvh4BM4JqXeJhXf+wSSGnUZSilC02QSiQWqLIbjjNk53/j54xuqVIxMju
 7ybOQGA8GDB8hICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 313C2139A1;
 Mon, 31 Mar 2025 16:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2J6ZCvu/6melWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Mar 2025 16:16:59 +0000
Date: Mon, 31 Mar 2025 18:17:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z-rAFF9yX3de8CZw@yuki.lan>
References: <f1833ac3-5c28-4a19-945c-2112dbd898eb@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1833ac3-5c28-4a19-945c-2112dbd898eb@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [kirk] Remove support for external testing suite
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> As you may know, Kirk supports the execution of certain kselftests and 
> liburing testing suites. It was initially created as an experiment.
> 
> We have made attempts to implement these features, but it seems we have 
> not succeeded. They appear to be largely unused by most users and are 
> creating a bottleneck for new Kirk implementations, such as the 
> automatic installation of LTP inside the SUT. This feature would be 
> particularly beneficial for QEMU vanilla images. We had it in the past 
> already and probably it's time to get this feature back. And we should 
> probably implement it for other testing suites due to the current API: 
> something that we really don't want to do (see eBPF kselftests compile 
> madness).
> 
> Another concern is the maintainability of supporting for additional 
> testing suites. While they are interesting, the implementation is 
> somewhat flawed. Each testing suite has its own 
> input/output/configuration/compilation methods, leading to confusion and 
> over-engineered solutions. While we understand that no solution is 
> perfect, it seems we have reached a point where Kirk = LTP. Therefore, 
> we should reconsider maintaining features that require updates due to 
> changes in external testing suites.
> 
> For these reasons, I propose that we remove support for the additional 
> testing suites and focus exclusively on LTP for Kirk maintenance.
> 
> What do you think?

Sounds reasonable to me. There is quite a bit of work to be done in
order to implement all the advanced features in kirk and it does not
help if we get distracted by side quests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
