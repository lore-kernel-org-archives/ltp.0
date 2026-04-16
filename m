Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52438F433D2
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 00:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776300992; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Lv4RrQgzI+OlRnxg6Z05W/9Kzyeahy1LHMQu8DemS2w=;
 b=Fww0iHlzYBS8AVW1R0Le+X878IGhcPIW4mGiswFUkf5pV4+PybF3l9Gq+Y6DwIZL1DgeL
 HTvUyG3Zr1haicGfoKfD7NFiLl1+Hu0zQKxog0eDe+bKMD0vme3my/UC8ZsZQWPUijvKbgG
 fSqdznBt0/TwmkyLRlTQ5S1ZpLmJPXY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F1B23E6EFE
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 02:56:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0BB33CC8C5
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E43C760070B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:06 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso72535025e9.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776300966; x=1776905766; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUEc3R0EVlkDgvPpdsFVeYH+6kO1pMcjTHuql3aDeNs=;
 b=bgns/kU73gNwDwHHphX6tuvNiQXXsfF6NlWwRcmviPR4jgAL5YRFvdmSf1gJefxHog
 0GqYuDNdQuTcz51CR7lCSEynO0QRUCQcTvpTlwMksOi+IMpkxsBTzh7ADBC5y+Bdn5J0
 umwAHkl5NNHPj7rHMfEbCpJqMFFfGVFucoFUwKit6eBzhwgn4zFfVvSNw2mqe8J9DAdS
 T2i41cq8ps6h+EpVaN7BORrGFEnsNijaAqI7TC1JRh3gxKqnW/VVy9cmlf1bnZHc8/Ct
 +3xNMGbYkoTf2rFNc3N/D8PpLwCRA7DSBA5afJYpTP9usAOshUXWq/XiDCV5NrLNWNy8
 /dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776300966; x=1776905766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUEc3R0EVlkDgvPpdsFVeYH+6kO1pMcjTHuql3aDeNs=;
 b=QvfEhBSrHSbntWvzW/yKLnnymYX+QMZCAcFx9Nn5czeFetx6eLZGWbYjKzwCVBjdoD
 GV4Dorpv/tRPZDx/M1kJdLJkrtgnbmbsglTXYKzWhGxzzAAnFfqPNDZNNinHOqcjpKGc
 nXZIHe8v0GLurpLRZ5aHG/JZvkYRallOayEYOBH10UVze+GlmhTifRUVQRcLC34eKaG5
 bp2XsHmUB112IFMoQshjvf52JY9rwStKfTVurjiFQK76a5EiKxL/T4jjS+S+9TgLT6u5
 o7PI3RE2qb9yCk6C5kpWgQ3wGC2pzOoDUPsYZiRWHLckWklVsP7h/rzuo800BvxHt8Y2
 J76Q==
X-Gm-Message-State: AOJu0Yz8+TAaCO8lRzhht+fONUrdWNBN8zO0HoPPsq9ORL7GbO08JQ/w
 KgQpE3sKUKYPMkgHN4+QCkhzpG5uN8HU5HKJJVMi8QJz5cc7SC8LJOajc6a32hAlsaN8Usi9jdi
 7SGA=
X-Gm-Gg: AeBDievvoIQWG+Ndv/jAVMSW+Nmm/OC18rjXXKaXiazGdayLUE/1ATOsZUFIDqiL3D1
 /bmW86iefiWAZ0R5xW9D5OteXAhgQJ7KcDDacF0FsJIHdU47B6w6RVaTv5LVDbt0Z/L6C6kQ332
 U00bRSUrw2EBpAci7y78R0biz+SIveGss20AYl5SuujSCGxs9P2/LFcA2RJ6gFTN3mduEfeMTlq
 KRUo4fxU2hnCyvt49oruTaOrU724g1pFW+vXRIWIxSHDWeuj6Jvdh3CEBf2K6H1vGOpw1Msz4FV
 3Hk9Pfz1zE0Ib6t2ZO8+jouEZO6070IC5nsBkb1TjO25gH3/dIMoHIX7QlVTyfwhs2GqPGLuI6n
 DM8tl47+Ar4Tk4GDeEXoGKt52WAAqmfQC4wDiPNdvYhOB8l0lIh8HAnsWpFmCFCleOg8ZwuYky/
 vwOOb+FqVlcdA=
X-Received: by 2002:a05:600c:1507:b0:485:3a27:a961 with SMTP id
 5b1f17b1804b1-488d7f23b18mr176045055e9.0.1776300966080; 
 Wed, 15 Apr 2026 17:56:06 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488f08bdadbsm35883865e9.0.2026.04.15.17.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 17:56:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 00:55:21 +0000
Message-ID: <20260416005603.22427-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415103812.21999-2-wegao@suse.com>
References: <20260415103812.21999-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/2] open16: allow restricted O_CREAT of FIFOs and
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


Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

v7->v8
- Update comments of test cases
- Refactor test case with tcase array
- Set file mode to 0030 for level2 check
- TST_EXP_FAIL->TST_EXP_FAIL2

 include/tst_uid.h                         |   7 +-
 lib/tst_uid.c                             |  26 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 128 ++++++++++++++++++++++
 5 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
