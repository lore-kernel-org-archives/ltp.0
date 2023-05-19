Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F004C77B7A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 10:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DA3E3CD40A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 12:58:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8483CB263
 for <ltp@lists.linux.it>; Fri, 19 May 2023 12:57:55 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B298C601426
 for <ltp@lists.linux.it>; Fri, 19 May 2023 12:57:53 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 7D09B5C01C9;
 Fri, 19 May 2023 06:57:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Fri, 19 May 2023 06:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684493871; x=1684580271; bh=6t
 ghhvqQTO2M3boBegFTkwrhDD7EEzNZF4A1vAHD+bg=; b=icWuBArC+iERgkvea1
 v9zRx/2Ks1wjunJGQusKG3OX4vWpkcZtlvt5CxrlNDT2BazZ7vD/35/HJvZGbk5K
 HgOnbr/tZzrlKBHYM4se9kEDRp0Kqhzl0WDlGp8gRj1vDcTsXG21cCoIG0GRdTof
 /8Ir/1UyEk+rpsVd4zfcQDgdz+nJA3QsCt4L3NpFoR6JGEhCtJlfKot5h4Y03Awc
 0OG197onPcDSxb6jMAvpYGhelMtBT/tedINrSb93y1M4XaZz9EGZ95INyCRGPCgR
 /hAxxhAKH5LOQf4l+3ZKZt7gpMJ2JLQUhe2Qp19uNqiesJQFU/losgnFN2NZNiUW
 oykw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684493871; x=1684580271; bh=6tghhvqQTO2M3
 boBegFTkwrhDD7EEzNZF4A1vAHD+bg=; b=pMCEQmezmGJgcKliIHzvaxxcUeg7t
 NnBJ+HX2b+hdU2Lvj5DnLcHMLMDV/yGvY5w6M0kYAZu4c8TphTbiglWVb4edm8Pb
 Vbf1m2yN8mBvd3j20U8DMfa1vLS8E0yJugw620Muf4cyRSkZSpatt+LxFNTzXitv
 GaxC8yXD5kB0IOaFy1CAxAJ3qRA7Smgb7Xh4vWuHpeInAd3DF3wMyP5fxL5cRrvC
 vBhJtIpIT8HuCdsG1L3PlFEpyoL1SnZ1AwxKpylcckLDuibaD22n1xgmtTLnfVuH
 qGwNdzhqdB7l1DWSUWNKuQhUA8sRV/FCvVoLbOG6w9AAFRDPf/7vXmhLw==
X-ME-Sender: <xms:L1ZnZPeGvmsa4M54ykFbS3Fbc2cUNqfgYthNZ4MZp8L9s8rb6qNPQw>
 <xme:L1ZnZFN9C_Paj2Wdjnc991eW2rdWLbmEkyIsNKoqt6SGngZh6xSI5_4nP_EzYXfXF
 pGxko9-9PFzw5mMrM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
 feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:L1ZnZIhGYUhM19kbEEOFBFAFuIrszkGZ3G6DKXLkdQJ2fb8HmbLWTw>
 <xmx:L1ZnZA-kDHEpJgBmDkgzdsGAtD2ib9YblGYFIBnQKVoVDltVSw8oJw>
 <xmx:L1ZnZLsY3_kxwgxC-3mlUZiOUMAqEkg9P7kSJs6C4Mk6SyhaPPm1dA>
 <xmx:L1ZnZMlP-RRg6ewheEo2L92qnEYgXXTpMtecLDjKbZST2Apfpx2cPA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id F2AFDB60086; Fri, 19 May 2023 06:57:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
In-Reply-To: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
Date: Fri, 19 May 2023 12:57:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, "LTP List" <ltp@lists.linux.it>,
 lkft-triage@lists.linaro.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Davidlohr Bueso" <dbueso@suse.de>,
 "Manfred Spraul" <manfred@colorfullife.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and
 32-bit userspace
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
Cc: Ard Biesheuvel <ardb@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, May 19, 2023, at 11:17, Naresh Kamboju wrote:
> LTP running on compat mode where the tests run on
> 64-bit kernel and 32-bit userspace are noticed on a list of failures.
>
> What would be the best way to handle this rare combination of failures ?
>
> * arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
>     - shmget02
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
> shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
> <4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
> enough memory for the allocation
> shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
> shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
> EINVAL: ENOMEM (12)

Adding Liam Howlett, Davidlohr Bueso and Manfred Spraul to Cc, they
have worked on the shm code in the past few years.

This is the line

	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},

from

https://github.com/linux-test-project/ltp/blob/04e8f2f4fd949/testcases/kernel/syscalls/ipc/shmget/shmget02.c#LL59C1-L59C61

right?

I think this is a result of SHMMAX being defined as
#define SHMMAX (ULONG_MAX - (1UL << 24)), so the kernel would
likely use a large 64-bit value here, while the 32-bit user
space uses a much smaller limit.

The expected return code likely comes from

static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
{
...
        if (size < SHMMIN || size > ns->shm_ctlmax)
                return -EINVAL;
        
but if ns->shm_ctlmax is probably set to the 64-bit value here.
It would then trigger the accounting limit in __shmem_file_setup():

        if (shmem_acct_size(flags, size))
                return ERR_PTR(-ENOMEM);

My feeling is that the kernel in this case works as expected,
and I wouldn't see this as a bug. On the other hand, this
can probably be addressed in the kernel by adding a check for
compat tasks like

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -714,7 +714,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
        char name[13];
        vm_flags_t acctflag = 0;
 
-       if (size < SHMMIN || size > ns->shm_ctlmax)
+       if (size < SHMMIN || size > ns->shm_ctlmax ||
+          in_compat_syscall() && size > COMPAT_SHMMAX))
                return -EINVAL;
 
        if (numpages << PAGE_SHIFT < size)


      Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
