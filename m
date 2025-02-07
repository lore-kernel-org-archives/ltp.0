Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF7FC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 17:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 565903C93C8
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 18:09:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF733C92E1
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:09:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0150E641D94
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738948139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFzSA/ClmQGokoZhScGx+kA2MANb1R9rM6kIq8DcjOU=;
 b=SvBg4uNZq/QzEM1D7UJIkJBvBUWfYw6MWRKQkQVMrpxm31eqTp3zPB+u3socP8HAyx5yjb
 YCBEDBhCcN6AsuSUC19va1yC/6n/mht77jgAlwpxK35iMhBX4lOe0THc4wL7hHcrOSJCBe
 ENzjs8X8I6JAItehW03M49H0FgcmqFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-rYX0D9wMOlCm23p5Ea3ajA-1; Fri,
 07 Feb 2025 12:08:56 -0500
X-MC-Unique: rYX0D9wMOlCm23p5Ea3ajA-1
X-Mimecast-MFC-AGG-ID: rYX0D9wMOlCm23p5Ea3ajA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A678C180098C; Fri,  7 Feb 2025 17:08:55 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.51])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BC8119560A3; Fri,  7 Feb 2025 17:08:54 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250207113726.GB1739723@pevik>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 07 Feb 2025 12:08:52 -0500
In-Reply-To: <20250207113726.GB1739723@pevik> (Petr Vorel's message of "Fri, 7
 Feb 2025 12:37:26 +0100")
Message-ID: <x498qqhel7f.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TXtuX0py7YODWIrnMZ0ai4PUMLEaSsdSPtZ9TEfQhZo_1738948135
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

Petr Vorel <pvorel@suse.cz> writes:

> @Jeff: would it be too hard to parse /proc/self/mountinfo (I suppose
> /proc/self/mounts is not enough)? I'm looking into libmount code E.e.

Looking more closely, I think /proc/self/mounts will work just fine.  I
was pointed to mountinfo originally and didn't consider mounts.  Thanks
for the suggestion, that will make this much easier!

Cheers,
Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
