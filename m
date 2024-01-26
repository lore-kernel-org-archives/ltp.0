Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1518EC47DDF
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 12:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E80593D060D
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 13:00:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF3B83C4D11
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:00:06 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81EE8600D66
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:00:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 694461FB7E;
 Fri, 26 Jan 2024 12:00:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 580B8134C3;
 Fri, 26 Jan 2024 12:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y7IdFMSes2XjQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jan 2024 12:00:04 +0000
Date: Fri, 26 Jan 2024 13:00:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbOe0gNjcyZCPi1H@yuki>
References: <20240125155107.430656-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240125155107.430656-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 694461FB7E
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> /dev/zero on pipe write started to succeeded on kernel 6.7.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> @Jan could you please check the problem is a kernel 6.7 bug
> or just wanted change and we should whitelist /dev/zero on pipe write?
> 
> Thanks!
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/splice/splice07.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> index 135c42e47..1fa13b3e6 100644
> --- a/testcases/kernel/syscalls/splice/splice07.c
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -38,6 +38,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
>  	if (fd_out->type == TST_FD_PIPE_WRITE) {
>  		switch (fd_in->type) {
>  		/* While these combinations succeeed */
> +		case TST_FD_DEV_ZERO:

long as the reading end is open and there is a space in the pipe. So I
suppose that we got EINVAL because the /dev/zero didn't support splice.

And indeed looking at git log drivers/char/mem.c shows:

commit 1b057bd800c3ea0c926191d7950cd2365eddc9bb
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Tue Sep 19 09:37:42 2023 +0200

    drivers/char/mem: implement splice() for /dev/zero, /dev/full

    This allows splicing zeroed pages into a pipe, and allows discarding
    pages from a pipe by splicing them to /dev/zero.  Writing to /dev/zero
    should have the same effect as writing to /dev/null, and a
    "splice_write" implementation exists only for /dev/null.

    (The /dev/zero splice_read implementation could be optimized by
    pushing references to the global zero page to the pipe, but that's an
    optimization for another day.)

    Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
    Link: https://lore.kernel.org/r/20230919073743.1066313-1-max.kellermann@ionos.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

With that I guess that we may want to skip the test only on newer
kernels and possibly implement splice test for these two special files
later on.


>  		case TST_FD_FILE:
>  		case TST_FD_MEMFD:
>  			return;
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
