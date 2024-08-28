Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F6EC54757
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 09:16:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA9023D278F
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 11:16:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEDA23CF762
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 11:16:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7AA361338A
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 11:16:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E9741FBED;
 Wed, 28 Aug 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31FFA1398F;
 Wed, 28 Aug 2024 09:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LNJWC9nqzmYjUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 28 Aug 2024 09:16:09 +0000
Date: Wed, 28 Aug 2024 11:14:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zs7qjUdRWuN9Pt6v@yuki.lan>
References: <20240828052500.2395-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240828052500.2395-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4E9741FBED
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] isofs.sh: Create group and user before check
 mount option
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

Here should a description why is this needed.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index d1a362d97..7ec314d1e 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -13,10 +13,27 @@ TST_NEEDS_CMDS="mount umount"
>  TST_NEEDS_TMPDIR=1
>  TST_TESTFUNC=do_test
>  TST_CNT=3
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
>  
>  MAX_DEPTH=3
>  MAX_DIRS=4
>  
> +test_group="abc"
> +
> +setup()
> +{
> +	if ! getent group $test_group > /dev/null; then
> +		useradd -U $test_group
> +	fi
> +}
> +
> +cleanup()
> +{
> +	userdel -f $test_group
> +	groupdel -f $test_group
> +}
> +
>  gen_fs_tree()
>  {
>  	local cur_path="$1"
> @@ -69,6 +86,7 @@ do_test()
>  	mkdir -p $make_file_sys_dir
>  	gen_fs_tree "$make_file_sys_dir" 1
>  
> +

And you shouldn't add empty lines like this.

>  	# Make ISO9660 file system with different options.
>  	# Mount the ISO9660 file system with different mount options.
>  	for mkisofs_opt in \
> @@ -92,8 +110,8 @@ do_test()
>  			"loop,block=512,unhide" \
>  			"loop,block=1024,cruft" \
>  			"loop,block=2048,nocompress" \
> -			"loop,check=strict,map=off,gid=bin,uid=bin" \
> -			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
> +			"loop,block=2048,nocompress" \ "loop,check=strict,map=off,gid=$test_group,uid=$test_group" \
> +			"loop,check=strict,map=acorn,gid=$test_group,uid=$test_group" \
>  			"loop,check=relaxed,map=normal" \
>  			"loop,block=512,unhide,session=2"
>  		do
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
