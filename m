Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD155C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 19:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80BC33C2355
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 20:55:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B9133C06D0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 20:54:58 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 966B41425B53
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 20:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739908495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BUoa56IcsgZKlIqbqblosMmSRoEw5rzv7HJcEX9TKg4=;
 b=ZC2WrBMEWzveuWKLVHg+D7GH5b0LY52iWkiar0J4S13WMJUoQQbfXUkQeK7uHiZUsFwMik
 Y0r2JsGuy5jGRo93G6c0btBg1wmegKsdlfB2gduGiQM/4gAtqhQojogyRaHLaeXqhR8c+D
 nbka2zZ0/ZA13LZbGWp9/ee0tBgdVWs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-18e_kWxPMdOn06h7Z0LUeA-1; Tue,
 18 Feb 2025 14:54:51 -0500
X-MC-Unique: 18e_kWxPMdOn06h7Z0LUeA-1
X-Mimecast-MFC-AGG-ID: 18e_kWxPMdOn06h7Z0LUeA_1739908491
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A38A1180087C; Tue, 18 Feb 2025 19:54:50 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.81.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AACC8300019F; Tue, 18 Feb 2025 19:54:49 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-3-jmoyer@redhat.com>
 <20250218125029.GB2469726@pevik>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2025 14:54:47 -0500
In-Reply-To: <20250218125029.GB2469726@pevik> (Petr Vorel's message of "Tue,
 18 Feb 2025 13:50:29 +0100")
Message-ID: <x49jz9nav08.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wGRoaX2hAKjjEU8jBCN9Ogdofaz0nHDEyGOqR5u7XPU_1739908491
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib/tst_device.c: check for
 BTRFS_SUPER_MAGIC instead of device major of 0
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Jeff,
>
>> stat() may return a major number of 0 in st_dev for any number of
>> pseudo file systems.  Check for the exact file system instead.  There
>> should be no change in behavior with this patch.
>
> LGTM, thank you!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> FYI I'll apply very minor formatting fix before merge.

Yup, that looks fine to me.  Thanks for taking care of that!

-Jeff

> +++ lib/tst_device.c
> @@ -559,12 +559,10 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
>  
>  	uevent_path[0] = '\0';
>  
> -	if (d) {
> -		sprintf(uevent_path, "%s/%s/uevent",
> -			bdev_path, d->d_name);
> -	} else {
> -		tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
> -	}
> +	if (d)
> +		sprintf(uevent_path, "%s/%s/uevent", bdev_path, d->d_name);
> +	else
> +		tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s", bdev_path);
>  
>  	if (SAFE_READDIR(NULL, dir))
>  		tst_resm(TINFO, "Warning: used first of multiple backing device.");
> @@ -600,7 +598,7 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>  	if (fsbuf.f_type == TST_BTRFS_MAGIC) {
>  		btrfs_get_uevent_path(tmp_path, uevent_path);
>  	} else if (dev_major == 0) {
> -		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
> +		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system", path);
>  	} else {
>  		tst_resm(TINFO, "Use uevent strategy");
>  		sprintf(uevent_path,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
