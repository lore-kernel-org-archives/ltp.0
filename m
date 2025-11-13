Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63530CD4F37
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 01:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762998791; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=K08n14iB6F4lZF8or2yz6lOH4XaPh0xRtG5f7vtnhLU=;
 b=fDkWSLBWFdBuyUoCxPEbjf7Os+DBGMnfZlvP172GupTH3uwD0z30Tba5Auakpq4VtMfrd
 AfST6/xprxWpiGVYqrUwX6ESI0FkuTvmhasTHBJ0/QGEbL6TXrrIlxIkrE1GfyPlBsfbdoL
 IRJb/HGnFgFRAg615lMx5zzTqayV3LY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A98B23CEE04
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 02:53:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360353CEB11
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:49 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 79DF8600669
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:49 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6419e6dab7fso412414a12.2
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762998768; x=1763603568; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLgEeFOmpBnayk1ua5BneVMPIuI4s7yscB15JSpeYys=;
 b=AcMdHdm5rrM0teAqUlnUCoe4W92imC88SpcZGd7zC8qpb5UVU7dwv1fxX9dLOK+EoS
 bXYTFR+5W02Tq1AvTh9Lw48xHRFCx4nDJnenp4Y45/MdwJlz3ZV9LxukNM/iQW3OZpeX
 ft0exRU8gE0lJjpogA2IGpg9QRTnn7jLtF2VekxvPWRkmR+tatj13bgGDOc/M9HjH9nD
 kfMPTSURkQ8a0a0fGyDShUvDTichruavaBD6Q8juOD3Iksg1EQmbNw9rf4kZELFSuq86
 oj7s9JlaRfJUPi05jw7apoCcUahcxiSIuTtbJ/T7xpiTkPGHxe4na9H7u+NOMkhJj/X0
 ikLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762998768; x=1763603568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XLgEeFOmpBnayk1ua5BneVMPIuI4s7yscB15JSpeYys=;
 b=QshKKFWg/KyTrOR+qZGDU/Ee64rpvDoEd7FGSeIyV6n0jfnOC3PfPXZFgLmSsqE5Y0
 pexGyx2hdWBkuHJa5Sh0NeFu0048uWyY+EPG6EzenpxbyMCvUDYmezhzqBPMOZNoUuiH
 9dnDVz92rJWCwvbXfoCM2k4LbMjfqrVgnUX5dLPyZw4CDCN3QY5NEbdE3Sg5AGoNxd38
 YsvBNHETjF+Xh1bOX1Lha7VNgs440VzMgMk9O3ZuYNqitjnXPc2Nfml2c9ha8PVXUu7U
 WpYgO5Upu4tE4OWWjcoyOT0HrcM3tNv4opJ/MHAmZRXWh62mHeP4WKz6KUr/Ml0HSvNP
 hmqg==
X-Gm-Message-State: AOJu0YyXOv7c+yCaignZQGYSP8LJeVYkTHv/9UP8fA/KDakrCNzwRmr6
 cWYqp5jlNSPY9RJciZUqNL3ul3DK1P1cIvGKEagIv6vAogzVLJaKZKL5GiWa4nVA0lKEpBS72+M
 UVUg=
X-Gm-Gg: ASbGncv+qL9jptVNlUKDMluzeNH0jwiz+6sb9yf4TJgOpg96v5ZX3R9/ih49fnOXSLI
 FqwpZ2SvaEq03oBcsHN9esSWIzBncfLk3W0kEki6qxv3oxdj9X8oK/4zVbY9bXn4WcGxiI2b022
 gG4Dq71mj4yl3O1LHdJ/fUyPT7boJeUkUVeWzeVT0yFGUR53v2dZwTTZo+VdL3er6x+0Dn5otoh
 JaDPYFNPyD/wUK3cZdDxJ3Snbn0OIS9jB8DNEpbj2F3WpN+1SYs1ZNvQrzeekg6pJaicXN6zHN6
 4Ar6IpamGCUVMxk0CL88+pbvjUM1wN+u8VWoEWqXQD5ssJb4BlvL4u/iP73rBt+HPzvQVPTy+40
 OfNe23P0AgJIB93xcP8Gk13sxxkQmQe2azd1RRrSSAyXHQt5H24UoIIpWF4KClwf+
X-Google-Smtp-Source: AGHT+IF7PTPnUNyH+rIEsO953Olsc1CwD9PVcM+OZfREPAoWr/KD8Mpp4tiIbNklnyPYE8z2yrLCcg==
X-Received: by 2002:a05:6402:5107:b0:641:24cc:26d7 with SMTP id
 4fb4d7f45d1cf-6431a4f159cmr4201782a12.14.1762998768610; 
 Wed, 12 Nov 2025 17:52:48 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6433a3d82cfsm325143a12.2.2025.11.12.17.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:52:48 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 01:52:29 +0000
Message-ID: <20251113015242.799-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101012320.24972-1-wegao@suse.com>
References: <20251101012320.24972-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] tst_filesystems01.c: Add test for .filesystems
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

v3->v4:
- Use #define for 128 and 10240
- Change commit subject with ci prefix if ci related changed
- Separate change which unrelated 

Wei Gao (3):
  tst_filesystems01.c: Add test for .filesystems
  ci: Add mount operation for busybox
  ci: Add e2fsprogs package for CI test

 ci/alpine.sh                                |   1 +
 ci/debian.sh                                |   1 +
 ci/fedora.sh                                |   1 +
 ci/tumbleweed.sh                            |   1 +
 lib/newlib_tests/runtest.sh                 |   1 +
 lib/newlib_tests/shell/tst_format_device.sh |   2 +-
 lib/newlib_tests/tst_filesystems01.c        | 108 ++++++++++++++++++++
 7 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
