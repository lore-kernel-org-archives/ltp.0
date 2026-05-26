Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54839CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4703E526D
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 13:50:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697F63C73EE
 for <ltp@lists.linux.it>; Tue, 26 May 2026 13:50:01 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01576200753
 for <ltp@lists.linux.it>; Tue, 26 May 2026 13:50:01 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49041e84237so33256185e9.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 04:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779796200; cv=none;
 d=google.com; s=arc-20240605;
 b=Ab0YkT53FGW4KoEr2ZfLP0oScG6sYKvK1/4+44EiqoDT21AvVtVdYUgP4Eykm4Hkzc
 OTUs3+S7DU5ho56GozLKSPpmP1CXxqzK5LK6lIGFSSrBRs+WFQ2X6RUxZJYDEyDl0+8j
 oxqywMdqpwAUoVhXQ3mqIvT7Wt5LooBJi7ronbrvqpxPTRasCyzUIajVGbK5r0gVkqPa
 J2QvmsVFuyOQu+NqinC9l3q6IgkhMtXrlQUVXTMZ2paJ0XfMNdBJhxwiQfi89GQlu2z3
 As3Qcd91LJEUvUMY80ZisLbA4IueKrIG/0P6gWtPrCPtAf+xalp+RtEZdEGRvdA8kqJN
 rg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RdgGw4jS0plJoYmX3Um9mPRvgp8PHoCqs47YktuuZu4=;
 fh=OOkx/wpptziDfcHXMb/r02tPpkip32ILmNFUYS5Uidk=;
 b=cIaFsP4x7wNTG69lpqI4RtWmbkLlBk68xl0C0aUfawQtwrKZII0RnuUKAKvG7XQy8E
 0+gZjA83nLqA6SPYSlremEsAAHuv7yjeDB8BGogKWSUh71Fmbz8FBAqDMB0thEpbHCsM
 Yvtl3yDS9i/GxDap7WzkVDF6Rfyfe52a/1ugbVzqjcJIDpO84muyVzsYyrYlAKhaXP2n
 Ztvf255mRnDqLKfTtsiztbGRxLpFKAwKjxRES1hgEyKCGZDNgnD6S+sNk6XJFqonFA29
 EgamVtFlnXuNMGPrUysk/Pknm7PnWNU9v3xIldrypVjR874uEY7SGYY2K0xYYZkgzP1A
 wFag==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779796200; x=1780401000; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RdgGw4jS0plJoYmX3Um9mPRvgp8PHoCqs47YktuuZu4=;
 b=NbOjgJ7YceAsKDgHLzVlVeFM1WSaGNz+Zhx62XzVghv5rvjFvSYp0QrioKH0mvjS1I
 mlkKPscAzWU/q9F/o0sdJMNcf24inBl/TIbwF7IbZ120CAHxLXUR96reNLRJ3SfiKmi6
 NSMaQvf6p9Zccy4BoqPl03I3mLZ1AivS7ixXlhKXoMxurfskORXqOuTDScoEkM2o4lK2
 AZll0Jb0/3ejWVtaqT/cKK9Y9HXaVmT1HTOskICyeL0P9Kl0PQwhJ5ON8b5v5KpriWCn
 0pj+l8AM7N7b/lPjBvKuonqisEPQ0hij/NIvHHUNBeOvYCcIt5IlIe5HB0+FWdyYrqb9
 Tbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779796200; x=1780401000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdgGw4jS0plJoYmX3Um9mPRvgp8PHoCqs47YktuuZu4=;
 b=G9FRhhnoyX3NY7iPnWfJ/8LnsNekXUU6etORqF81M7jbu1fdbkWHBH/xTLEbjt0YDU
 SuK1fzm2faScWzY64FKubUMQUgtWz3KxVVBipPK+Sl1YOROAbMfc1NG+kenPgXj5MKGk
 4d7miBIzmHZOArrpVlT15HpjgD0rjvo/VS2VgIAQCejlxMOlb+5R+YTBk8gS/rB9nTIr
 EbPnb51w3Z37z5OZmrEEdGQhkIOwulDCS1qMCbRwlzBS5u0xSDey1OBb7UFr27HKi9eR
 OmJbHccYmIFVbK2AyVdqg4gOvpyW/10cuNqgSioSvW/3VenyRon7FZqZ4Tyd6ZZo5PC0
 TaIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xah5Rshrp8GCPMiO4lpiZab2/xfT8Mdc3HJu3wa2ayI6CqIAqGEeJB9vEdNoZTGcg4zk=@lists.linux.it
