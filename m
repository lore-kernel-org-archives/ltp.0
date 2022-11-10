Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E449CC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 11:26:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECE9B3CDA71
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 12:26:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1F4E3CD6F0
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 12:26:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4BCC6601259
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 12:26:03 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3C2F922C69;
 Thu, 10 Nov 2022 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668079563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/Uenr9wE2bD9beG4ZvuhteD585dwIO7fR3MN8xc0aA=;
 b=sJ30GUHlmX9poJLHLE8lUoXTE7xNG8deiPo3oG5p+9W0uUTKS0azI2M6u4WKNIB77JHwEW
 QlKzKE84kSyztngqGPtxyaYYp5OqLx3UE4KcTwd5I8kRBOz1vf/NanO3XFsLoIDqfPx74a
 5FKJsotXTlXNbQAiW8OZYStDPfQcWNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668079563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/Uenr9wE2bD9beG4ZvuhteD585dwIO7fR3MN8xc0aA=;
 b=zk7Mg9Qzk4V1xjZxkVw3I4LH7MEDLTmQEnf+n4jfcTPjXrwmSWwt2Gaadzejsepk/gY+/8
 CbDVTgwFOdReqYAw==
Received: from localhost.localdomain (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EA4D72C141;
 Thu, 10 Nov 2022 11:26:02 +0000 (UTC)
References: <877d05wxwe.fsf@suse.de>
 <20221109193819.875478-1-alessandro.carminati@gmail.com>
 <20221109193819.875478-2-alessandro.carminati@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 10 Nov 2022 11:16:42 +0000
Organization: Linux Private Site
In-reply-to: <20221109193819.875478-2-alessandro.carminati@gmail.com>
Message-ID: <87zgczqce3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Pushed with minor changes, thanks!

I added some whitespace and replaced my signoff tag with reviewed by.

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> +			if (errno == ENOTTY)
> +				tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", path);
> +			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl
> failed with %d.", errno);

TERRNO prints the errno, instead I added the tmp_path.

>  
> -	SAFE_FCLOSE(NULL, file);
> +	if (!access(uevent_path, R_OK)) {
> +		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
>  
> -	if (!*dev)
> -		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> +		if (dev_name[0])
> +			sprintf(dev, "/dev/%s", dev_name);

GCC 12 complains about a null ptr deref here. Seems unlikely to happen,
but I added the nonnull attribute to silence the warning.

> +	} else {
> +		tst_brkm(TBROK, NULL, "uevent file (%s) access failed", uevent_path);
> +	}
>  
>  	if (stat(dev, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
