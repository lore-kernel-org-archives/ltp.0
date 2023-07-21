Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5A5EB64DA
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 02:14:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 227D23CE974
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 04:14:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1005F3C9CD3
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 04:13:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A1F6200042
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 04:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689905636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5cvfWxs/yR9W6uL+jRzWQcVmSMb7972R59EHtR/P4s=;
 b=HRwTRw2lG8t3/WbTQSgffH1SCGaBIKPtzPHR8pv2OEc3rRLNn7bPAJsfAobiBTh529Hnu8
 WnCdzrKniiclCyjHxb5qF95CX8Q7T56jjtbdmBAOOP//BvQgrEpPiRtvoLYNS9483d5Ygm
 mQNC5KWAdelEG8/f6AX9MiCOnLvwx40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-jg2TEHzgMwOoz5utQqGPyA-1; Thu, 20 Jul 2023 22:13:50 -0400
X-MC-Unique: jg2TEHzgMwOoz5utQqGPyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 239D4858290;
 Fri, 21 Jul 2023 02:13:50 +0000 (UTC)
Received: from [10.22.17.23] (unknown [10.22.17.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9FC9C57969;
 Fri, 21 Jul 2023 02:13:48 +0000 (UTC)
Message-ID: <bd976e78-953c-68cb-291f-7ad2188aa3fb@redhat.com>
Date: Thu, 20 Jul 2023 22:13:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, kernel test robot <oliver.sang@intel.com>
References: <20230628211637.1679348-1-longman@redhat.com>
 <202307171539.3d8d0e8-oliver.sang@intel.com> <ZLVS_ANORaZO_ZIE@yuki>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZLVS_ANORaZO_ZIE@yuki>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Phil Auld <pauld@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Peter Hunt <pehunt@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 oe-lkp@lists.linux.dev, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/17/23 10:41, Cyril Hrubis wrote:
> Hi!
>> Running tests.......
>> <<<test_start>>>
>> tag=sched_setaffinity01 stime=1689382567
>> cmdline="sched_setaffinity01"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
>> sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EFAULT (14)
>> sched_setaffinity01.c:73: TFAIL: sched_setaffinity() succeded unexpectedly
>> tst_test.c:1612: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>> tst_test.c:1614: TBROK: Test killed! (timeout?)
> So what the test does is that it sets empty affinity mask to
> sched_setaffinity() and expects EINVAL. Instead it looks like the call
> now succeeeds, the test stops getting schedulled and is killed by
> timeout.
>
I had sent out a v2 patch should not fail the LTP's sched_setaffinity() 
test.

Cheers,
Longman


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
