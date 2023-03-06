Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8AFC678D4
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 09:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30B7B3CB8BE
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 10:46:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75AA43C30A8
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 10:46:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE01B1A00359
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 10:46:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3AE01FDDD;
 Mon,  6 Mar 2023 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678095973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mipzp8E9OmpSARrJ7MCUCTH+b/QB38/XdP7H6aAxoTc=;
 b=PqjJgZ+2llSWUbtbU1s6GIXML654zN/S5s6YZzLEVxSvSY2n5C8gnEm0yQ5JuTdjmb1sI6
 v/4w5LJcTnMLqwP+gR68jyGKodo9XW9pKQoo5djK7l5Y4HhONvXseYe4KapnQm03BxY5WN
 ce8SWUK6cpfKy2pysJkoQ1holiLualA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678095973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mipzp8E9OmpSARrJ7MCUCTH+b/QB38/XdP7H6aAxoTc=;
 b=5R8nW6wj/nRoM4VmYI0IvPNZ5OAeq7iJfO+ZTW4YzyZ2XOJSC02y7p1JJ9DsemRwC2lOQ4
 B82eiEaXKl6BYuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC65C13A66;
 Mon,  6 Mar 2023 09:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RSi4NGS2BWTPZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Mar 2023 09:46:12 +0000
Date: Mon, 6 Mar 2023 10:47:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZAW2tX2ZfPYRcFFW@yuki>
References: <20230303095730.26049-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230303095730.26049-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Remove tomoyo testing suite
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
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> The tomoyo testing suite is built and installed inside the LTP testcases
> folder, but it's not used and maintained anymore.
> This patch removes it, so we get rid of ltp_clone_quick as well and make
> some space in the installation folder.

We should metion here that this has been acked by the tomoyo maintainer,
ideally as Acked-by: tag.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/security/tomoyo/.gitignore   |   9 -
>  testcases/kernel/security/tomoyo/Makefile     |  29 -
>  testcases/kernel/security/tomoyo/README       |  58 --
>  testcases/kernel/security/tomoyo/include.h    | 379 ----------
>  testcases/kernel/security/tomoyo/newns        | Bin 0 -> 22848 bytes
          ^
	  This does not look right.
>  testcases/kernel/security/tomoyo/newns.c      |  49 --
>  testcases/kernel/security/tomoyo/testall.sh   |  46 --
>  .../kernel/security/tomoyo/tomoyo_accept_test | Bin 0 -> 46136 bytes
>  .../security/tomoyo/tomoyo_accept_test.c      | 146 ----
>  .../kernel/security/tomoyo/tomoyo_file_test   | Bin 0 -> 57296 bytes
>  .../kernel/security/tomoyo/tomoyo_file_test.c | 304 --------
>  .../security/tomoyo/tomoyo_filesystem_test    | Bin 0 -> 88160 bytes
>  .../security/tomoyo/tomoyo_filesystem_test.c  | 633 -----------------
>  .../security/tomoyo/tomoyo_new_file_test      | Bin 0 -> 84864 bytes
>  .../security/tomoyo/tomoyo_new_file_test.c    | 627 -----------------
>  .../kernel/security/tomoyo/tomoyo_new_test    | Bin 0 -> 69800 bytes
>  .../kernel/security/tomoyo/tomoyo_new_test.c  | 652 ------------------
>  .../security/tomoyo/tomoyo_policy_io_test     | Bin 0 -> 49648 bytes
>  .../security/tomoyo/tomoyo_policy_io_test.c   | 195 ------
>  .../security/tomoyo/tomoyo_policy_memory_test | Bin 0 -> 34080 bytes
>  .../tomoyo/tomoyo_policy_memory_test.c        | 358 ----------
>  .../security/tomoyo/tomoyo_rewrite_test       | Bin 0 -> 44712 bytes
>  .../security/tomoyo/tomoyo_rewrite_test.c     | 169 -----
>  23 files changed, 3654 deletions(-)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
