Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC48BC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 15:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A00B3C7C02
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 16:50:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C75B3C7BD0
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 16:50:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F46E140B5B4
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 16:50:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E37C621164;
 Thu, 16 Jan 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D274F13332;
 Thu, 16 Jan 2025 15:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p5U+MrEqiWe9dwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jan 2025 15:50:09 +0000
Date: Thu, 16 Jan 2025 16:50:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z4kqqIQlgj4QF21X@yuki.lan>
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E37C621164
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In cases where worker completes specified number of `iterations` before
> oper completes all `total_ios`, such oper remains on active_list.
> This is a problem because cleanup only walks over finished list,
> and closes fds only for items on this list. So it's possible for
> test to exhaust ulimit for open files and fail:
> 
> $ ./aio-stress -a1 -I100 -o2 -r4 -f1 -d1^
> aio-stress.c:1347: TPASS: Test passed
> aio-stress.c:1285: TINFO: starting with random write
> aio-stress.c:1296: TINFO: file size 1024MB, record size 0KB, depth 1, I/O per iteration 1
> aio-stress.c:1298: TINFO: max io_submit 1, buffer alignment set to 4KB
> aio-stress.c:1300: TINFO: threads 1 files 1 contexts 1 context offset 2MB verification off
> aio-stress.c:1314: TBROK: open(file0.bin,1052738,0600) failed: EMFILE (24)

Looks like the test has many options and some combinations may set
things in a way that does not make much sense.

> Clean/free also items from active_list. Also don't let `status` from cleanup
> be set to zero once it becomes non-zero.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/io/ltp-aiodio/aio-stress.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index 419fc2cd25a4..e84308d1d0e8 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -1122,7 +1122,12 @@ restart:
>  	while (t->finished_opers) {
>  		oper = t->finished_opers;
>  		oper_list_del(oper, &t->finished_opers);
> -		status = finish_oper(t, oper);
> +		status = finish_oper(t, oper) ? : status;
> +	}
> +	while (t->active_opers) {
> +		oper = t->active_opers;
> +		oper_list_del(oper, &t->active_opers);
> +		status = finish_oper(t, oper) ? : status;
>  	}


I guess that this works as a minimal fix.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
