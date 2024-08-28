Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA07C54ECC
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 10:51:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9F6B3D2794
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 12:51:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60B093D272A
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 12:51:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6682C616652
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 12:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724842288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zm0TwZoHc6xSTNSFjy0hnAEuUfI8PfQsywCXlruU0iM=;
 b=g9R/O2WPev2KYDOIZXoNDy+rTswO9bugFCIv7dZMmKRcxTs5kq4A84LGA8Gx8/Vzq3P9Z+
 cad0PsQbLlJJM4cjRKXp1YTKJlm9CO5DKlHbjlfwUydIre+aqDWfZIdQcwozWzrxzEeKoO
 7K4MnhpJwQTXBUpMDS3U4ULmrBZlAh4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-BbDufEW7NVW85vaz9bvHxg-1; Wed, 28 Aug 2024 06:51:25 -0400
X-MC-Unique: BbDufEW7NVW85vaz9bvHxg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-372fe1ba9a6so4192459f8f.1
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724842284; x=1725447084;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zm0TwZoHc6xSTNSFjy0hnAEuUfI8PfQsywCXlruU0iM=;
 b=NX+UrZ/F0vuUTebCo6CjKMVu/JLg59lBm0Nl2r+g67mKfPb4g6ixfGKs/pi4/5yeQn
 ZaIHf+V5vu5fGajF9AbWmFl4HXVinsy2qS3H2APjPrkv4+EHmCkG3hcj43PTO0ZRYDMN
 ZUFSl+/erL5UH7GnS9zGP3elDELFkP7iAz1Tk4ZrTD0hlkjNVoNWJuxzE7E+BxTlFYJ8
 Sn7VZaFA60d4Virkk7FkyQrXes+/xX0CLvDOzl7uDg+NpwcFHDpGww7IoBro2gQ6AuC9
 /jpBtVS5INhCyxwiXOPBdZIRaBynHu/APkC2j+hETdynSTn+2hKv6DZ4WqgoQtn8DoRS
 agHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjGrce/eNf2IYpIrs/XZk0mKzKI3xG8jvC7kBjV05BEmFPd+AQwHRtjybPVz5Zlo1qgIg=@lists.linux.it
X-Gm-Message-State: AOJu0YwHwKXzIGmCBSpsNVF24YAVHY12liRvtgU20AbufUE6D5q8htDl
 n9Ap/fC9u6r0UbwDWonYz00a1aKUVCAvGYEA0qm0iN+VjNG/A5w2jmqHn3Ic59JgxuIvFy07L0T
 rre/MpCD19UAfANIQe7RIJHKQQ5d+N785QkH6rDyFc3IKOuwI
X-Received: by 2002:a5d:5848:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-374968598fcmr1195316f8f.51.1724842283951; 
 Wed, 28 Aug 2024 03:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfSs2XZnzcexg6U//5VRL3+QDrHSGOUjDLcCvKXnGLOuTAtx59xAGKO+RKsTr+ZC71YA49Zw==
