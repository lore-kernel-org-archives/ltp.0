Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65372C47DA9
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 09:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 355C03CE131
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 10:02:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9A43CB9A0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:02:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72D036001E1
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:02:28 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65E841F7DE;
 Mon, 29 Jan 2024 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706518947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqIvOO1sukYeJ32ExVXokdPrV4zis7oxrH0gzITuimo=;
 b=VeQD1kxZO5xYxZk96qLbdrdNMP/ZVWVJxaJ3m00hY/2n6XIpVPxFKKQ55fYlhdksIrfsLl
 q5Ee4nmziWu7vqhQ84Mrggb6joNRRiME0WK3UjwE4z/h6psW3hAPl3wFBzq9/4ryOik/7P
 Mg5CvHltP9ns6BtfpN3VRA348rfmV4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706518947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqIvOO1sukYeJ32ExVXokdPrV4zis7oxrH0gzITuimo=;
 b=yUmCB4j5IkRnTAs28nqspaQWUiOX8if/WPEPzjLL2Hj+3Tx9BcBduXuBTgZa5cBizZumY4
 2RLzyDxQMEZxb6DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706518947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqIvOO1sukYeJ32ExVXokdPrV4zis7oxrH0gzITuimo=;
 b=VeQD1kxZO5xYxZk96qLbdrdNMP/ZVWVJxaJ3m00hY/2n6XIpVPxFKKQ55fYlhdksIrfsLl
 q5Ee4nmziWu7vqhQ84Mrggb6joNRRiME0WK3UjwE4z/h6psW3hAPl3wFBzq9/4ryOik/7P
 Mg5CvHltP9ns6BtfpN3VRA348rfmV4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706518947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqIvOO1sukYeJ32ExVXokdPrV4zis7oxrH0gzITuimo=;
 b=yUmCB4j5IkRnTAs28nqspaQWUiOX8if/WPEPzjLL2Hj+3Tx9BcBduXuBTgZa5cBizZumY4
 2RLzyDxQMEZxb6DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3109B13911;
 Mon, 29 Jan 2024 09:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id FTdkCaNpt2VoPQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 09:02:27 +0000
Date: Mon, 29 Jan 2024 10:02:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Message-ID: <20240129090217.GA576336@pevik>
References: <20240128181526.5395-1-subramanya.swamy.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240128181526.5395-1-subramanya.swamy.linux@gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VeQD1kxZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yUmCB4j5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FREEMAIL_TO(0.00)[gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 65E841F7DE
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] isofs.sh:Run test on genisoimage,
 xorriso &mksisofs if not symlinks
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

Hi Subramanya,

>     1)mkisofs, genisoimage and xorriso tools are present as separate
>     tools in some distros while in others they are symlinks to one
>     another. Tests are skipped on symlinks.

>     2)mkisofs supports only -hfs option
>       genisoimage supports both -hfs & -hfsplus options
>       xorrisofs supports only -hfsplus option
=> this change actually fix xorrisofs on CentOS, see below.

First, we are just to release LTP version today and we would like to avoid last
minute changes. Looking to the original version, the attempt was to fix
xorrisofs on CentOS which is a symlink to mkisofs and because it does not
supports -hfs test IMHO fails. So I would be for merging this (with a diff, thus
I repost as v3), but depends on Cyril.

[1] https://lore.kernel.org/ltp/20240115155936.3235-1-subramanya.swamy.linux@gmail.com/

> Co-Authored-By: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 41 ++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 9 deletions(-)

> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index dfa4ac73d..9aa853e67 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -13,18 +13,16 @@ TST_NEEDS_CMDS="mount umount"
>  TST_NEEDS_TMPDIR=1
>  TST_SETUP=setup
>  TST_TESTFUNC=do_test
> +TST_CNT=3

>  MAX_DEPTH=3
>  MAX_DIRS=4

>  setup()
>  {
> -	if tst_cmd_available mkisofs; then
> -		MKISOFS_CMD="mkisofs"
> -	elif tst_cmd_available genisoimage; then
> -		MKISOFS_CMD="genisoimage"
> -	else
> -		tst_brk TCONF "please install mkisofs or genisoimage"
> +	if !(tst_cmd_available mkisofs \
> +		|| tst_cmd_available genisoimage || tst_cmd_available xorrisofs);then
> +			tst_brk TCONF "please install mkisofs / genisoimage / xorriso"
IMHO this is not needed, we check for command in the test itself.
>  	fi
>  }

> @@ -46,6 +44,29 @@ gen_fs_tree()

>  do_test()
>  {
> +        case $1 in
> +        1) MKISOFS_CMD="mkisofs"
> +	   HFSOPT="-hfs -D"
> +	   GREPOPT="mkisofs";;
> +        2) MKISOFS_CMD="genisoimage"
> +	   HFSOPT="-hfsplus -D -hfs -D"
> +	   GREPOPT="genisoimage";;
> +        3) MKISOFS_CMD="xorrisofs"
> +	   HFSOPT="-hfsplus -D"
> +	   GREPOPT="xorriso";;
This is clearly broken formatting (test uses tabs, but you add spaces, we care
about it as it would break readability).
> +        esac
> +
> +
> +        if ! tst_cmd_available $MKISOFS_CMD; then
> +                tst_res TCONF "Missing '$MKISOFS_CMD'"
> +                return
> +        fi
> +
> +        if ! $MKISOFS_CMD 2>&1 | head -n 2 |grep -q "$GREPOPT"; then
> +                tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
> +                return
> +        fi
> +
>  	local mnt_point="$PWD/mnt"
>  	local make_file_sys_dir="$PWD/files"
>  	local mkisofs_opt mount_opt
I prefer local to be at the beginning of the function.

> @@ -62,14 +83,16 @@ do_test()
>  	for mkisofs_opt in \
>  		" " \
>  		"-J" \
> -		"-hfs -D" \
> +		${HFSOPT} \
 		"$HFSOPT" \

{ } brackets are not needed, but quotes are.
Missing quotes actually causes -hfs -D being split (run separately)

Kind regards,
Petr

>  		" -R " \
>  		"-R -J" \
>  		"-f -l -D -J -allow-leading-dots -R" \
> -		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
> +		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J \
> +			-allow-leading-dots -R"
>  	do
>  		rm -f isofs.iso
> -		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
> +		EXPECT_PASS $MKISOFS_CMD -o isofs.iso \
> +			-quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
>  			|| continue

>  		for mount_opt in \

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
