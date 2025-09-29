Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F072CAC5B0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 11:29:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57BA43CE1D6
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 13:29:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A02B3CAB73
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 13:29:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 92971140097E
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 13:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D7413183A;
 Mon, 29 Sep 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047B713782;
 Mon, 29 Sep 2025 11:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XA6LAKBt2mgmcAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 29 Sep 2025 11:29:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 29 Sep 2025 13:29:35 +0200
Message-ID: <2823256.mvXUDI8C0e@thinkpad>
In-Reply-To: <20250929110922.13506-1-mdoucha@suse.cz>
References: <20250929110922.13506-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1D7413183A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Reduce extent size block count
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

Hi,

On Monday, September 29, 2025 1:08:58 PM CEST Martin Doucha wrote:
> Reduce test extent size to 128 blocks. Otherwise the FS_IOC_FSSETXATTR
> ioctl may exceed extent size limit and fail on archs with 64K blocksize.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Avinesh Kumar <akumar@suse.de>
Tested-by: Avinesh Kumar <akumar@suse.de>

> ---
>  testcases/kernel/syscalls/file_attr/file_attr02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
> index d0cb47696..f6625985a 100644
> --- a/testcases/kernel/syscalls/file_attr/file_attr02.c
> +++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
> @@ -15,7 +15,7 @@
>  
>  #define MNTPOINT "mntpoint"
>  #define FILENAME "ltp_file"
> -#define BLOCKS 1024
> +#define BLOCKS 128
>  #define PROJID 16
>  
>  static int fd = -1;
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
