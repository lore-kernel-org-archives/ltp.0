Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E43C4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 07:24:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5993CAF37
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 09:24:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A072E3CAB0D
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 23:49:13 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C6A8600C89
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 23:49:12 +0200 (CEST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so1381846pgs.3
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=J5mjwMGu2qk5bP3hjRC2Gj2D7aOEOgPLH90aVWzBSuE=;
 b=XPvm2Eg+Chky+3e450NOaAV2UIYc7ESS3vD/9UeYZ5M4LrmS1Hf8OwPSl3u75HfXLC
 x3FJ1Ky317rOZYN+DPoEKoGUuS6zwKZi4xJhmzYXsWQ975GXGeRcNvzloZh0jOHOEryh
 sPySJJA/wq6Gytkx0xezdVJ4LgFdGZ1UW3Tq8GcATRic5/Lo9D8Nhn4Y8wadwIkOxcpC
 rvU0Wy075n7cfKESfZkVe/fo4Um5uiSfHHeyog5ZMxSE5LZ6td+GYJYhiwOwHmrBr6od
 7okf40/bn71z1astTaD4KyEi/Og6spyIWQkIOx0mMSsgvG4qNBz6+ZUuIY1Bem2bkH/M
 Kf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5mjwMGu2qk5bP3hjRC2Gj2D7aOEOgPLH90aVWzBSuE=;
 b=jKrdNFAEyjBZ27WCViK1YO2ICVKPYNesXEQs/jV7a4Wau+6wBUTNCG551cNKdTaCd4
 spHqwSt93xl8yFSLu7AKw7en0c+JZP3/g/u76elaAGwq6mELLMM0deNgozSxPzgaZ1Lw
 OSFpL9SJCHwHCLiMCm7eOyBu/ZYcgMBjS2F5Azv2IRdm8MrSYzzu2FuljbtNWSJjH0Os
 rQOLOaF+IReHOzzcgGOcKIzBxUFTj/ByXOzl4mG9/PVv+gp3ny2uGAib7t5PxoUIfVqr
 XGon8ZuGf282zWDhTa5Jlu0m/ILQnGGRVTlSZObpdXdr7oHzmflGpxV9WFKnD3Bgi2Yk
 7dBA==
X-Gm-Message-State: ACrzQf0LfsCD/mz+oPxwnUhyw1SN62lWfNvTe+PYEJo+O7MWqgpO4LF9
 wNFVUPH0S7ujyChZNiuOz5/t3w==
X-Google-Smtp-Source: AMsMyM6mvmMMRIFn+fboyuZWimGbL12CxiIDTmDavT+W16uZk9STafGUskTVP2CF6z1gw3ZQUCiRtg==
X-Received: by 2002:a05:6a00:804:b0:563:264a:f5e5 with SMTP id
 m4-20020a056a00080400b00563264af5e5mr1795424pfk.62.1665697750534; 
 Thu, 13 Oct 2022 14:49:10 -0700 (PDT)
Received: from localhost ([50.221.140.188]) by smtp.gmail.com with ESMTPSA id
 o63-20020a62cd42000000b0056258a3606csm149495pfg.215.2022.10.13.14.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 14:49:10 -0700 (PDT)
Date: Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30953-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
From: Palmer Dabbelt <palmer@rivosinc.com>
To: vapier@gentoo.org, chrubis@suse.cz, wanlong.gao@gmail.com,
 jstancek@redhat.com, 
 stanislav.kholmanskikh@oracle.com, alexey.kodanev@oracle.com,
 ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Oct 2022 09:24:00 +0200
Subject: [LTP] [PATCH] MAINTAINERS: git://github -> https://github.com for
 linux-test-project
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
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d103b44fb40c..d118acdce8b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11972,7 +11972,7 @@ M:	Alexey Kodanev <alexey.kodanev@oracle.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
 W:	http://linux-test-project.github.io/
-T:	git git://github.com/linux-test-project/ltp.git
+T:	git https://github.com/linux-test-project/ltp.git
 
 LYNX 28G SERDES PHY DRIVER
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
