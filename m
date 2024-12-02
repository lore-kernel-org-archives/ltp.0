Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E0D78322
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741A93DD45A
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:34:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F9793DD053
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:16:14 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D2FDD1BD7706
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733102170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSk3imCUi8ZDmXU/6VFGaPW5KBEYALcVfB2iPzTZYHs=;
 b=WLZs6l/8eBbvmKXYrInOS+d4OkiLOi8nroULRTDHctQuOgE6Vxd+PpaT+Df4S325rTCta8
 TGEZ38tQ1towZT4wQzsEPH5GXh4FoowNLY6De4q+ThOF8CJyxXFpgjG29bPjC4wjNAgLJ9
 7i6OYtIV42z0bj8Y8ktr8Y94Qf2jTVE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-UzwJMSMeMb6-pIWfUzrFzw-1; Sun, 01 Dec 2024 20:16:08 -0500
X-MC-Unique: UzwJMSMeMb6-pIWfUzrFzw-1
X-Mimecast-MFC-AGG-ID: UzwJMSMeMb6-pIWfUzrFzw
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee31227b58so2954169a91.3
 for <ltp@lists.linux.it>; Sun, 01 Dec 2024 17:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733102167; x=1733706967;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XSk3imCUi8ZDmXU/6VFGaPW5KBEYALcVfB2iPzTZYHs=;
 b=APdLHn9FJMCSIZMDzNKfjmCBs2H4voXMeVDeHIAlqjLb67AENbK4XjEo81ZlXVwUKu
 p6pr10FGDDGTT1BwqHyEivNkswYMJ33KRg7RS/S4DB2cUx8xe07JMvGdpN762U7EEGC9
 4qsIGtRJynPMF5D957zK+Gzk3RjtAJQUi0JIJ5f2GrBi2lW2Ix5w9YrOW1VwSwqJOOxJ
 f7nsZw/ZpG6ztOpT337xLHOiUBywgLmiAp0XUlxhgX7/T1wbVBVl5yOCgbYK62Tpmq9T
 5KmzKhigPwl7y+Jd3eSCu8xoUMgsOkEy2ncfBdq+th1HClFuTHtA6S6nhHCyTbi9KFDC
 +9yg==
X-Gm-Message-State: AOJu0YwRRw0K8b2eGmRuOb4S4P6/k2HvXyh3YMGeRyaIcMNvb373n4W5
 a3PGxQKP1KbfRKsgorW04Pyxe1wk/6bjLxqQeiWZ2IvOiE6Zhb1jGE7Ojh1cV8fYcLl2CDJ+Mnj
 D/ZiD9S/UJtTooXY7+NJOP+m157sCg5b4YE7bGBRdgeEhDJwynJJcqvwI
X-Gm-Gg: ASbGncvJfOO6iKwIEQyLt6QFb3GXwXF6RlJWuyqAqOsAiul4YISEd3J3Z0kg9HDyC3R
 ctkddiF2H5jYzvzAQox4krJb4a6dgqZwYvLZDVImxnHwWw+u7mcJ5murMsklxDF9gwDl/o5MrAf
 kYYFu/UYJKRxTpMzHnuTBDa0KTYee3M3J10J1l1n6o1Qc92LX7sqhce6QgckmSbWCCJFW4JAJUp
 1U+dapc59PZbKl4GqNV/YRKS/pNfAew8zuHTK21t9DURNeoy9Q=
X-Received: by 2002:a17:90b:530b:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2eeb8ac75bdmr4046921a91.36.1733102167229; 
 Sun, 01 Dec 2024 17:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6W4xZSqIvXWWXZJt2+0iqTm7CFfbzsV6AXji05WOjomThRMj/WRRbuI4bKaqUNizsM6nk6Q==
X-Received: by 2002:a17:90b:530b:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2eeb8ac75bdmr4046892a91.36.1733102166834; 
 Sun, 01 Dec 2024 17:16:06 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee6e5a72c1sm4137023a91.13.2024.12.01.17.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 17:16:06 -0800 (PST)
Message-ID: <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
Date: Mon, 2 Dec 2024 09:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z0mXHSnqmstCIMrF@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IMrhUoa64L8DHDS4lUjrEutt8mY7r8bOnnmQOfqjRXQ_1733102167
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 11/29/24 18:27, Cyril Hrubis wrote:
> Hi!
>> './configure' is needed just before generating the Makefiles.
>>
>> Signed-off-by: Xiubo Li<xiubli@redhat.com>
>> ---
>>   doc/users/quick_start.rst | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
>> index 1581b1f0c..e80c1c244 100644
>> --- a/doc/users/quick_start.rst
>> +++ b/doc/users/quick_start.rst
>> @@ -54,6 +54,7 @@ generated first:
>>   .. code-block:: console
>>   
>>      $ cd testcases/open_posix_testsuite/
>> +   $ ./configure
> That should be before the 'cd testcase/...' otherwise good catch, this
> is clearly missing there.

Wait.

I check it again. I think we should do it under 
'testcases/open_posix_testsuite/' too ? For me it doesn't work only do 
this just before 'cd testcase/...'

Please see:

$ cd testcases/open_posix_testsuite/ $ ls AUTHORS bin ChangeLog 
configure.ac COPYING functional Makefile QUICK-START scripts tools 
autom4te.cache BUILD configure conformance Documentation include NEWS 
README stress

The 'make generate-makefiles' will fail without running the 
`./configure` under 'testcases/open_posix_testsuite/':

$ make generate-makefiles include/mk/env.mk:8: 
/tmp/ltp/testcases/open_posix_testsuite/include/mk/config.mk: No such 
file or directory make: *** No rule to make target 
'/tmp/ltp/testcases/open_posix_testsuite/include/mk/config.mk'. Stop.

Run then './configure' first and then run to generate the makefiles it 
will succeed:

$ ./configure checking for gcc... gcc checking whether the C compiler 
works... yes checking for C compiler default output file name... a.out 
checking for suffix of executables... checking whether we are cross 
compiling... no checking for suffix of object files... o checking 
whether the compiler supports GNU C... yes checking whether gcc accepts 
-g... yes checking for gcc option to enable C11 features... none needed 
configure: creating ./config.status config.status: creating 
include/mk/config.mk

$ make generate-makefiles make[1]: Entering directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance' make[2]: Entering 
directory '/tmp/ltp/testcases/open_posix_testsuite/conformance/behavior' 
make[2]: Leaving directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance/behavior' make[2]: 
Entering directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance/definitions' 
make[2]: Leaving directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance/definitions' 
make[2]: Entering directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance/interfaces' 
make[2]: Leaving directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance/interfaces' 
make[1]: Leaving directory 
'/tmp/ltp/testcases/open_posix_testsuite/conformance' make[1]: Entering 
directory '/tmp/ltp/testcases/open_posix_testsuite/functional' make[1]: 
Leaving directory '/tmp/ltp/testcases/open_posix_testsuite/functional' 
make[1]: Entering directory 
'/tmp/ltp/testcases/open_posix_testsuite/stress' make[1]: Leaving 
directory '/tmp/ltp/testcases/open_posix_testsuite/stress' Generating 
buildonly Makefiles Generating runnable Makefiles

>>      $ make generate-makefiles
>>      $ cd conformance/interfaces/foo
>>      $ make
>> -- 
>> 2.46.0
>>
>>
>> -- 
>> Mailing list info:https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
