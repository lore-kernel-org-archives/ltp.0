Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E888C61DD3
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788250959; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gIJvkV86yeZHe6wPFbqr3+Bqhx1hKIqy2XhWd6evqVg=;
 b=kAzqKAqO1837FWEvoa5SFIecp6iV6i6dbMWfGsHMHmvb0w7gVRzQpWvAWls6O08jkMsvS
 upW1eQR2pmbT2NPDlJHoJXLicI4ml3EjKRtXm0mniRdkfpPp98tgTHprYtGvUDcFbth+GIj
 pYpLuVnjGUZSPOEksWr3x6mkrKhkKec=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEE393E9475
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 10:22:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4274D3CC155
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 10:22:18 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 984821000D51
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 10:22:17 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so52781905e9.1
 for <ltp@lists.linux.it>; Tue, 01 Sep 2026 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788250937; x=1788855737; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Hl1rpH0TMoPFhJ04rEEhQC10fT+wI++eYRvbX528CU=;
 b=Dbm5b8L3UisCiWjY+di5P9ihJ3meKaBwHlLfUAE36NfEShJ+TqaZh+k68uNtLi51Te
 iJN8/B2M/Mnib/uLbjmqW56vnOoEmbm15c+bxE+JD4ZQxHoJUngE+RZ0S0fRUe+domCs
 5sB35WL66yLIHo9nv5bq+JuBAtAeVwfR2lcIxIeWUawM60GgQbpIe0Z9uD6xP1Cz/q//
 099LxMmCJKygHMOHRW/YhKuFy9lMGSgc62Lb9EdcMJ9BlASbZ7ErZxJ9IaIQYrRvuwpE
 yfv5cQRojZ0RUBuG97JMxweOEsgERSXK8S6rR1oCAkOJzZOQZ+FRi8PrlUq4AcCmERH/
 YGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788250937; x=1788855737;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Hl1rpH0TMoPFhJ04rEEhQC10fT+wI++eYRvbX528CU=;
 b=PWIBOOYS1je/PGPdNSMnzdepvWz+XqMJTSChypnLMRAlPETnyEmSdzh7rpSm8di1ZD
 IoE93ZKLN7wNU1NQdbYDO3HlpqddgTjIz9DUBNOo8f37q9EzLWhE9Grbp7TXbA1wOSH/
 hXMBhJIcbTwmvxasEuIGSfKaUFYfY3exv23gMEkyCLouasr3SPrHl/VypvpdK76TLVwS
 Ab6IGfL+e4NI+Z/fHqgtESt60uwpEZK0kK8LVW4qqwDHPi4rUHTvDyf+dLaI0bQoNF5m
 xaUiuziMwsMMW8XvQWkjcFPBXqauU9oXZsKhScIR8KKm5ktjU6ewi9GpIrD3CoqPwB1y
 du9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQDFsEHoxRNlm/w9rcw77wDpgzF8EsC+YMLIP4yY8Ww4rXMpu938SxEWLQAZc0cJLUrXw=@lists.linux.it
X-Gm-Message-State: AFuF++lFUxAduPKfGQ8r9cT4vr18+A4IZs2/8XqlvX9fbUXUJipeYCf6
 2d8exRG7vQj6v8tMdGC0vae0gB5mZKJ7wa96xJEHAfG506h2lQbw3GJJ7MCBf/lLtw==
