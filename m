Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D0CC0218D
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738171179; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6rpkGL7VWCf9oWH4uODReKU+usWZ/exh2WQVsiJ/r9M=;
 b=Hi+e/gEc0K8HrfQ5HvGagV+WU03lVRTtJe9U3G5fV568N5V1vA8JsK+Ivmctn8Gfkn+xU
 SP6vmJixbZCOKfn7Xg868pa2G33YSAkSSguiXjwAKBPIr6FHgGN+9iMpcC7cc4CNRnlwDEw
 p0iO6X2FatoKysm1YV9bxPabrnyNK0A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CFA93C6F84
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 18:19:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BAFB3C23C9
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 18:19:17 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E6FE76170A0
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 18:19:15 +0100 (CET)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166f1e589cso11907125ad.3
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 09:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738171153; x=1738775953;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26r6Lxn/gZNPGEw+7tthsdkLbr5x8LE+5mVw61jJDhI=;
 b=AAzz3OsPGlkvId+7jDBadJIbRSYu4wHELQ2oTzDwCv/+Fr3Rc48WrJvgBt1hxUuays
 oKbXPGtVwbr8QQUe6W9mFQkShA5gyM3tbOKP+2DJ70kM/xFedT1UHE+73aP/RQDiqv6e
 ac2o4EPNTOct6kfwW+BASPrhHayVQh1YOdQJPHu+U4nGlJdeGdtGYmJkKMpK4aoeU9AJ
 +wFcGC6A4DxdMpJPAHlupUa3RS3OMPeLGwMOUrZoB6TUfc+JYlgwfLbcTYLbnQcMLcCf
 7cLJCzmPPwjoB3zvCDRAws3p0nNfdMinhxYzV/NYBXbpNTwH5NUyzFi44vJala92a5Wc
 ATyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXac3npJvK8nam1ajo0dG3MTuF9KmeYkFvMhKDAMftCfsryeVf+HPvl3qIeMp80STaYuVM=@lists.linux.it
X-Gm-Message-State: AOJu0Yzo5F4ZCeUnmp8IzrY0xweyLoC0GZUJxr317e9LHXENTgCCBkim
 vqF1pqIfKpZxsHnO5pkz5OuNsBAL6t01jrGt5OA+R89GDwos4WKyLgzppA==
X-Gm-Gg: ASbGncv+eeLspIabDEivA4Zv4W+qWtskdKDuWf8yRFKNSJOb2Us3n6JK68qcDDqBC0a
 L9xZEBPF9/ruMBR91clJNJlCasswOPQetKr3Bh/VVmsHa8I/G11Ju98HYuCFtDeAohjmxFLL0xN
 lP0TYoWn8YfZeMO/jjjWbSBkkW8uCyrgQ+KPet+xBcspuiOe1aYPX6G1MrC8kEn0NUo1dxsy6Yf
 a9ehxkOZRe29k1unW9hJcAW+XR1o0PQ1qQp1er7ZBHXN4PekDCW20xNsQ6m3TC2VZk2LYNNJnYw
 vwr8Zfp8zw==
X-Google-Smtp-Source: AGHT+IGOFCfbukJlmWIgCKWQBrvoBrVHlsY9xahF0ZbAh9vzdI8sNkx7lJGDtbvy3NkFcV7IuRte8g==
X-Received: by 2002:a05:6a00:c88:b0:727:3c37:d5fb with SMTP id
 d2e1a72fcca58-72fd0c70535mr5769414b3a.16.1738171153111; 
 Wed, 29 Jan 2025 09:19:13 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac490acf549sm8893504a12.35.2025.01.29.09.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2024; t=1738171150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26r6Lxn/gZNPGEw+7tthsdkLbr5x8LE+5mVw61jJDhI=;
 b=j2B8nmDMqVxTj3ZrM4Omu7Q6LWniT5EFywMG0zt2nOa/lgGs1Uf6Rj9AWLVfAq6mLhuDMv
 XlJvbNcSIZ5CdMMmSPxn6g1XdlbjOWScioHkuF4CVD98KBKp7GY1znFGBDCiUsSV1wUIue
 NLoOu8NQxjGlSN2Fuo3j77svIKlNsJZGGdvjQ5IcW4KsOajTISs5EYFYdtv9ut/LBKyLmT
 H5SllzTPy21/ZNtcORHbKdxOMliORBVFoN5Gcpue68LHd6Wh0/PqQPogZJBBN2mxvOwjqY
 yS0hA+43j8nrB0ZwPaMGii0FMgqCLIzSPwDCCz2bIVVUSWFp+ChPCewteK1WzQ==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Wed, 29 Jan 2025 14:19:04 -0300
