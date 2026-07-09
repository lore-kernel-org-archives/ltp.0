Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990B0C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783616974; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+zjzavkGxrkuoP8gSKKuniEXl7it+G8OMCzJcXCeKUY=;
 b=WtxH8+/XfMCS4jYwba5ar3emwt+CnX2BATK/yEfaiQS2tDFO754ZKM5BCPJuVh5Uihlcz
 LMh0gYZp3ggnlawRsXcDSfd42o9eot+BYmS1QHFbNuh21Z5RZnhpWs89p2kguEVVjz+bQ7g
 ukxvp7YunOBqJ1IkK0xo6em97Ys30Rs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7386B3CF935
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 19:09:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DCB33CE45A
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:09:15 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C7091400DE5
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:09:14 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493c1950518so7657535e9.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783616954; x=1784221754; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yfc+Gb05pmnEYskElszT58D7Cj03dpgIE4CO/JVlYfY=;
 b=C99cGujKsxK0nD7pnUUFqbejgCvwqczoenaLp810KWZCUEZtvGxfkZM/HNMA23sVbN
 l6ASc2uR2MOluFrex59s+OZHXKHRrsz4sURyN4Cy0j5/AdFGLa76RAs5Vsr7AOYpYK6S
 +zqji55Bj6kI+Znc56Zf9/C6ryqiJ0kTc4LALpGHoO9Wq1LxGB2stEdLsISEC0Vw+rR2
 dTQIfmGVabia/uLxoQZcupg2BsiTXEauSSyPJREZNDjB5SfKhG3jhCLXgnFb4bwOxIr7
 FGCpuXzon9VZOUQUAuK4aTt2NSPOy1MUR7bRYiVl4GEF0/UNvwva5sDow68cvjOI+ex9
 8BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783616954; x=1784221754;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yfc+Gb05pmnEYskElszT58D7Cj03dpgIE4CO/JVlYfY=;
 b=GcyFH/2fqb1ctNdkanigQXIZb9CU7+sQry5KYkpBo+FyBHs2exbuuJxMNVDZzxGPaQ
 6FSqcnFGjRpth27nyY7Pdo6Y3Lb24yJVfNaNBwu6QxZLzRGc2KQj6+2qtpWZkSDjv9ZW
 sQzrwBCVZfzMRUSKL6KkpjIaqTzHHuL8/8atk5hL9Bx9e4Ga+y0kd/lnSrS/vOfGsW1B
 Eq9FifATLlAAvMKGvm6UelSZjB2tZoNN4e8w197/jrZ4JEdnIPiUn2fymya7HOUeOA5S
 VDbDhzu1n3Lgx94/vCydGyQ0La4XyrywVcDWhXhDE/fcz9o/s4QVZrG1EXDy42L0AHl/
 dpag==
X-Gm-Message-State: AOJu0Yx+2ctraBAFYxAaI7f8WgDdg58ZV0AwU82GKeVtLd7s6H8Ziy5F
 pCiZueHU4pXDJ6fqhWxL/OxQzR3u7RxOL7Al8sFDqFkj9pra2VGS8A3sSGaH1qqfvqc=
X-Gm-Gg: AfdE7cnrRwNe8Yg4oFw8BJEJQi4/D559gtGdjQImN1kELjyINsxw45Z22UVaidKgQjh
 /jufEt56qUyCGIgKwrm/MqhCWQ/QGegyD1+E8r2phV3F97A1qCrmmMBn8ePfdY2pvRUfXYgBvMl
 +ndz4yfPAnl243q0PLIuCdTRI+eqe2F//AeDs8s378EKILdu8Skm2zvovDCrf6ayC7ti0WnXjm+
 qf/CRuIlXnUJQ9ZMb7CRV6ntKDoeQxT9Fjj26TH4b6I+DoWWU/UKJvsj5x1QxyBMOsnJ11OcFe5
 pQSQWBJHnHJ5d5672SH/TPzCRlETq1rxertK/2cBXYQGsldDK94E+NIk7Yr7Cgke703ORIZVeT4
 T2+v07nY55y1lCguOkLSWajtghQm7q5al6iW7ZKTW6q4uMLXTa4mWShYwXOT0ORMk1zIpi6VKh5
 f46jfQMJNdwOcrpJwhfNx5BIP3Q0VHr2wj
X-Received: by 2002:a05:600d:8445:20b0:493:e963:e671 with SMTP id
 5b1f17b1804b1-493f2b24ce5mr493425e9.3.1783616953706; 
 Thu, 09 Jul 2026 10:09:13 -0700 (PDT)
