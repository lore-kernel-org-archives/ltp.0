Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A75CC636CC
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 02:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8D143CD0C5
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 03:25:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1643CC148
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 03:25:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4439E2000E8
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 03:25:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1129F3492F;
 Thu,  9 Feb 2023 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675909526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7A7jYpMq75tuz15a2LR0LZ/HTS05StJ9FhLa+fGxdak=;
 b=pKh747J0I+U9Kq1a0TArCp4PUHv4Wo3UbTUewvVF6iQR3JrgtDy8xZAhq0PcZ8ygnMWeCt
 sUgoYflWCkeOr95pYn2nnDOsfJVtNCR/W2AObJ93AG/zfB4J6fknwcVly8jxQwAVZ5Id97
 yJ6IL+xMaiMa1iLmokEfd6viF1TrcE4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EA3B133E0;
 Thu,  9 Feb 2023 02:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CYNFEpVZ5GOlHwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 09 Feb 2023 02:25:25 +0000
Date: Wed, 8 Feb 2023 21:25:22 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230209022522.GA10910@localhost>
References: <20230129115021.25778-1-wegao@suse.com> <Y9pf5075zsuAhznN@pevik>
 <Y+DYmkBnv/NQK8gZ@aa> <Y+Eoqd5+bWPxlpXD@pevik>
 <20230208090148.GA8108@localhost> <20230208154823.GD1918@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230208154823.GD1918@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On Wed, Feb 08, 2023 at 04:48:23PM +0100, Petr Vorel wrote:
> > On Mon, Feb 06, 2023 at 05:19:53PM +0100, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > ...
> > > > > Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:
> 
> > > > > tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
> > > > > tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
> > > > > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > > > > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > > > > mke2fs 1.46.5 (30-Dec-2021)
> > > > > fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)
> 
> > > > > Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
> > > > > used?
> 
> > > > I have not test on 6.2.0 kernel, i need reproduce this firstly.
> 
> > > FYI 6.0.6 is also broken, works on 5.10.46.
> 
> 
> > After long investigation i finally get what's happen now since i have
> > never touch kernel fs code before :)
> 
> > The root caused is cebe85d570cf8 which make udpate initialize of
> > ext3_fs_type.
> What exactly happen in cebe85d570cf ("ext4: switch to the new mount api")
> from v5.17-rc1? This enables fsconfig, thus test *should* be working on >=
> v5.17-rc1, right? But it does not.
> 

In my test case use "\x00" as fsconfig key parameter, this parameter ONLY
can be accept if kernel using legacy_parse_param. But cebe85d570cf8 make
a change lead kernel start using ext4_parse_param then error will happen
in your test in v5.17, it's normal behaviro.

So the correct behaviro are:
1)you will encounter crash if you running my ltp test case before v5.17. 
2)if you test from v5.17, the security fix 722d94847de29 together with
internal logic change cebe85d570cf8 both happen, and test case will
failed since cebe85d570cf8 change the whole logic and workaround the
security fix 722d94847de29(More detail please see below summary). 

Why 1) not happen now in your test env? 
Since currently my v1 patch has a mistake on loop i number, if you increase loop number i to
5000 then you will encounter crash on kernel before v5.17(ext2/3/4).

+       for (unsigned int i = 0; i < 2; i++) { <====increase this to i < 5000
+               TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
+               if (TST_RET == -1)
+                       tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
+       }



Let me explain more detail for this:

CVE-2022-0185 security bug popped up since 5.1-rc1 and fixed by 722d94847de29 in v5.17-rc1~50, so normally we should check build from v5.17.
Most important thing is this security issue ONLY happen if fsconfig go through legacy_parse_param function(security issue happen and fixed within this function).

But:
For xfs filesystem, from v5.5-rc1 already start use xfs_fs_parse_param instead of  legacy_parse_param, so make no sense check this secruity issue
For ext2&ext3&ext4, after patch cebe85d570cf8 in v5.17-rc1~131^2~36, use ext4_parse_param instead of legacy_parse_param, so also make no sense check 

In summary, we can reject this test case since from v5.17, ext2/ext4/xfs not go through legacy_parse_param and means we can not verify security fix 
722d94847de29(this fix happen in legacy_parse_param.)


Just FYI : fix bug patch which within legacy_parse_param
722d94847de29 (Jamie Hill-Daniel   2022-01-18 08:06:04 +0100 551)       if (size + len + 2 > PAGE_SIZE)
git describe --contains 722d94847de29
v5.17-rc1~50


