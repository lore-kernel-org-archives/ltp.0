Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C2EC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5AB73C9978
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:04:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B04A93C080E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:03:54 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 968071400E78
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:03:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 545D522221;
 Mon, 22 Jan 2024 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705914231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DpKNJuIoGPczK5Pgu9PFMaxU/N88xcYaKuasVJLOwZE=;
 b=bhtune/LHXCfIVwVxJl86jR7AnLRmqxIZqtYmAwz9yTqlPY8jCrCAOqML2n1Mrh9CJBU4G
 SK9J7Knl++7yPQosY8Xh4NqtgOjpM9JnnMwnahs3OzpiWvufxmcNR/X8ueQLe5SmEbQ7wZ
 gh80Px5ZeafkGvqsAImpKRMrUPSwwUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705914231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DpKNJuIoGPczK5Pgu9PFMaxU/N88xcYaKuasVJLOwZE=;
 b=6HTTdnzlqCr2xJs8iZ3G3kuFFOzKCtN6A0UKV6TnUjybPNb1SINBNTSFlesu9bDFDs42l+
 hZu3Sgrd9W0aMbBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705914231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DpKNJuIoGPczK5Pgu9PFMaxU/N88xcYaKuasVJLOwZE=;
 b=bhtune/LHXCfIVwVxJl86jR7AnLRmqxIZqtYmAwz9yTqlPY8jCrCAOqML2n1Mrh9CJBU4G
 SK9J7Knl++7yPQosY8Xh4NqtgOjpM9JnnMwnahs3OzpiWvufxmcNR/X8ueQLe5SmEbQ7wZ
 gh80Px5ZeafkGvqsAImpKRMrUPSwwUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705914231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DpKNJuIoGPczK5Pgu9PFMaxU/N88xcYaKuasVJLOwZE=;
 b=6HTTdnzlqCr2xJs8iZ3G3kuFFOzKCtN6A0UKV6TnUjybPNb1SINBNTSFlesu9bDFDs42l+
 hZu3Sgrd9W0aMbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E80413995;
 Mon, 22 Jan 2024 09:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZAk7BncvrmUDaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 09:03:51 +0000
Date: Mon, 22 Jan 2024 10:03:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122090349.GD76754@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240122072948.2568801-1-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bhtune/L";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6HTTdnzl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 545D522221
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril,

> This introduce an enhancement to the library's is_swap_supported
> function to check for filesystem compatibility before attempting
> to create and enable a swap file.  A list of supported filesystems
> is added (ext2, ext3, ext4, xfs, vfat, exfat, ntfs), and a check
> against this list is performed to ensure that the swap operations
> are only attempted on known compatible filesystems.

> If the make_swapfile function fails, the error handling is now
> more descriptive: it distinguishes between failures due to the
> filesystem not supporting swap files and other types of failures.
> Similarly, when attempting to enable the swap file with swapon,
> the patch ensures that clearer error messages are provided in
> cases where the operation is not supported by the filesystem.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  libs/libltpswap/libswap.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)

> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 13610709e..623f2fb3c 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -12,6 +12,17 @@
>  #include "libswap.h"
>  #include "lapi/syscalls.h"

> +static const char *const swap_supported_fs[] = {
> +	"ext2",
> +	"ext3",
> +	"ext4",
> +	"xfs",
> +	"vfat",
> +	"exfat",
> +	"ntfs",
> +	NULL
> +};
> +
>  /*
>   * Make a swap file
>   */
> @@ -40,23 +51,31 @@ int make_swapfile(const char *swapfile, int safe)
>   */
>  void is_swap_supported(const char *filename)
>  {
> +	int i, sw_support = 0;
>  	int fibmap = tst_fibmap(filename);
Just a note unrelated to this patchset. When testing on SLES kernel based on
5.3.18 we still get TCONF due missing FIBMAP ioctl support:

tst_test.c:1669: TINFO: === Testing on btrfs ===
tst_test.c:1118: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1132: TINFO: Mounting /dev/loop0 to /tmp/LTP_swazaqF1L/mntpoint fstyp=btrfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:45: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01

libswap.c:114: TCONF: Swapfile on btrfs not implemented

Am I wrong or could it be solved with FIEMAP (<linux/fiemap.h>)?
If yes, I wonder if we should fallback on btrfs when FIBMAP is missing

https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt
https://unix.stackexchange.com/questions/623859/how-do-you-find-the-physical-offset-for-a-file-in-btrfs

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