Received: from localhost.localdomain ([37.162.206.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73b161sm66908345e9.9.2026.07.09.10.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:09:13 -0700 (PDT)
Message-ID: <6a4fd5b9.a1b3dc3f.1e550b.63db@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260709041323.107-1-sachinp@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:09:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/min_free_kbytes: Fix incorrect pass/fail
 accounting
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

I think with this patch we are working around the problem. Which is..
the test is badly written and it needs a complete refactoring, since
it seems like a mix of old and new API.

For instance, we could heavily simplify the test_tune(), adding a helper
for setting the min free kb, then using SAFE_FORK():

static void set_min_free_kbytes(int i)
{
	unsigned long memfree, memtotal, tune;

	switch (i) {
	case 0:
		tune = default_tune;
		break;
	case 1:
		tune = 2 * default_tune;
		break;
	default:
		memfree = SAFE_READ_MEMINFO("MemFree:");
		memtotal = SAFE_READ_MEMINFO("MemTotal:");
		tune = MIN(memfree / 20, memtotal / 50);
		break;
	}

	TST_SYS_CONF_LONG_SET(PATH_VM_MIN_FREE_KBYTES, tune, 1);
}

and then handling SAFE_WAITPID() only once for all.

Anyway..below there are some considerations about the patch:

> When check_monitor() detected a violation (MemFree < min_free_kbytes) it
> called tst_res(TFAIL, ...) from the child process, which atomically
> incremented the shared results->failed counter, and then the child exited
> with status 0. Back in the parent, min_free_kbytes_test() checked the
> child exit status, found it was 0, and fell through to the unconditional
> tst_res(TPASS, ...) at the end of the function.
> 
> This produced a misleading summary of 'passed 1 / failed 1' on violation:
> the TFAIL from the monitor child was correctly counted, but the
> unconditional TPASS that followed also added to the pass count regardless
> of the violation.
> 
> Fix this by moving TPASS/TFAIL reporting into check_monitor() in the child
> process. Emit tst_res(TFAIL, ...) immediately on each individual violation
> so that the TINFO diagnostic and its corresponding TFAIL are always paired;
> the 'violated' flag is kept to suppress the final TPASS when any breach was
> seen. Emit tst_res(TPASS, ...) only when no violation was observed across
> the entire monitoring run.
> The parent's wait-result block is changed to guard against unexpected
> termination (signal death or non-zero exit) only; it emits no result for
> the monitor outcome since that is already reported by the child. The
> original condition WIFEXITED && WEXITSTATUS != 0 missed signal death;
> the corrected condition is !WIFEXITED || WEXITSTATUS != 0.

Commit message is really verbose and a bit hard to follow without reading
the code. It's good practice to describe why patch has been created in a
short way so everyone will understand the patch by reading it at the very
first look.

> 
> After the fix the summary correctly reflects the outcome:
> - No violation:  passed 1 / failed 0
> - Violation:     passed 0 / failed N  (one TFAIL per breached sample)
> 
> Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
> ---
> v1 -> v2:
> - Addressed review comments by moving TPASS/TFAIL reporting
>   into check_monitor() in the child process.
> 
> ---
>  testcases/kernel/mem/tunable/min_free_kbytes.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index bdc9126c2..132c8fe70 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -68,11 +68,9 @@ static void min_free_kbytes_test(void)
>  	SAFE_KILL(pid, SIGUSR1);
>  	SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);
>  
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -		tst_res(TFAIL, "check_monitor child exit with status: %s",
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "check_monitor child failed: %s",
>  			tst_strstatus(status));
> -
> -	tst_res(TPASS, "min_free_kbytes test pass");

We can simply remove the whole check on the exit status, since LTP
already calls tst_reap_children().

>  }
>  
>  static void test_tune(unsigned long overcommit_policy)
> @@ -173,6 +171,7 @@ static int eatup_mem(unsigned long overcommit_policy)
>  
>  static void check_monitor(void)
>  {
> +	int violated = 0;
>  	unsigned long tune;
>  	unsigned long memfree;
>  
> @@ -182,12 +181,16 @@ static void check_monitor(void)
>  
>  		if (memfree < tune) {
>  			tst_res(TINFO, "MemFree is %lu kB, "
> -				 "min_free_kbytes is %lu kB", memfree, tune);
> +				"min_free_kbytes is %lu kB", memfree, tune);
>  			tst_res(TFAIL, "MemFree < min_free_kbytes");
> +			violated = 1;
>  		}
>  
>  		sleep(2);
>  	}
> +
> +	if (!violated)
> +		tst_res(TPASS, "min_free_kbytes test pass");

This is correct and good practice. tst_reap_children() will take care of it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
