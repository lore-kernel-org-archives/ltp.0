Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FFBC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:38:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E6CF3D09A6
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 15:38:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677CC3D07E8
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:38:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B9E061400512
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:38:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0502219D2;
 Wed,  5 Jun 2024 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717594712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kchwc5kBSrFVxeesJOXDs85Io+mlLmG+BLpXjq6Gs3I=;
 b=OtTf6fqdfNGrfxOctn0SrM05+M1K7Jg5b/bpTXy6MmtpZVmyUEysbky8mpJI/t9bybaYK6
 dal6QFiykn3uOLfOmaL5pcS3Oct1JmpezmRAN4Soropu2RvSvPhTKTAnBKHXqYqpenL7I3
 2GDVSO92k3wPJIS9q22UMVwOguSVPgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717594712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kchwc5kBSrFVxeesJOXDs85Io+mlLmG+BLpXjq6Gs3I=;
 b=ZMXVKpnfbg2W3wa1pGsImuCc7blZjKApixNGwAWCXiDLn7edgwzrmiHFM0BqmxO8A0udvY
 zQN0x14a8KXI41CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717594711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kchwc5kBSrFVxeesJOXDs85Io+mlLmG+BLpXjq6Gs3I=;
 b=VvNesHEBOH/5zY07LKOtQ9O+CPmLwPH1z+D0eVWZ0m4lu6e2siOFLyylZqTkxTMP/3XZOO
 xyqpM2mZ3eXOlyu6q9w1A3iNRxMMch50mmEnlrC8KOSzMPiDu0dXNApDOV39KNBVHbfSkG
 dPzdexCDvCajRO4ZXCVJJ320o5wJPwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717594711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kchwc5kBSrFVxeesJOXDs85Io+mlLmG+BLpXjq6Gs3I=;
 b=lfTouEwlvDyUX/jtYogveM3A2Ly5KFP0VZmKPIzkA2PdHNtAlj1cC68CW8/HvQmh9lh2rG
 vINAk4YNyKpVShBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A4813A24;
 Wed,  5 Jun 2024 13:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M9L6KldqYGZkIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 13:38:31 +0000
Date: Wed, 5 Jun 2024 15:38:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240605133830.GA395864@pevik>
References: <20240528124756.18977-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240528124756.18977-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs02: Add subtest for O_DIRECT
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

Hi Martin,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs02.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs02.sh b/testcases/network/nfs/nfs_stress/nfs02.sh
> index b7fbbce9c..100909790 100755
> --- a/testcases/network/nfs/nfs_stress/nfs02.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs02.sh
> @@ -8,7 +8,7 @@

>  # Ported by: Robbie Williamson (robbiew@us.ibm.com)

> -TST_CNT=3
> +TST_CNT=4
>  TST_TESTFUNC="do_test"
>  LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"

> @@ -46,5 +46,18 @@ do_test3()
>  	tst_res TPASS "test3 passed"
>  }

> +do_test4()
> +{

I suggest to add here before merge:

tst_require_cmds dd diff

Thank you for this test!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	tst_res TINFO "do_test4, copy data in direct mode"
> +	ROD dd oflag=direct if="$LTP_DATAFILES/ascii.jmb" of=ascii2.jmb
> +	echo 3 >/proc/sys/vm/drop_caches
> +	ROD dd iflag=direct if=ascii2.jmb of="$TST_TMPDIR/ascii2.jmb"
> +	echo 3 >/proc/sys/vm/drop_caches
> +	tst_res TINFO "compare both ascii.jmbs"
> +	ROD diff "$LTP_DATAFILES/ascii.jmb" ascii2.jmb
> +	ROD diff "$LTP_DATAFILES/ascii.jmb" "$TST_TMPDIR/ascii2.jmb"
> +	tst_res TPASS "test4 passed"
> +}
> +
>  . nfs_lib.sh
>  tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
