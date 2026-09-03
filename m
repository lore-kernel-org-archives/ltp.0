Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583AC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788429199; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+GjHtWXbCZE2lfoTADp109ASMeluMRyiqJ0pYqJH0S0=;
 b=n01FXgsgs45kaQD6EfMSsxSjAQRhILzmURKBoQoi+a1gngCN0q5i8vk2fd51Sct0IIzc5
 K3wh5SO0lgf1m9uWlIMoaVLNOkml2xw1UcJ2bhNEU+g7iVEJTiVZ1eARjSH6v/aimt54OTV
 1EJaJuYnLsG4v+UBR3R2+EIqNDz2KwE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C32E3E9832
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2F63C3015
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:52:58 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECAA71A0020E
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:52:57 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso31755575e9.2
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788429177; x=1789033977; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Lt1+eFGT72e77navyscee4QE0zlXbXYTKO8DetR0wo=;
 b=RXDCz1IRgY3U0+YxlVpF1prHS94Bcg1pWiDEdwm7WrBwixcUzTiGy+WnJmgJxwoXOC
 yKWC6PdQrnI1kEaTbeIdSsKy/jT4PTmN8ezHuhOMOceqfgsI8d+YgcMLSXDCQy8fMiF2
 P0DeH82/4Lo7e+vYHMvhF0S7U+kSFPJrvvQTnMnCG9jAX8YTDplDsSfMt2QUkPG77l4B
 XgGnoAwxl3rEwK23FjJ5+9T03jdHPGVmMy8d4yF6r4IZrVyEkt10byBaGBneH2LiVRZg
 +Qfhaypp+pBPtv7o07y2a/s4fseajj0BX8YNcaOeoi50HbpKg/MAGjPLj7iju6OR+Isx
 5kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429177; x=1789033977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Lt1+eFGT72e77navyscee4QE0zlXbXYTKO8DetR0wo=;
 b=sFpLb6R4Nsa4rBJ+fyU9z6dxbDKB3OjRGLni+V4JC6gS0q6/MWoQhkd9N3MXENQ+FE
 zC1HqXs0ENeSrOge92sMc++YKjbc5y+CQbjPxTADNdcVQFUQXViwSngVGIEdnUcJ4IXs
 NWcRyXFenx+MaNq1ctNE1iX0BPXANTgah28CvjLySDnnGTWQZQTwYlEKwOkI3cKfe9rp
 0Ivhn10Yl5rA8zBIWbxP7ntsuZYNw17N5NE/mTGbrnu8fv0zvmEl+RzaoKB9PhNCr69R
 FUkB4xJ8eOuYx4l+pfZLYhrpB9n9salU1fOPqWv5GvQ7LqEXUvm35S/6I5jlRCRhvhNX
 Mj2A==
X-Gm-Message-State: AFuF++kVcTraE6tG1+A8XSh2Kdtk/rTDoqxHQKHYjbg4sNDZ1p5Vgch8
 2DbRAv3LBjtnMXzqV+LhaJ6B32w8QGZiZ5pIAJX/FBnpy1uI5aW2YPGK2f0igHORRpQp3WOD+4/
 Cn2g=
X-Gm-Gg: AYBFou1akNgv8QIRiC7a40tkUsnouLygtEPdVDFsrQHqAdoCFoGCYZixcWj0IYOZQkZ
 TA54DdyUrUxrGtp+pLrOk9TInZbFLr6wprropBMTC9R7vqRia8qpb0ohuqzS2QYjZlqGQwn4TQV
 YjwWnV5T2lKkM9isBBDX1Y71JI3rdGegee6ARQhh1B0Bjt+2NPFeNuRJcklxUh91Axojr0T07Y7
 gE3Ulk2JTobR+arzAYBdc7GX8uX9O2d4/kDXINokjAzqUj35tjQ2w7XZmWWTxrxL0Hv0aRShCZq
 ORk3x+VfMBxyXZDWQ0cK2T4u4Pycer7gUzw4lKBrxl+YmwzubvabOoIt5nX4GEW+bwqdOllLTfI
 JLSrsvWdkKUJ9SorCk8vzmhByxLXZojceLDH3rwI/2ULeQGZB6ySkHfha0o8bBmkSv1AHl33isI
 SOjaEEfnkl4sPvE0NW3/YsQ6hrWWn4xM+KxfLXrDHcxYoaQCQWfzBeOE2SdUo3RsIUBgX1vuK7k
 KChtFiE005AESOtI5uo6HI5Q6Ag+5G3jtmDmbXo1g/p
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49ce5828104mr170209575e9.7.1788429177421; 
 Thu, 03 Sep 2026 02:52:57 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49cee5d476esm65733705e9.1.2026.09.03.02.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 02:52:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 09:52:51 +0000
Message-ID: <20260903095255.4925-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/2] shmctl03: Fix 32-bit compat mode failure
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

v10-v11:
- Fix make check format issue

Wei Gao (2):
  lib: Extend tst_assert_ulong() with enum flags
  shmctl03: Fix 32-bit compat mode failure

 include/tst_assert.h                        | 34 ++++++++++++++++++---
 lib/tst_assert.c                            | 26 ++++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++--
 3 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
