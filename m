Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA6F4198E
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776249519; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=51D7J7gE4LE1DStXAPBXKf5piOc0+EJfLT+FUV2k68o=;
 b=UJgYej7dRF1HWjgsJ+IrkABxM9OwjHMyYDccnBM3ckGS0+Yi4ynawilhku5+aLMR1Zqag
 zeKd5ccPjvVNhWn6qyhvw+riEsztkdq8t/83XTaw0Q2DJ8Z8QNgk4+4WatDTeZ9HR3bZQNl
 PfAumHkMl085ulIWK2zbGfLRWBAeivQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A583E5B67
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 12:38:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7443E4AE9
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:16 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 97576140004C
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:15 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso80486195e9.2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776249495; x=1776854295; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/t1WPYIVWI93duWckuhOSzLDNnRSmSx5VvBqFjNU8E=;
 b=ImBGSN+SHHlzmWpBIVqglWGcHzbT/qZnV8MM0g+FU/ffGWr3wfvgD+zrDsRf7rZSn9
 vCD+7cHf7CkIlNRrAlPPsXqeu/fn4HEdLQ8KvMg3Zt8uaHEUz7Jy8mYJtLw6H8P7tUaE
 afvzhxFlpDSnzPIY0Zx81+MxU4aKf8oWRmVgKs0Qrs9ufM5thEAEY4viRzoww/VCystB
 B+AxNVLPg7SCM4gc8f5J2gZIoFKe81PJnuoEZALxqsNf2WWR/j1kXGeHKJ1mhzHmrMn7
 4Ahn9xSoNFG3w4jERn1CfdRlWoDKj5qRydrauSGBC1PbXUZ2OQ2QpvnSS4S9RqaDIyty
 GBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776249495; x=1776854295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h/t1WPYIVWI93duWckuhOSzLDNnRSmSx5VvBqFjNU8E=;
 b=MsprnH4VnvfcT74uCDJNlIhkGoF6wBlohghmVDZljYzaKf8NO05Yt7615sR5Qar1lk
 YbIUbfLevLntjJ4H4XWt0L7breLab+kfpFnkUwUXIHc91pxAtUaPG4E4/vwoDzALVenG
 ovp5DNb8xJBXZOoy62N7Eyr94RKwdbJnvqRQGoEvUUOMawGqqa1lPr1Am6ya++annsWK
 4g7AhMokWko6nse07ee1KiZCSVSYHmTWxAIvYyF+kNyw+2SCvTh0ZpCyIv72qmLizf7x
 0cbecIuCYY0m4g8izGJp8QhCxILTJgXEyFvzLe3pWWtRESDPbWtbbEe2FLh3IZlYN+0K
 SQog==
X-Gm-Message-State: AOJu0Yzv6Jbk+O+cqOjBa5Ly5rCaxYB5CDCNy3C6CxaFesDJvmvZRI17
 /RdfGpyWTgi6/CF9s2Nqzgt6e6v5b4oQpWW3SgFgXHg44vNw23w8qPxmM6RXGTVIltA1SzJHAFY
 CrYs=
X-Gm-Gg: AeBDievLGi3w7AxFFseXdzAbGtrnWaEfrm6jg6f/l9bQFMGEjS8cLevnmQjuY3fFDe5
 Ig+1hznmtmpjb0T6AWizmv1ENVHRIuzcloApOtLgksA9KbH1TU0MvZ6lnXn/YH0VSu5Un2PlEmB
 QRG5z2yKCsGvhQ1VWPr4Y0j38+Q97uLqLRTHxzmtERU8T+3gakge5byuE/xPdJ1FAOOa2q0aSWJ
 FwrsEiUts9eS6sC6xPD9ciMhoAZfvdFxhcCPBi5R0Ov6mpmjQkCny7dUE0ALE4Ih74oo8RR2he6
 +3vrfi8sgojinSX2IgMl09FkWEntJIIqhah85wlUhMu+gLan5URL1tJVKTH9+fnOFekSa9GD2qW
 Sfad4/QRUJdapFl3k9xH6jWy8MtYY5Bc5zR4wmQI16+4hu7BBdSgU/EscHse2w1cA28H1TCq5EP
 LgNOk4xTDmeU5n7rKM146Hyw==
X-Received: by 2002:a05:600c:19cd:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488d67e3671mr288453215e9.10.1776249494690; 
 Wed, 15 Apr 2026 03:38:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488ede24eb0sm134881325e9.8.2026.04.15.03.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 03:38:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 10:37:53 +0000
Message-ID: <20260415103812.21999-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415060728.21662-1-wegao@suse.com>
References: <20260415060728.21662-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] open16: allow restricted O_CREAT of FIFOs and
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

v6->v7:
- Add commit body
- Update test description

 include/tst_uid.h                         |   7 +-
 lib/tst_uid.c                             |  26 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 132 ++++++++++++++++++++++
 5 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
