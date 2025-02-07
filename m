Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A42EC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:28:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 984363C23FA
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 16:28:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F72E3C23FA
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 16:28:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 72DD2619588
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 16:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738942092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9D6ErKaGFhdXlMsW7z/wuDFaVUtLs3djRPvGVWOYhk=;
 b=E3ND7gPeL1WGXriPBe3CQ0vyAL+gvgUhzPZT1137VCgVeJJLcGzgtD4wkWqyQSJDJO5fBV
 C8Gs7ZoNc+ncQa9/08ODaPWyto0tOxMSpn6hEkbqmpvjShzUH/L2MoEp4Jz+ChsgBUV2pT
 JYTtxOv4d4W1DecBDujjFgo0TaI/boI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-yWlJ78cdNR60VxgoMKG7vQ-1; Fri,
 07 Feb 2025 10:28:09 -0500
X-MC-Unique: yWlJ78cdNR60VxgoMKG7vQ-1
X-Mimecast-MFC-AGG-ID: yWlJ78cdNR60VxgoMKG7vQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53FF5180087E; Fri,  7 Feb 2025 15:28:08 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AB071955BCB; Fri,  7 Feb 2025 15:28:06 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250207113726.GB1739723@pevik> <Z6X-skb0ce8MYUnb@yuki.lan>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 07 Feb 2025 10:28:05 -0500
In-Reply-To: <Z6X-skb0ce8MYUnb@yuki.lan> (Cyril Hrubis's message of "Fri, 7
 Feb 2025 13:38:10 +0100")
Message-ID: <x49cyftepve.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YRQ7h4pp3ZTVLimYBfBB7_MME4fS1OmJIMU412c3a0s_1738942088
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

Hi, Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > tst_tmpdir.c:316: TINFO: Using
>> > /mnt/fstests/TEST_DIR/ovl-mnt/ltp-hSHEHy5M0s/LTP_aio4q4GMW as
>> > tmpdir (overlayfs filesystem)
>> > tst_test.c:1888: TINFO: LTP version: 20220121-2271-g91a10df22
>> > tst_test.c:1892: TINFO: Tested kernel: vendor kernel
>> > tst_test.c:1723: TINFO: Timeout per run is 0h 40m 00s
>> > aiocp.c:211: TINFO: Maximum AIO blocks: 65536
>> > tst_device.c:551: TINFO: Use BTRFS specific strategy
>> > tst_device.c:569: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
>> 
>> > The issue is that stat(2) on an overlayfs mount point will return a
>> > major device number of 0.  The code assumes this is btrfs, and tries
>> > to issue a btrfs-specific ioctl.  When that fails, the final message is
>> > printed that suggests this might be tmpfs.
>> 
>> > I modified the code to use statfs(2) to get the file system type, and
>> > use that to determine which file system specific code to call.  Finally, I
>> > added code to parse out the upper directory from the overlayfs mount options
>> > using libmount.  libmount is part of util-linux, so it should be fairly
>> 
>> We try to avoid external libraries to help testing kernel on some minimal
>> embedded devices. @Cyril: is it ok to drag libmount-devel?
>
> For the base LTP library? I would say no.

OK, I'll spin a version with custom parsing code.

Thanks for taking a look!

-Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
