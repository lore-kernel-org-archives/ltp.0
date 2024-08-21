Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54891C52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 08:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5665D3D2254
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 10:44:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBF493D1B17
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 10:44:41 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1685A1A02389
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 10:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724229879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8+3vlnfHmJwpwssq29Yu4QXZMa+kW4/g5w49AQIsMVs=;
 b=XYnketHwy8m2PjA1EHrhYuVNDv1sX2j313+MEDP2Z2Mr7qYbaeigFkK1T8REnvUopF388m
 gVvtaTD2PLdNS+YwGt4vLTa9aHYJvop4Rlxkpc8ZKejX8SlXLmdMGSL+WdT7Z9dNwGYT7G
 RHli1imlfvZnuqcK2eNAUwnkIKDRavk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-fMbeRorwPnuiSxLdQnCHrw-1; Wed, 21 Aug 2024 04:44:36 -0400
X-MC-Unique: fMbeRorwPnuiSxLdQnCHrw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42aa70df35eso49458035e9.2
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 01:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724229875; x=1724834675;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8+3vlnfHmJwpwssq29Yu4QXZMa+kW4/g5w49AQIsMVs=;
 b=GCLu35zY/rTni0TlYSIceubUSetxKQ5C+27EHiEU/yUaHOGk6qPyOakmsxiSuk2QFd
 STZiXHEuRrFckntAGya5oyLyILwEc7Rnw2ZeEesCvfL7+u6nO4rjm04K455sPQVWRoWH
 geUsU0CnODNrnn8iNMtmleJXqXdKlwOwDt7LQuIfzcAfAecIDnOK7gjQp1YQDiGSHxWS
 xPzBhjpneTFKXN6ujpcVjBgfUaSa+V66G4/laZYBOEDO5F51BAXrAAyznxxZn9TuaYSf
 8vttJPmIzXguU3+p8HgYQwYBhGABkbX7CenVf9Ot9Y50JXt+z4KPm9aGxBa+q0Kj+7g8
 iAwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXICihYr6ticr8qOJ+xxWKQmdRzvpWydITk3jD48jHU3f1dL9reHTEv6TLR2Kog5FN/I/8=@lists.linux.it
X-Gm-Message-State: AOJu0YzpRw74twJE69sob7gQUxWkGEHG/ukZwoBp3zHhGutjGw5GpI02
 Bk4a/AlaMxL6Stuaw9oJmTP/q6VtK5EbDIxZbbphZ2WSpNLkv+jPwo1hTtLWuqgVBfwxfSz0MZA
 S0qQsg0h42bRl010/U0r4Hhx1pE2By5WbQHUkZSYpjaUwuEQV
X-Received: by 2002:a05:600c:1392:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42abd255453mr13640505e9.35.1724229875429; 
 Wed, 21 Aug 2024 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBftAN+6Be0P7G6DupA5viq3qyf1tBgO8VTsIaJQrFRT5PDE2+3jX3exovRXCsq7Kb7H6Rw==
X-Received: by 2002:a05:600c:1392:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42abd255453mr13640205e9.35.1724229874535; 
 Wed, 21 Aug 2024 01:44:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734?
 (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de.
 [2003:cb:c705:4300:16d5:c5b:8388:a734])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718989708esm15283766f8f.70.2024.08.21.01.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 01:44:34 -0700 (PDT)
Message-ID: <767d1908-dc30-42ae-9a8a-d2ad42a4d491@redhat.com>
Date: Wed, 21 Aug 2024 10:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <oliver.sang@intel.com>
References: <202408211026.636ade1a-oliver.sang@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202408211026.636ade1a-oliver.sang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm/migrate] b28dd7507f:
 ltp.move_pages04.fail
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
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, lkp@intel.com,
 Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, ltp@lists.linux.it,
 Janosch Frank <frankja@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 21.08.24 06:44, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.move_pages04.fail" on:
> 
> commit: b28dd7507f2dd7923325eab6ea1f291416dcc396 ("mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master bb1b0acdcd66e0d8eedee3570d249e076b89ab32]
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240817
> with following parameters:
> 
> 	test: numa/move_pages04
> 
> 
> 
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408211026.636ade1a-oliver.sang@intel.com
> 
> 
> 
> Running tests.......
> <<<test_start>>>
> tag=move_pages04 stime=1724192393
> cmdline="move_pages04"
> contacts=""
> analysis=exit
> <<<test_output>>>
> move_pages04    1  TFAIL  :  move_pages04.c:142: status[1] is ENOENT, expected EFAULT

This change is to be expected, and I touched on that in the patch 
description. I am rather surprised that we have a test for that 
handling, especially because it changed already (see below).

The man page says:

	-EFAULT: This is a zero page or the memory area is not mapped
		 by the process.

"memory area not mapped" to me translates to "there is no mmap()", not 
"there is no page mapped". And it says:

	-ENOENT: The page is not present.


It's not really specifies what happens when "The memory area is mapped 
by the process, but no page is faulted in.".

And the old handling was even inconsistent: to achieve the old behavior, 
we abused FOLL_DUMP, which triggers in mm/gup.c:no_page_table():

(1) is_vm_hugetlb_page() *and* a hugetlb page is in the pagecache?
     Return -EFAULT. Otherwise return NULL -> -ENOENT.
(2) vma_is_anonymous() || !vma->vm_ops->fault ? Return -EFAULT.
     Otherwise return NULL -> -ENOENT.

So, if nothing is mapped, for things like shmem we would always return 
"-ENOENT", for anonymous memory always "-EFAULT", and for hugetlb 
"-ENOENT" or "-EFAULT", depending on the page cache state. Inconsistent, 
and that handling is only in place because we abused FOLL_DUMP.

(there are other issues in the old implementation: on PMD migration 
entries we would likely have returned -EFAULT in some cases where we 
should have returned -ENOENT ...)

While writing folio_walk, I temporarily had a version that would return 
error codes instead of NULL to indicate "there is something, but we 
cannot return  it" and "there is nothing", but it didn't feel right. And 
I'm not really interested in revisiting that :)

----

Staring at the test,  I realized the that behavior *changed* already, 
because we wanted to fix the "zero page" and started abusing FOLL_DUMP, 
but ended up changing the behavior for unpopulated (nothing mapped) 
memory as well:

  * NAME
  *	move_pages04.c
  *
  * DESCRIPTION
  *      Failure when page does not exit.
  *
  * ALGORITHM
  *
  *      1. Pass zero page (allocated, but not written to) as one of the
  *         page addresses to move_pages().
  *      2. Check if the corresponding status is set to:
  *         -ENOENT for kernels < 4.3
  *         -EFAULT for kernels >= 4.3 [1]
  *
  * [1]
  * d899844e9c98 "mm: fix status code which move_pages() returns for 
zero page"
  *

Likely test is *wrong*, because it claims to test the "zero page" but it 
just passes "unpopulated" memory.

Let me dig deeper into the test.

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
