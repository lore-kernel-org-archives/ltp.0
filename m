Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E0C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 17:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F96D3C9A40
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 18:06:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16A7D3C76F0
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 18:05:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 807B91421762
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 18:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739379952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nt+8s8iCDrWtJkd/lXP9kqd5JltevpeU3w3yhV0eT8Q=;
 b=jTlkAvLUpRT4M+j/hg57tQH67NKOrTAHCujJw3LrCzt2Od7sXexd8G/GrngmbH9EZqC6QR
 hZWHIRy8WmFiK7AJelWEcQgRA5dqmedfUz0JMF0lzi4EL9FKCG7lQ4/JHzl3Wsrr45ODZK
 5MTtpi+tyQ4gGp6f5PMGqWbGbLf14TA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-iiw6f_JnOu-1v-ZrKC7nLA-1; Wed,
 12 Feb 2025 12:05:48 -0500
X-MC-Unique: iiw6f_JnOu-1v-ZrKC7nLA-1
X-Mimecast-MFC-AGG-ID: iiw6f_JnOu-1v-ZrKC7nLA_1739379947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B9C1800268; Wed, 12 Feb 2025 17:05:47 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B7293001D10; Wed, 12 Feb 2025 17:05:46 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20250211214627.152634-1-jmoyer@redhat.com>
 <20250211214627.152634-3-jmoyer@redhat.com>
 <20250211235232.GA1992438@pevik>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 12 Feb 2025 12:05:44 -0500
In-Reply-To: <20250211235232.GA1992438@pevik> (Petr Vorel's message of "Wed,
 12 Feb 2025 00:52:32 +0100")
Message-ID: <x49wmdvhz4n.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: juSElyAiI-bPpGuMMreEw6jNv6RMlndKk11dRzDr5zg_1739379947
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib/tst_device.c: check for
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

Hi, Petr,

Thanks a lot for the review.  I just have one question, below:

Petr Vorel <pvorel@suse.cz> writes:

>> @@ -595,8 +595,13 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>>  	dev_minor = minor(buf.st_dev);
>>  	*dev = '\0';
>
>> -	if (dev_major == 0) {
>> +	if (statfs(path, &fsbuf) < 0)
>> +		tst_brkm(TWARN | TERRNO, NULL, "statfs() failed");
> Please use SAFE_STATFS() here.

SAFE_STATFS appears to be part of the new safe macros
(tst_safe_macros_inline.h), whereas tst_device.c includes the older
macros via #include "safe_macros.h".  How would you like me to proceed?
I could add a SAFE_STATFS to the old macros, or I could submit a prep
patch that converts tst_device to the new macros.  Or something else?

Thanks!
Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
