Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD98C6FD18
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 11:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45C443CD0FB
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 13:59:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D7BA3CA32A
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 13:59:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B31551400BD5
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 13:59:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7505E219D6;
 Wed, 29 Mar 2023 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1680091139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t3rZQ001Z6yqTw3ixumPuW6yMwnyJRyAPImEQKtQE5w=;
 b=Qqqxr6hm+S4ZtbRAbN68yP7HGxq2kqbScSNxmiTOU3Q5GZZaYooOHwwZ6PIjkXJp23Str1
 Q3OBjfG7U/U7gU9dP9Qm0fddrURELEBbmCl+CpcSCHPxCo0q1a33SnBQ2SusP+OX49c9U9
 5tnVyXfULVElazB5lKNXjmbPVlj77A0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D6E8138FF;
 Wed, 29 Mar 2023 11:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gPZSOAEoJGRiXwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 29 Mar 2023 11:58:57 +0000
Date: Wed, 29 Mar 2023 07:58:50 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230329115850.GA28443@localhost>
References: <20230328144031.791212-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230328144031.791212-1-pvorel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 28, 2023 at 04:40:31PM +0200, Petr Vorel wrote:
> fsconfig03 is broken not only on vfat and ntfs, but also over FUSE:
> 
> tst_supported_fs_types.c:120: TINFO: FUSE does support exfat

I have a question on function has_kernel_support.

If has_kernel_support start check exfat file system, if exfat not exist then start
check fuse, i have no idea why we still need check fuse, i suppose directly
return "exfat not support" instead of "FUSE does support exfat".

static enum tst_fs_impl has_kernel_support(const char *fs_type)
{
...
        snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
        if (!mkdtemp(template))
                tst_brk(TBROK | TERRNO, "mkdtemp(%s) failed", template);

        ret = mount("/dev/zero", template, fs_type, 0, NULL);
        if ((ret && errno != ENODEV) || !ret) {
                if (!ret)
                        tst_umount(template);
                tst_res(TINFO, "Kernel supports %s", fs_type);
                SAFE_RMDIR(template);
                return TST_FS_KERNEL;
        }

        SAFE_RMDIR(template);

        /* Is FUSE supported by kernel? */  /////////start check fuse???
        if (fuse_supported == -1) {
                ret = open("/dev/fuse", O_RDWR);
                if (ret < 0) {
                        fuse_supported = 0;
                } else {
                        fuse_supported = 1;
                        SAFE_CLOSE(ret);



> tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
> ...
> tst_test.c:1634: TINFO: === Testing on exfat ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
> fsconfig03.c:38: TBROK: fsopen() failed: ENODEV (19)
> 
> NOTE: it actually works on vfat which is not over FUSE:
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

I feel you can not skip fuse system since i found following list in LTP:
static const char *const fs_type_whitelist[] = {
        "ext2",
        "ext3",
        "ext4",
        "xfs",
        "btrfs",
        "vfat",
        "exfat",
        "ntfs",
        "tmpfs",
        NULL
};

>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "722d94847de29"},
>  		{"CVE", "2022-0185"},
> -- 
> 2.40.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
