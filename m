Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A384C54E65
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 17:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F8223CC893
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:31:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F2833C68A4
 for <ltp@lists.linux.it>; Thu, 22 May 2025 19:31:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1DA4660055F
 for <ltp@lists.linux.it>; Thu, 22 May 2025 19:31:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1DF9218DF;
 Thu, 22 May 2025 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747935078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOwaTRLivHC0XYlb5L6QzSzGS1KHmCqhDth+b41xBvE=;
 b=LXrwdN4rEv2cLiynxtlK4NfXUBcmU0f05MFoypVe23A83We392A07C5ykcYLNBsJdOTvwZ
 cL/H42t4tOpXQoWO3gy7q7uMN2Iie4tIgWoObI2Q88CUkteYQgu2CaNMnpRIohsXXdhQ8e
 O2tDoscEfXED81RkjyAcXkDMsIZgTXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747935078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOwaTRLivHC0XYlb5L6QzSzGS1KHmCqhDth+b41xBvE=;
 b=4eDfabc1YWSoQRcm8v06CT3EJpt533Y8BgmorS9/k1CKMZ0lal32zKidY3bVTtiKdDZaPi
 SoBkF55XmHiPyJCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747935078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOwaTRLivHC0XYlb5L6QzSzGS1KHmCqhDth+b41xBvE=;
 b=LXrwdN4rEv2cLiynxtlK4NfXUBcmU0f05MFoypVe23A83We392A07C5ykcYLNBsJdOTvwZ
 cL/H42t4tOpXQoWO3gy7q7uMN2Iie4tIgWoObI2Q88CUkteYQgu2CaNMnpRIohsXXdhQ8e
 O2tDoscEfXED81RkjyAcXkDMsIZgTXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747935078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOwaTRLivHC0XYlb5L6QzSzGS1KHmCqhDth+b41xBvE=;
 b=4eDfabc1YWSoQRcm8v06CT3EJpt533Y8BgmorS9/k1CKMZ0lal32zKidY3bVTtiKdDZaPi
 SoBkF55XmHiPyJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFD7813433;
 Thu, 22 May 2025 17:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lBcGFWVfL2hgSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 17:31:17 +0000
Date: Thu, 22 May 2025 19:31:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250522173111.GA19708@pevik>
References: <20250521095302.13845-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250521095302.13845-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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

Hi Cyril, Jan, all,

> The case of LTP_SINGLE_FS_TYPE did not proplerly used the fuse
> filesystem blacklist and we enabled fuse filesystem even for tests that
> explicitly stated in the tst_test structure that they do not work with
> fuse.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jan Polensky <japo@linux.ibm.com>
> ---
>  lib/tst_supported_fs_types.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index bbbb8df19..3a394283c 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -158,8 +158,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
>  	only_fs = getenv("LTP_SINGLE_FS_TYPE");

>  	if (only_fs) {
> +		enum tst_fs_impl ret;
>  		tst_res(TINFO, "WARNING: testing only %s", only_fs);
> -		if (tst_fs_is_supported(only_fs))
> +		ret = tst_fs_is_supported(only_fs);
> +		if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
>  			fs_types[0] = only_fs;

Is it really good thing to do?
Because LTP_SINGLE_FS_TYPE forces whatever filesystems, it ignores
.skip_filesystems. E.g. creat09.c don't want to be tested on ntfs (and others
but we can force it):

	.skip_filesystems = (const char*[]) {
		"exfat",
		"ntfs",
		"vfat",
		NULL
	},

# LTP_SINGLE_FS_TYPE=ntfs ./creat09
...
tst_supported_fs_types.c:162: TINFO: WARNING: testing only ntfs
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_test.c:1887: TINFO: === Testing on ntfs ===
tst_test.c:1216: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1228: TINFO: Mounting /dev/loop0 to /tmp/LTP_creI1VfeG/mntpoint fstyp=ntfs flags=0
tst_test.c:1228: TINFO: Trying FUSE...
creat09.c:71: TINFO: User nobody: uid = 65534, gid = 65534
creat09.c:73: TINFO: Found unused GID 11: SUCCESS (0)
creat09.c:82: TBROK: mntpoint/testdir: Setgid bit not set

If I add "fuse" among .skip_filesystems (NOTE: ntfs on SUT is fuse implementation),
with this patch it gets skipped:

# LTP_SINGLE_FS_TYPE=ntfs ./creat09_skip_fuse
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_creMF902Y as tmpdir (tmpfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1952: TINFO: LTP version: 20250130-274-g62559c3849
tst_test.c:1955: TINFO: Tested kernel: 6.12.20-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.20-1 (2025-03-23) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.12.20-amd64'
tst_test.c:1773: TINFO: Overall timeout per run is 0h 00m 31s
tst_supported_fs_types.c:162: TINFO: WARNING: testing only ntfs
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_test.c:1916: TCONF: There are no supported filesystems

That's inconsistency.

Could we clearly define what we expect from LTP_SINGLE_FS_TYPE?
FYI I put links to the discussion in the ticket
https://github.com/linux-test-project/ltp/issues/1242

I understand the wish to use LTP_SINGLE_FS_TYPE for a proper testing.  If that
requires to respect .skip_filesystems, but
1) it should be done for all filesystems
2) we should have another variable to allow to force the user defined
filesystem, e.g.
LTP_SINGLE_FS_TYPE=ntfs LTP_SINGLE_FS_TYPE_FORCE_FS=1

Kind regards,
Petr

>  		return fs_types;
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
