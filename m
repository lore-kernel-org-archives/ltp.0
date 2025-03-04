Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4C4C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 21:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1E743CA052
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 22:15:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156C33C65A8
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 22:15:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A03A5609181
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 22:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741122925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mv/Ewy8p3XavgC8xhz1Bo0c09l/FMi1rPKlcY/faOIo=;
 b=ITFF4tjoD1qbgyhKSFDf43yRM0Vd8HChh63g6LRBrWEzLV9CdgyYibc+64aTvrQFn2t9ia
 jb+FcJS8NAF9tDCvpXHmH93240Na2G2tWiyrALiy8b1iLZfr15VT7x57g2bwCHeaCQwLTP
 /h1dfHQ5Jpa0vf/7wLjOImBW7F8DqYM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-D-ugz9NpNFKl3Z6RsLK4Wg-1; Tue,
 04 Mar 2025 16:15:14 -0500
X-MC-Unique: D-ugz9NpNFKl3Z6RsLK4Wg-1
X-Mimecast-MFC-AGG-ID: D-ugz9NpNFKl3Z6RsLK4Wg_1741122912
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC1311800874; Tue,  4 Mar 2025 21:15:11 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.81.178])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB7F1800359; Tue,  4 Mar 2025 21:15:10 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-4-jmoyer@redhat.com>
 <Z7cOxcRhtPcZSpsL@yuki.lan>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 04 Mar 2025 16:15:08 -0500
In-Reply-To: <Z7cOxcRhtPcZSpsL@yuki.lan> (Cyril Hrubis's message of "Thu, 20
 Feb 2025 12:15:17 +0100")
Message-ID: <x495xkozeeb.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: snpTCoft4W_Y0XvqpwM6rERk_tFs0KhDm5no9gsutA8_1741122912
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

Hi, Cyril,

Thanks for the review.  Comments inline.

Cyril Hrubis <chrubis@suse.cz> writes:

>> +static char *overlay_mount_from_dev(dev_t dev)
>> +{
>> +	unsigned dev_major, dev_minor, mnt_major, mnt_minor;
>> +	FILE *fp;
>> +	char line[PATH_MAX];
>
> PATH_MAX does not really make any sense here. It's as good as any other
> number so I would just hardcode 4096 here.

Agreed.  Also, the theoretical max is beyond 4k, but it shouldn't be a
practical issue.  I did struggle with plucking a value out of thin air,
here.

>> +		if (ret != 3)
>> +			tst_brkm(TBROK, NULL,
>> +				 "failed to parse mountinfo line: \"%s\"",
>                                                                    ^
>                 We usually use ' instead of " inside of strings in LTP.

Ok.

>> +	if (!mountpoint)
>> +		tst_brkm(TBROK, NULL,
>> +			 "Unable to find mount entry for device %u:%u\n",
>                                                                       ^
> 							No newlines in
> 							tst_*()
> 							messages please.

Oops!

>> +	while ((mnt = getmntent(mntf)) != NULL) {
>> +		if (strncmp(mnt->mnt_dir, mountpoint, strlen(mountpoint)))
>> +			continue;
>
> Why strncmp() here? Isn't this possibly generating false positives in
> the case that we there is more mounts that have the same prefix that
> matches mountpoint?

Yes, good point.  Thanks!

>> +		if (strncmp(mnt->mnt_type, "overlay", strlen("overlay")))
>> +			tst_brkm(TBROK, NULL,
>> +				 "expected overlayfs on mount point \"%s\", but it is of type %s.",
>> +				 mountpoint, mnt->mnt_type);
>
> Here as well, I suppose that the probability of false positive here is
> close to zero, but I do not see the reason for strncmp() here either.

Agreed.

>> +		optstr = hasmntopt(mnt, "upperdir");
>> +		if (optstr) {
>> +			optstart = strchr(optstr, '=');
>> +			optstart++;
>> +			optend = strchrnul(optstr, ',');
>> +			upperdir = calloc(optend - optstart + 1, 1);
>> +			memcpy(upperdir, optstart, optend - optstart);
>
> Isn't this just a complicated way how to re-implement strndup()?

Yes.  :)  I'll fix that up.

>> +static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
>> +{
>> +	int ret;
>> +	struct stat st;
>> +	char *mountpoint, *upperdir;
>> +
>> +	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
>> +
>> +	ret = stat(tmp_path, &st);
>> +	if (ret)
>> +		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
>> +
>> +	mountpoint = overlay_mount_from_dev(st.st_dev);
>> +	upperdir = overlay_get_upperdir(mountpoint);
>> +	free(mountpoint);
>
> Since the mntpoint is only intermediate result, why can't we pass the
> st.dev to the overlay_get_upperdir() and call overlay_mount_from_dev()
> from there?

It makes more logical sense to me to pass a mount point to that
function.  Another argument against changing would be that
overlay_get_upperdir is already pretty large.  However, if you feel
strongly about it, I can certainly change it.

Thanks again for the thorough review!

Cheers,
Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
