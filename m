Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E403C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749210385; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4AGOXemzZfBEEXCahu7Sh93zoQ449ckTNrzKYWGwoy4=;
 b=Nauk5RrFlPU6y2mJ3YZus2OM1NuLrEz/MJA76Xln4XPMA3ZLyV1xPGtxB5aZmkY/f3ZpT
 zzQlz3QUBq6ZOpBqwFguhe1HUDq9ZG6eE0lFRSCc6lVqmHMUCxaGVsMIXpRsxXG7YTRugZX
 3RVFpAIO7ibY+q2N0OSwUyeuzcPc/18=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E1C83CA01B
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:46:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33B93C9ACD
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:46:02 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0155260029D
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:46:01 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1859201f8f.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749210361; x=1749815161; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl8uIAfGMF6ShqbqBMOzohBx+n+VkN8auqq7bO+VceM=;
 b=AvT9mI6RArrjq/XSYcUJrrozeqDRdI3KuNNCSZlEcYGzRor1HUW1Axc6KOAkHwrO/W
 tXhJNsXKI37IEVaF89kYiozWhuU+9FfZnnTwnz7/ssDcw5my3bpPWWoPSeUnanRoB6j/
 h8ZlH+HwzazyecWIN1/4BVIDrNA4DfTLpzngHaOc6QUVwQ8w6LQDh6B0cLfiAS3damdo
 tJFFRFe/9Wlu3uTboE9U7qrR3SZsZ/iJNmuqBnwthag0lSvDYfRkWK4chqf6Hws+SO6M
 QqCpdi1EdgRMjjCBCllNiUzWoC4NFP4/B7Zd2s+jgJB8gDbU74zU4z63czU5fuYM1YR/
 nd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749210361; x=1749815161;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yl8uIAfGMF6ShqbqBMOzohBx+n+VkN8auqq7bO+VceM=;
 b=DvDV4/ayFPl9m97WrEP8yfoBKsf9UC6Cnl0OaXrthx5bEIjKsMalEfylJw0vzQYuhc
 /PWIgLv7xRhG8r40m4p7IycwoqCAJGOvI+m/R0/cPFrCev4AMJgnFFvxq9NTTwn9Ruzm
 P+PeQP4fobXHsa9tMk9lG0Zc4r60bZ1wOWIe8FhpkSBj+s+FfMyEE4Vk0jzLkQE53PeH
 4dLJFup6skcXDKtJsUhUXBT1d20O5VD5BGpMFZQ86Q7NOHCvwL0v/+wpc+e4mGFcQUwr
 Xb0pIxzmjLM2IJ8x+MYda+W2gcOjpYu4PEFJLNZWv1FyM97rfLgBD8ewGKoF+TZwsimN
 wzzw==
X-Gm-Message-State: AOJu0YyS+EmTyBGEByvKgltqsU1Y7icWbuRCXCaj4S0HXHbfm7TRptdP
 7obdlgGIb6R+05LZnbeP7HhTaxK7ggYIV7Oac0hQD1gGr7HxDSdVNwWk178+mOaXtFE=
X-Gm-Gg: ASbGncvZwj/OCDx1FcEPhmfZr3lKryCjmAh7YG2kldclAQ56ryRZE6TMsUEAnbQmoa6
 dT5qhyx4JYvMiB638PZEkPO8/R5eMyzyB2n3BFB38PdWrKcsyOiEHUWIqe/IDrEawQDnz74vCo2
 VyShsr+LxifxempbA/JR6nIowhTj2q6uOzqBH626XdqFEG+AWwyUuUrrK93Odm2TG8/vX9oPkhF
 9tZc/aVV7SvEBGNz4lyrGovKZW6jXM+4/4mFFI4NA5Zny0ZwcOmPwbNPQEsLYw8uqA04nS145eX
 xW3GE1tc/aQUV4/JcU++KKmy8lbIRda7YHYNJQ==
X-Google-Smtp-Source: AGHT+IHbEdk3Kcx3CqEuTpp3ARVitNZm8wV4n56ozxd0uEOfOk3TK3IUc/7XUWLOW3i/8ZdsFt8MVg==
X-Received: by 2002:a05:6000:2082:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3a53188ca22mr2889462f8f.13.1749210361320; 
 Fri, 06 Jun 2025 04:46:01 -0700 (PDT)