> BTW xfs also uses new mount API 73e5fff98b64 ("xfs: switch to use the new
> mount-api") in v5.5-rc1.  Obviously legacy ext2 driver does not use it.
> 
> I'd expect fsopen_supported_by_kernel() is enough and no filesystem needs to be
> filtered out (at least not real linux filesystems like ext2 or xfs).
> 
> > Each file system will initialize a struct file_system_type and ext3 initialize 
> > in fs/ext4/super.c(maybe ext3 much same as ext4 so they put in same file).
> Yes, ext3 and ext4 share the same code (ext4 driver). This code also servers
> ext2 filesystem if CONFIG_EXT4_USE_FOR_EXT2=y (mostly the default), otherwise
> there is ext2 driver: CONFIG_EXT2_FS).
> 
> Kind regards,
> Petr
> 
> > This patch add new memeber .init_fs_context in ext3 file_system_type struct and 
> > this new member will lead pase function which called by fsconfig change
> > from legacy_parse_param to ext4_parse_param(this function will check
> > parameter and not allow 0x00)
> 
> > ===key change part of cebe85d570cf8===
> >  static struct file_system_type ext3_fs_type = {
> > -       .owner          = THIS_MODULE,
> > -       .name           = "ext3",
> > -       .mount          = ext4_mount,
> > -       .kill_sb        = kill_block_super,
> > -       .fs_flags       = FS_REQUIRES_DEV,
> > +       .owner                  = THIS_MODULE,
> > +       .name                   = "ext3",
> > +       .init_fs_context        = ext4_init_fs_context,  // in this patch init_fs_context start set ext4_init_fs_context
> > +       .parameters             = ext4_param_specs,
> > +       .kill_sb                = kill_block_super,
> > +       .fs_flags               = FS_REQUIRES_DEV,
> >  };
> > ===key change part of cebe85d570cf8===
> 
> 
> > Following logic will decide whether use legacy_init_fs_context base on
> > exist of init_fs_context, obviously before patch we have no
> > init_fs_context but after patch we have it
> 
> > ==function alloc_fs_context== 
> >         .....
> >         init_fs_context = fc->fs_type->init_fs_context;
> >         if (!init_fs_context)
> >                 init_fs_context = legacy_init_fs_context;  //before patch cebe85d570cf8, legacy_init_fs_context will be set.
> >         ret = init_fs_context(fc);
> 
> > ==function alloc_fs_context== 
> 
> 
> > ====code example for set parse function used by fsconfig===
> > const struct fs_context_operations legacy_fs_context_ops = {
> >         .free                   = legacy_fs_context_free,
> >         .dup                    = legacy_fs_context_dup,
> >         .parse_param            = legacy_parse_param,   
> >         .parse_monolithic       = legacy_parse_monolithic,
> >         .get_tree               = legacy_get_tree,
> >         .reconfigure            = legacy_reconfigure,
> > };
> 
> > /*
> >  * Initialise a legacy context for a filesystem that doesn't support
> >  * fs_context.
> >  */
> > static int legacy_init_fs_context(struct fs_context *fc)
> > {
> >         fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL_ACCOUNT);
> >         if (!fc->fs_private)
> >                 return -ENOMEM;
> >         fc->ops = &legacy_fs_context_ops;
> >         return 0;
> > }
> > ====code for set parse function used by fsconfig===
> 
> 
> > ====final call parse function within fsconfig logic==
> > vfs_parse_fs_param
> > 145             if (fc->ops->parse_param) {
> > 146                     	ret = fc->ops->parse_param(fc, param); //this will call legacy_parse_param or ext4_parse_param                                   
> > 147                     if (ret != -ENOPARAM)
> > 148                             return ret;
> > 149             }
> > ====final call parse function within fsconfig logic==
> 
> 
> 
> > Just FYI the fs_type real data show in GDB(init_fs_context= 0 in kernel5.x but in kernel 6.x init_fs_context=ext4_parse_param):
> 
> > (gdb) p *fs_type
> > $4 = {name = 0xffffffff822278e1 "ext3", fs_flags = 1, init_fs_context = 0x0 <fixed_percpu_data>, parameters = 0x0 <fixed_percpu_data>,
> >   mount = 0xffffffff812ec510 <ext4_mount>, kill_sb = 0xffffffff811f7220 <kill_block_super>, owner = 0x0 <fixed_percpu_data>,
> >   next = 0xffffffff82564600 <ext2_fs_type>, fs_supers = {first = 0x0 <fixed_percpu_data>}, s_lock_key = {<No data fields>},
> >   s_umount_key = {<No data fields>}, s_vfs_rename_key = {<No data fields>}, s_writers_key = 0xffffffff825645e8, i_lock_key = {<No data fields>},
> >   i_mutex_key = {<No data fields>}, invalidate_lock_key = {<No data fields>}, i_mutex_dir_key = {<No data fields>}}
> 
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
