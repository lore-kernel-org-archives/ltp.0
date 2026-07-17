Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32085C44514
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:14:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6615B3E55E0
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:14:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8767D3C9911
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:14:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEBCB1000A2C
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:14:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 457A078E08;
 Fri, 17 Jul 2026 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784279657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz0BpeZWRlN4B5liM0DTpMoYP3XgECDsKnOUB+Zta6I=;
 b=pcH8K+NAVVwK11bszNq2ANzdwCh/SX4DOaE9LuoD0iTa8QWotKyffg25hGeWSyGYbY2Ugn
 3LvTWvb+hooukOy+tY3dyss27I1bYGIjORRkOz7pJIunx1LrVFC6d2pA9GCFw3JLqtdCvf
 BLzNVLGRD1wATJDfYnvblBHKcfq4vII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784279657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz0BpeZWRlN4B5liM0DTpMoYP3XgECDsKnOUB+Zta6I=;
 b=IFuclK3x+1faYg31Q/20XFq9N8fQXUsxSso5UfN5/r8uuVuFChvssf6e3rwZcCnUlvQi3i
 oDkAZaKyl1UDsZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784279657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz0BpeZWRlN4B5liM0DTpMoYP3XgECDsKnOUB+Zta6I=;
 b=pcH8K+NAVVwK11bszNq2ANzdwCh/SX4DOaE9LuoD0iTa8QWotKyffg25hGeWSyGYbY2Ugn
 3LvTWvb+hooukOy+tY3dyss27I1bYGIjORRkOz7pJIunx1LrVFC6d2pA9GCFw3JLqtdCvf
 BLzNVLGRD1wATJDfYnvblBHKcfq4vII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784279657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz0BpeZWRlN4B5liM0DTpMoYP3XgECDsKnOUB+Zta6I=;
 b=IFuclK3x+1faYg31Q/20XFq9N8fQXUsxSso5UfN5/r8uuVuFChvssf6e3rwZcCnUlvQi3i
 oDkAZaKyl1UDsZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35FE3779AA;
 Fri, 17 Jul 2026 09:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vb5GDGnyWWorawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jul 2026 09:14:17 +0000
Date: Fri, 17 Jul 2026 11:14:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <alnyZYfYiEhNBJ5i@yuki.lan>
References: <20260716-rewrite_inode_testing_suite-v1-1-b6fee6f0d0ba@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260716-rewrite_inode_testing_suite-v1-1-b6fee6f0d0ba@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode: convert to new API and merge into a single
 test
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
> The inode01 and inode02 tests shared the same directory/file tree engine
> and differed only in tree dimensions and in whether the workload ran in
> a single process or across several parallel workers.
> 
> inode01 now covers both scenarios, so inode02 is removed together with
> its entries in runtest/fs, runtest/fs_readonly and the .gitignore. Note
> this drops inode02 as a test id; its runtest/fs_readonly slot is left as
> a gap so unrelated test_robind entries keep their numbers.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/fs                           |   1 -
>  runtest/fs_readonly                  |   1 -
>  testcases/kernel/fs/inode/.gitignore |   1 -
>  testcases/kernel/fs/inode/inode01.c  | 864 +++++----------------------------
>  testcases/kernel/fs/inode/inode02.c  | 902 -----------------------------------

Just FYI diffs for big rewrites like this are much more readable if
generated with the git -B switch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