X-Gm-Gg: AR+sD10WDh9V8WzfM+ITq4OSYcHSHf9XO+Cso+q6PwokshqAZiK2yZgucnSs1tK34v6
 DoTjYy0pD7Tpn5sd/dH2APXK1PSkFY/yH2sBuxJBliqR/gKxaAHRPo/0AjiJJn2CPc35AljSzqX
 LbM1m90cmmGjuCP2EWanXZ3GEMX0JAvPK3Mfsu0TuY26IrR1BPPthfD5v537F5+aijoQDiRxJbo
 Oa2EazhyHxb4epGvu1sqXLDyBYGVa/RamBZZMJH8PvB+r3wllkAey5Fa6yj3PP+0ibN0HbuUvGu
 bLcGP3+OVE03+z8UF2kbMfGBAwLkbe1IWtT7runByBEVRUBsUffJ68jTI7Y//5PBITY9EnyY2/D
 y60kITg+NsGCEa6QnYva51LuMLFbW3ms60shMKftnMjFej44xrLYNdvDbiwMOTtl4xXTjJhJxhW
 rtTRpepteSpJNcV91HLCWU+tJnColg+RY/C2rnvHyLNehKZmpBhsWf45+4ZGJ3XDhN/44vYK3DP
 8HTOyHM7QgZD681lQjv8fLJtd5QeNLA8ay9ZJg53BcbNl1v5FVkAPEgFkeJ0Q==
X-Received: by 2002:a05:600c:1d1d:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-49b91c3ddbcmr399579795e9.10.1788250936677; 
 Tue, 01 Sep 2026 01:22:16 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e1ebsm51556725e9.14.2026.09.01.01.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:22:16 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:22:14 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apaLNkgJJlT-6HGd@autotest-wegao.qe.prg2.suse.org>
References: <apYysdNBmxPxyn3z@autotest-wegao.qe.prg2.suse.org>
 <6a9680d9.9099b29d.2c53c3.ca0e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a9680d9.9099b29d.2c53c3.ca0e@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 01, 2026 at 07:38:01AM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > > Something as:
> > > 
> > > diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > > index 4e6023399..2c0c6fb02 100644
> > > --- a/testcases/kernel/mem/mmapstress/mmapstress06.c
> > > +++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > > @@ -59,8 +59,9 @@ static void run_test(void)
> > >  
> > >                 for (size_t i = 0; i < map_size; i += page_size) {
> > >                         mmapaddr[i] = 'a';
> > > -                       if ((i % (2 * 1024 * 1024)) == 0)
> > > -                               usleep(1000);
> > > +
> > > +                       if (i >= mem_limit && !(i % (2 * 1024 * 1024)))
> > > +                               usleep(100000);
> > >                 }
> > > 
> > > The testrun increses to 6s from 1s but it makes the OOM very unlikely to
> > > happen.
> > Thanks for your suggestion.
> > I have tested above solution in our openqa setup but still encounter failure, 3 test cases
> > still failure with oom after run 100 cases. Maybe slow down dirty loop
> > is still too late?
> 
> I still believe there's no way to avoid this, unless we re-implement the
> OOM-killer or memory.reclaim mechanism increasing the amount of attempts
> per request. We will always encounter hardware that is too slow that
> won't swap memory fast enough for the test.

@Andrea @Cyril
As my former email suggestion "protect task with oom_score_adj set to -1000", and this can work
after 100 runs. If you agree this solution then i will create v2 new patch.


--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include "tst_test.h"
+#include "tst_memutils.h"

 static struct tst_cg_group *cg_child;
 static int page_size;
@@ -47,6 +48,8 @@ static void run_test(void)
                char *mmapaddr;
                unsigned long cg_swap_before = 0, cg_swap_after = 0;

+               tst_enable_oom_protection(0);
+
                /* Move child to the constrained cgroup */
                SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());

@@ -57,11 +60,12 @@ static void run_test(void)

                tst_res(TINFO, "Dirtying %zu bytes in child", map_size);

-               for (size_t i = 0; i < map_size; i += page_size) {
+               /*
+                * Tasks with the OOM protection (oom_score_adj set to -1000)
+                * are treated as an exception and are never killed.
+                */
+               for (size_t i = 0; i < map_size; i += page_size)
                        mmapaddr[i] = 'a';
-                       if ((i % (2 * 1024 * 1024)) == 0)
-                               usleep(1000);
-               }

                SAFE_CG_SCANF(cg_child, "memory.swap.current", "%lu", &cg_swap_after);




> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
