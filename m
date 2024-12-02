Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404FBD7831F
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9303DD465
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:33:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18893D98F5
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:00:49 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1FF1F1020DEE
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733101246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXDjoyDGbdGJFrHTUV5STwitXMd9LhvrYV6xfcqauvY=;
 b=JNCd0IqMMOB0R4aX1b8ocv2DyImWRLP+C3BuTeflYxfRWzhFcECun7kLT6AuqOz04SK6Y6
 r0VVB47+xwoTRlE1gauFbHZE95uo9TDrQFcPLBAJPS33+2sxX2U/GoifkcltcCRjT/yHf9
 8y5z//xYqRs8TOuYptx55ZReexaqfeU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-YXIyY-9CPZaXvJUPDhRw3w-1; Sun, 01 Dec 2024 20:00:45 -0500
X-MC-Unique: YXIyY-9CPZaXvJUPDhRw3w-1
X-Mimecast-MFC-AGG-ID: YXIyY-9CPZaXvJUPDhRw3w
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so983708a91.1
 for <ltp@lists.linux.it>; Sun, 01 Dec 2024 17:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733101244; x=1733706044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXDjoyDGbdGJFrHTUV5STwitXMd9LhvrYV6xfcqauvY=;
 b=lGaoa+LGRiH9dFxt1F2BfjLrGIDQJj7/2TrkJVGURotXXn9ck24EzPDI0qgis0aIdN
 pH1LrXf9m6adnbiY3wUgE+u40T6dS2eFafL858jXNFWrbI6pM9jbtjCK5KfcsDPHWFTe
 RCdnRTA8x0c/NKFng/hjlrioml2YpVaN7dwbFL/V9QDGxpAxod7xf0VWAXIO0cPclpFR
 sGlWMBszi6utkJOLF27mbN5FtyS+diCvzluYmNJaO6XU8vIyFg4YgTVhzc2LopNAKihD
 HQNAFDxOFX2cpX+lc7YmTZIM03tfNgZR5fcNxu4h4hHf/Zk0sanufcWBLJqkEnX4Wlgq
 xL3A==
X-Gm-Message-State: AOJu0YxrJ9mb5CNXhxBs9yRIAi2iovm3nbQQaG9h+ugMeg0JrnbDqgNG
 i1dPQoIric/L9z0sMR9pfFn4f+Ijys6FH5pQpnXudTNkGpADON5z1PZYcH4qP9LycCJdTAr21z/
 2q+9zbGfdGPEi1Vaj3xCJI8nSP/WkUoBtP7hLHDemJc7NJ6Zt
X-Gm-Gg: ASbGnctBESMYC6OqDQ/BpMfqAxqXteQGgtm0SdJ5VyPn0Qk3ZqBW6OPg1Q0Cu8sUYBk
 wG42lc49wd7UyLxz/ZegP9BNfkoyEUfPT6DhcGXbWP/pHs2piixmSiJ1DV5Gu4E4QcySoyEs4QF
 mgQ+1Ng4P3fPlSHktCMA9uOvN1scL97/eHSB2PZ94L/VybOBupINQRhYlzpIO9sbo5jG+NgzkPb
 f2XGFa2Y08OFFq/Ttvj3CFTW1ws9/ffwxYM2r+4wCJGyr2jq7E=
X-Received: by 2002:a17:90b:1dd2:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2eec5eabed1mr3592926a91.29.1733101243992; 
 Sun, 01 Dec 2024 17:00:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl5F2sSLutUPl1cZ8gKsk/vTOnuxdjoMePMl1X0n1eAkhrCok8GwjcHJfMeEF4jcsYkJi/lA==
X-Received: by 2002:a17:90b:1dd2:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2eec5eabed1mr3592868a91.29.1733101243441; 
 Sun, 01 Dec 2024 17:00:43 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee58666b31sm2977870a91.2.2024.12.01.17.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 17:00:42 -0800 (PST)
Message-ID: <1873bfe4-3d44-40a7-89cb-0742bea8494a@redhat.com>
Date: Mon, 2 Dec 2024 09:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z0mXHSnqmstCIMrF@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jVZ1vvaikzt3i_0BZdQjwpH4F5XEkcmSPlIfuPVuGsQ_1733101244
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
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
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
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

Good catch.

Fixed it.

Thanks!


>>      $ make generate-makefiles
>>      $ cd conformance/interfaces/foo
>>      $ make
>> -- 
>> 2.46.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
