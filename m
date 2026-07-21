Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEBCC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784619733; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=v7mT6VYoECgKfL88U7f9O9a0VgL+I+EuzExWxpWOlFs=;
 b=C+sn/fMldnW1mOwV4MjBbgff8gqOPJ+6CcjBhU+uMMXwFILD/xq+0zL1tR40Tv7Z4Lbyr
 I4osyntTbIoZoJZWKyFbZpednAiRXqio5gMJ+TNaWmxgm6Tqs9xvS94nT6Abz/44ktDZPMR
 PE4VWzIMSTxIdM5J4FFrmucX9fi6Diw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24F873E239D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 09:42:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC59D3E2159
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6AC8C6007AF
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:49 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so5400367f8f.2
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784619709; x=1785224509; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T2lXRGoCOGGJKUTud73pQeformg9BlG8oH6+l2jxLHc=;
 b=D/9ys07pQ+UZle/9Z8FsB7+4mWzgm6pJUEyMTpefjPuOuYFOpuVNVrpm5t9W5awdb8
 ycdOQZOQYpRs833IzrDp0gnHIkei1owx8z+FXSHHN/FDc2fYvQYvTI93QS71UKOBGp0W
 b/f9N+1s1QFhqvcAJd/H7gOWXUKjx/YXyVTA1UXF0JyC6gNM6WjkkeYjC5a4GyyVjGXH
 dE0c9pdWfVRlneJacEbDpyLTf+spqjvho3ldHc/Y6wZ6JkQ0EiMqlO8iZ2AHMXWpZeaG
 o9aFOI4C56GoGwvUlxhMcid65D66CuwH84XHtqrZjdf8weJHSJiislqa6yr36kIL+SAy
 6bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619709; x=1785224509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T2lXRGoCOGGJKUTud73pQeformg9BlG8oH6+l2jxLHc=;
 b=nEuANRoLNLCAYYtkj/Ln+kq1moQnx+mlfGyHiVssL03UZ2O+QkTCBJ89x301Y166LH
 ylfYXM6sLt59kv6rVnBvWBGlwvAipGA0UjWLoAkiiHc8h0AP2Z7/aNoRY4d7+aeE5r6V
 Y6dq/IbXIMl23USzJ7BZFLtVXZMPKO/dJOFoDcLJgIRg7GdFSEWFnwsVSDqSKHOUvZHO
 srexBDsB/vbQ9dbarcqgglgq296bm+IzVxoYc0aLLDRst+rWU9ARbQHUuzp3VUnJsgmK
 ThyPFpTNBVSdhc1tQg9mPhL15Qpbmk9W2+AlomP5sJsXZS2IRCuVcLl7vEQfWWnOhFa4
 GOKg==
X-Gm-Message-State: AOJu0Yy6YCrEkIE4YJdDr7dVg6YL25/Wjb40ZLnrkRZq/vIuNKcHmnWP
 mSQy2nzwTDpbATb6MSy018nsTBIFsOnrSC/PLdU1c2ad8FbCeSC6xS/eX8xa6k9M9W2Z7Lj3qNQ
 Knfo=
X-Gm-Gg: AR+sD118zts8qP27UpqyV93ytfF2XhHnpQhObdKny8O+l2BS6ijM+61EUaVtOcK2Eu/
 oYXjWJBShZQDom44KcbFhrF6+Xk/8ebYL2utx2SPMTeLdrGALo5OqunjByTefGg5eR+tw1nkV/p
 g2dG1aKUIkKhRkPG/Wk4RJV1ywxbjPOtq0YLCZJr1a2E2TDqK+Y7C1My8fPBtHXBkw7HFnls+s/
 3IHYRA8T5NccW26bRfZnkNWU6AWO3AHlmW6Df9Y7AnOIgfnd+St5DXNnKStHB9PYUhypYaOYPoq
 rZn402dC15LgEnpMZ0+hE5wh1mAp1+nKgvNAtlny7Zd66CcgPa+6/akmgos4tMDw7AgxfdnQ6Vw
 MnEWnaw94ZCpQ4Y0QogwjCWxsvGbWMc8lxtdoztg52EYCgy3Jpx94QArLteplbafcBA==
X-Received: by 2002:a05:6000:4912:b0:473:1ccc:15c9 with SMTP id
 ffacd0b85a97d-47f6232249fmr18784632f8f.40.1784619708879; 
 Tue, 21 Jul 2026 00:41:48 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63eddd27sm36795683f8f.28.2026.07.21.00.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:41:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 07:41:27 +0000
Message-ID: <20260721074146.2779-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707054804.24232-2-wegao@suse.com>
References: <20260707054804.24232-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/2] open16: allow restricted O_CREAT of FIFOs and
 regular files
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v10->v11:
   * tst_uid.h: Moved kernel-doc comments above the macros to fix parser warnings.
   * tst_uid.c: Removed TERRNO from tst_get_free_gid_ success path to avoid misleading output.
   * open16: Added group-writable sticky directories to the commit message to match the test.

Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_uid.h                         |  29 ++++-
 lib/tst_uid.c                             |  30 ++++-
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 135 ++++++++++++++++++++++
 5 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
