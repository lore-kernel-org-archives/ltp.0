Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDCAC54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 09:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC0723CC7B9
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:45:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4868A3CC7A7
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:45:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FBA71000662
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:45:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0BB208DD;
 Wed, 21 May 2025 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747820739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bz0FiYkdq05yTDqAkUQS/drldALoBjYmN+DPkeeweO4=;
 b=YcSkyJrjy3/KRWiYhUOU4x9gfq8gL1q+YVpg7zo68DEVMFR4gxWu1J3+Bd2JkbMOz4sDay
 KkgFuNdg8np+L2Qid15Iw1se1aqQXJosxV+6FFWIOHSOYmhF/S7cwstyxZdpwRv6mGH1Em
 V4wKfNUAkc9lN9UWcCX8Wxhl5frmu0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747820739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bz0FiYkdq05yTDqAkUQS/drldALoBjYmN+DPkeeweO4=;
 b=qpxbwFJFxXLJxZViixiE810zkq8rt5ySSHqQ7lO+mMjbi7GdM3wluzlbeQL0JFg6cl7K0O
 so9O+dEUc2KC8qCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YcSkyJrj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qpxbwFJF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747820739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bz0FiYkdq05yTDqAkUQS/drldALoBjYmN+DPkeeweO4=;
 b=YcSkyJrjy3/KRWiYhUOU4x9gfq8gL1q+YVpg7zo68DEVMFR4gxWu1J3+Bd2JkbMOz4sDay
 KkgFuNdg8np+L2Qid15Iw1se1aqQXJosxV+6FFWIOHSOYmhF/S7cwstyxZdpwRv6mGH1Em
 V4wKfNUAkc9lN9UWcCX8Wxhl5frmu0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747820739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bz0FiYkdq05yTDqAkUQS/drldALoBjYmN+DPkeeweO4=;
 b=qpxbwFJFxXLJxZViixiE810zkq8rt5ySSHqQ7lO+mMjbi7GdM3wluzlbeQL0JFg6cl7K0O
 so9O+dEUc2KC8qCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7294C13888;
 Wed, 21 May 2025 09:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6e+0G8OgLWhzRAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 May 2025 09:45:39 +0000
Date: Wed, 21 May 2025 11:45:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aC2gu5sCY8cc2PPL@rei>
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-3-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250513165640.185122-3-japo@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7F0BB208DD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 2/2] statmount06.c: Fix incorrect fs_type
 assumption NTFS->FUSEBLK
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
> The test incorrectly assumed that a volume mounted with "fuseblk" would report
> its fs_type as "ntfs" via statmount, which contradicts the actual mount options
> used and the resulting fs_type "fuseblk".
> 
> Old behavior:
> 
> 	sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount06
> 	...
> 	statmount06.c:42: TFAIL: st_mount->str + st_mount->fs_type (fuseblk) != tst_device->fs_type (ntfs)
> 	...

This may be a bug in the LTP_SINGLE_FS_TYPE, because the test has
.skip_filesystems = {"fuse", NULL} in the tst_test structure, which
means that the test is not supposed to run on fuse.

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/statmount/statmount06.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
> index fe41d5b87e7f..dedf9bba14f9 100644
> --- a/testcases/kernel/syscalls/statmount/statmount06.c
> +++ b/testcases/kernel/syscalls/statmount/statmount06.c
> @@ -28,6 +28,8 @@ static struct statmount *st_mount;
>  
>  static void run(void)
>  {
> +	const char *expected_fs_type;
> +
>  	memset(st_mount, 0, SM_SIZE);
>  
>  	TST_EXP_PASS(statmount(root_id,	STATMOUNT_FS_TYPE, st_mount,
> @@ -37,7 +39,11 @@ static void run(void)
>  		return;
>  
>  	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
> -	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, tst_device->fs_type);
> +	if (!strcmp(tst_device->fs_type, "ntfs"))
> +		expected_fs_type = "fuseblk";
> +	else
> +		expected_fs_type = tst_device->fs_type;
> +	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, expected_fs_type);

And this does not really work, since there is in-kernel ntfs driver as
well and in newer kernels it has supposedly read-write support too.

I guess that if we wanted to enable the test on fuse, we would have to
base this on check if the fs has been mounted by fuse. Maybe we need a
tst_is_fuse() function that would possibly parse /proc/mount or
something along that way.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
