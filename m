Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DAC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:11:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF6B93C8C8C
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:11:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61BF23C0354
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:11:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 712D4600A2D
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:11:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A498421100;
 Fri, 25 Mar 2022 10:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648203085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lCYDMOzIEnDyqiDZ28iuyHyo9VDxt9pkCN4+V4F4/Y=;
 b=hnmHoKShTpetWNNqubxVYL51wxIHa3GyQuX28fqFdX1eaPdcBdX7N0Az2nBH4WhP0EcBNh
 QDpHlTeoLwiKJgALu8P+LzCdlsiAzeBygHLmxTlWTD9+RhBHIV91xThMXEiapbGoY6wwYs
 RtYAi3W1ZzvSgyclAB/ZDa/klXAh9HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648203085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lCYDMOzIEnDyqiDZ28iuyHyo9VDxt9pkCN4+V4F4/Y=;
 b=9hDDXFT+0UITbIrRmP5dMPCBOeLKHDGNJbDOYtYFnqt7nO7ZuYz96trXw2HcUXDZsKvlf0
 Ic5wxwKW3PcRp/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90A1313A30;
 Fri, 25 Mar 2022 10:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6FU5Ik2VPWIbFQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 25 Mar 2022 10:11:25 +0000
Date: Fri, 25 Mar 2022 11:13:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yj2V2fu/3Zzio3TZ@yuki>
References: <20220325040057.544211-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325040057.544211-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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
 Waiman Long <llong@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 25, 2022 at 12:00:57PM +0800, Li Wang wrote:
> This is to get rid of the intermittent failures in clock_gettime04,
> which are likely caused by different clock tick rates on platforms.
> Here set the threshold no less than each clock tick in millisecond:
> 
> 	delta = 1000(ms)/ticks_number_per_sec + 5;
> 
> Error log:
>   clock_gettime04.c:163: TFAIL: CLOCK_REALTIME_COARSE(syscall with old kernel spec):
>         Difference between successive readings greater than 5 ms (1): 10
>   clock_gettime04.c:163: TFAIL: CLOCK_MONOTONIC_COARSE(vDSO with old kernel spec):
> 	Difference between successive readings greater than 5 ms (2): 10
> 
> From Waiman Long:
>   That failure happens for CLOCK_REALTIME_COARSE which is a faster but less
>   precise version of CLOCK_REALTIME. The time resolution is actually a clock
>   tick. Since arm64 has a HZ rate of 100. That means each tick is 10ms. So a
>   CLOCK_REALTIME_COARSE threshold of 5ms is probably not enough. I would say
>   in the case of CLOCK_REALTIME_COARSE, we have to increase the threshold based
>   on the clock tick rate of the system. This is more a test failure than is
>   an inherent problem in the kernel.
> 
> Fixes #898
> 
> Reported-by: Eirik Fuller <efuller@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Waiman Long <llong@redhat.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> index a8d2c5b38..cccbc9383 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -35,7 +35,7 @@ clockid_t clks[] = {
>  };
>  
>  static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
> -static long long delta = 5;
> +static long long delta;
>  
>  static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
>  {
> @@ -92,6 +92,7 @@ static struct time64_variants variants[] = {
>  
>  static void setup(void)
>  {
> +	delta = 1000/sysconf(_SC_CLK_TCK) + 5;

This does not look correct to me. The sysconf(_SC_CLK_TCK) returns 100
on systems where the test was working fine with 5 second delta. I think
that the difference is that _SC_CLK_TCK returns how fast are the jiffies
incremented which does not really matter for most of the modern hardware
that uses high resolution harware for timers.

I think that we should really use whatever is returned by the
clock_getres(CLOCK_REALTIME_COARSE, &res), as long as high resolution
timers are not available this call will return resolution in miliseconds
and with high resolution timers available the reported resolution will
be in nanosecond range, so it should probably be something as:

	clock_getres(CLOCK_REALTIME_COARSE, &res);

	delta = 5 + (res.tv_nsec / 1000000) * 5;

>  	if (tst_is_virt(VIRT_ANY)) {
>  		tst_res(TINFO, "Running in a virtual machine, multiply the delta by 10.");
>  		delta *= 10;
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
