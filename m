Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2801C02193
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 02:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78FE13C91D3
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 03:37:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2513C6E6B
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 03:37:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0ACCC6373E7
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 03:37:12 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BCE67A415DC;
 Wed,  5 Feb 2025 02:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565ADC4CEDF;
 Wed,  5 Feb 2025 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1738723030;
 bh=UMN3I8ugG4IroGqBeu8UD16HZSzIa0wlUCA/0Y8bC9w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PKr2dLkP73x/+9jsz+6Rpz5dIR1j9EeewhSNfHPKTsifReqR6FTgsZdeRnfsZud6z
 alayUOjsaDlgfnQFjV+n2uGXtBTKkRvigaILgpapAyDiVzRxZrDMehoC+c/9bCWPq/
 0JoIyHd/tVynl13SaFId9fS/gvpWTN/yrTqRILJc=
Date: Tue, 4 Feb 2025 18:37:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: bugzilla-daemon@kernel.org
Message-Id: <20250204183709.3db159f63a99a8dc25b7d342@linux-foundation.org>
In-Reply-To: <bug-219750-27@https.bugzilla.kernel.org/>
References: <bug-219750-27@https.bugzilla.kernel.org/>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug 219750] New: Unexpected result from the stack_clash
 test for CVE 2017-1000364
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
Cc: rick.p.edgecombe@intel.com, lawa@nvidia.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 04 Feb 2025 22:19:44 +0000 bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219750
> 
>             Bug ID: 219750
>            Summary: Unexpected result from the stack_clash test for CVE
>                     2017-1000364
>            Product: Memory Management
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: lawa@nvidia.com
>         Regression: No

Thanks.  I'm suspecting that the changes in 6b008640db73 ("mm: move
'mmap_min_addr' logic from callers into vm_unmapped_area()") broke the
heuristics in stack_clash.c.  Let's cc the LTP team and ask whether
others are seeing this?

> Created attachment 307574
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307574&action=edit
> git bisect log file
> 
> I ran into the following unexpected result from the stack clash test included
> with the LTP testsuite while running tests against 6.12.10:
> 
> ###
> 
> tst_test.c:1724: TINFO: Overall timeout per run is 0h 04m 00s 
> tst_kconfig.c:629: TINFO: stack_guard_gap is not found in /proc/cmdline 
> stack_clash.c:296: TINFO: STACK_GROWSDOWN = 1 == 0x7fffffffcfd0 >
> 0x7fffffffcf40 
> stack_clash.c:247: TINFO: Stack:0x7fffffefc000+0x103000
> mmap:0x7fffffdfb000+0x1000 
> stack_clash.c:207: TBROK: mmap((nil),4096,PROT_READ | PROT_WRITE(3),34,0,0)
> failed: ENOMEM (12) 
> stack_clash.c:329: TBROK: Child exited with 2 
> 
> HINT: You _MAY_ be missing kernel fixes: 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58c5d0d6d522 
> 
> HINT: You _MAY_ be vulnerable to CVE(s): 
> 
> ###
> 
> 
> The test worked previously on 6.1.x.   
> 
> I ran the same test on a 6.6.x  (6.6.70 to be specific) and I got the same
> failure.
> 
> git bisect testing appeared to narrow down the reason for the unexpected result
> to the   following commit:
> 
> 6b008640db7355d8de6ac18f74cedd7ccc92684f
> 
> 
> Tested reverting the changes from the latter commit and I was able to get the
> expected result:
> 
> 
> [root@rno2-sim-j08-017 ~]# stack_clash
> tst_test.c:1900: TINFO: LTP version: 20240930
> tst_test.c:1904: TINFO: Tested kernel: 6.12.10 #8 SMP PREEMPT_DYNAMIC Fri Jan
> 31 12:42:41 PST 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1724: TINFO: Overall timeout per run is 0h 00m 30s 
> tst_kconfig.c:629: TINFO: stack_guard_gap is not found in /proc/cmdline
> stack_clash.c:296: TINFO: STACK_GROWSDOWN = 1 == 0x7fffffffd3b0 >
> 0x7fffffffd320
> stack_clash.c:247: TINFO: Stack:0x7fffffefc000+0x103000
> mmap:0x7fffffdfb000+0x1000
> stack_clash.c:89: TINFO: mmap = [7fffffdfb000, 7fffffdfc000), addr =
> 7fffffefbd60, diff = ffd60, THRESHOLD = ff000
> stack_clash.c:321: TPASS: stack is far enough from mmaped area
> 
> Summary:
> passed   1   
> failed   0   
> broken   0   
> skipped  0
> warnings 0
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are the assignee for the bug.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
