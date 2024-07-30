Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E3EC3DA49
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 07:50:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3123D1C18
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:50:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992783D0B1D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:49:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 928F21000DE4
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:49:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE2DE21A92;
 Tue, 30 Jul 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9831913297;
 Tue, 30 Jul 2024 07:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tSzlJCWbqGYwdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jul 2024 07:49:57 +0000
Date: Tue, 30 Jul 2024 09:49:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqibBUXHVfSjN-_4@yuki>
References: <20240729223431.1307306-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729223431.1307306-1-pvorel@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AE2DE21A92
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] cachestat01: Reduce required space on 64kb
 page size
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
> cachestat01.c:39: TINFO: Number of pages: 4096
> cachestat01.c:56: TPASS: cachestat(fd, cs_range, cs, 0) passed
> cachestat01.c:59: TPASS: cs->nr_cache + cs->nr_evicted == num_pages (4096)
> cachestat01.c:38: TINFO: Disable file synchronization
> cachestat01.c:39: TINFO: Number of pages: 8192
> cachestat01.c:46: TBROK: write(3,0x1000ddb0aa0,65536) failed: ENOSPC (28)
> 
> Fixes: 93b28ee69d ("Add cachestat01 test")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> First I thought we should use tst_fs_has_free() in each
> test_cached_pages() run, but test uses .all_filesystems, thus it's
> always 300 MB. Should we, just in case, use .dev_min_size = 300,
> to make sure it runs correctly even we change the DEV_SIZE_MB value?
> 
> Or, should we really calculate required space with tst_fs_has_free(),
> based on page size num_pages and * 1.1 (reserved space for metadata)?

Hmm, I guess that we should calculate how many pages are going to fit
into the filesystem and cap it on a sane number as well, so that the
test runs for a reasonable time if user passed a real and big block
device, so something as:

num_pages = MIN(tst_device->size/(2*page_size), 15);

>  testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
> index f7f6275cbd..edb6335d9e 100644
> --- a/testcases/kernel/syscalls/cachestat/cachestat01.c
> +++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
> @@ -67,7 +67,7 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
>  
>  static void run(unsigned int use_sync)
>  {
> -	for (int i = 0; i < 15; i++)
> +	for (int i = 0; i < page_size > 4096 ? 13 : 15; i++)

Uff, this is starting to look like perl...

>  		test_cached_pages(use_sync, 1 << i);
>  }
>  
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
