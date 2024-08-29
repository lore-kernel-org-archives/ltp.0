Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CD8C83F27
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 13:49:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61623D281F
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 15:49:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FC163C0063
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 15:49:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FE4A203C5D
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 15:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724939365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YXeMCPB8XUwA+GrH5mBsawuNF+gaG4norj+rELVS68U=;
 b=b9bOf6HL3VRRyZyGYvZyHeP0ixv0vRJhdope357MLgQNOCLgzrzKSsGJOD8Bt3OWB/sXt9
 OT4PBzzj2h45sJHXhTIffxr7+b8V+7p8mZfM/Um6FqYXnlO3oLxx1pzpEDFSJMVIXPLwtQ
 o5FJG05eceMl/N2LIPt7j4sf2896J1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-eKCCOZlHO9iazv_LNmjL_A-1; Thu, 29 Aug 2024 09:49:24 -0400
X-MC-Unique: eKCCOZlHO9iazv_LNmjL_A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-371afcaab22so474924f8f.3
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 06:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724939362; x=1725544162;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YXeMCPB8XUwA+GrH5mBsawuNF+gaG4norj+rELVS68U=;
 b=nHHqdKJXnkTgsCF5b2l2FU2eVr7nywkAurXmDcbCldYv64EggHUkpBEe7aaxOusHs7
 YC9uJs0GNTVftoUT28mY0elrQ9by8dbmby+QdRjvhmtBRtKGwHBrCV7yp1NBqs5DMZm8
 +9tAMzUnK04x5+JJq2zyl/JUtQ7lKhq5sDMYNJxKTChU3ewt0jgnBAqcJak82AKO/iNS
 pWfwEm2DCN/Q8WU+1e4jju2zYDf3DmyiauvPRMFbQoGijeHAt1kzCJexwbCAzVexCug8
 RYT+TXlPfZ6S8k9KbtV+Z2x2lysI3m7lQdGYgZIHD7Fm2nhd2ZCOHddDFbrnD4rrGgD9
 IsyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzy32yX2zJvE50zNs3R/JsfUGCNNmpcT7iRZfY4VsNPp7iwKjIgZGE6f+vocMVTvetWvM=@lists.linux.it
X-Gm-Message-State: AOJu0YyuF0kSUPufddBiA0PYHIp/mC1+uaxGqsYClZQuoXGyCcQbgUvT
 i95KI0h56YuiCkxv0Ltscb2S4vczIzAIiRJVt4KBT+AaQwbrTn3fyQu6u4s/AWhOKyLG3hHEjwS
 gzTNZngnSE8PYye7mc7j6ZjpEhPaqnjmwF81hfflLSA2kpKTA
X-Received: by 2002:adf:e641:0:b0:367:980a:6aa with SMTP id
 ffacd0b85a97d-3749b589cc7mr2111413f8f.54.1724939361911; 
 Thu, 29 Aug 2024 06:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObVB/Ocly9Kb3LfFCU0iUWwVmHJ0ECuxr4T7zH9h78htvkeg8FcNKPAF8QoiQyTfnY8cGJg==
X-Received: by 2002:adf:e641:0:b0:367:980a:6aa with SMTP id
 ffacd0b85a97d-3749b589cc7mr2111364f8f.54.1724939361025; 
 Thu, 29 Aug 2024 06:49:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:c600:c1d6:7158:f946:f083?
 (p200300cbc711c600c1d67158f946f083.dip0.t-ipconnect.de.
 [2003:cb:c711:c600:c1d6:7158:f946:f083])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a4dsm18038305e9.12.2024.08.29.06.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 06:49:20 -0700 (PDT)
Message-ID: <8a16ac0e-4a3f-48cc-a118-ea05c23d5d2b@redhat.com>
Date: Thu, 29 Aug 2024 15:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <202408211026.636ade1a-oliver.sang@intel.com>
 <767d1908-dc30-42ae-9a8a-d2ad42a4d491@redhat.com>
 <8bde28af-3401-4d72-b821-d8cf01bbcd64@redhat.com> <Zs7-A5S_ivFlosrj@yuki.lan>
 <c6fb5f16-59bb-47a5-a2dd-3c4207d73614@redhat.com> <Zs8W3nQszwhbSiT9@yuki.lan>
 <4c190c79-401e-43a9-a4d1-e64f78110e0b@redhat.com> <Zs8Yg7nXZHG8U821@yuki.lan>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs8Yg7nXZHG8U821@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, lkp@intel.com,
 Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 ltp@lists.linux.it, Matthew Wilcox <willy@infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, Sven Schnelle <svens@linux.ibm.com>,
 Zi Yan <ziy@nvidia.com>, oe-lkp@lists.linux.dev,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 28.08.24 14:30, Cyril Hrubis wrote:
> Hi!
>>> If we are going to stick to ENOENT for page that wasn't faulted in the
>>> kernel from now on we should stick to it in the test as well.
>>
>> Right, it will make kernels >= 4.3 fail, though, until this series is
>> upstream. I mean, it highlights a BUG, but we had a similar condition
>> with the zeropage and worked around it in the test to keep it passing.
> 
> What we do in this case is that you are free to send a patch, we will do
> review but the final merge will happen once the code has been released
> in the upstream kernel.

Yes, let me send something out for discussion.

> 
>>> Also I think there is a third case that we do not cover either, what
>>> happens when we pass an address that is not mapped at all, e.g. NULL? Do
>>> we get EFAULT as well?
>>
>> Yes, that's documented as EFAULT and should behave that way. I can
>> extend the test to handle that as well.
> 
> Ideally the test should be ported to the new test API as well, but I can
> do that later on the top of your work.

I tried, and it all looked easy, until I realized that these tests use a 
share code-base:
	testcases/kernel/syscalls/move_pages/move_pages_support.c

That is also written using the old API. I assume mixing APIs might not 
work as expected ...

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
