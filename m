Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900EFC3DA7A
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 09:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CF7E3CCEDD
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 10:37:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B583C2F29
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 10:37:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB10A1A006A4
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 10:37:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E14820BA8;
 Mon,  2 Jan 2023 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672652230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rf+EXV3NkwksfTmNndnZ0HUxSFL+hXsB2PYRous3HdM=;
 b=zMbwLClQ0SniOWx3kciyw0LW23F/wNI+fV/wye1G4PpTH0DWTnuiMP7TP/Lg9BpGQOyLnr
 5EakaVJUspxzL/DpbrLXmRNDls35kcpTKs7vvBGHdw468jK3MqKadgE9UWN/8iFgoFnYg8
 keLbF6nPuhBl7dM2sqpa2hdz1i+3biA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672652230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rf+EXV3NkwksfTmNndnZ0HUxSFL+hXsB2PYRous3HdM=;
 b=aiEg9wdrCyS8xL0BaCnWVSK0QZLW6kJJ6vGj3RQ4NR4GEXlrHzTr08lgcAcXUgKn20yHHt
 dA0kj2UttvHjThCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB0A8139C8;
 Mon,  2 Jan 2023 09:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DWyZM8WlsmOgPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 02 Jan 2023 09:37:09 +0000
Date: Mon, 2 Jan 2023 10:37:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y7KlxBSIvN3q576G@pevik>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
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

Hi Xu,

...
> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> @@ -21,8 +21,7 @@ DEBUGFS_WAS_MOUNTED=0
>  DEBUGFS_PATH=""
>  DEBUGFS_CONTROL=""
>  DYNDEBUG_STATEMENTS="./debug_statements"
> -EMPTY_FLAG="-"
> -NEW_INTERFACE=0
> +EMPTY_FLAG="=_"

>  mount_debugfs()
>  {
> @@ -55,11 +54,6 @@ setup()
>  		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>  	fi

> -	if tst_kvcmp -ge 3.4 ; then
> -		NEW_INTERFACE=1
> -		EMPTY_FLAG="=_"
> -	fi
> -
>  	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
>  }

> @@ -83,10 +77,8 @@ do_all_flags()

>  	for INPUT_LINE in $ALL_INPUTS; do
>  		do_flag "+p" "$OPTION" "$INPUT_LINE"
> -		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
> -			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
> -			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
> -		fi
> +		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
> +		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>  		do_flag "-p" "$OPTION" "$INPUT_LINE"
>  	done

> @@ -131,7 +123,7 @@ cleanup()
>  		FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' $DYNDEBUG_STATEMENTS)
>  	fi
>  	if [ "$FLAGS_SET" ] ; then
> -		FLAG_PREFIX=$([ $NEW_INTERFACE -eq 1 ] && echo "" || echo "+")
FYI Original code was ugly, it should have been
[ $NEW_INTERFACE -eq 1 ] || NEW_INTERFACE="+"
(Now ignoring that local variables should use local keyword and be lowercase.)

> +		FLAG_PREFIX=$(echo "")
This evaluates to FLAG_PREFIX=
=> please remove the variable as it's always empty

>  		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
>  			/bin/echo -n "$FLAG_LINE" \
>  				| awk -v prf="$FLAG_PREFIX" -F " |:" \
change to:
  				| awk -v prf= -F " |:" \

NOTE: I'm going to cleanup the test after you merge (/bin/echo + variables).

With these changes:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
