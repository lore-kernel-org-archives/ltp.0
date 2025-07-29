Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B4CC83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48A7B3CA535
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 12:20:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E6F3C9BE2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 12:19:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AFDC1400DE0
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 12:19:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 935C621A10;
 Tue, 29 Jul 2025 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753784385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vltcQjghInqBDSmdSIcojZtkXlLBUVE+3l4auRBN8=;
 b=xEIB+nzMOkgEdEwGnJ+LB8SBptwTcfG638a3WMIAjR0Ccj7Oix0xOx8jiIY18TrmXj869Q
 fJPbxojZBFdZma2LX+QuN3wmuo1QTwMXFma8u+fIHAogWkV7gidPv8tnI6PAUAzpnajZv8
 aWCKCoeoJo7NIFvBXFWs7Y8RtO1tKXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753784385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vltcQjghInqBDSmdSIcojZtkXlLBUVE+3l4auRBN8=;
 b=X1ySGDjMmPAi8TmscYNYAn0d+HiQBZemB/susdx+njqKxpKiTUcGfb/4ctaXI1A5pLkCYb
 9AsOr9o3bcNCLXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753784385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vltcQjghInqBDSmdSIcojZtkXlLBUVE+3l4auRBN8=;
 b=xEIB+nzMOkgEdEwGnJ+LB8SBptwTcfG638a3WMIAjR0Ccj7Oix0xOx8jiIY18TrmXj869Q
 fJPbxojZBFdZma2LX+QuN3wmuo1QTwMXFma8u+fIHAogWkV7gidPv8tnI6PAUAzpnajZv8
 aWCKCoeoJo7NIFvBXFWs7Y8RtO1tKXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753784385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vltcQjghInqBDSmdSIcojZtkXlLBUVE+3l4auRBN8=;
 b=X1ySGDjMmPAi8TmscYNYAn0d+HiQBZemB/susdx+njqKxpKiTUcGfb/4ctaXI1A5pLkCYb
 9AsOr9o3bcNCLXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8307A13A73;
 Tue, 29 Jul 2025 10:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qSnLH0GgiGh9YAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 29 Jul 2025 10:19:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue, 29 Jul 2025 12:19:45 +0200
Message-ID: <5005196.GXAFRqVoOG@thinkpad>
In-Reply-To: <20250727152454.682633-1-japo@linux.ibm.com>
References: <20250727152454.682633-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] safe_macros.c: Fix missing ro flag for
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>
nit: maybe the patch title also should not mention NTFS.

-
Avinesh

On Sunday, July 27, 2025 5:24:54 PM CEST Jan Polensky wrote:
> The test incorrectly assumes that NTFS mounts are read-only, but the mount
> command does not explicitly set the read-only flag. As a result, the test fails
> when checking `sb_flags` against `MS_RDONLY`.
> 
> Old behavior:
> 
>     sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount02
>     ...
>     statmount02.c:47: TFAIL: st_mount->sb_flags (0) != MS_RDONLY (1)
>     ...
> 
> Relevant log excerpt:
> 
>     3890601 mount("/dev/zero", "/tmp/mountBDSEqk", "ntfs", 0, NULL) = -1 ENOTBLK (Block device required)
>     3890608 mount("/dev/loop0", "/tmp/LTP_staTPRruR/mntpoint", "fuseblk", 0, "allow_other,blksize=4096,fd=4,rootmode=40000,user_id=0,group_id=0") = 0
>     3890607 statmount({size=24, mnt_id=0x80010957, param=STATMOUNT_SB_BASIC}, {size=512, mask=STATMOUNT_SB_BASIC, sb_dev_major=7, sb_dev_minor=0, sb_magic=FUSE_SUPER_MAGIC, sb_flags=0}, 512, 0) = 0
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
> Change since v1 (Thanks Cyril & thanks for the ping):
> * Removed restriction for NTFS.
> 
>  lib/safe_macros.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 6946cc5bcb94..be04eb455d57 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	 */
>  	if (possibly_fuse(filesystemtype)) {
>  		char buf[1024];
> +		const char* mount_fmt;
> 
>  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> -			filesystemtype, source, target);
> +		if (mountflags == MS_RDONLY)
> +			mount_fmt = "mount.%s -o ro '%s' '%s'";
> +		else
> +			mount_fmt = "mount.%s '%s' '%s'";
> +		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
> +				source, target);
> 
>  		rval = tst_system(buf);
>  		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
> --
> 2.50.1
> 
> 
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