X-Gm-Message-State: AOJu0YwWQglk13qo3myemolMYgf0l14FGNktpJJ7cazDgfhU2JzQM+vv
 F0rXnklOKeh3QewBfShBdIKVNnKW4hL7kXzzGFFit3A/LqqceQukBXRQP4C/EVB4AprqhcCqvFC
 Q64v1OIyNdgztXPbvWC0r1fSIwLqTd/VtZp6PQUQ=
X-Gm-Gg: Acq92OHbasoVdOcnJlhLihRtNDsV1hcsplYGZifMva2S6cg9tbq9Ex0nahZLO6ZK0lI
 xRzUFx7+tPhC9agMtaiw2Vo5Wc2c2MG0gfD+twuIZwaCiNatB4B0fAqrGyyldYgqP/8Y5xPyONa
 CWyngiPErgU5M/98RPiprUhlNcvhygv+lHOfdPkpBX7e8hgIPX659x22Xv0BnltBDdtILJF6kWS
 wEaOHylsN7raFR1SPZhV3hpGsg9MPPo7nKNeKnNegc4tT+z1VGgrudn6uQQcIafbRb4XHJHX8iO
 4WzCAH//wg7AvZS4UHFYQrZLfRTVvHkm5VUhng==
X-Received: by 2002:a05:600c:8686:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-4904226f20bmr169853145e9.6.1779796200136; Tue, 26 May 2026
 04:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
 <20260501151420.1042995-1-priyama2@linux.ibm.com>
 <CAJCsO8epT++TaOs7=NAy+jC4pQDN9tA-1n_tFy233sHKkJ697w@mail.gmail.com>
 <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
 <bf329b6c-1acb-4168-82f8-a1c3de600dc9@linux.ibm.com>
 <ahTtZMiQ52AlVrU_@shinmob>
In-Reply-To: <ahTtZMiQ52AlVrU_@shinmob>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Tue, 26 May 2026 13:49:48 +0200
X-Gm-Features: AVHnY4Jd6Xf3KHtmi6RLf10ueHQaNUgkTs_MC_bCLdYh46hnVvC8mNICHa0d4Tc
Message-ID: <CAJCsO8cZqzQ+6t6ebd-qYG+=DE_LY4sAfWMgRRq7fX8yyrVvgA@mail.gmail.com>
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, daniel.wagner@suse.com,
 ltp@lists.linux.it, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Priyama, Shin'ichiro,

On Tue, 26 May 2026 at 03:21, Shin'ichiro Kawasaki <
shinichiro.kawasaki@wdc.com> wrote:

> Hello Priyama,
>
> From blktests maintainer side, let me share my views on your proposal.
>
> Blktests started as the community effort among the kernel storage
> sub-system
> developers. It was discussed at LSF/MM 2017, and started as the place to
> stock
> test scripts for the kernel stroage sub-system. In my understanding, the
> developers expect blktests is the test set to run before posting patches
> for the
> storage subsystem. In the same manner, I expect and hope that nvme driver
> patches tested with the nvme test group in blktests, to reduce the load of
> reviewers and maintainers.
>
> When LTP supports the nvme tests as you propose, what will be your
> expectation
> for nvme driver patch submitters? Do you expect they run both blktests
> nvme test
> group and LTP nvme group? If so, I suggest to add linux-nvme mailing list
> to
> this discussion thread to ask their opinions.
>
> Also, please find my inline comment below.
>
> On May 25, 2026 / 11:00, priyama2 wrote:
> > Hi Sebastian,
> >
> > Thank you for raising this important question. After reviewing blktests'
> > coverage, I see the concern about duplication.
> >
> > *Proposed LTP NVMe Test Suite - System Integration Focus:*
> >
> > Rather than duplicating blktests' comprehensive NVMe protocol testing, I
> > propose LTP focus on system-level integration and kernel API validation.
>
> The primary role of the blktests nvme test group is to cover the nvme
> driver
> codes in the kernel source tree. It is not intended to test NVMe protocol
> or
> NVMe devices. Blktests can be used for NVMe protocol/device testing as
> just a
> side effect.
>
>   It is often discussed to extend blktests to cover NVMe device
> compatibility
>   test with Linux nvme driver, but it is still an idea at this moment.
>
> I guess you misunderstood this point, so the list below still has
> duplications
> with the blktests coverage. It will make it difficult to tell which test
> framework (blktests or LTP) to add new nvme driver tests.
>
>
Personally I agree with the above - the list still has duplications.
If we get clinical and define things carefully, we still - I believe -
expose ourselves to such duplications in the future.
Effectively we would have NVMe tests in both LTP and blktests, people will
contribute to both and we end up with competing tests...

