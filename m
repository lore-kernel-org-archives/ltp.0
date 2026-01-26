Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B52D19501
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 16:42:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0F03C6F5E
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 17:42:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19233C00FE
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 17:41:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 410B11A0027B
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 17:41:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71D373376F;
 Mon, 26 Jan 2026 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769445695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3atoJg0JDEWGjtePr6NgE3PqurYdVtLBrj6cYpXiIM=;
 b=b6Jy6naEaDT2Kp8fZULq8sea/0NNQHmbadkKZiD9H/H1VvX+Wz0nhpwFG2vRxdbduFzO2q
 LwSGLcQmOKDuhvyS7VDzVDSTxQHmJzI/N4gv81z/1EYU0qprNZHGlC/G1S58lsNySLm48n
 Sk5DDTkGEi7ogwbIqJqRt5DSRZbw5X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769445695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3atoJg0JDEWGjtePr6NgE3PqurYdVtLBrj6cYpXiIM=;
 b=GiC7k2kq5mYwb6Zr56YsLsOK6ehHoQL/z4RxQ3hXzlF3fot/EZ5kWbmFbsqZ3OUyJmEFlh
 XY9sn+9uXHVK8KAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769445695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3atoJg0JDEWGjtePr6NgE3PqurYdVtLBrj6cYpXiIM=;
 b=b6Jy6naEaDT2Kp8fZULq8sea/0NNQHmbadkKZiD9H/H1VvX+Wz0nhpwFG2vRxdbduFzO2q
 LwSGLcQmOKDuhvyS7VDzVDSTxQHmJzI/N4gv81z/1EYU0qprNZHGlC/G1S58lsNySLm48n
 Sk5DDTkGEi7ogwbIqJqRt5DSRZbw5X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769445695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3atoJg0JDEWGjtePr6NgE3PqurYdVtLBrj6cYpXiIM=;
 b=GiC7k2kq5mYwb6Zr56YsLsOK6ehHoQL/z4RxQ3hXzlF3fot/EZ5kWbmFbsqZ3OUyJmEFlh
 XY9sn+9uXHVK8KAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 588F4139F0;
 Mon, 26 Jan 2026 16:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 82GpFD+Zd2lqJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Jan 2026 16:41:35 +0000
Date: Mon, 26 Jan 2026 17:42:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aXeZjiDcGjVp0u2G@yuki.lan>
References: <20260122171249.31590-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122171249.31590-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl_sg01: Allow using USB device again
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
> The failures when the ioctl_sg01 test tried to query a USB device
> turned out to be another data leak. Allow using USB devices again
> but keep the improved device lookup algorithm.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Tested on kernels v4.4 and v6.12.
> 
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 29 ++++++--------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index dada174e0..9862d7324 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -30,7 +30,7 @@
>  #include "tst_memutils.h"
>  
>  #define SYSDIR "/sys/block"
> -#define BLOCKDIR "/sys/block/%s/device"
> +#define BLOCKDIR "/sys/block/%s/device/generic"
>  
>  #define BUF_SIZE (128 * 4096)
>  #define CMD_SIZE 6
> @@ -41,14 +41,14 @@ static unsigned char command[CMD_SIZE];
>  static struct sg_io_hdr query;
>  
>  /* TODO: split this off to a separate SCSI library? */
> -static const char *find_generic_scsi_device(int access_flags, int skip_usb)
> +static const char *find_generic_scsi_device(int access_flags)
>  {
>  	DIR *sysdir;
>  	struct dirent *ent;
>  	int tmpfd;
>  	ssize_t length;
>  	char *filename;
> -	static char devpath[PATH_MAX], syspath[PATH_MAX];
> +	static char devpath[PATH_MAX], genpath[PATH_MAX];
>  
>  	sysdir = opendir(SYSDIR);
>  
> @@ -60,28 +60,15 @@ static const char *find_generic_scsi_device(int access_flags, int skip_usb)
>  		if (ent->d_name[0] == '.')
>  			continue;
>  
> -		snprintf(syspath, PATH_MAX, BLOCKDIR, ent->d_name);
> -		syspath[PATH_MAX - 1] = '\0';
> -
> -		/* Real device path matches the physical HW bus path */
> -		if (!realpath(syspath, devpath))
> -			continue;
> -
> -		strncat(devpath, "/generic", PATH_MAX - strlen(devpath) - 1);
> +		snprintf(devpath, PATH_MAX, BLOCKDIR, ent->d_name);
>  		devpath[PATH_MAX - 1] = '\0';
> -		length = readlink(devpath, syspath, PATH_MAX - 1);
> +		length = readlink(devpath, genpath, PATH_MAX - 1);
>  
>  		if (length < 0)
>  			continue;
>  
> -		syspath[length] = '\0';
> -		filename = basename(syspath);
> -
> -		/* USB devices often return HW info in SG_IO response buffer */
> -		if (skip_usb && strstr(devpath, "/usb")) {
> -			tst_res(TINFO, "Skipping USB device %s", filename);
> -			continue;
> -		}
> +		genpath[length] = '\0';
> +		filename = basename(genpath);
>  
>  		snprintf(devpath, PATH_MAX, "/dev/%s", filename);
>  		/* access() makes incorrect assumptions about block devices */
> @@ -121,7 +108,7 @@ static void dump_hex(const char *str, size_t size)

I just wonder, shouldn't we find all the devices on the system and
return array of strings? Or at least pick at least one device per
differet bus?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
