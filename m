Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D6C2BD09
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 08:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63EA3D3DAD
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 10:20:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35E8B3D0CAA
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 10:20:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E02ED1001851
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 10:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719994823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ2fUdFfeBy+JyKrkcpiT8xvmVSUvxRWIP9fETsgFwc=;
 b=OKdRQoqEXEmpNJO8keZXjYb7c4ZfjINLMQ43E34LetPLHMQgVz/bOKOfs27t1pX5xJUiSh
 V3RLJ6R4f9Ya1dq8RPXXP/5N98IQ5A8G/Ah7SldvBBeZhmgUVXuzgWErRP0b+LvtaAXvMQ
 Ujhn7zQGByD6S4Gpk4gKpCk/EieuK78=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-mHqJfSSwNL-Dv8-pHN3m5g-1; Wed, 03 Jul 2024 04:20:21 -0400
X-MC-Unique: mHqJfSSwNL-Dv8-pHN3m5g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c974ec599cso420454a91.1
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994820; x=1720599620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZJ2fUdFfeBy+JyKrkcpiT8xvmVSUvxRWIP9fETsgFwc=;
 b=BkmzhmFY6vUNSyz9GNdfD81bM5wvT1jL7rGCH3R9UXDtaMFPU8TpeO2HXZsvOT0QU4
 ni61dzEWAy6XnB/8BHtSvPqQzhtbMuq9cm73nRSpYqWfcL9+KTiQNSL0R7WHQATePMB/
 cOH4z3fG1WyIQxY3FMNV7kxvJHfGQjfG//7TLfS+J/exDPYkrepCl0nXEsZJb21NBQc6
 RqYcrIzWN9Blxra4IZDQISkRC+jEDiBx5yQLM4FGVEtwpP50XspZrCfTiABpshNwOwS8
 KuEuX2qqxx0m6LloXRYuN+P6mkk/DVexf4VK4goLlayORldRX5WpqFY4xoLajyoRwzZJ
 pthQ==
X-Gm-Message-State: AOJu0YzkON8bnoSjU8ANClmyL3sfv8UoJYPvk/aVhlF1KGofOJUbmHjP
 nCo1BcbgSgTbor72Ozj36WIidV9skAHe6wbHLUun7j26IA93YPOPfBo1noCu2vED8zLGaxPmCNk
 PO4EPkef5/yvKEWNkUipqtzZMLY5Ij0gaU9shQJa/3eeUmgu1Zhdy0+cdbkizFXIEA1kOQL+VU4
 VqLMxQ5EOHR1BHCOoFlkKtD2c=
X-Received: by 2002:a17:90a:ce08:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c97ad4ca7amr1491806a91.21.1719994820109; 
 Wed, 03 Jul 2024 01:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3QAXgnlE5jB1UgHfA0sTj/60NXY5iY7hnWDrVpQ+lLB5IjQit2AWvTL9msB0MWQaTk3OfeqcDKKK0zmo06I4=
X-Received: by 2002:a17:90a:ce08:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c97ad4ca7amr1491792a91.21.1719994819739; Wed, 03 Jul 2024
 01:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-8-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-8-58e9af649a72@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Jul 2024 16:20:07 +0800
Message-ID: <CAEemH2ekjHU_wuyr7ThWbbs8NYZ8+8hUB-KLVP-tG=V2NWAT5Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/10] Add landlock04 test
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

I got some failures when this test was performed with exfat FS, but haven't
figured out the reason, FYI:

# uname -r
6.9.6-200.fc40.aarch64

# LTP_SINGLE_FS_TYPE=exfat ./landlock04
...
tst_test.c:1694: TINFO: === Testing on exfat ===
tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra
opts=''
tst_test.c:1120: TINFO: Mounting /dev/loop0 to /tmp/LTP_lantEvE2G/sandbox
fstyp=exfat flags=0
landlock_common.h:30: TINFO: Landlock ABI v4
landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_CHAR
landlock_tester.h:237: TINFO: Test normal or special files creation
landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: EPERM
(1)
landlock_tester.h:120: TINFO: Test binary execution
landlock_tester.h:131: TPASS: execve(FILE_EXEC, args, NULL) : EACCES (13)
landlock_tester.h:146: TINFO: Test writing file
landlock_tester.h:151: TPASS: open(FILE_WRITE, O_WRONLY, PERM_MODE) :
EACCES (13)
landlock_tester.h:159: TINFO: Test reading file
...
tst_test.c:1694: TINFO: === Testing on exfat ===
tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra
opts=''
tst_test.c:1120: TINFO: Mounting /dev/loop0 to /tmp/LTP_lantEvE2G/sandbox
fstyp=exfat flags=0
landlock_common.h:30: TINFO: Landlock ABI v4
landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_BLOCK
landlock_tester.h:237: TINFO: Test normal or special files creation
landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: EPERM
(1)
...
tst_test.c:1694: TINFO: === Testing on exfat ===
tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra
opts=''
tst_test.c:1120: TINFO: Mounting /dev/loop0 to /tmp/LTP_lantEvE2G/sandbox
fstyp=exfat flags=0
landlock_common.h:30: TINFO: Landlock ABI v4
landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_SOCK
landlock_tester.h:237: TINFO: Test normal or special files creation
landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: EPERM
(1)
...


Regard,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