LTP is oftentimes used for some regression testing. From this standpoint I
would assume it might make sense to introduce some sort
of NVMe sometests - basic coverage to see if things are terribly broken.
Personally I would still prefer to use blktests/nvme as that one is
well maintained and goes deeper into details.

But yeah your ideas are great however -  writing directly -  I would just
implement them in the blktests, so we end up with more mature coverage in
there
rather than spreading the effort on 2 testing tools (ltp and blktests).

I would also emphasize the point made here by Shin'ichiro and earlier by
Daniel - blktests are run on the relevant -next trees, so we would be
better off
with more mature tests in the blktests.

cheers,
Sebastian


>   Said that, the list below includes testing aspects that is not yet
> covered.
>   I agree that those ideas are great.
>
>
> > Here's an overview of the planned test suite:
> >
> > *1. nvme01 - Device Discovery & System Integration (Current Patch)*
> >
> >  * Basic device enumeration through /sys and /dev interfaces
> >  * Driver binding verification
> >  * *LTP-specific angle*: Validates kernel's sysfs/devfs integration,
> >    not NVMe protocol
> >
> > *2. nvme02 - File System Operations (Planned)*
> >
> >  * Standard POSIX I/O operations (open, read, write, close, fsync)
> >  * O_DIRECT, O_SYNC flag behavior
> >  * mmap() operations on NVMe-backed files
> >  * File locking (flock, fcntl) with NVMe storage
> >  * *Differentiation*: Tests syscall interface, not NVMe commands
> >
> > *3. nvme03 - Process & Thread Safety (Planned)*
> >
> >  * Concurrent access from multiple processes
> >  * fork() with open NVMe file descriptors
> >  * Thread-safe I/O operations
> >  * Signal handling during NVMe I/O
> >  * *Differentiation*: Multi-process integration, not device-level testing
> >
> > *4. nvme04 - Resource Management & Limits (Planned)*
> >
> >  * Cgroup I/O throttling with NVMe devices
> >  * ulimit enforcement (RLIMIT_FSIZE, RLIMIT_NOFILE)
> >  * Disk quota behavior on NVMe filesystems
> >  * Memory pressure scenarios
> >  * *Differentiation*: Kernel resource management integration
> >
> > *Key Differentiators from blktests:*
> >
> > Aspect        blktests        LTP (Proposed)
> > *Focus*       NVMe protocol & features        System call & kernel API
> > *Scope*       Block layer specifics   Multi-subsystem integration
> > *Interface*   NVMe commands, ioctl    POSIX syscalls (read/write/open)
> > *Duration*    Comprehensive (longer)  Smoke tests (<5 min total)
> > *Use Case*    NVMe validation         System regression detection
> >
> > *Concrete Examples of LTP-Specific Value:*
> >
> > 1. *System Integration*: Does|fsync()|properly flush NVMe write cache
> >    through the kernel's VFS layer?
> > 2. *Process Safety*: Can a child process inherit and use parent's NVMe
> >    file descriptor after|fork()|?
> > 3. *Resource Limits*: Does cgroup I/O throttling correctly limit NVMe
> >    bandwidth?
> > 4. *Platform Coverage*: Does NVMe work in PowerPC LPAR, s390x LPAR, ARM
> >    virtualization?
> > 5. *Container Integration*: Are NVMe devices properly accessible in
> >    containerized environments?
> >
> > *Positioning:*
> >
> >  * *blktests*: "Does NVMe hardware/protocol work correctly?"
> >  * *LTP*: "Does the kernel's NVMe integration work with the rest of the
> >    system?"
> >
> > *Current Status & Next Steps:*
> >
> > The current nvme01 patch is admittedly basic. I'm happy to:
> >
> > 1. *Withdraw*if LTP prefers no NVMe coverage
> > 2. *Refocus*nvme01 on system integration (e.g., test sysfs attribute
> >    access patterns)
> > 3. *Proceed*with the differentiated test suite outlined above
> > 4. *Collaborate*with blktests maintainers to ensure no overlap
> >
> > Please let know which direction would the LTP community prefer?
> >
> > Best regards, priyama2
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
