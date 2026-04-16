Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142CCF8A145
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776331324; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OEVlpxmzUGfE2OqG/TfFZ9QsiTdEAkclLl2YmMjyPmQ=;
 b=PUfNX9+dHm2GiXDQNc2hiIxePArR9SSFs4u02QvUmNszlBJdvpKg3UjFr4IHuhMd5jOA+
 zHNT/8SnrEF88qGPEK9Ug1ESF51K7bd/ZVzNPCM+Ra2BpYFYyBOTXwa4hybiWF7gCzZ4u9c
 tUaFd1Rf/J/mHl8aAegmdYC7dqFgpUw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C103E268D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:22:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736CE3CDBD8
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 11:21:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B337C600836
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 11:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776331297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8ESu070ULh+P8bhamzEYNaIVsDZaOMg32AKwdYIU2U=;
 b=FPb0WaYyBxwjKE80kZzsTSyRp/U1/ZMHzmdERgsPxCmq1qvCoucfe//rVNZjNBMna6wod3
 8iug8pC2Vu3imDp9FbPUxL8c80BaVANzBei1EtzB1bABn13nPjgg+WLkWgZKs5d6eFr5B1
 M/Gpgvzq8F0cmzkSuIcTBnNFZXZbK3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-NmFJItU5PkC8WwYv03XS3Q-1; Thu, 16 Apr 2026 05:21:36 -0400
X-MC-Unique: NmFJItU5PkC8WwYv03XS3Q-1
X-Mimecast-MFC-AGG-ID: NmFJItU5PkC8WwYv03XS3Q_1776331295
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d76eeb303so4510180f8f.3
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331295; x=1776936095;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x8ESu070ULh+P8bhamzEYNaIVsDZaOMg32AKwdYIU2U=;
 b=UrgknuD3PVWiFULsPQKd2CqY3r9701Xav01vJi/2+urc1d7Hmn+lrxlfg9+MuXD89D
 fzgd0QeM4dMHmqhSnWC1AxLg1Pn1k1lvs3q3luSoRLoxHNsoHPbP8Rlw6dI1bt/KLcKO
 a+QlAKnhIWjK5E6XiPlqFxBEIwcNaO/PP0/1h/X2CYRM67aYk8RMeWi/p+uxKV3smH6i
 q8+raPbdTMn5oxNu3mspxud61qTm8w1aiPrLvJJkzodUk9Jx4kmY3WY/W37Nq6nT0ttJ
 gJXp21h4gxmkDpebu+F+CX4WDCa1TyzZaj9Xrbw3IdIAefhyIabU4Xk/MCcSAWAfD3/j
 kPdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OVa0uBM1gbD02399hOroNVx9s5SvtPmIUvjQMLq2pBSmwiRkDHdnwC9frQ4XZV2wtfeo=@lists.linux.it
X-Gm-Message-State: AOJu0YzbDHHCrzwFc4y9kNi3o4RYrC9BIGPXbMFb6gj3Ivs82Jzsmamm
 rjFuT21HWLCDvWn+odM7nlNXHt6mgl7O3uNQtLvitI3MdRXZ/wLXTp/9CSMelkgUXsvoVNKNFUu
 f6FaN552fzFGn7mm0aq+OzyvOMjV8JUo+9d8INzwgT4dv7VozE5eL
X-Gm-Gg: AeBDieuVZfWxsKA1UpFu+GYirCgHVkhVpd7U8rfnzag37PNT3LTGtJfGxR9j5nznrFi
 zY8MLWN6XGsEgMCmVK/vWoYKmollVK5kTNulLa49comUolsk7sVPQV8BgcamJaQJyZNcOPIfRuC
 q/N1MnRIa0perVU2nKCFtxN3b5YwuM9Q3TkQsD9o1jwIohUh2Rwvofm161kpH4ncyWX1VIEuqre
 O7iGBBqsVT+OSHAiwYy6NFUU3g51wEeVRnDsuZNHOCbAtRXy/fSi9Um1Jhl+G+AOJbNgM8lHYAD
 j5X8ps1rFJhqavX2Z6Q4M/9EamE6acihhRD5TdkaNRJxVdmLYVc6cIdvXwMRasHkVIjGmqTanEv
 D+Xromqipn8Z+47cpNIBDltuSiWO+VExZLg==
