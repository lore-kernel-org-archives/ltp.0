Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8CEC6FA82
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 15:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A95A43CAAE7
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 17:26:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BA9C3CA96B
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 17:26:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C414210008F8
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 17:26:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 267A033A11;
 Mon, 12 Sep 2022 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662996388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhobOEe2+jqr1ZVJOauMhnzGAABwZ3+TOPsJS2CPLc0=;
 b=vlETHheZYK/9DXa4K/j5aD/YY1/9M/bB0EL8fo/tFq9cWLniP5v96UGK8QH1eqLOGRT0DO
 AgqcaR20LKmGTwC2HSHIorSmUsvOLGDYqBM6l067p8Y8ItjzKz6ei0hUZnj7cDIHgPi+1l
 mM44TyqYq8YZ1pP2OE75YCsirNlhLSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662996388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhobOEe2+jqr1ZVJOauMhnzGAABwZ3+TOPsJS2CPLc0=;
 b=Ofg2oiJhrBimxmxcqjp/KPYZJSZR1RKT3wrWVIVKKg63giHYz01vXUd0q9WaSw6lar8pts
 2G4TMrhxWftomsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3E48139E0;
 Mon, 12 Sep 2022 15:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z3vqMKNPH2NlXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 15:26:27 +0000
Date: Mon, 12 Sep 2022 17:28:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yx9QFWuRMjDUAafp@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-8-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909141840.18327-8-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @@ -307,6 +307,18 @@ tst_mount()
>  	if [ $ret -ne 0 ]; then
>  		tst_brk TBROK "Failed to mount device${mnt_err}: mount exit = $ret"
>  	fi
> +
> +	mnt_real="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
> +	case $mnt_real in
> +		'') tst_brk TBROK 'Failed to found filesystem type in /proc/mounts';;
> +		'fuseblk') TST_FS_TYPE_FUSE=1;;
> +		*)
> +			if [ "$mnt_real" != "$TST_FS_TYPE" ]; then
> +				tst_brk TBROK "$mnt_real: unsupported type in /proc/mounts"
> +			fi
> +			TST_FS_TYPE_FUSE=
> +		;;
> +		esac
>  }

I just wonder if this is worth being added to the test library just for
a single test. Or do you expect this to be usable in more than df01.sh?

Also maybe it would be a better as a function so that the code does not
run unconditionally on each tst_mount() call?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
