Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1115F41987
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 800CC3E5BAA
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 12:18:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E18C3C1E06
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:18:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2732A600BCE
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:18:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 925205BE39;
 Wed, 15 Apr 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 841114B963;
 Wed, 15 Apr 2026 10:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wYLEH95l32n9JwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Apr 2026 10:18:06 +0000
Date: Wed, 15 Apr 2026 12:18:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <ad9l7MeJneX1LdCe@yuki.lan>
References: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 925205BE39
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid syscall param ioctl(generic) points to
 uninitialised byte(s)
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> From b81924101f441d7f2103197c8b81a38e8920fda4 Mon Sep 17 00:00:00 2001
> From: Super User <root@vm-10-0-185-15.hosted.upshift.rdu2.redhat.com>
> Date: Wed, 20 Jan 2038 01:08:34 -0500
> Subject: [PATCH] Avoid syscall param ioctl(generic) points to uninitialised
>  byte(s)
> 
> lib/tst_clocks.c: fix uninitialized memory in run()  Reproducible
>                   using userfaultfd01.

This description does not seem to correspond to the actual change.

> Signed-off-by: Martin Cermak <mcermak@redhat.com>
> ---
>  testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> index 7368d3863..d24766e7c 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -92,8 +92,8 @@ static void *handle_thread(void)
>  static void run(unsigned int i)
>  {
>  	pthread_t thr;
> -	struct uffdio_api uffdio_api = {};
> -	struct uffdio_register uffdio_register;
> +	struct uffdio_api uffdio_api = {0, };
> +	struct uffdio_register uffdio_register = {0, };

Given that we were using = {}; in the code before can we keep using that
and for all instances?

Also I assume the problem is the ioctls field in the uffdio_api
structure that is not initialized beacuse is supposed to be set by
kernel before returning into userspace. Should valgrind warn about such
cases?


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
