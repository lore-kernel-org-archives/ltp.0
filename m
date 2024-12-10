Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B94EE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733831636; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Yx89zoLXx5VbQ6r82pkM7GKK68xQXaS0W0i9L2zctIA=;
 b=JS+bf4w5nvIthijLCQqrX8zRit0SNv7Z3jBWQcN7XdqWoPzXbSUbhGBB2PbtkkgnpdYIF
 xOjmUgrne/2sQKwGuiWpM0uhOUQ83Rr275djzvsoJTxk5EAkW9cZeKzvV9TPh0WHDLKLmYr
 ukB2Xyy02jswoSRlRnOabU0ycBd1yDc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A2BB3E8D27
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 12:53:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266B93E8C96
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 12:53:35 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF228100FD8F
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 12:53:33 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so277394066b.0
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733831613; x=1734436413; darn=lists.linux.it;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YivzoTrM7EixFemi5eqdrHriwk1BXdPJTC0wE0RjCeo=;
 b=ffN7nDxultbsmnibK71joMYNPmEF2LiPGVK/u9A98/a4tUHni8FUmiynM2WBkhAB8P
 IkbdckiIw3bryQIjAv3fx18+pKSf6yYWxJlpEJceNlr5tsfVPtk1yv4pp7IsfX88L8h4
 sPoyaKU6H28lWHn7rOAdRrXxsoP98eT9Nkx0QiiAhnGCneAfh0siY1KPDBs4J0yT9lTy
 tZUwK6FUbWY1uM/Y4nYoRu928PqANsf2Y5XADDkkE8HMT+7XqXa5f+mhi/YkCQ0kwhvO
 hi9dW7mBHBaHCHMkte2fRIs3yIU4yYySzlkp17GwKHDolU7dcZ4HPMGq4Nfl8bNt09aM
 I+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733831613; x=1734436413;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YivzoTrM7EixFemi5eqdrHriwk1BXdPJTC0wE0RjCeo=;
 b=som6NJLLp5YBaUSDCLG4jBjcLKMEosNVFj7d9O5ThzD3IVFIDDYpxNvmm9t/U3UQOa
 yPa0sYWjiBnhIHDhW6SFFB7PlW3jyGeLlX52NZHEj6DDAL1IFBjxfLOeIgyVnaKAvaFi
 q15tkyoARSnWyvKx/oDMivB6xGn2JLc5GhRtvAJKlgTXkQQ0fgl6mEhtChVNZ04PP1P9
 /qM5BsKE4F5ziwkoiFDB4dExTQT01rV9VUB/g8Vx3yCJcqIkRs6ne5B2T3J8N/w13/0S
 gaNFtOQ8GI8tVY3W7r8uNnuvLzPe6hFowYeacURUqoPqxk2q74VLA3D98aRBPPbmPVhB
 KYpw==
X-Gm-Message-State: AOJu0Yx7wffuJ7UZ1R0XRafFhVTo72t3fImD9jDFlOWKe+NWNXuMT7WT
 H0eER//tscPx8qsYrCLbqf375jMSzEKqvRt5Ra4MlW5QOUF1P3+hGM1iV6JbQA==
X-Gm-Gg: ASbGncvQfNqSDSxK5cjXk9KB9LK1HwiA63MYnzpzlH77lc0YEDOvFE158oucQp+ViM3
 LlW4CC3/UGmGzSC632sco474LqTgtXWldCUBHn7X1fA2e2bVb/47uyIISUQvKdO7EswhuEvyJlA
 4DzwlCed4Kc8wNzQyRT+A4lb037xNtolMtsz5/SWtNZCyaahmG35levHEs1vmK3fu0/PRvSK7/N
 BctigTunhF6eSj1SZuwUGj1g0G9NAG2s4PYuQ==
X-Google-Smtp-Source: AGHT+IGkpQMUwc6O8VQALzzIbsBHwYjqB1y0OdCme+ricdCeNR7th/wvOq8PZGvnVDVjjXyJMZ2krw==
X-Received: by 2002:a17:906:4ca:b0:aa6:93c4:c691 with SMTP id
 a640c23a62f3a-aa69ce6e698mr440111166b.58.1733831613271; 
 Tue, 10 Dec 2024 03:53:33 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6773936c8sm403972066b.85.2024.12.10.03.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 03:53:33 -0800 (PST)
Date: Tue, 10 Dec 2024 06:53:26 -0500
To: jstancek@redhat.com, emunson@mgebm.net, samir@linux.vnet.ibm.com
Message-ID: <Z1grtnHIJz//u4kB@wegao>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Question on hugemmap34
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi ALL

Is there any special config needed for this test case? Since the test faile=
d with the following output on my test setup(opensuse15.5 with 6.12 kernel):

tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_hugLSJb7r as tmpdir (btrfs filesyst=
em)
tst_test.c:1100: TINFO: Mounting none to /tmp/LTP_hugLSJb7r/hugetlbfs fstyp=
=3Dhugetlbfs flags=3D0
tst_test.c:1890: TINFO: LTP version: 20240930
tst_test.c:1894: TINFO: Tested kernel: 6.12.3-lp155.11.g78b0030-vanilla #1 =
SMP Fri Dec =A06 08:56:39 UTC 2024 (78b0030) ppc64le
tst_test.c:1727: TINFO: Timeout per run is 0h 00m 30s
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D6671)
hugemmap34.c:88: TBROK: waitpid(0,0x7fffd8baa220,0) failed: ECHILD (10)
hugemmap34.c:92: TFAIL: Child: exited with 2

The root cause is the mmap call encounter failure with EBUSY.

LTP mmap call =

https://github.com/linux-test-project/ltp/blob/7bb960cc4f736d8860b6b266119e=
71e761e22b32/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c#L71

hit kernel code
https://elixir.bootlin.com/linux/v6.12/source/arch/powerpc/mm/book3s64/slic=
e.c#L568
=A0 =

Let me give an example to explain why this happens base pmap of process in =
my test system:

Address =A0 =A0 =A0 =A0 =A0 Kbytes =A0 =A0 RSS =A0 =A0 PSS =A0 Dirty =A0 =
=A0Swap Mode =A0Mapping
0000000010000000 =A0 =A0 256 =A0 =A0 256 =A0 =A0 128 =A0 =A0 256 =A0 =A0 =
=A0 0 r-xp- /root/ltp/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34
0000000010040000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A032 =A0 =A0 =A064 =
=A0 =A0 =A0 0 r--p- /root/ltp/testcases/kernel/mem/hugetlb/hugemmap/hugemma=
p34
0000000010050000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =
=A0 =A0 =A0 0 rw-p- /root/ltp/testcases/kernel/mem/hugetlb/hugemmap/hugemma=
p34
0000000010060000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =
=A0 =A0 =A0 0 rw-p- =A0 [ anon ]
0000010010090000 =A0 =A0 192 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =
=A0 =A0 0 rw-p- =A0 [ anon ]
00007fff8f3b0000 =A0 =A02368 =A0 =A01408 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =
=A0 =A0 0 r-xp- /lib64/libc.so.6
00007fff8f600000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A032 =A0 =A0 =A064 =
=A0 =A0 =A0 0 r--p- /lib64/libc.so.6
00007fff8f610000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =
=A0 =A0 =A0 0 rw-p- /lib64/libc.so.6
00007fff8f620000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A032 =A0 =A0 =A064 =
=A0 =A0 =A0 0 rw-s- /dev/shm/ltp_hugemmap34_15513 (deleted) =A0 =

00007fff8f630000 =A0 =A0 128 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =
=A0 =A0 0 r--p- =A0 [ anon ]
00007fff8f650000 =A0 =A0 =A064 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =
=A0 =A0 =A0 0 r-xp- =A0 [ anon ]
00007fff8f660000 =A0 =A0 320 =A0 =A0 128 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =
=A0 =A0 0 r-xp- /lib64/ld64.so.2
00007fff8f6b0000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A032 =A0 =A0 =A064 =
=A0 =A0 =A0 0 r--p- /lib64/ld64.so.2
00007fff8f6c0000 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =
=A0 =A0 =A0 0 rw-p- /lib64/ld64.so.2
00007fffc6740000 =A0 =A0 192 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =A0 =A064 =A0 =
=A0 =A0 0 rw-p- =A0 [ stack ] <<<<
---------------- ------- ------- ------- ------- -------
total kB =A0 =A0 =A0 =A0 =A0 20416 =A0 =A02432 =A0 =A01318 =A0 =A0 896 =A0 =
=A0 =A0 0

Test power system config:
#getconf PAGE_SIZE
65536
#grep Hugepagesize /proc/meminfo
Hugepagesize: =A0 =A0 =A016384 kB

Kenel split VM space into: =

16 low_slice(64KB page size), each slice size is 256MB
4096 high_slice(64K page size), each slice size is 1TB

00007fffc6740000(stack) is belong 127th high_slice(range is 00007f000000000=
0 - 00007fffffffffff)

When mmap try to allocate a 16M space(with page size MMU_PAGE_16M) near sta=
ck address(00007fffc6740000), =

kernel will first check good_mask but failed, since the all slices is MMU_P=
AGE_64K =

but mmap request page size is MMU_PAGE_16M.
https://elixir.bootlin.com/linux/v6.12/source/arch/powerpc/mm/book3s64/slic=
e.c#L531

Next kernel start check potential_mask(seach all slice which has no any VM =
mapped), obviously
the 127th slice is occupied and 126th is the good candidate one but address=
 range not match =

the mmap's request address(0x00007fffc6740000 - 2 * hpage_size), so finally=
 EBUSY returned. =

https://elixir.bootlin.com/linux/v6.12/source/arch/powerpc/mm/book3s64/slic=
e.c#L559

BTW: I have tested a scenario which disables MAP_FIXED_NOREPLACE, the kerne=
l will
allocate successfully within the range of 126th high slice. =


Thanks.
Regards
Wei Gao

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