X-Received: by 2002:a05:6000:290b:b0:43e:a703:3665 with SMTP id
 ffacd0b85a97d-43ea7033872mr14896966f8f.25.1776331294694; 
 Thu, 16 Apr 2026 02:21:34 -0700 (PDT)
X-Received: by 2002:a05:6000:290b:b0:43e:a703:3665 with SMTP id
 ffacd0b85a97d-43ea7033872mr14896900f8f.25.1776331294047; 
 Thu, 16 Apr 2026 02:21:34 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5c8fsm12742765f8f.19.2026.04.16.02.21.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2026 02:21:33 -0700 (PDT)
Date: Thu, 16 Apr 2026 11:21:31 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260416092131.kkbfd3cdi3tv7z7l@lida.tpb.lab.eng.brq.redhat.com>
References: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
 <ad9l7MeJneX1LdCe@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <ad9l7MeJneX1LdCe@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xagP8hjRak1OpHYusdE0UktGYlDtlnwK1Rr46q1YFp8_1776331295
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid syscall param ioctl(generic) points to
 uninitialised byte(s)
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On  Wed  2026-04-15  12:18 , Cyril Hrubis wrote:
> Hi!
> > From b81924101f441d7f2103197c8b81a38e8920fda4 Mon Sep 17 00:00:00 2001
> > From: Super User <root@vm-10-0-185-15.hosted.upshift.rdu2.redhat.com>
> > Date: Wed, 20 Jan 2038 01:08:34 -0500
> > Subject: [PATCH] Avoid syscall param ioctl(generic) points to uninitialised
> >  byte(s)
> > 
> > lib/tst_clocks.c: fix uninitialized memory in run()  Reproducible
> >                   using userfaultfd01.
> 
> This description does not seem to correspond to the actual change.

Oh, right, this is a true mistake in my proposed patch.  Sorry about that.

