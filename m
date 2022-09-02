Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ADBECAAD5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E306A3CA8BB
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:32:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5943CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:31:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 554841A01076
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:31:52 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5780B342AE;
 Fri,  2 Sep 2022 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662111112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLH8JrCK18R3f0kmDg84xyYnj4fjYI5yjJqIBhAs4oI=;
 b=IqP6U2rfHM/jxLVCknyvQkAW8wGBZnNNNzjizD3n1dbpwe9z58RpznLsNI6yYooP7Eu8f2
 jT2ztKiF7NHyhIL1aDOF3iougw9jhsZrmiQef1mN4kdx66f+WjKYvfs3tm0wQrdrCgG207
 NIkEGNbydsQHuLD3FHdSsYzyA72BtXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662111112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLH8JrCK18R3f0kmDg84xyYnj4fjYI5yjJqIBhAs4oI=;
 b=xWgLglygXBpbMMfy3zcMoT3yAzSGNc57Ukb48tumg8rINdY1UJmrmB8TX4QyIbQ4yejzoM
 J4mMImaayfaqQbAA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E0D952C141;
 Fri,  2 Sep 2022 09:31:46 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-4-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:31:43 +0100
In-reply-to: <20220804121946.19564-4-pvorel@suse.cz>
Message-ID: <8735da2kc8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 03/10] tst_test.sh: Allow $ ;
 after whitelisted variable
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> Variable followed by other variable was not whitelisted:
> e.g.:
> $TST_FS_TYPE$pattern
> TWARN: Reserved variable TST_FS_TYPE$ used!
>
> for i in $SKIP_FILESYSTEMS; do
> TWARN: Reserved variable TST_SKIP_FILESYSTEMS used!
>
> Also use the same patter for second grep for detection of _tst_*
> functions variables.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v3
>
>  testcases/lib/tst_test.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index b7cf5f3d4..3494f7786 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -625,9 +625,10 @@ tst_run()
>  	local _tst_data
>  	local _tst_max
>  	local _tst_name
> +	local _tst_pattern='[='\''"} \t\/:`$\;].*'
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
> -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
>  			case "$_tst_i" in
>  			DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
> @@ -647,7 +648,7 @@ tst_run()
>  			esac
>  		done
>  
> -		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed "s/.*_tst_//; s/$_tst_pattern//"); do
>  			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
>  		done
>  	fi
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
