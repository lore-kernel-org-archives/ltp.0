Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC419D1CA29
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730784647; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FUGfNhKVxjVHZN4WwMiyKit+PVAPmxCRRRwfXIDI7Qo=;
 b=iUE2j74VxPqizV54QdZSGG2lMNRw4F8JMwrNPIU57SQyFK0GTPaWl9XHd+ht9HRvzQaXb
 FT6CIpxji7VHOiQadLSyWskXPnc/jt0UL15a2BcKN2wvc4g9YftNNv+1dXRPRr1wR/uoj6s
 iExxTtzm3+nCy/RSmu9ryzXqaQ899GI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 377F63D1B49
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 06:30:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BAEC3D1A54
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 06:30:24 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9828141ABB7
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 06:30:23 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9eaf93e40dso107033666b.0
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730784623; x=1731389423; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2cCmKiT9ubFl9Ox+6s5+jmW2FlMjQyvQ6sUP3SyXgG0=;
 b=YjlBuwIXFqWXb4t8qpTdBe3zxxmQPSNAKoHyHJlDq5oWsPEc5jDZ9xJtLJJQB+RKCF
 sHDpOXxaXF4GfnT2fZfRDNeW2UTOsJfKtDm4ZouaCbsuirqmN9ZbaEhxlN+Fvh3E1NP5
 7BJ5sXGa3cSngdhcTzc6Q2Y4QRUAv88bp7wsg1GGMwtlyxtCVbKwSOSYeuWHjPOLt14y
 lSlaVJMmk0Kfh3jU967uvI2o4aiWpTZxBtrnz/du1FTFXixo1HAendr9Vqd4I3ZHVcBB
 T9MT19Ps+3ipqz7ObX84LyOQgxPSUqwIM3YzG05rGMAb9QeH0/RGg2nknviIY2+Qh/Pz
 rbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730784623; x=1731389423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cCmKiT9ubFl9Ox+6s5+jmW2FlMjQyvQ6sUP3SyXgG0=;
 b=f2zT1EnneB5kwmKeHpHN5uOqRDHIJ+fFJS3BxeMFAuHz98HGmRjLk1RDbI7f5jVbc9
 PrASRwENpEosnwAvrHc8Nvb9IMGTt+iwBWLpigWTv3pw9Z+McOA2/RjprK9sK8iqO8HC
 2HuIOGim4RXIu9Sbx1q5rTbYdTkUru/JI0gaXV1ENUqTtZtjvhIYjdyTHPhNSid7ZXuu
 KQbMsgnjd048cJmRKzWWt3VaSTWOkqCD2DH3DEVV3vrDW1PJNSVDCxdQkLj12kb191JD
 2KPty13lwXJObRH0y+8J3U4bOsu/Yp0nY0+q3OjEkRqjf56gIi4Trr6avoZak+L0SM1I
 wr5A==
X-Gm-Message-State: AOJu0YziPbFCTSi8VbJWx8R/5vI+Ov0bNVfMklDDvgtyr2PNhEdf5jZo
 m7x/vMoJDGHaQQGnuNPmhHwoWPwqwsb5QqHM+/hXhypa3MuWq27DFhEeLpd4Ww==
X-Google-Smtp-Source: AGHT+IF55bY3KVz6nbn7yHsahqrBYRV/JVKSmT9R/VEomP03/LRYuPemxNoP7l4xRvhh3TdEd1uKig==
X-Received: by 2002:a17:907:7f07:b0:a9a:17f5:79a8 with SMTP id
 a640c23a62f3a-a9de5d6fad3mr3494714466b.13.1730784623121; 
 Mon, 04 Nov 2024 21:30:23 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a3bf6sm79324566b.24.2024.11.04.21.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 21:30:22 -0800 (PST)
Date: Tue, 5 Nov 2024 00:30:16 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZymtaEIKm/caa+z2@wegao>
References: <20240926061936.21499-1-wegao@suse.com>
 <20240930135809.9300-1-wegao@suse.com>
 <20241101105808.GD1145995@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101105808.GD1145995@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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

On Fri, Nov 01, 2024 at 11:58:08AM +0100, Petr Vorel wrote:
> Hi Wei, Cyril,
> 
> > "Reimplementing the test6 of cpuset_memory_testset.sh as a separate C testcase"
> This could be followed by removing test6 from cpuset_memory_testset.sh?
> 
> The conversion itself from shell test test6 LGTM.
> 
> I suppose the reason is that moving code to C improves stability of the test.
> But this would be nice to mention in the commit message. (Remember "what" versus
> "why" - often the reason for the change is more important that describing the
> change.)
> 
> > index 8e41c0223..366d67ce9 100644
> > --- a/testcases/kernel/mem/cpuset/Makefile
> > +++ b/testcases/kernel/mem/cpuset/Makefile
> > @@ -19,6 +19,13 @@
> 
> >  top_srcdir		?= ../../../..
> 
> > +LTPLIBS = numa
> > +
> >  include $(top_srcdir)/include/mk/testcases.mk
> >  include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
> > +
> > +LDLIBS  += $(NUMA_LIBS)
> > +LDLIBS  += $(top_srcdir)/testcases/kernel/controllers/cpuset/cpuset_lib/libcpu_set.a
> This is not enough, because there is no build dependency on libcpu_set.a.
> 
> Other tests which depends on libcpu_set.a are in the subdirectories (e.g.
> testcases/kernel/controllers/cpuset/cpuset_hotplug_test/) and they use
> testcases/kernel/controllers/cpuset/Makefile.inc. Can you somehow use it?
> 
> Maybe we should move cpuset_lib code to libs/ directory, when used elsewhere.
I have created another new patch for move lib code:
https://patchwork.ozlabs.org/project/ltp/patch/20241105052507.29630-1-wegao@suse.com/
> 
> That would also help to avoid ugly includes like:
> > +#include "../../controllers/cpuset/cpuset_lib/cpuset.h"
> 
> (This could be also improved with CFLAGS += -I../../controllers/cpuset/cpuset_lib/.)
> 
> 
> > +LTPLDLIBS = -lltpnuma
> > +
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
> > new file mode 100644
> > index 000000000..a62c98b3f
> > --- /dev/null
> > +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
> > + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * This test check cpuset's mems work with hugepage file.
> Maybe: Test checks cpuset.mems works with hugepage file.
> 
> > + *
> Please remove the blank line above ^.
> > + */
> ...
> 
> > +static void count_cpus_mems(void)
> > +{
> > +	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
> > +	if (node->cnt <= 1)
> > +		tst_brk(TCONF, "test requires NUMA system");
> > +}
> nit: Function used only once, I would move the code into setup().
> 
> Later (separate effort), this function (with size parameter) could be in
> libs/numa/tst_numa.c, because it's used in many tests, or even added into struct
> tst_test.
> 
> > +static void run_test(void)
> > +{
> ...
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		child();
> > +	} else {
> > +		SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
> > +
> > +		TST_CHECKPOINT_WAKE(0);
> > +		TST_CHECKPOINT_WAIT(1);
> > +
> > +		SAFE_WAITPID(pid, NULL, 0);
> > +
> > +		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> > +	}
> 
> Very nit: IMHO saving indent would be more readable:
> 
> 	if (!pid) {
> 		child();
> 		return; // or call exit() in child() and no return here.
> 	}
> 
> 	SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
> 
> 	TST_CHECKPOINT_WAKE(0);
> 	TST_CHECKPOINT_WAIT(1);
> 
> 	SAFE_WAITPID(pid, NULL, 0);
> 
> 	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