X-Received: by 2002:a5d:5848:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-374968598fcmr1195282f8f.51.1724842283014; 
 Wed, 28 Aug 2024 03:51:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a?
 (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de.
 [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730817a5acsm15253414f8f.64.2024.08.28.03.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 03:51:22 -0700 (PDT)
Message-ID: <c6fb5f16-59bb-47a5-a2dd-3c4207d73614@redhat.com>
Date: Wed, 28 Aug 2024 12:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <202408211026.636ade1a-oliver.sang@intel.com>
 <767d1908-dc30-42ae-9a8a-d2ad42a4d491@redhat.com>
 <8bde28af-3401-4d72-b821-d8cf01bbcd64@redhat.com> <Zs7-A5S_ivFlosrj@yuki.lan>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs7-A5S_ivFlosrj@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

On 28.08.24 12:37, Cyril Hrubis wrote:
> Hi!
>> Okay, and it even looks like the test caught the unintended change for
>> "unpopulated memory", but instead we decided to change the test to
>> expect the other return code ... because there was some confusion about
>> "zero page".
>>
>> Long story short: the test needs to be fixed.
> 
> Will do, but we need the patch to land into some kernel version first so
> taht we can add the range of kernels where the kernel wrongly returns
> EFAULT.
> 
> Or alternatively if you are going to backport this to stable trees we
> can revert the test change that expect -EFAULT so the test expects only
> -ENOENT.
> 

I am not yet sure if we should simply allow either -EFAULT or -ENOENT for
the "nothing mapped" case in the check (below).

Alternatively, I agree, wee need to have this in the kernel so we can
check for versions.

What would be your preference?


Currently I have (WIP):

 From c152535cdfae194819b6df450cdc29a60f8cdb8d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Aug 2024 10:58:34 +0200
Subject: [PATCH] move_pages04: properly check for "no page mapped" and "shared
  zero page mapped"

While the kernel commit d899844e9c98 ("mm: fix status code which
move_pages() returns for zero page") fixed the return value when the
shared zero page was encountered to match what was state in the man page,
it unfortunately also changed the behavior when no page is mapped yet --
when no page was faulted in/populated on demand.

Then, this test started failing, and we thought we would be testing for
the "zero page" case, but actually we were testing for the "no page mapped"
yet case, and didn't realize that the kernel commit had unintended side
effects.

As we are changing the behavior back to return "-ENOENT" for the "no
page mapped" case, while still making keeping the shared zero page to
return "-EFAULT" the test starts failing again ...

The man page clearly spells out that the expectation for the zero page is
"-EFAULT", and that "-EFAULT" can also be returned if "the memory area is
not mapped by the process" -- which means that there is no VMA/mmap()
covering that address.

The man page isn't completely clear what the expected return value for the
"no page mapped" case is. It documents "-ENOENT" for "The page is not
present", which can be interpreted to include "there is nothing mapped"
and not just "there is something, it' just simply not suitable".

We'll clarify the man page soon, to be clearer that the expectation is
to get "-ENOENT" in that case, like the kernel originally did. But we'll
also add a note that some kernel versions will return either -ENOENT
or -EFAULT.

So let's test for both cases, and make sure we allow both -ENOENT and
-EFAULT for the "no page mapped" case.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  .../kernel/syscalls/move_pages/move_pages04.c | 82 ++++++++++++++-----
  1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index f53453ab4..f51a73b6c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -26,13 +26,16 @@
   *	move_pages04.c
   *
   * DESCRIPTION
- *      Failure when page does not exit.
+ *      Failure when no page is mapped or the shared zero page is mapped.
   *
   * ALGORITHM
   *
- *      1. Pass zero page (allocated, but not written to) as one of the
- *         page addresses to move_pages().
- *      2. Check if the corresponding status is set to:
+ *      1. Pass the address of a valid memory area where no page is mapped yet
+ *         (not read/written) and the address of the shared zero page
+ *         (read, but not written to) as page addresses to move_pages().
+ *      2. Check if the corresponding status for "no page mapped" is set to
+ *         either -ENOENT or -EFAULT.
+ *      3. Check if the corresponding status for "shared zero page" is set to:
   *         -ENOENT for kernels < 4.3
   *         -EFAULT for kernels >= 4.3 [1]
   *
@@ -64,10 +67,11 @@
  #include "test.h"
  #include "move_pages_support.h"
  
-#define TEST_PAGES 2
+#define TEST_PAGES 3
  #define TEST_NODES 2
  #define TOUCHED_PAGES 1
-#define UNTOUCHED_PAGE (TEST_PAGES - 1)
+#define NO_PAGE (TEST_PAGES - 1)
+#define ZERO_PAGE (NO_PAGE - 1)
  
  void setup(void);
  void cleanup(void);
@@ -89,12 +93,12 @@ int main(int argc, char **argv)
  	int lc;
  	unsigned int from_node;
  	unsigned int to_node;
-	int ret, exp_status;
+	int ret, exp_zero_page_status;
  
  	if ((tst_kvercmp(4, 3, 0)) >= 0)
-		exp_status = -EFAULT;
+		exp_zero_page_status = -EFAULT;
  	else
-		exp_status = -ENOENT;
+		exp_zero_page_status = -ENOENT;
  
  	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
  	if (ret < 0)
@@ -106,6 +110,7 @@ int main(int argc, char **argv)
  		int nodes[TEST_PAGES];
  		int status[TEST_PAGES];
  		unsigned long onepage = get_page_size();
+		char tmp;
  
  		/* reset tst_count in case we are looping */
  		tst_count = 0;
@@ -114,13 +119,30 @@ int main(int argc, char **argv)
  		if (ret == -1)
  			continue;
  
-		/* Allocate page and do not touch it. */
-		pages[UNTOUCHED_PAGE] = numa_alloc_onnode(onepage, from_node);
-		if (pages[UNTOUCHED_PAGE] == NULL) {
-			tst_resm(TBROK, "failed allocating page on node %d",
+		/*
+		 * Allocate memory and do not touch it. Consequently, no
+		 * page will be faulted in / mapped into the page tables.
+		 */
+		pages[NO_PAGE] = numa_alloc_onnode(onepage, from_node);
+		if (pages[NO_PAGE] == NULL) {
+			tst_resm(TBROK, "failed allocating memory on node %d",
+				 from_node);
+			goto err_free_pages;
+		}
+
+		/*
+		 * Allocate memory, read from it, but do not write to it. This
+		 * will populate the shared zeropage.
+		 */
+		pages[ZERO_PAGE] = numa_alloc_onnode(onepage, from_node);
+		if (pages[ZERO_PAGE] == NULL) {
+			tst_resm(TBROK, "failed allocating memory on node %d",
  				 from_node);
  			goto err_free_pages;
  		}
+		/* Make the compiler not optimize-out the read. */
+		tmp = *((char *)pages[ZERO_PAGE]);
+		asm volatile("" : "+r" (tmp));
  
  		for (i = 0; i < TEST_PAGES; i++)
  			nodes[i] = to_node;
@@ -135,20 +157,38 @@ int main(int argc, char **argv)
  			tst_resm(TINFO, "move_pages() returned %d", ret);
  		}
  
-		if (status[UNTOUCHED_PAGE] == exp_status) {
+		switch (status[NO_PAGE]) {
+		case -ENOENT:
+		case -EFAULT:
+			/*
+			 * Before 4.3, the kernel returned -ENOENT. With 4.3
+			 * that behavior was changed by accident to return
+			 * -EFAULT for some mapping types (including anonymous
+			 * memory we use here). Newer kernels are expected to
+			 * change that behavior again back to -ENOENT.
+			 */
  			tst_resm(TPASS, "status[%d] has expected value",
-				 UNTOUCHED_PAGE);
+				 NO_PAGE);
+			break;
+		default:
+			tst_resm(TFAIL, "status[%d] is %s, expected %s or %s",
+				NO_PAGE,
+				tst_strerrno(-status[NO_PAGE]),
+				tst_strerrno(ENOENT), tst_strerrno(EFAULT));
+		}
+
+		if (status[ZERO_PAGE] == exp_zero_page_status) {
+			tst_resm(TPASS, "status[%d] has expected value",
+				 ZERO_PAGE);
  		} else {
  			tst_resm(TFAIL, "status[%d] is %s, expected %s",
-				UNTOUCHED_PAGE,
-				tst_strerrno(-status[UNTOUCHED_PAGE]),
-				tst_strerrno(-exp_status));
+				ZERO_PAGE,
+				tst_strerrno(-status[ZERO_PAGE]),
+				tst_strerrno(-exp_zero_page_status));
  		}
  
  err_free_pages:
-		/* This is capable of freeing both the touched and
-		 * untouched pages.
-		 */
+		/* This is capable of freeing all memory we allocated. */
  		free_pages(pages, TEST_PAGES);
  	}
  #else
-- 
2.46.0


-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
