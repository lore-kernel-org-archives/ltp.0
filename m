Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8D4C47DDB
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 16:42:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4973CF9BD
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 17:42:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 702A23C1CD9
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 17:41:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 62E1A600F3A
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 17:41:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D83D1F7E6;
 Mon, 29 Jan 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706546517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TNpVhy1xrYFICIlvz6KQ0BFlHJZl4fkgilXBrw6Zxg=;
 b=gYF+Yapk+Q/Z9z5k3JKKqub7HS/7bUfvYmgFjS1yijgDKk680xHKxzV7YisRWjdDrtkVa6
 CmpL8fh57vS4KpqIZdJSEYpJ4zUjeFQ7z+8RHQKHOibdGbLh3Qm+qD3Kk5CdAjKl3kLHpd
 3m7hMMcIhXVvqC60UrqIPpvzXcV1PbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706546517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TNpVhy1xrYFICIlvz6KQ0BFlHJZl4fkgilXBrw6Zxg=;
 b=W6wNAb+8GkRjiBzungNTaNwx8ypIIs5z42DMQiHIUV7oE2z2U2+F0DxD11ISn6ORr1Dogl
 +sk6kjmuXOqchlAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706546517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TNpVhy1xrYFICIlvz6KQ0BFlHJZl4fkgilXBrw6Zxg=;
 b=gYF+Yapk+Q/Z9z5k3JKKqub7HS/7bUfvYmgFjS1yijgDKk680xHKxzV7YisRWjdDrtkVa6
 CmpL8fh57vS4KpqIZdJSEYpJ4zUjeFQ7z+8RHQKHOibdGbLh3Qm+qD3Kk5CdAjKl3kLHpd
 3m7hMMcIhXVvqC60UrqIPpvzXcV1PbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706546517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TNpVhy1xrYFICIlvz6KQ0BFlHJZl4fkgilXBrw6Zxg=;
 b=W6wNAb+8GkRjiBzungNTaNwx8ypIIs5z42DMQiHIUV7oE2z2U2+F0DxD11ISn6ORr1Dogl
 +sk6kjmuXOqchlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD7F12FF7;
 Mon, 29 Jan 2024 16:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3DsbAVXVt2VlVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Jan 2024 16:41:57 +0000
Date: Mon, 29 Jan 2024 17:42:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbfVZIxK779HhqWY@yuki>
References: <20240129092232.599010-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240129092232.599010-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[13.45%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] isofs.sh: Test genisoimage,
 xorriso and mksisofs
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @@ -50,10 +39,33 @@ do_test()
>  	local make_file_sys_dir="$PWD/files"
>  	local mkisofs_opt mount_opt
>  
> +	case $1 in
> +		1) MKISOFS_CMD="mkisofs"
> +			HFSOPT="-hfs -D"
> +			GREPOPT="mkisofs";;
> +		2) MKISOFS_CMD="genisoimage"
> +			HFSOPT="-hfsplus -D -hfs -D"
> +			GREPOPT="genisoimage";;
> +		3) MKISOFS_CMD="xorrisofs"
> +			HFSOPT="-hfsplus -D"
> +			GREPOPT="xorriso";;
> +	esac
> +
> +	tst_res TINFO "Testing $MKISOFS_CMD"
                ^
               Maybe this should be after the two TCONF messages so that
	       we do not print:

	       INFO: "Testing foo"
	       CONF: "Missing foo"


Other than that it does look fine, as long as it's well tested feel free
to add this for the release.

Reviewed-by: Cyril Hrubis

> +	if ! tst_cmd_available $MKISOFS_CMD; then
> +		tst_res TCONF "Missing '$MKISOFS_CMD'"
> +		return
> +	fi
> +
> +	if ! $MKISOFS_CMD 2>&1 | head -n 2 | grep -q "$GREPOPT"; then
> +		tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
> +		return
> +	fi
> +
>  	mkdir -p -m 777 $mnt_point
>  	mkdir -p $make_file_sys_dir
>  
> -	# Generated directories and files
>  	mkdir -p $make_file_sys_dir
>  	gen_fs_tree "$make_file_sys_dir" 1
>  
> @@ -62,15 +74,16 @@ do_test()
>  	for mkisofs_opt in \
>  		" " \
>  		"-J" \
> -		"-hfs -D" \
> +		"$HFSOPT" \
>  		" -R " \
>  		"-R -J" \
>  		"-f -l -D -J -allow-leading-dots -R" \
> -		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
> +		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J \
> +			-allow-leading-dots -R"
>  	do
>  		rm -f isofs.iso
> -		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
> -			|| continue
> +		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt \
> +			$make_file_sys_dir 2\> /dev/null || continue
>  
>  		for mount_opt in \
>  			"loop" \
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
