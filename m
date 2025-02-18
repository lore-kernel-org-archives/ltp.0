Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9DC021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 20:01:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 305E13C2411
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 21:01:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85CAC3C19ED
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 21:01:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A3D5208E19
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 21:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739908872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NDv/DW/DvMulYW06ozJZWt6/dZb2SPZHVlz0JNFrT8=;
 b=Z7EHhfQBb/jAvfIo189MzsTa9nyQk1er8RgKZO2ZX4xAIkRx8SmmDkQ4aTerI1D+0amQs9
 f5FLMw/uY3gqid37B0Ag9Kw29jAGSe6IGU7koWntPfgm+CaDE0Im7vmx0CPuSF+dI15DLM
 ONsKyG6RSL2q/STJZQ6uGF4BXS7KXNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-I4r88cMDPxigdXFMQjj3UA-1; Tue,
 18 Feb 2025 15:01:10 -0500
X-MC-Unique: I4r88cMDPxigdXFMQjj3UA-1
X-Mimecast-MFC-AGG-ID: I4r88cMDPxigdXFMQjj3UA_1739908870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A5BD19560AF; Tue, 18 Feb 2025 20:01:09 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.81.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BD3C1954B01; Tue, 18 Feb 2025 20:01:07 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-4-jmoyer@redhat.com>
 <20250218125746.GC2469726@pevik>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2025 15:01:06 -0500
In-Reply-To: <20250218125746.GC2469726@pevik> (Petr Vorel's message of "Tue,
 18 Feb 2025 13:57:46 +0100")
Message-ID: <x49frkbaupp.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k0o0ZXZ7Ts_kEe09By6YEsLA6DaPSiZfQsTnN754jIk_1739908870
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] tst_find_backing_dev(): add support for
 overlayfs
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

Hi, Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Jeff,
>
>
>> Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
>> a single device is checked (the upper one) and returned from
>> tst_find_backing_dev().
>
>> The implementation uses both /proc/self/mountinfo and /proc/self/mounts.
>> The former is used to map a device to a mountpoint, and the latter is
>> used to get the file system options for the mountpoint.  All of the
>> information is present in mountinfo, but the file format is more complex,
>> and there are no glibc helpers for parsing it.
>
>> The '#define _GNU_SOURCE' was added for the use of the strchrnul(3)
>> function.
>
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>
>> ---
>> v3: Address review comments from Petr:
>>     - Don't split long strings across lines
>>     - use TST_OVERLAYFS_MAGIC instead of the kernel's definition
>>     Note that I did not use SAFE_SSCANF, as tst_device.c uses the old
>>     style safe macros, and that function is not covered.
>> v2: Don't use libmount.  Instead, map from device number to mount-point
>>     using /proc/self/mountinfo, and then use the mntent.h helpers to get
>>     the mount options for the mountpoint from /proc/self/mounts.
>
> LGTM, thanks for a very nice work!
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I'd prefer others have look into it before merging.

Sure, any review is appreciated.

> Again, I'll apply minor formatting changes before merge (using SAFE_STAT(),
> moving else branch after break to it's own and checkpatch.pl fixes).

It looks fine, but I will make a couple of observations.

> @@ -634,11 +633,11 @@ static char *overlay_get_upperdir(char *mountpoint)
>  			upperdir = calloc(optend - optstart + 1, 1);
>  			memcpy(upperdir, optstart, optend - optstart);
>  			break;
> -		} else {
> -			tst_brkm(TBROK, NULL,
> -				 "mount point %s does not contain an upperdir",
> -				 mountpoint);
>  		}
> +
> +		tst_brkm(TBROK, NULL,
> +			 "mount point %s does not contain an upperdir",
> +			 mountpoint);

This is technically different, but I don't think it matters.  All
overlay mount points need an upperdir, so it is valid to error out here.

>  	}
>  	endmntent(mntf);
>  
> @@ -679,26 +678,21 @@ static char *overlay_get_upperdir(char *mountpoint)
>   */
>  static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
>  {
> -	int ret;
>  	struct stat st;
>  	char *mountpoint, *upperdir;
>  
>  	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
>  
> -	ret = stat(tmp_path, &st);
> -	if (ret)
> -		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
> +	SAFE_STAT(NULL, tmp_path, &st);

Sorry for not using SAFE_STAT.  I don't know how I missed that.  Thanks
again for the review and for fixing up these issues.

Cheers,
Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
