Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87463CD8CA8
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 10:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E253E55F8
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 12:36:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B47F3C1E1C
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 12:36:38 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA28310005DB
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 12:36:37 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-915d64fead9so299043085a.0
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781346996; x=1781951796; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thfFcje8HASpqqP9d+aNtxxqLDYCAQg5gVraYHj1n+8=;
 b=Ei3NWQLItFMpWvJTYlbWbS9/ZlTeU5/qoYd+XmqCU7vLWk2B4YIWUB+thMrmwmTL+/
 CR0pZXnuVCzLZL47siw8el+BtMyAx/k1MfRjKktQ7Xs/4vxxwdS7D4EoF7pwXQ6tthqI
 WybzhS+mQDVPO8cs+GGp1uCZ7AiETYNVD1y+3twwV2Fam0DyFuN+1deFvtic3GFjyoc0
 Mi/VxxD6dYgNZsqvzo7CD7i0SUoSRk8Ka1LVVgz1xvqlkVhhexnOemmj2IlahdsZFa30
 Gg5xZ0zr4JfXYaCIChGg184Quy19VM70o/g5KNzdVuuoudIdAghru7czFzvJ2x8RvObj
 n4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781346996; x=1781951796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thfFcje8HASpqqP9d+aNtxxqLDYCAQg5gVraYHj1n+8=;
 b=O2k/fHp07QfM0gZBEbLtx1efHKKTnpUCU7wA+h9AaLJjaSY0+5K33aNEy+Z5UZBo+O
 cXBT1BEnhjw6Bg1EGeXcCuUA3BLF80W0HpvbyR7G2ZDAQpdRrk1+RKfJtReJj4PERIHY
 +UtHJ4mbUAxd7Aj+yM8v7uX0ojiFj6EfwVIjPZ8A6QRitCswLoVWxV5C1jYdKFcMJ4jm
 rLDpCzBc8xxfEFSh8qxUja8r2bK8ihAIIWyHOTae8M5tqwB5O+0X5R5gUhzk6tzSxHKm
 g70pG0xVmHy6EqolpDhivP9HRXZMEoBM0uVyrbisfkgPI3nc5b4fGtBbS4W84Unt3P1/
 TBqg==
X-Gm-Message-State: AOJu0Yx2LVrQ8FkL4lWPweHY4OjIfF7s4QANU2rYzNVW5VacibixxSlO
 JsiXGzqqTnybF0p+lxsIUOLP3No2qSxNzDc9xSEH9wEIPEnCM54N5zAU
X-Gm-Gg: Acq92OH1owouCt5V66ODHheZRp2HJKzGAQQWGdhEPQf9VkWCjrqSQX4FyHXMgR9LynM
 lEDdL7rHEdI7SyIM6bU1q/xo1kCeeGr1YhJCELOm6Z/ugSuU7fimtslZQfWjkkXOlAWJ9MHWero
 AlG3VMlan2REOJxDOsSTU6rXn1m8Pvz7PEp8II8pGmy+UXrbipx80Y3LDiFRgwdrt45XriEe5xB
 XAKTiPENUPiqn+yuhhQCLbZVE2rZ/0TvNuqG4ug0TfdwF3ARW/GyZbCF9bt8RKTDuvL5uzT4mDR
 ror5Emxn7Q37PYBPEO4YY6e1ZivjE9H/yC4c9Jh8Br9reayx3cqkZ0pbLx8ajYgRKh74izuYirW
 y6CdxELVthmZxAf43Zw+5gXObe8aNgeKukwyJee24p4CBjANZQxAInQtohJtElCQ0NK1ucvP3/u
 9/sy4+F3WnW/7Z71fhTcPe9HYanju6Cprd4N5uPJZxWnrKlHGbwZTuO+/hnnYF2tk9VAOSbNh8f
 mJaa3uCKhJ7bFeizUOHbMMbBxDSQF973eOQ+5o=
X-Received: by 2002:a05:620a:a2cb:10b0:915:29cd:3082 with SMTP id
 af79cd13be357-91619db0152mr615151385a.8.1781346996549; 
 Sat, 13 Jun 2026 03:36:36 -0700 (PDT)
Received: from
 runnervm1li68.4zenpulcgpvenhjux0oihply3f.bx.internal.cloudapp.net
 ([74.235.70.224]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d305705920sm49415436d6.45.2026.06.13.03.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 03:36:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Sat, 13 Jun 2026 10:36:35 +0000
Message-ID: <20260613103635.4166-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613090543.78643-2-sachinp@linux.ibm.com>
References: <20260613090543.78643-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Sat Jun 13 14:35:36 2026 +0530, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 1/8] ---

> + * to files and directories. The test validates that:
> + * - ACL_USER_OBJ permissions are applied directly as the owner bits

RST requires a blank line before a bulleted list, otherwise the
list items are parsed as continuation of the preceding paragraph.
Could a blank ` *` line be inserted after "that:"?

--- [PATCH 2/8] ---

> + * For each entry type (ACL_USER, ACL_GROUP, ACL_GROUP_OBJ):
> + * - Set up ACL with full permissions for the entry

Same RST issue here -- a blank ` *` line is needed between the
introductory sentence and the first list item.

--- [PATCH 5/8] ---

> + * Test 1 - :manpage:`chmod(2)` interaction:
> + * - Create file with read-only ACL entries

Missing blank ` *` line before the list.

> + * Test 2 - :manpage:`chown(2)` interaction:
> + * - Create file with specific ACL entries (rw for user, r for group/other)

Same here.

--- [PATCH 7/8] ---

> +	if (removexattr(TESTFILE, XATTR_TEST_FILE_NAME) == -1) {
> +		tst_res(TFAIL | TERRNO, "removexattr failed");

removexattr() is part of the tested functionality and should be
wrapped in TEST(), e.g.:

  TEST(removexattr(TESTFILE, XATTR_TEST_FILE_NAME));
  if (TST_RET == -1) {
      tst_res(TFAIL | TTERRNO, "removexattr failed");

> +	size = getxattr(TESTFILE, XATTR_TEST_FILE_NAME, value,
> +			sizeof(value));
> +	if (size >= 0 || errno != ENODATA) {

This verifies that removal took effect and checks for a specific
errno, so it should also use TEST() and TST_ERR instead of errno
directly, e.g.:

  TEST(getxattr(TESTFILE, XATTR_TEST_FILE_NAME, value,
                sizeof(value)));
  if (TST_RET >= 0 || TST_ERR != ENODATA) {

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
