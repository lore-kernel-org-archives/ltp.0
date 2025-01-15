Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A26C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736946902; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Y9w2olf9kug/s+VBncfimjPSDHaQGTBcBN0YwRPs24M=;
 b=NSF8Jm+1JjSIZRIpWmBocME7vhB+ACz7X+pEMKd/+7IyR3y/d5NknnKq/jcXWsvNaQiH6
 T02IPSga30sKzS/oqoFKa1ovSs5s00+nrSIxs78V8/NjK2nTdp04dJT+A3YCOhZw8Gd8nhM
 5MU0I4ZSShm05TNZc2h25qkq6Dppf+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5E5A3C7B48
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 14:15:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 753323C0299
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 14:14:40 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C8CB622261
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 14:14:40 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso64352525e9.3
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736946879; x=1737551679; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoOdYJnx3UBt6EfYjOgQoxlNiIoHzlSO+jTjOs3C4vs=;
 b=hATgCFT1oDVgtU+al//MBpTFVRD02gVpSMNJV9v57u2NuwiMScgizKnFtN9IO3HAh8
 GllumZDvybopWeFxoVwhAQ9sVzVoLNrvqelkOdhUiz4H6OI7TwlYnCWbagESEo3vgjeb
 hmAsEkqRxpZ4xgyxCOMhI7ZNPkhDZOVcJjmPuveVVZKnkiz1NqdyWiuKKB6BHdjYOBct
 CJ3obzR8zYfkr6KDXrqUsByS75f69VXdO7hUHxuuxv8iXZymGxWOSTAY6j4Y9NOvZYiz
 gSYl1FfncEU5M95WP69gkwyOj3P+JuASN+zt/x3maNUo/Z1qdkpu8BQg4ESyQSTOTJOl
 wR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736946879; x=1737551679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CoOdYJnx3UBt6EfYjOgQoxlNiIoHzlSO+jTjOs3C4vs=;
 b=j3OBVZzCxNZWBDfuX0fEW5RAK4OqZjWVb0eoBKMiYIuAEUJfqMTMvTI8/irYHHUTc/
 m15QGxDZwd1F/nza7kBrmJMblNSU+65oNKn/+vh2AnsBM2xR5aYMAQv/36mskqj/TtzJ
 Nln+XdLckxHxCSnajsW7vL1HNnnx5+ZRCgYh6KAEcPdPipRz885OfnXjClrhM/91n8CG
 Ntu/tZCvMK1VqA8OFXS9HIOy28c830HvxCvQ3vXvwwgsUm684h7eOT0h8bM+Ofm2P7E1
 uBQbMkDWzcBAUVs8bFLZ3Hda3z3J+MhVwzeuDdeFsWocD2Fd6VGof9YBzOmAcjqDXnUt
 6bzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWowmSh/uCtgcsRzGT293WcQ3BnHvvpjRK2/RypOEu2tlIy3yxsj0Kcvx1s9bj1PvzvqVk=@lists.linux.it
X-Gm-Message-State: AOJu0YyHlYIZ6ykbKGpzmSFSDPR9HsZ7Er9eEyW6rChOt4ECQhQOpACX
 smmipQUgR8pKFFzdM/uhuH1sOP8agHm8nUwC6Akwm8spkfFwvKg5DheSMFN+V/c=
X-Gm-Gg: ASbGnct1rRoCOiSqx/uBr2CPhrZZ4EIevjWyMABU9GJ0qQPIusW3xq26h+rstQ+dimA
 IGg3PDyA/XuP3F8B6v0ifsGQCfElAUkJmf8xLVCWscjMMBtkjiwTuAD4ovQi+NqrGmoCVb38Hnz
 88z3I65oTL199W4T0HKT8rQUPucxuXcBgKRn0x2qX+8u9G6NDfP/7Si3l4XZ4zLdn1xNXWeXC0s
 kVw2/2Ms+f7j3/CT5z9m3Y8cyO7SmmIGJKDD//MvpV5l8xZjEbH37pQaFVmRv8m5QoxRHQKtKLU
 MTZ21c0NlYGczE+VSremdtXaUqlzUO3paIBjor0zISNhaxXq0/QveQ8vlnjn+nAkgsE7mbjVE/v
 L8diRe2lWn1EZ/+8Ke2s=
X-Google-Smtp-Source: AGHT+IGrXywZNOb39KWBbH3CYRJJz0nxkqqFPEytm01m2LBx6MQYbIw2fkdiSk//B6iENcMFAuEzBQ==
X-Received: by 2002:a05:600c:45c3:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-436e26c3c3fmr298413195e9.10.1736946879477; 
 Wed, 15 Jan 2025 05:14:39 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7528076sm23500045e9.25.2025.01.15.05.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 05:14:39 -0800 (PST)
Message-ID: <7f1c0594-e6ef-497b-852a-e8fe6ee2afe4@suse.com>
Date: Wed, 15 Jan 2025 14:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
 <20250114-conversions-v1-1-7869a9f786d0@suse.com>
