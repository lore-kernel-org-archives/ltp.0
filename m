Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D30DFC72A8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774249416; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=4bfZtr+wfgOPe2OUJUPddOEyi48FBFsG8upp4FNS+uk=;
 b=XNlj5CLUIt4i/bB6oBLXC3p0PnqK1qiR1e4sw0WJ8uXCtdk6mA+YJIDxWqqYUbXfSDI6L
 TcikBIkKePO5Zpy4M2TmkzNbbT5tT8nGWP5VWvzkyPxB64bX+BQyF/iBPgUkch1QkyCgim9
 yPkg8cNzje9g2DlEJ/hj+e1bc8NdXNI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836F53E1FB5
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:03:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174743E1452
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:03:12 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A9566009C6
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:03:12 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso19065185e9.1
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774249391; x=1774854191; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MZ1TR+lw0qGqv1AwegtlWtDee+GYc9yXhqAANgNucJg=;
 b=RVywVhpt+Qr6KFyZ3TxR2BF/K7sglVPM+VifLhJFEQpPr7R35Jwx8EWfjNr20zVx8n
 p+f6h7pjPYfXvsD9a5xDdTh5LWT2UUY8MGXRJubMZuC85klqfoW7+LVTF6eiUjyQ4e40
 yTdhaIeST6p/eD3VfNY7kxE+OjKRemV2EJwsrk7Jbz0EdPkNpQCqONw0ejHwPn0P0Lu2
 2ymw65UoJ6y2s3z/NT0swzlA5D+qmFjHaVP8bk6Q8dzlMyUfSxxm08RnrdZo1LOVMLvK
 IwHC++MdMld//Hmb3BU1hqkbpo7L2EibgFhYWBavFFBLoOY3uehjqWj3mo8uT2GQTs2/
 2VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774249391; x=1774854191;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ1TR+lw0qGqv1AwegtlWtDee+GYc9yXhqAANgNucJg=;
 b=VwVvmtSdc4cbs+P3/No2NZwClPzvSQo2K8LYMizryjUbtUuUnuaGEBUUEUup+6jPif
 Z7dySRMXAQcGr+5R61xHHvR3Xo7tdq+zT5QRPJy0zZ1It1KsIsT39ttAHcJinzfKuRY0
 RwYFgKApjiF0JUxgRcxYRjB82R9xHQxE5+sagUgvLYnjNcktZfe/xa9gf7L0krLCxCyj
 u+dYi1lQCRCWW4wyg61KOj48vQNibwR3q7pj5h5gBTuZF1U4rRsnoZgFrFiUHYU7IicM
 I+2hGqAiJdEWv3cY2Foam10YbAkJMyD8jrFI8WOxJ+r3WNLAPuo14mVPXX6i1ya6VXl9
 htxQ==
X-Gm-Message-State: AOJu0YzkczDqvMUkqSueWD4yJVSIQazgy5gowWT7z+uLbWtnnM1Qp602
 c1xuU3whFLolOnXdWeiP228Kl+WEK/Kmz0nxwedT18kQsqsgXFN6jX504+ZG2cKGMxMqGyUGSp1
 BqkiAkvk=
X-Gm-Gg: ATEYQzwyXBSvuW/CBQDZlW9JF9mxjZRmLWhdtE2RzMBZPRcgxK+cTkzQb7+WuNGdxjy
 5/cLIO1/W/PX3OZpJopXl4BYSHRnFojmcSSvZypOhe5Pu1rz8yZ8riQjGJLtt5IwObEf542sk8p
 rjpQy0MkBnNXDBNjbdojRDyXFm5RYwCsy6v7RheaIaRDOhMJWi5d5fg7buRXvfpLAPo5srBo3zJ
 s8G3AKi1Jwhv4jQVnwqSjnJyvD1n7SzA9qeqFRaml108bnfbMa7k46Mbxucg3MDFhuzxEo8+Qig
 dm9M3VnGPBDUmcDBYVIgt4PE5xktWg3x0D/SVnjd8SYrEIUr2DALY/G6L2+HiKHwQu+QmxXnSyf
 Jy41ZYUyx/BQrEYyNsM9zNL+gID7pQprgoeGyo35V6ypt0Tj6cMZulCMn2mJarOscn9uXoSxavQ
 z3p+792vqUpgkFAeG73Z43PCaLstsRnpr/beuOUeNFXg==
X-Received: by 2002:a05:600c:1da8:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-486fee20129mr148730025e9.26.1774249391194; 
 Mon, 23 Mar 2026 00:03:11 -0700 (PDT)
Received: from localhost.localdomain ([37.160.205.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7ea44bsm260171635e9.8.2026.03.23.00.03.09
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:03:10 -0700 (PDT)
Message-ID: <69c0e5ae.050a0220.25bf93.a9a9@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260225090525.19581-1-wegao@suse.com>
Date: Mon, 23 Mar 2026 07:03:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

The overall structure looks good, but there are a few bugs that need
fixing before this can be merged.

> +static int uffd;

This is zero-initialized by the compiler, but fd 0 is a valid file
descriptor (stdin). cleanup() guards with `if (uffd != -1)`, so if
setup() fails before SAFE_USERFAULTFD assigns a real fd, cleanup() will
call SAFE_CLOSE(0) and close stdin. Initialize it to -1:

  static int uffd = -1;

> +static void fault_handler_thread(void)

pthread start routines must have the signature `void *(*)(void *)`.
Casting a `void (*)(void)` function to that type and calling it through
the incompatible pointer is undefined behavior. Please use the correct
signature:

  static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
  {
          ...
          return NULL;
  }

> +	if (new_remap_addr != NULL)
> +		SAFE_MUNMAP(new_remap_addr, page_size);
> +
> +	if (fault_addr != NULL)
> +		SAFE_MUNMAP(fault_addr, page_size);

Kernel coding style: drop the `!= NULL`, write `if (new_remap_addr)`
and `if (fault_addr)`. checkpatch also flags these.

> +	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
> +		(void * (*)(void *))fault_handler_thread, NULL);
> +
> +	new_remap_addr = mremap(fault_addr, page_size, page_size,
> +		MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
> +
> +	if (new_remap_addr == MAP_FAILED)
> +		tst_brk(TBROK | TTERRNO, "mremap failed");

Two issues here:

1. TTERRNO prints TST_ERR, which is the errno captured by the TEST()
   macro. mremap() is called directly, so TST_ERR is stale. Use TERRNO
   (system errno) instead.

2. new_remap_addr is a static variable that is set here but only freed
   in cleanup(). When the test is run with `-i N` for N > 1, each
   iteration overwrites new_remap_addr with a fresh mremap result, and
   the previous iteration's mapping is leaked. Add an explicit munmap at
   the end of run() and reset the pointer:

     SAFE_MUNMAP(new_remap_addr, page_size);
     new_remap_addr = NULL;

> +	.needs_root = 1,

This is not needed. SAFE_USERFAULTFD() is called with retry=true, which
automatically retries with UFFD_USER_MODE_ONLY when EPERM is returned.
Everything this test does (mmap/mremap, UFFDIO_REGISTER, UFFDIO_COPY on
user pages) works without root on kernels >= 5.11. On 5.7--5.10 the
retry will result in TCONF, which is the correct behavior. Please drop
.needs_root.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
