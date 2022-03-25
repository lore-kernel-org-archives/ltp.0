Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B5C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 09:02:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE3A63C9A9A
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 11:02:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622953C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 15:26:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 710D3601AF6
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 15:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648218375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKgjNoaVMXWK5T7wIsXaCgUA6OVnOtOsSFGmd3vldtg=;
 b=UNzDjosJEZoMhFtcUnUkuz0T1ottVxvEZe5ubbidQ1z/6TJgf5cKWkaKRzxYSTNyjHeKTp
 JU+A7+0IMzoGYmyumX1IEcx5tqJk0wcKABs+NQvftT/VrDZMur9KXG3kcwcU5paQ+wDbC9
 Bc1D1y1uuk+bgDudcjXGYaITWGk5ZvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-Kw_wH_XDMIieG0eMznL0lQ-1; Fri, 25 Mar 2022 10:26:14 -0400
X-MC-Unique: Kw_wH_XDMIieG0eMznL0lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D8D8811E76;
 Fri, 25 Mar 2022 14:26:14 +0000 (UTC)
Received: from [10.22.19.30] (unknown [10.22.19.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB8B740E7F03;
 Fri, 25 Mar 2022 14:26:13 +0000 (UTC)
Message-ID: <badfd854-f6c6-24ea-eeec-e2772aff2578@redhat.com>
Date: Fri, 25 Mar 2022 10:26:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20220325040057.544211-1-liwang@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20220325040057.544211-1-liwang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 28 Mar 2022 11:02:28 +0200
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 3/25/22 00:00, Li Wang wrote:
> This is to get rid of the intermittent failures in clock_gettime04,
> which are likely caused by different clock tick rates on platforms.
> Here set the threshold no less than each clock tick in millisecond:
>
> 	delta = 1000(ms)/ticks_number_per_sec + 5;
>
> Error log:
>    clock_gettime04.c:163: TFAIL: CLOCK_REALTIME_COARSE(syscall with old kernel spec):
>          Difference between successive readings greater than 5 ms (1): 10
>    clock_gettime04.c:163: TFAIL: CLOCK_MONOTONIC_COARSE(vDSO with old kernel spec):
> 	Difference between successive readings greater than 5 ms (2): 10
>
>  From Waiman Long:
>    That failure happens for CLOCK_REALTIME_COARSE which is a faster but less
>    precise version of CLOCK_REALTIME. The time resolution is actually a clock
>    tick. Since arm64 has a HZ rate of 100. That means each tick is 10ms. So a
>    CLOCK_REALTIME_COARSE threshold of 5ms is probably not enough. I would say
>    in the case of CLOCK_REALTIME_COARSE, we have to increase the threshold based
>    on the clock tick rate of the system. This is more a test failure than is
>    an inherent problem in the kernel.
>
> Fixes #898
>
> Reported-by: Eirik Fuller <efuller@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Waiman Long <llong@redhat.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> index a8d2c5b38..cccbc9383 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -35,7 +35,7 @@ clockid_t clks[] = {
>   };
>   
>   static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
> -static long long delta = 5;
> +static long long delta;
>   
>   static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
>   {
> @@ -92,6 +92,7 @@ static struct time64_variants variants[] = {
>   
>   static void setup(void)
>   {
> +	delta = 1000/sysconf(_SC_CLK_TCK) + 5;
>   	if (tst_is_virt(VIRT_ANY)) {
>   		tst_res(TINFO, "Running in a virtual machine, multiply the delta by 10.");
>   		delta *= 10;

Actually, only CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE use 
clock tick for its time measurement. The rests use a higher resolution 
internal timer. Perhaps, we could have a separate coarse_delta for these 
two cases and use delta for the rest.

Cheers,
Longman


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
