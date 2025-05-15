Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E5AC2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 19:48:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8228B3CC546
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 21:48:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CAF53C26B6
 for <ltp@lists.linux.it>; Thu, 15 May 2025 21:48:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 644CE6009D7
 for <ltp@lists.linux.it>; Thu, 15 May 2025 21:48:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C71201F812;
 Thu, 15 May 2025 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747338513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtEx1vYj8KskmU0Ac5nwGV+MS5BHidfvNNKgWhyT4co=;
 b=icxazPXZoji6B7koDK+32Kf8YxSbOWHtKnmQvwxci5VW4BHhNGeCtTyDDcLAMqx5XTwD7w
 SFqrSpT2Lc7kO629EcAyz89vU02aXvgwmztaO4DFA/KVd0dr3KblCEQezclDTecJw9xPoS
 XTgOnax1qx8EJZOogWrmJPcVbjuyzPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747338513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtEx1vYj8KskmU0Ac5nwGV+MS5BHidfvNNKgWhyT4co=;
 b=SZMr2p8aoQ4Vgmmg7/mPtxZ9n5IxdDyns4z5ekGz8SnPYnGFBbUklVqGXo6575ujiU8alw
 pYAlZIhxU3A66ICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747338513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtEx1vYj8KskmU0Ac5nwGV+MS5BHidfvNNKgWhyT4co=;
 b=icxazPXZoji6B7koDK+32Kf8YxSbOWHtKnmQvwxci5VW4BHhNGeCtTyDDcLAMqx5XTwD7w
 SFqrSpT2Lc7kO629EcAyz89vU02aXvgwmztaO4DFA/KVd0dr3KblCEQezclDTecJw9xPoS
 XTgOnax1qx8EJZOogWrmJPcVbjuyzPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747338513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtEx1vYj8KskmU0Ac5nwGV+MS5BHidfvNNKgWhyT4co=;
 b=SZMr2p8aoQ4Vgmmg7/mPtxZ9n5IxdDyns4z5ekGz8SnPYnGFBbUklVqGXo6575ujiU8alw
 pYAlZIhxU3A66ICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F28139D0;
 Thu, 15 May 2025 19:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fNGUARFFJmg5DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 19:48:33 +0000
Date: Thu, 15 May 2025 21:48:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20250515194826.GB501284@pevik>
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-2-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250513165640.185122-2-japo@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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

Hi Jan,

> The test incorrectly assumes that NTFS mounts are read-only, but the mount
> command does not explicitly set the read-only flag. As a result, the test fails
> when checking `sb_flags` against `MS_RDONLY`.

> Old behavior:

Reviewed-by: Petr Vorel <pvorel@suse.cz>
IMHO candidate for a release. Li, Cyril WDYT?

> 	sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount02
FYI the problem is currently LTP_SINGLE_FS_TYPE is still meant only for testing
one of the filesystems among .all_filesystems => these in fs_type_whitelist[]
(see lib/tst_supported_fs_types.c).

BTW that's similar to use case we haven't even formulated in issue:
https://lore.kernel.org/ltp/Z066Fj9VQVlTOMp_@rei.lan/
https://lore.kernel.org/ltp/Z1mA2wzjW0hpQxUH@yuki.lan/
(The only difference is that this requires to use filesystem not in
fs_type_whitelist[], therefore minor bug for it was found).

Kind regards,
Petr

> 	...
> 	statmount02.c:47: TFAIL: st_mount->sb_flags (0) != MS_RDONLY (1)
> 	...

> Relevant log excerpt:

> 	3890601 mount("/dev/zero", "/tmp/mountBDSEqk", "ntfs", 0, NULL) = -1 ENOTBLK (Block device required)
> 	3890608 mount("/dev/loop0", "/tmp/LTP_staTPRruR/mntpoint", "fuseblk", 0, "allow_other,blksize=4096,fd=4,rootmode=40000,user_id=0,group_id=0") = 0
> 	3890607 statmount({size=24, mnt_id=0x80010957, param=STATMOUNT_SB_BASIC}, {size=512, mask=STATMOUNT_SB_BASIC, sb_dev_major=7, sb_dev_minor=0, sb_magic=FUSE_SUPER_MAGIC, sb_flags=0}, 512, 0) = 0

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  lib/safe_macros.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 6946cc5bcb94..1270b17af8f4 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	 */
>  	if (possibly_fuse(filesystemtype)) {
>  		char buf[1024];
> +		const char* mount_fmt;

>  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> -			filesystemtype, source, target);
> +		if (!strcmp(filesystemtype, "ntfs") && mountflags & MS_RDONLY)
> +			mount_fmt = "mount.%s -o ro '%s' '%s'";
> +		else
> +			mount_fmt = "mount.%s '%s' '%s'";
> +		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
> +				source, target);

>  		rval = tst_system(buf);
>  		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
