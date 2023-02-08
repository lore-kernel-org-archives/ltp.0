Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB2C05027
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 09:02:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07D753CC164
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:02:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD76B3CB0FC
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:01:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1CAD6008FE
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:01:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0CFB208DF;
 Wed,  8 Feb 2023 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675846912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ouVIbpPPXKRqxNOfJfeTIpVn/Jmfd0uliDyQoh7m+5Y=;
 b=oB/DdEJQDmb5IrHpvNr9xjEZ1OhkV07Fcal8P+HSo6Ki/WIE8h8lLkxWlKiaMQzEFbjIlj
 V/giX0vzIPhHnDQORsE8aaKkLIeOoiGGj3Ie9kNawqiwarJhJaLq6mhiGFH+pQHqu/XfjY
 iZo9BluP7eLgqNR58zTrDBEwHWI4RGg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B64213A1F;
 Wed,  8 Feb 2023 09:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EpuLNf9k42MlDgAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 08 Feb 2023 09:01:51 +0000
Date: Wed, 8 Feb 2023 04:01:48 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230208090148.GA8108@localhost>
References: <20230129115021.25778-1-wegao@suse.com> <Y9pf5075zsuAhznN@pevik>
 <Y+DYmkBnv/NQK8gZ@aa> <Y+Eoqd5+bWPxlpXD@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+Eoqd5+bWPxlpXD@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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

On Mon, Feb 06, 2023 at 05:19:53PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > > Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:
> 
> > > tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
> > > tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
> > > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > > mke2fs 1.46.5 (30-Dec-2021)
> > > fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)
> 
> > > Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
> > > used?
> 
> > I have not test on 6.2.0 kernel, i need reproduce this firstly.
> 
> FYI 6.0.6 is also broken, works on 5.10.46.
> 

After long investigation i finally get what's happen now since i have
never touch kernel fs code before :)

The root caused is cebe85d570cf8 which make udpate initialize of
ext3_fs_type.

Each file system will initialize a struct file_system_type and ext3 initialize 
in fs/ext4/super.c(maybe ext3 much same as ext4 so they put in same file).
This patch add new memeber .init_fs_context in ext3 file_system_type struct and 
this new member will lead pase function which called by fsconfig change
from legacy_parse_param to ext4_parse_param(this function will check
parameter and not allow 0x00)

===key change part of cebe85d570cf8===
 static struct file_system_type ext3_fs_type = {
-       .owner          = THIS_MODULE,
-       .name           = "ext3",
-       .mount          = ext4_mount,
-       .kill_sb        = kill_block_super,
-       .fs_flags       = FS_REQUIRES_DEV,
+       .owner                  = THIS_MODULE,
+       .name                   = "ext3",
+       .init_fs_context        = ext4_init_fs_context,  // in this patch init_fs_context start set ext4_init_fs_context
+       .parameters             = ext4_param_specs,
+       .kill_sb                = kill_block_super,
+       .fs_flags               = FS_REQUIRES_DEV,
 };
===key change part of cebe85d570cf8===


Following logic will decide whether use legacy_init_fs_context base on
exist of init_fs_context, obviously before patch we have no
init_fs_context but after patch we have it

==function alloc_fs_context== 
        .....
        init_fs_context = fc->fs_type->init_fs_context;
        if (!init_fs_context)
                init_fs_context = legacy_init_fs_context;  //before patch cebe85d570cf8, legacy_init_fs_context will be set.
        ret = init_fs_context(fc);

==function alloc_fs_context== 


====code example for set parse function used by fsconfig===
const struct fs_context_operations legacy_fs_context_ops = {
        .free                   = legacy_fs_context_free,
        .dup                    = legacy_fs_context_dup,
        .parse_param            = legacy_parse_param,   
        .parse_monolithic       = legacy_parse_monolithic,
        .get_tree               = legacy_get_tree,
        .reconfigure            = legacy_reconfigure,
};

/*
 * Initialise a legacy context for a filesystem that doesn't support
 * fs_context.
 */
static int legacy_init_fs_context(struct fs_context *fc)
{
        fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL_ACCOUNT);
        if (!fc->fs_private)
                return -ENOMEM;
        fc->ops = &legacy_fs_context_ops;
        return 0;
}
====code for set parse function used by fsconfig===


====final call parse function within fsconfig logic==
vfs_parse_fs_param
145             if (fc->ops->parse_param) {
146                     	ret = fc->ops->parse_param(fc, param); //this will call legacy_parse_param or ext4_parse_param                                   
147                     if (ret != -ENOPARAM)
148                             return ret;
149             }
====final call parse function within fsconfig logic==



Just FYI the fs_type real data show in GDB(init_fs_context= 0 in kernel5.x but in kernel 6.x init_fs_context=ext4_parse_param):

(gdb) p *fs_type
$4 = {name = 0xffffffff822278e1 "ext3", fs_flags = 1, init_fs_context = 0x0 <fixed_percpu_data>, parameters = 0x0 <fixed_percpu_data>,
  mount = 0xffffffff812ec510 <ext4_mount>, kill_sb = 0xffffffff811f7220 <kill_block_super>, owner = 0x0 <fixed_percpu_data>,
  next = 0xffffffff82564600 <ext2_fs_type>, fs_supers = {first = 0x0 <fixed_percpu_data>}, s_lock_key = {<No data fields>},
  s_umount_key = {<No data fields>}, s_vfs_rename_key = {<No data fields>}, s_writers_key = 0xffffffff825645e8, i_lock_key = {<No data fields>},
  i_mutex_key = {<No data fields>}, invalidate_lock_key = {<No data fields>}, i_mutex_dir_key = {<No data fields>}}


> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
