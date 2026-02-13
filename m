Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7949EE36A0
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 09:28:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA3163CF7A3
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 721FA3CF678
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 10:27:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BD4F52009C9
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 10:27:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 462005BCC4;
 Fri, 13 Feb 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29D363EA62;
 Fri, 13 Feb 2026 09:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KgpOCZLujmm3TAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 13 Feb 2026 09:27:46 +0000
Date: Fri, 13 Feb 2026 10:27:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aY7ulL28AnCh2qP6@yuki.lan>
References: <20260125063035.31171-1-wegao@suse.com>
 <20260213023801.11713-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260213023801.11713-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 462005BCC4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_pidfd02.c: fix clone3 EFAULT in 32-bit
 compat mode due to sign extension
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
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_common.h                            | 5 +++++
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 2 +-
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 2 +-
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 2 +-
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 2 +-
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
>  6 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/tst_common.h b/include/tst_common.h
> index 473228149..430c5e171 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -86,4 +86,9 @@
>  #define TST_TO_STR_(s) #s
>  #define TST_TO_STR(s) TST_TO_STR_(s)
>  
> +/*
> + * TST_PTR_TO_UINT - Casts a pointer to a 64-bit unsigned integer.
> + */
> +#define TST_PTR_TO_UINT(x) ((uint64_t)(uintptr_t)(x))

There is no need to have the (uint64_t) cast here, the uintptr_t cast is
enough to fix the problem.


Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
