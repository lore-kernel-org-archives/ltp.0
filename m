Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7393BC25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 09:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83E033D0B90
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 11:55:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82C4C3CE77C
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 11:54:45 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7975960346E
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 11:54:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EEC9B336AA;
 Tue, 11 Jun 2024 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718099683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TfuhAGlZjpRQ/rb7v9hxI2G09KhGOQ0OuTMFJx4+hEo=;
 b=Ey6EZPFhNqswNX5JGYL4di3bUSqEpTe7iyt3IE7+Urvm/fxL7+PzsCRPUjaBDm6e94BsIH
 FJPkrYaLSWIddDWqH+oQADVQPcp7HhM7Up6u22Zv5gZ+IhrlqfJMG46Lfj8CV/GzUpTmdR
 NSHk1YesnCUbI+eme3acaRs29fgSOAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718099683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TfuhAGlZjpRQ/rb7v9hxI2G09KhGOQ0OuTMFJx4+hEo=;
 b=b1q/pv223F3RMVA87yo2rtp8U3xPOYNUfIjkxDJgBYdCJjqRkMwXQc1C3eENuB1oNa0pdt
 cGprknwY5+HdNbAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kcVZmV1D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DpuXdqBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718099682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TfuhAGlZjpRQ/rb7v9hxI2G09KhGOQ0OuTMFJx4+hEo=;
 b=kcVZmV1DgZo/4ySCK0MyGf46IgzHah/1loIij0E3AwrfQacPR1iAYn8+yqJKzDnP5dZOas
 m9y0Cxfr7QlCxk260j8rwU/gXLJ/y4BwURiyCUd9TBbnU1EQYHIsc2H+OIIKMURqw9OLWv
 YiJ3ljdJ9SwkD4/h8kEuwagr0ZN2Bk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718099682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TfuhAGlZjpRQ/rb7v9hxI2G09KhGOQ0OuTMFJx4+hEo=;
 b=DpuXdqBsTRwn1To4REWhByduzo57NMsoeEvMfj/sX5oydVvSJM1n74Q63Enp6StvdOOrTA
 NuRjvjAegJn7RUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E39BD13A55;
 Tue, 11 Jun 2024 09:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Oo9IN+EeaGaSewAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 11 Jun 2024 09:54:41 +0000
Message-ID: <85b362c0-9126-45cb-90af-9fe09b848661@suse.cz>
Date: Tue, 11 Jun 2024 11:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20240603123455.7968-1-chrubis@suse.cz>
 <20240603123455.7968-2-chrubis@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240603123455.7968-2-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EEC9B336AA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
a design note below.

On 03. 06. 24 14:34, Cyril Hrubis wrote:
> This commit does:
> 
> * Group the filesystem type, mkfs and mount options into a separate
>    structure
> 
> * Add an array of these structures to be able to define per filesystem
>    mkfs and mount options
> 
> The details on the usage should be hopefully clear from the
> documentation comments for the struct tst_test.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   include/tst_test.h                            | 64 ++++++++++------
>   lib/tst_test.c                                | 73 +++++++++++++------
>   .../kernel/syscalls/fanotify/fanotify22.c     |  4 +-
>   .../kernel/syscalls/fanotify/fanotify23.c     |  4 +-
>   .../kernel/syscalls/getxattr/getxattr04.c     |  4 +-
>   testcases/kernel/syscalls/ioctl/ioctl08.c     |  4 +-
>   testcases/kernel/syscalls/mmap/mmap16.c       | 19 ++---
>   .../kernel/syscalls/quotactl/quotactl01.c     |  6 +-
>   .../kernel/syscalls/quotactl/quotactl02.c     |  6 +-
>   .../kernel/syscalls/quotactl/quotactl03.c     |  6 +-
>   .../kernel/syscalls/quotactl/quotactl04.c     |  4 +-
>   .../kernel/syscalls/quotactl/quotactl05.c     |  6 +-
>   .../kernel/syscalls/quotactl/quotactl06.c     |  6 +-
>   .../kernel/syscalls/quotactl/quotactl07.c     |  4 +-
>   .../kernel/syscalls/quotactl/quotactl08.c     |  4 +-
>   .../kernel/syscalls/quotactl/quotactl09.c     |  6 +-
>   testcases/kernel/syscalls/statx/statx05.c     |  4 +-
>   testcases/kernel/syscalls/statx/statx06.c     |  8 +-
>   testcases/kernel/syscalls/statx/statx07.c     |  4 +-
>   testcases/kernel/syscalls/statx/statx09.c     |  4 +-
>   20 files changed, 157 insertions(+), 83 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 8dc20d110..6ac11f7d8 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -247,6 +247,36 @@ struct tst_ulimit_val {
>   	rlim_t rlim_cur;
>   };
>   
> +/**
> + * struct tst_fs - A file system type, mkfs and mount options
> + *
> + * @fs_type A filesystem type to use.
> + *
> + * @mkfs_opts: A NULL terminated array of options passed to mkfs in the case
> + *             of 'tst_test.format_device'. These options are passed to mkfs
> + *             before the device path.
> + *
> + * @mkfs_size_opt: An option passed to mkfs in the case of
> + *                 'tst_test.format_device'. The device size in blocks is
> + *                 passed to mkfs after the device path and can be used to
> + *                 limit the file system not to use the whole block device.
> + *
> + * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
> + *             device in the case of 'tst_test.mount_device'.
> + *
> + * @mnt_data: The data passed to mount(2) when the test library mounts a device
> + *            in the case of 'tst_test.mount_device'.
> + */
> +struct tst_fs {
> +	const char *type;
> +
> +	const char *const *mkfs_opts;
> +	const char *mkfs_size_opt;
> +
> +	const unsigned int mnt_flags;
> +	const void *mnt_data;
> +};
> +
>   /**
>    * struct tst_test - A test description.
>    *
> @@ -377,29 +407,21 @@ struct tst_ulimit_val {
>    *
>    * @dev_min_size: A minimal device size in megabytes.
>    *
> - * @dev_fs_type: If set overrides the default file system type for the device and
> - *               sets the tst_device.fs_type.
> + * @fs: If fs.type is set it overrides the default file system type for the
> + *      device. The rest of the parameters describe default parameters for
> + *      mkfs and mount.
>    *
> - * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
> - *               of 'tst_test.format_device'. These options are passed to mkfs
> - *               before the device path.
> - *
> - * @dev_extra_opts: A NULL terminated array of extra options passed to mkfs in
> - *                  the case of 'tst_test.format_device'. Extra options are
> - *                  passed to mkfs after the device path. Commonly the option
> - *                  after mkfs is the number of blocks and can be used to limit
> - *                  the file system not to use the whole block device.
> + * @fss: A NULL type terminated array of per file system type options. If
> + *       tst_test.all_filesystems is not set the array describes a list of
> + *       file systems to test along with parameters to pass to mkfs and mount.
> + *       If tst_test.all_filesystems is set the mkfs and mount options are
> + *       taken from tst_test.fs unless there is an override for a given
> + *       file system type defined in this array.

I like the general idea but I don't see the point of having separate .fs 
and .fss. You could simply use .fss[0] for the same purpose as .fs.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