Content-Language: en-US
In-Reply-To: <20250114-conversions-v1-1-7869a9f786d0@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] mmap001: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 1/14/25 23:26, Ricardo B. Marliere via ltp wrote:
> From: Ricardo B. Marliere <rbm@suse.com>
>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>   testcases/kernel/syscalls/mmap/mmap001.c | 206 ++++++++-----------------------
>   1 file changed, 49 insertions(+), 157 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
> index dabb7d1e4998b1097e179abe23555926f5841117..bc9b4155e8b53f942ef694fdf3187c0e544a97cd 100644
> --- a/testcases/kernel/syscalls/mmap/mmap001.c
> +++ b/testcases/kernel/syscalls/mmap/mmap001.c
> @@ -1,183 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
>    *                    Aaron Laffin <alaffin@sgi.com>
> + * Copyright (c) 2025 Linux Test Project
> + */
> +
> +/*\
> + * [Description]
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> - *
> - * mmap001.c - Tests mmapping a big file and writing it once
> + * Tests mmapping a big file and writing it once
Description is a bit short and it needs a bit more information. For 
example, what we expect to see and what could happen during test (SEGV 
for example).
>    */
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
>   
> -#include "test.h"
> +#include "tst_test.h"
>   
> -char *TCID = "mmap001";
> -int TST_TOTAL = 5;
> -static char *filename = NULL;
> -static int m_opt = 0;
> +static int fd = -1;
> +static int m_opt = 1000;
>   static char *m_copt;
>   
> -static void cleanup(void)
> -{
> -	free(filename);
> -
> -	tst_rmdir();
> -}
> -
>   static void setup(void)
>   {
> -	char buf[1024];
> -	/*
> -	 * setup a default signal hander and a
> -	 * temporary working directory.
> -	 */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	snprintf(buf, 1024, "testfile.%d", getpid());
> -
> -	if ((filename = strdup(buf)) == NULL) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "strdup failed");
> -	}
> -
> -}
> -
> -static void help(void)
> -{
> -	printf("  -m x    size of mmap in pages (default 1000)\n");
> +	if (tst_parse_int(m_copt, &m_opt, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid size of mmap '%s'", m_copt);
>   }
>   
> -/*
> - * add the -m option whose parameter is the
> - * pages that should be mapped.
> - */
> -option_t options[] = {
> -	{"m:", &m_opt, &m_copt},
> -	{NULL, NULL, NULL}
> -};
> -
> -int main(int argc, char *argv[])
> +static void run(void)
>   {
>   	char *array;
> -	int lc;
>   	unsigned int i;
> -	int fd;
>   	unsigned int pages, memsize;
>   
> -	tst_parse_opts(argc, argv, options, help);
> -
> -	if (m_opt) {
> -		memsize = pages = atoi(m_copt);
> -
> -		if (memsize < 1) {
> -			tst_brkm(TBROK, cleanup, "Invalid arg for -m: %s",
> -				 m_copt);
> -		}
> -
> -		memsize *= getpagesize();	/* N PAGES */
> -
> -	} else {
> -		/*
> -		 * default size 1000 pages;
> -		 */
> -		memsize = pages = 1000;
> -		memsize *= getpagesize();
> -	}
> -
> -	tst_resm(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
> -		 memsize);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		fd = open(filename, O_RDWR | O_CREAT, 0666);
> -		if ((fd == -1))
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "opening %s failed", filename);
> -
> -		if (lseek(fd, memsize, SEEK_SET) != memsize) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup, "lseek failed");
> -		}
> +	memsize = m_opt;
> +	pages = m_opt;
> +	memsize *= getpagesize();
>   
> -		if (write(fd, "\0", 1) != 1) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup,
> -				 "writing to %s failed", filename);
> -		}
> +	tst_res(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
> +		memsize);
>   
> -		array = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
> -		if (array == MAP_FAILED) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup,
> -				 "mmapping %s failed", filename);
> -		} else {
> -			tst_resm(TPASS, "mmap() completed successfully.");
> -		}
> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT);
> +	SAFE_LSEEK(fd, memsize, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
>   
> -		tst_resm(TINFO, "touching mmaped memory");
> +	array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
>   
> -		for (i = 0; i < memsize; i++) {
> -			array[i] = (char)i;
> -		}
> +	tst_res(TINFO, "touching mmaped memory");
> +	for (i = 0; i < memsize; i++)
> +		array[i] = (char)i;
>   
> -		/*
> -		 * seems that if the map area was bad, we'd get SEGV,
> -		 * hence we can indicate a PASS.
> -		 */
> -		tst_resm(TPASS,
> -			 "we're still here, mmaped area must be good");
> -
> -		TEST(msync(array, memsize, MS_SYNC));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "synchronizing mmapped page failed");
> -		} else {
> -			tst_resm(TPASS,
> -				 "synchronizing mmapped page passed");
> -		}
> -
> -		TEST(munmap(array, memsize));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "munmapping %s failed", filename);
> -		} else {
> -			tst_resm(TPASS, "munmapping %s successful", filename);
> -		}
> +	/*
> +	 * Seems that if the map area was bad, we'd get SEGV,
> +	 * hence we can indicate a PASS.
> +	 */
If this is true, we need to find a way to test that specific scenario. 
This can e done by forking a process where test is running and to check 
if SIGSEGV killed it after calling SAFE_WAITPID()
> +	tst_res(TPASS, "we're still here, mmaped area must be good");
>   
> -		close(fd);
> -		unlink(filename);
> +	SAFE_MSYNC(array, memsize, MS_SYNC);
> +	SAFE_MUNMAP(array, memsize);
> +}
>   
> -	}
> -	cleanup();
> -	tst_exit();
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.options =
> +		(struct tst_option[]){
> +			{ "m:", &m_copt,
> +			  "Size of mmap in pages (default 1000)" },
> +			{},
> +		},
> +};
>
Kind regards,
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
