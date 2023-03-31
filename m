Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8388C76196
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 15:35:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AD3A3CC97E
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 17:35:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AADB3CC95F
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 17:34:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 52F901A00FBC
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 17:34:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC3351FD87;
 Fri, 31 Mar 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1680276895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY7aObhdu2NBeaqcrBa+Ex7mzXV789lezbC7Sy3osj0=;
 b=HNCqsYsXWC+Vqxr+ufWsMXx2r4ydPsHDQI6UQ9UUn0dLgfDXdridqtJM7mDtBW/sg5Eb5r
 UxTgQ3FVWKKtcB403QzourWoKJhxOSHLmmV/HeipAWiE4vobM17RvWLDUCm7ZBjbEhzE5Y
 LrNVbyPbwxkMN/I29aX9l+KlSvdb4sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1680276895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY7aObhdu2NBeaqcrBa+Ex7mzXV789lezbC7Sy3osj0=;
 b=Ib0kTIkViKVYkkcbZcOxG4oQIVKvh4E9MRyqbTTIXwD8Phhl0A7JhSg9UG/yepql+YsXDB
 Ves522W0j9uUOIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68C10133B6;
 Fri, 31 Mar 2023 15:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uPZxD5/9JmTFDQAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 31 Mar 2023 15:34:55 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Mar 2023 21:04:53 +0530
Message-ID: <2956694.zlGccA3lKM@localhost>
Organization: SUSE
In-Reply-To: <20230328144031.791212-1-pvorel@suse.cz>
References: <20230328144031.791212-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsconfig03: Skip on FUSE
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

Hi Petr,

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Tested-by: Avinesh Kumar <akumar@suse.de>

On Tuesday, March 28, 2023 8:10:31 PM IST Petr Vorel wrote:
> fsconfig03 is broken not only on vfat and ntfs, but also over FUSE:
> 
> tst_supported_fs_types.c:120: TINFO: FUSE does support exfat
> tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
> ...
> tst_test.c:1634: TINFO: === Testing on exfat ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
> fsconfig03.c:38: TBROK: fsopen() failed: ENODEV (19)
I could also reproduce this failure when running FUSE implementation of exfat.
And tested the patch which takes care of it.
> 
> NOTE: it actually works on vfat which is not over FUSE:
Yes, test works fine on vfat.

> tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
> tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
> ...
> tst_test.c:1634: TINFO: === Testing on vfat ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> fsconfig03.c:72: TPASS: kernel seems to be fine on vfat
> 
> Reported-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Verifying NTFS as kernel module (I'd be surprised if it was not
> working). The setup is the same as for fsconfig01.c (fsconfig02.c is for
> expected errors, thus has less strict requirements).
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/fsconfig/fsconfig03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> index e891c9f98..0ba5355d3 100644
> --- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -88,7 +88,7 @@ static struct tst_test test = {
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
>  	.taint_check = TST_TAINT_W | TST_TAINT_D,
> -	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
> +	.skip_filesystems = (const char *const []){"fuse", NULL},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "722d94847de29"},
>  		{"CVE", "2022-0185"},
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