> 
> > Signed-off-by: Martin Cermak <mcermak@redhat.com>
> > ---
> >  testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > index 7368d3863..d24766e7c 100644
> > --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > @@ -92,8 +92,8 @@ static void *handle_thread(void)
> >  static void run(unsigned int i)
> >  {
> >  	pthread_t thr;
> > -	struct uffdio_api uffdio_api = {};
> > -	struct uffdio_register uffdio_register;
> > +	struct uffdio_api uffdio_api = {0, };
> > +	struct uffdio_register uffdio_register = {0, };
> 
> Given that we were using = {}; in the code before can we keep using that
> and for all instances?

I saw both initializers in the LTP source, see `$ grep -rIn  '= {};'` and
`$ grep -rIn  '= { 0, };'`.  The latter one is compliant with older standards.
But to keep the coding style within this file, I've updated the initializer.

> Also I assume the problem is the ioctls field in the uffdio_api
> structure that is not initialized beacuse is supposed to be set by
> kernel before returning into userspace. Should valgrind warn about such
> cases?

You are right that zeroing just this uffdio_register.ioctls = 0; is suffi-
cient to to avoid the valgrind complaint.  Zeroing whole the struct seems
syntactically more concise and also correct.

Here is how Valgrind complains when uffdio_register.ioctls isn't zero inited:

el10 x86_64 # echo $T
/root/ltp/testcases/kernel/syscalls/userfaultfd/userfaultfd01
el10 x86_64 # 
el10 x86_64 # 
el10 x86_64 # 
el10 x86_64 # $T
tst_test.c:2059: TINFO: LTP version: 20260130
tst_test.c:2062: TINFO: Tested kernel: 6.12.0-218.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Mar 31 08:07:36 EDT 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.x86_64/build/.config'
tst_test.c:1887: TINFO: Overall timeout per run is 0h 25m 00s
userfaultfd01.c:120: TPASS: Pagefault handled!
userfaultfd01.c:120: TPASS: Pagefault handled!

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
el10 x86_64 # valgrind $T
tst_test.c:2059: TINFO: LTP version: 20260130
tst_test.c:2062: TINFO: Tested kernel: 6.12.0-218.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Mar 31 08:07:36 EDT 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.x86_64/build/.config'
tst_test.c:1887: TINFO: Overall timeout per run is 0h 25m 00s
==2747289== Syscall param ioctl(generic) points to uninitialised byte(s)
==2747289==    at 0x4966D1F: ioctl (ioctl.c:36)
==2747289==    by 0x40534C: run (userfaultfd01.c:113)
==2747289==    by 0x41164C: run_tests (tst_test.c:1730)
==2747289==    by 0x41164C: testrun (tst_test.c:1796)
==2747289==    by 0x41164C: fork_testrun (tst_test.c:1936)
==2747289==    by 0x413B74: tst_run_tcases (tst_test.c:2079)
==2747289==    by 0x404E8D: main (tst_test.h:755)
==2747289==  Address 0x1ffefff98a is on thread 1's stack
==2747289==  in frame #1, created by run (userfaultfd01.c:93)
==2747289== 
==2747289== 
==2747289== Exit program on first error (--exit-on-first-error=yes)
tst_test.c:1953: TBROK: Child returned with 253

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
el10 x86_64 # 


Here is the updated patch (inline):


---------------------------------8<------------------------------------
$ cat 0001-userfaultfd01.c-Zero-initialize-the-uffdio_register-.patch 
From e1ed7e74551bfa51204e1f45fe0b3bb64f21bcae Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Thu, 16 Apr 2026 11:15:38 +0200
Subject: [PATCH] userfaultfd01.c: Zero-initialize the uffdio_register struct

Without this patch, valgrind complains when running userfaultfd01:

el10 x86_64 # valgrind testcases/kernel/syscalls/userfaultfd/userfaultfd01
tst_test.c:2059: TINFO: LTP version: 20260130
tst_test.c:2062: TINFO: Tested kernel: 6.12.0-218.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Mar 31 08:07:36 EDT 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.x86_64/build/.config'
tst_test.c:1887: TINFO: Overall timeout per run is 0h 25m 00s
==2748329== Syscall param ioctl(generic) points to uninitialised byte(s)
==2748329==    at 0x4966D1F: ioctl (ioctl.c:36)
==2748329==    by 0x40534C: run (userfaultfd01.c:113)
==2748329==    by 0x41164C: run_tests (tst_test.c:1730)
==2748329==    by 0x41164C: testrun (tst_test.c:1796)
==2748329==    by 0x41164C: fork_testrun (tst_test.c:1936)
==2748329==    by 0x413B74: tst_run_tcases (tst_test.c:2079)
==2748329==    by 0x404E8D: main (tst_test.h:755)
==2748329==  Address 0x1ffefff98a is on thread 1's stack
==2748329==  in frame #1, created by run (userfaultfd01.c:93)
==2748329==
==2748329==
==2748329== Exit program on first error (--exit-on-first-error=yes)
tst_test.c:1953: TBROK: Child returned with 253

It would be sufficient to zero out the uffdio_register.ioctls member.
This patch inits whole the struct before use.
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 7368d3863..bd955ffdd 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -93,7 +93,7 @@ static void run(unsigned int i)
 {
        pthread_t thr;
        struct uffdio_api uffdio_api = {};
-       struct uffdio_register uffdio_register;
+       struct uffdio_register uffdio_register {};
        struct tcase *tc = &tcases[i];
 
        if (tc->kver == AFTER_5_11 && kver == BEFORE_5_11)
-- 
2.53.0

$ 
---------------------------------8<------------------------------------


Cheers,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
