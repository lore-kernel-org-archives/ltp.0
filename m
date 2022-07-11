Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0CCC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 12:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFEC83CA6FB
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 14:13:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 253933C6912
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 14:13:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11212200911
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 14:13:38 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 822B622863;
 Mon, 11 Jul 2022 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657541618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ag0oF3d8Tu1ZMq9I6Og9iroDaUVGEcykJtz2am08mjU=;
 b=qgQLplfRZlv0NwgiHOKxcaa5PTFgrh6jYGIeqgUDd53N1FB0+2ApTDeGqlwMdrKmuKOtoI
 +Dq5fCn8Ryz1EOGgFw9Kyg6pyAlTn2X4JEAoViKaHqsyAe6R9cIDa59TFbN2MZNxKLiVwq
 SamgSTazUNTtL59ExUzxwiCx6mBFG+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657541618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ag0oF3d8Tu1ZMq9I6Og9iroDaUVGEcykJtz2am08mjU=;
 b=+77td58fqvGvv4SBZuAeA4jVNSC4Yy8bH7U8qFE4TxvTP2DvzpEHcO7YTwgv8Q2/Yekh36
 OT7/JgJ2AsGfH1Ag==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4E73C2C141;
 Mon, 11 Jul 2022 12:13:38 +0000 (UTC)
References: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2022 13:05:21 +0100
In-reply-to: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
Message-ID: <87fsj7onim.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: fix logic in matching mount
 point
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> If backing dev is btrfs root device, then starting best_match_len
> from 1 creates an issue, because root (/) is never matched.
> Also we should check that entire mount point string is present in
> path we are matching against.
>
> In case there's error also dump /proc/self/mountinfo before tst_brk.
>
> This fixes test with following partition layout (TMPDIR is on /):
>   # cat /proc/self/mountinfo  | grep btrfs
>   59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=257,subvol=/root
>   93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/home
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_device.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index c34cbe6d1f56..414bf0eea816 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -506,12 +506,17 @@ unsigned long tst_dev_bytes_written(const char *dev)
>  	return dev_bytes_written;
>  }
>  
> -static int count_match_len(const char *first, const char *second)
> +static int str_starts_with(const char *str, const char *prefix)
>  {
>  	int len = 0;
>  
> -	while (*first && *first++ == *second++)
> +	while (*prefix) {
> +		if (!*str)
> +			return 0;
> +		if (*str++ != *prefix++)
> +			return 0;
>  		len++;
> +	}

I'm not sure this is better than the original. It's a seperate cleanup
in any case.

>  
>  	return len;
>  }
> @@ -524,7 +529,7 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	char *pre = NULL;
>  	char *next = NULL;
>  	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> -	unsigned int len, best_match_len = 1;
> +	unsigned int len, best_match_len = 0;
>  	char mnt_point[PATH_MAX];
>  
>  	if (stat(path, &buf) < 0)
> @@ -550,7 +555,7 @@ void tst_find_backing_dev(const char *path, char *dev)
>  			break;
>  		}
>  
> -		len = count_match_len(path, mnt_point);
> +		len = str_starts_with(path, mnt_point);
>  		if (len > best_match_len) {
>  			strcpy(dev, pre);
>  			best_match_len = len;
> @@ -559,8 +564,10 @@ void tst_find_backing_dev(const char *path, char *dev)
>  
>  	SAFE_FCLOSE(NULL, file);
>  
> -	if (!*dev)
> +	if (!*dev) {
> +		tst_system("cat /proc/self/mountinfo");
>  		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> +	}
>  
>  	if (stat(dev, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> -- 
> 2.27.0

Makes sense. However I suspect this function can be replaced with the
standard library method used in tst_stat_mount_dev. I didn't try this
before because I'm not sure why it scans mountinfo instead of mounts.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
