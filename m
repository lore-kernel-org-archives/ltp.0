Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37381C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:27:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DF233C939E
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 16:27:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9C93C23FA
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 16:27:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 316FA21C077
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 16:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738942046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdLNkJssyfL2VuiAS5X2vqLf5I9CodE4ojXUlrxBn2U=;
 b=ervUud4fiPDqrTov9WBJa0BKQpKyTIbZplzFZzioRcdFgRLBQZkKmBq4IOy2IEplg5tQIA
 GaOkR9WLjPJvyTqGId3Dlj8Kl4lCdjFVjkgXV12HZ9SwNg4oITXlfK6+z0BZHVvkiDIvoP
 Th2lpEzB2+ec1gkhFNuXYKUbl1CiGco=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-UgT3TCFCPHuO1LIEpp9wag-1; Fri,
 07 Feb 2025 10:27:24 -0500
X-MC-Unique: UgT3TCFCPHuO1LIEpp9wag-1
X-Mimecast-MFC-AGG-ID: UgT3TCFCPHuO1LIEpp9wag
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 070C5180087C; Fri,  7 Feb 2025 15:27:23 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.51])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFCE619560A3; Fri,  7 Feb 2025 15:27:21 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250207113726.GB1739723@pevik>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 07 Feb 2025 10:27:19 -0500
In-Reply-To: <20250207113726.GB1739723@pevik> (Petr Vorel's message of "Fri, 7
 Feb 2025 12:37:26 +0100")
Message-ID: <x49h655epwo.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zjEd6mcVLQDr5dQEGOOBhBkOqj6GTJNbRwznXgZrlQU_1738942043
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] tst_device: add support for overlayfs
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

> Hi Jeff, all,
>
> NOTE: 'rm -fv lib/libltp.a' is required to apply the patchset.

Right, sorry for not mentioning that.

> Besides it, it does not compile yet:
> /usr/bin/ld: cannot find -lltp: No such file or directory
> https://lore.kernel.org/ltp/20250207112353.GA1739723@pevik/

It compiled for me, so that's surprising.  I would help track it down,
but it sounds like Cyril would prefer we didn't add a dependency.

>
>> When running ltp-aiodio on an overlay file system, the following error
>> occurs:
>
>> tst_tmpdir.c:316: TINFO: Using
>> /mnt/fstests/TEST_DIR/ovl-mnt/ltp-hSHEHy5M0s/LTP_aio4q4GMW as tmpdir
>> (overlayfs filesystem)
>> tst_test.c:1888: TINFO: LTP version: 20220121-2271-g91a10df22
>> tst_test.c:1892: TINFO: Tested kernel: vendor kernel
>> tst_test.c:1723: TINFO: Timeout per run is 0h 40m 00s
>> aiocp.c:211: TINFO: Maximum AIO blocks: 65536
>> tst_device.c:551: TINFO: Use BTRFS specific strategy
>> tst_device.c:569: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
>
>> The issue is that stat(2) on an overlayfs mount point will return a
>> major device number of 0.  The code assumes this is btrfs, and tries
>> to issue a btrfs-specific ioctl.  When that fails, the final message is
>> printed that suggests this might be tmpfs.
>
>> I modified the code to use statfs(2) to get the file system type, and
>> use that to determine which file system specific code to call.  Finally, I
>> added code to parse out the upper directory from the overlayfs mount options
>> using libmount.  libmount is part of util-linux, so it should be fairly
>
> We try to avoid external libraries to help testing kernel on some minimal
> embedded devices. @Cyril: is it ok to drag libmount-devel?
>
> @Jeff: would it be too hard to parse /proc/self/mountinfo (I suppose
> /proc/self/mounts is not enough)? I'm looking into libmount code E.e.
> mnt_fs_get_option() [1]. Or do you think it would be too fragile to parse it
> without libmount?

I thought about it, but I typically avoid string parsing whenever
possible.  There are just too many corner cases.  Looking through the
libmount code convinced me I did not want to wade into those waters.  :)
It is, of course, possible to parse it directly.  There may be some
added maintenance burden, but it should be managable.  I'll purue that
route.

Thanks for taking a look!

-Jeff

>
> Kind regards,
> Petr
>
> [1]
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/libmount/src/fs.c#n1568
>
>> ubiquitous.  stat(2) is then called on the upper directory to get to the
>> underlying device node.
>
>> Review of the series is greatly appreciated.
>
>> Thanks in advance!
>> Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