Received: from localhost ([189.99.236.12]) by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-87ebd23127bsm989417241.34.2025.06.06.04.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 04:46:00 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 06 Jun 2025 08:45:57 -0300
Message-Id: <DAFFBKW0G6Y9.1IOAQDST1JG6B@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-5-0b5cff90c21c@suse.com>
 <20250606114412.GD1289709@pevik>
In-Reply-To: <20250606114412.GD1289709@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/8] syscalls/mknod05: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri Jun 6, 2025 at 8:44 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
> ...
>> -/*
>> - * Test Name: mknod05
>> - *
>> - * Test Description:
>> - *  Verify that mknod(2) succeeds when used by root to create a filesystem
>> - *  node with set group-ID bit set on a directory with set group-ID bit set.
>> - *  The node created should have set group-ID bit set and its gid should be
>> - *  equal to that of its parent directory.
>
>> - *
>> - * Expected Result:
>> - *  mknod() should return value 0 on success and node created should have
>> - *  set group-ID bit set and its gid should be equal to that of its parent
>> - *  directory.
>> - *
> ...
>> +/*\
>> + * Verify that mknod(2) succeeds when used to create a filesystem node with
>> + * set group-ID bit set on a directory with set group-ID bit set. The node
> very nit: The original reader was not consistent when referring to setuid.
> Mostly he used "set-group-ID" which is also used in man chmod(2) and in The
> Linux Programming Interface book. Therefore I'll modify before merge:
>
> s/set group-ID/set-group-ID/
>
>> + * created should have set group-ID bit set and its gid should be equal to
>> + * that of its parent directory.
>>   */
>
>> -#define LTPUSER		"nobody"
>> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
>> -#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO
>
> And again, as I noted at mknod0[34].c here is constant used for mknod() uses
> S_IFIFO.
>
>> -struct stat buf;		/* struct. to hold stat(2) o/p contents */
>> -struct passwd *user1;		/* struct. to hold getpwnam(3) o/p contents */
>> +#define MODE_RWX 0777
>> +#define MODE_SGID (S_ISGID | 0777)
>
> But you don't use it.
>
> ...
>> +	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
>
>> -		/*
>> -		 *  Attempt to create a filesystem node with group id (sgid)
>> -		 *  bit set on a directory with group id (sgid) bit set
>> -		 *  such that, the node created by mknod(2) should have
>> -		 *  group id (sgid) bit set and node's gid should be equal
>> -		 *  to that of effective gid of the process.
>> -		 */
>> -		TEST(mknod(node_name, MODE_SGID, 0));
>
> I vote for following diff (using a constant you defined also for mknod03.c).
> No need to repost, I can change it before merge.

That would be perfect, thank you!

>
> Kind regards,
> Petr
>
> +++ testcases/kernel/syscalls/mknod/mknod05.c
> @@ -7,8 +7,8 @@
>  
>  /*\
>   * Verify that mknod(2) succeeds when used to create a filesystem node with
> - * set group-ID bit set on a directory with set group-ID bit set. The node
> - * created should have set group-ID bit set and its gid should be equal to
> + * set-group-ID bit set on a directory with set-group-ID bit set. The node
> + * created should have set-group-ID bit set and its gid should be equal to
>   * that of its parent directory.
>   */
>  
> @@ -17,7 +17,7 @@
>  #include "tst_test.h"
>  
>  #define MODE_RWX 0777
> -#define MODE_SGID (S_ISGID | 0777)
> +#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)
>  
>  #define TEMP_DIR "testdir"
>  #define TEMP_NODE TEMP_DIR "/testnode"
> @@ -29,7 +29,7 @@ static void run(void)
>  {
>  	struct stat buf;
>  
> -	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
> +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO_SGID, 0);
>  
>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, S_ISGID);
> @@ -48,7 +48,7 @@ static void setup(void)
>  
>  	SAFE_MKDIR(TEMP_DIR, MODE_RWX);
>  	SAFE_CHOWN(TEMP_DIR, nobody_uid, free_gid);
> -	SAFE_CHMOD(TEMP_DIR, MODE_SGID);
> +	SAFE_CHMOD(TEMP_DIR, MODE_FIFO_SGID);
>  }
>  
>  static struct tst_test test = {


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
