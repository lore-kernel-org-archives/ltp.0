Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38A6CAC592
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 04:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757996631; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EVMmMEBqyoEe2T5EQZ7xeP1CTcfyzkix1je0rKJfvi0=;
 b=Ucrt5KeGOamehdmisiqvgNaq4KxNAcRY6c/rB++d0nMgz/8/P8AQPz1htHuHrMaTGUZug
 2P9DJFP7BA1jxibfiCUcpV4Hq8DVz0USHWKToEkC+aUSU5REOVUPxvHJQ/PfZT8K3qjMz1w
 T8rfhnZFM2gFkk1BPrx5SYyQmIKYmv8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28DAA3CDAC8
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 06:23:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8B9B3C008D
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 06:23:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C9C81000901
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 06:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757996606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=sWd6iwn9WDngy0kkyGE3RMavUsJTwqbB4eThJlX0idY=;
 b=SA9C8RFzO1q6ANt4iwx3CuzoNXJF/cncgyBamE80vZ4gMLlkuFQVsplcqM6+DTyzMV9Ao5
 hRZYSXOZGO0o8sskyiwEa3bJDEItrkP8o8yVHOnZXephuOROqgHqVh4nrpdc6Lm58fI3qs
 0euEQm4hjsFDh8HAk2QFfETtFAl6oAM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-hgLArK8_MdqflMSCxF_9hw-1; Tue, 16 Sep 2025 00:23:24 -0400
X-MC-Unique: hgLArK8_MdqflMSCxF_9hw-1
X-Mimecast-MFC-AGG-ID: hgLArK8_MdqflMSCxF_9hw_1757996603
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-262f626d62dso18363615ad.2
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 21:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757996603; x=1758601403;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYL2ibUOeO2A8IXgwHO/L+6rLp88WSid7r9AQb/k72E=;
 b=DxPCmbuDyBHm/AvR2XkUPtt6rFqCTXTEqGxYg39dBUHX5mFSido8DN/hCMHZOKdEjw
 mOCJIN2w/tVZm6w4d9AglyYeoRhDWn4XJa14/niZYW/LhVYPlRJaTL0pFitsk9GO2wqw
 VgUuh0QK+agsasJ0PzL7qnMuoC177+ZWN9DW5+XCmRtuU4lhuJRMMwLnYhExYMEi+EaD
 TtdyW9YKHLxVHvoHddFnQwaxKjoJXvGl2y2acZOZv4YFi715nPqWgRCIlpe4681VDzio
 RLj2jTnbmLUUAW/SszaL5O633Ot5Z+xqydB2HXq5g7BVPiP1ytM7/WW4hvD/fPf5roLa
 JlnQ==
X-Gm-Message-State: AOJu0YyHsPsxXJwozPhpkG6p2iiBrSp4ipg23hYNIK7YKuaY70NKw+zR
 1RKiMr07xbUcGOhK8miIDkzgrKl6j+Bu4PTiqqasOjzo0gq4pf0eg1wHYbBwiKNjw9pXkpFgKXI
 CXtBFZA5TPdy+4IDR3LSuBad3deL6tws+JlZSg4LXpsfh8BWPVVkgRVf/2P6tfZNMVax+t2kGLp
 Bibhv+NTvuTR94Ck8XFmKJw0dloKs=
X-Gm-Gg: ASbGncsHmfwydAh8zwJhVDbj8rIgqSueGO4fqSx8CNKSvByN2y3l7DyZUrUr00+z+5e
 HXrb3D2SiHVZVUfJdnRaGKP2TFZEGpM0S3xN1kPJnZ25MbWjItH+4Q7CJgHF+HNf/Bdfk5xikNZ
 QKU4GqbiRibZOLSStZ77QnSA==
X-Received: by 2002:a17:903:388b:b0:250:6d0e:1e40 with SMTP id
 d9443c01a7336-25d242f2f14mr153946915ad.7.1757996603175; 
 Mon, 15 Sep 2025 21:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgDj38WrTRkkl5wD5hHwbrsovgIZy/0gSpicDRLGRaFpclnL7Gyv2X3L6F2e7KgM8Z4JUrdMmWEJTA4NFOORw=
X-Received: by 2002:a17:903:388b:b0:250:6d0e:1e40 with SMTP id
 d9443c01a7336-25d242f2f14mr153946635ad.7.1757996602740; Mon, 15 Sep 2025
 21:23:22 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 12:23:11 +0800
X-Gm-Features: AS18NWD8k66WyZLE5O_KcpSiP_UBC7oUM9fnq4jmVI3VQB0Db8iJCevd0oyelNI
Message-ID: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6jF3Vn569op3HJ_wAKm8ELEXMsdRcMJBTq4dUj_W4wg_1757996603
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] kirk cannot handle env variable correctly
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, All,

We discovered that the LTP tests in the CI job all had a fixed timeout
value set,
regardless of LTP_TIMEOUT_MUL or LTP_RUNTIME_MUL . This only seemed
to happen when running Kirk, so to demonstrate the issue I manually ran the
following test:

=================
# ./kirk --framework ltp:root=/mnt/testarea/ltp --run-command mmap22 --env
LTP_TIMEOUT_MUL=1
Host information

System: Linux
Node: hp-dl380g10-01-vm-02.rhts.eng.pek2.redhat.com
Kernel Release: 6.12.0-124.el10.x86_64+rt
Kernel Version: #1 SMP PREEMPT_RT Fri Aug 22 11:49:27 EDT 2025
Machine Architecture: x86_64
Processor:

Temporary directory: /tmp/kirk.root/tmptyhqv079

Connecting to SUT: host
mmap22
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmafXwQ0v as tmpdir (xfs filesystem)
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.12.0-124.el10.x86_64+rt #1 SMP
PREEMPT_RT Fri Aug 22 11:49:27 EDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-124.el10.x86_64+rt/config'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 54s
mmap22.c:63: TPASS: MAP_DROPPABLE test pass.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Exit code: 0


Disconnecting from SUT: host
Session stopped


==================
# export LTP_TIMEOUT_MUL=1
# ./kirk --framework ltp:root=/mnt/testarea/ltp --run-command mmap22
Host information

System: Linux
Node: hp-dl380g10-01-vm-02.rhts.eng.pek2.redhat.com
Kernel Release: 6.12.0-124.el10.x86_64+rt
Kernel Version: #1 SMP PREEMPT_RT Fri Aug 22 11:49:27 EDT 2025
Machine Architecture: x86_64
Processor:

Temporary directory: /tmp/kirk.root/tmpw5dssvts

Connecting to SUT: host
mmap22
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmafWMgDV as tmpdir (xfs filesystem)
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.12.0-124.el10.x86_64+rt #1 SMP
PREEMPT_RT Fri Aug 22 11:49:27 EDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-124.el10.x86_64+rt/config'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 54s
mmap22.c:63: TPASS: MAP_DROPPABLE test pass.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Exit code: 0


Disconnecting from SUT: host
Session stopped

================
# LTP_TIMEOUT_MUL=1 ./mmap22
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaGHM6fT as tmpdir (xfs filesystem)
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.12.0-124.el10.x86_64+rt #1 SMP
PREEMPT_RT Fri Aug 22 11:49:27 EDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-124.el10.x86_64+rt/config'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 01m 00s
mmap22.c:63: TPASS: MAP_DROPPABLE test pass.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
