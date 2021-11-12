Return-Path: <SRS0=aRd5=P7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD9C433F5
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 12:08:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED3860F70
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 12:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4ED3860F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 755263C8108
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 13:08:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C49313C7B14
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 13:07:56 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10AF7600143
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 13:07:55 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A94349FAFA;
 Fri, 12 Nov 2021 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1636718874; bh=UAJFentqKEQgNEAu4dr0Q+oHeEiMiLcG3sYYr4RoQd8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=LgQ4/CKed4w15HdZKJcmzDygpOJiBbTJJ80RjOb10uZdjUzr/MF3ZUxIHlrjqFDfK
 jjUF51YpKcC83XS27rlIoPURk0xrcZ7dhN6DRGWOAakxjwOFIWrgDBMn2w7Vne2P9u
 hv8JNjRlnu+9K8wIYPOD4/m+BELpYEQAXIB4AgWo=
Message-ID: <06846bb0-d082-3b7f-ceca-598791dd40da@jv-coder.de>
Date: Fri, 12 Nov 2021 13:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>, ltp@lists.linux.it
References: <20210913153118.25002-1-bogdan.lezhepekov@suse.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <20210913153118.25002-1-bogdan.lezhepekov@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] realtime:matrix_multi: main function to return
 exit status
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

is the test even returning any valid results anywhere?
I don't know if systems are running too fast for the test nowadays,
but in my tests, they always divide by 0, even with very high iteration 
counts even in qemu.

e.g:

$ matrix_mult -i10000000

---------------------------------------
Matrix Multiplication (SMP Performance)
---------------------------------------

Running 10000000 iterations
Matrix Dimensions: 100x100
Calculations per iteration: 8
Number of CPUs: 4

Running sequential operations
Min: 0 us
Max: 160 us
Avg: 0.0000 us
StdDev: 0.2082 us

Running concurrent operations
Min: 0 us
Max: 1693 us
Avg: 0.0000 us
StdDev: 0.6652 us

Concurrent Multipliers:
Min: -nan
Max: 0.0945
Avg: -nan

Criteria: 3.00 * average concurrent time < average sequential time
Result: FAIL



If this is not a result of my test system, we should probably remove the 
test from the
profile, at least as long as it was not fixed.

Joerg


On 9/13/2021 5:31 PM, Bogdan Lezhepekov via ltp wrote:
> The original version always returned 0.
>
> Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
> ---
>   testcases/realtime/func/matrix_mult/matrix_mult.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
> index 61ab887fc..e702c0ff9 100644
> --- a/testcases/realtime/func/matrix_mult/matrix_mult.c
> +++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
> @@ -188,7 +188,7 @@ void *concurrent_thread(void *thread)
>   	return NULL;
>   }
>   
> -void main_thread(void)
> +int main_thread(void)
>   {
>   	int ret, i, j;
>   	nsec_t start, end;
> @@ -308,7 +308,7 @@ void main_thread(void)
>   	     criteria);
>   	printf("Result: %s\n", ret ? "FAIL" : "PASS");
>   
> -	return;
> +	return ret;
>   }
>   
>   int main(int argc, char *argv[])
> @@ -319,7 +319,7 @@ int main(int argc, char *argv[])
>   	numcpus = sysconf(_SC_NPROCESSORS_ONLN);
>   	/* the minimum avg concurrent multiplier to pass */
>   	criteria = pass_criteria * numcpus;
> -	int new_iterations;
> +	int new_iterations, ret;
>   
>   	if (iterations <= 0) {
>   		fprintf(stderr, "iterations must be greater than zero\n");
> @@ -348,7 +348,7 @@ int main(int argc, char *argv[])
>   	printf("Number of CPUs: %u\n", numcpus);
>   
>   	set_priority(PRIO);
> -	main_thread();
> +	ret = main_thread();
>   
> -	return 0;
> +	return ret;
>   }


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