Message-Id: <D7EQ8W8TM84D.T8OZ3RKV2RH3@marliere.net>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Ricardo B. Marliere"
 <rbm@suse.com>, "Linux Test Project" <ltp@lists.linux.it>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
 <20250114-conversions-v1-1-7869a9f786d0@suse.com>
 <7f1c0594-e6ef-497b-852a-e8fe6ee2afe4@suse.com>
In-Reply-To: <7f1c0594-e6ef-497b-852a-e8fe6ee2afe4@suse.com>
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <ricardo@marliere.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

thanks for reviewing!

On Wed Jan 15, 2025 at 10:14 AM -03, Andrea Cervesato wrote:
> Hi!
>
> On 1/14/25 23:26, Ricardo B. Marliere via ltp wrote:
>> From: Ricardo B. Marliere <rbm@suse.com>
>>
>> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
>> ---
>>   testcases/kernel/syscalls/mmap/mmap001.c | 206 ++++++++-----------------------
>>   1 file changed, 49 insertions(+), 157 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
>> index dabb7d1e4998b1097e179abe23555926f5841117..bc9b4155e8b53f942ef694fdf3187c0e544a97cd 100644
>> --- a/testcases/kernel/syscalls/mmap/mmap001.c
>> +++ b/testcases/kernel/syscalls/mmap/mmap001.c
>> @@ -1,183 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
>>    *                    Aaron Laffin <alaffin@sgi.com>
>> + * Copyright (c) 2025 Linux Test Project
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * as published by the Free Software Foundation; either version 2
>> - * of the License, or (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>> - *
>> - * mmap001.c - Tests mmapping a big file and writing it once
>> + * Tests mmapping a big file and writing it once
> Description is a bit short and it needs a bit more information. For 
> example, what we expect to see and what could happen during test (SEGV 
> for example).

Ack.

>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL | TTERRNO,
>> -				 "munmapping %s failed", filename);
>> -		} else {
>> -			tst_resm(TPASS, "munmapping %s successful", filename);
>> -		}
>> +	/*
>> +	 * Seems that if the map area was bad, we'd get SEGV,
>> +	 * hence we can indicate a PASS.
>> +	 */
> If this is true, we need to find a way to test that specific scenario. 
> This can e done by forking a process where test is running and to check 
> if SIGSEGV killed it after calling SAFE_WAITPID()

Good idea, I kept the original comment and TPASS string but it could
surely be expanded. What do you think of the following? I'll be sending
as v2 when the series receive some more reviewing.

diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
index bc9b4155e8b5..10ce7a48e7c2 100644
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ b/testcases/kernel/syscalls/mmap/mmap001.c
@@ -8,7 +8,8 @@
 /*\
  * [Description]
  *
- * Tests mmapping a big file and writing it once
+ * This test will map a big file to memory and write to it once,
+ * making sure nothing bad happened in between such as a SIGSEGV.
  */
 
 #include "tst_test.h"
@@ -25,6 +26,8 @@ static void setup(void)
 
 static void run(void)
 {
+	pid_t pid;
+	int status;
 	char *array;
 	unsigned int i;
 	unsigned int pages, memsize;
@@ -40,20 +43,23 @@ static void run(void)
 	SAFE_LSEEK(fd, memsize, SEEK_SET);
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
 
-	array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
-
-	tst_res(TINFO, "touching mmaped memory");
-	for (i = 0; i < memsize; i++)
-		array[i] = (char)i;
-
-	/*
-	 * Seems that if the map area was bad, we'd get SEGV,
-	 * hence we can indicate a PASS.
-	 */
-	tst_res(TPASS, "we're still here, mmaped area must be good");
-
-	SAFE_MSYNC(array, memsize, MS_SYNC);
-	SAFE_MUNMAP(array, memsize);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
+		tst_res(TINFO, "touching mmapped memory");
+		for (i = 0; i < memsize; i++)
+			array[i] = (char)i;
+		SAFE_MSYNC(array, memsize, MS_SYNC);
+		SAFE_MUNMAP(array, memsize);
+		exit(0);
+	} else {
+		SAFE_WAITPID(pid, &status, 0);
+		if (WIFSIGNALED(status) && WEXITSTATUS(status) == SIGSEGV)
+			tst_res(TFAIL, "test was killed by SIGSEGV");
+		else
+			tst_res(TPASS,
+				"memory was mapped and written to successfully");
+	}
 }
 
 static void cleanup(void)
@@ -66,6 +72,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
+	.forks_child = 1,
 	.options =
 		(struct tst_option[]){
 			{ "m:", &m_copt,



> Kind regards,
> Andrea

Thank you,
-	Ricardo.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
