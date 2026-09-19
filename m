Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75184C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 01:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789782834; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=EVbwxI8cj70qaegSu6NWoqVdeoEDT3M6Xhme7rWrULQ=;
 b=DVrhJnqwViOcd5U9eP0+roK+nJAFv4SFP1ekcCrLGTrnz5zjS/aMhX4sOXLB4UagpM2Hh
 A2qG1qV4XxKX8GWm+wDiVpYmU1H43BdLfGlWIzfi8ct9/JejcGjpe3MfXY0czqakYK1y7M2
 vWdvq2dEt947hwSYCdIqLGh8FJOZuUM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB7A23EADAE
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 03:53:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC5A63E72AB
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:34 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6BF7601CFC
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:32 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so7502555e9.3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789782812; x=1790387612; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AgF/sQPbzPxb0vtEewaZuEZBwTKQvUowWbFjcmHK2UU=;
 b=U/NYMLtLAJkEPiWs81W31iIwX6dhXzY+MoWHRScXEEmqzPZqOs/vYnCAx9/9c3uTmN
 3u8jHnRi0d7rGqaBLJvH4PiuX0RoXIxjmKIDA7LS63P65h0QDsayE/UFSUg8wnmwgFee
 xRhj0dIcqtbhvGRSnwQIKCE50LhwlVRHKTyhQRKxx8YHLaKZ/c8smee03Vl1ZlTb+oQ5
 0rYyR7wXzjrcXNKihnqv/SX/X94cFkKgbcO/HSAUbyMScQytE/74nJjbUDJXN04+VKuK
 Li7Dy2cIASh6gkxz1DHqhZ/iC6D1mwxKBmuzXVOtGOt1Ng9U2NwC7UCzw5PqyUzJu9el
 ANwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789782812; x=1790387612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AgF/sQPbzPxb0vtEewaZuEZBwTKQvUowWbFjcmHK2UU=;
 b=KHKPJEWk6s/WD6If+rLQkUdMGHk0Y8FJsEj3/H5BgFVl6pBPspN0BmOD0tdCg6PTV8
 q2Ztq+NiR+VJh3kTeWYeN7UU6o7/ke1Q7w+E/7DTCABC2IzJ04Awvo8ErJ1p6B+Nczm/
 O6nDOStt4YfvS1NsI1KsqANRG+GTvWHiEhiOXviJ3j2ogdB4IEPrEwhjO6OxdoZEqlED
 zRchFl5b8oPaDk6LgYRVnYSuKmgHLKQI9qzyuCh9LbMEEq9AM9KuaB+Dp0TlXO4ms67n
 w+qZ2P0UJRaX7BcalAxPfE9iK7DEENyQBcuWLw2zNfDE1MKisAZ2mq21ZhZZhA1FoUvs
 Hq2g==
X-Gm-Message-State: AFuF++nsHrVmFyb2GuaqeoM5qqGeJB+B87hSW3ldAGnzBcs9FPvu38OT
 IhK7GgsUdNAYEvInvdxiENrUPZvUXvWJPzgF5e8rx/7xYTKeUbVbiYzQFGEzslJffFo+mdRG/nu
 vRtQ=
X-Gm-Gg: AYBFou1FbpDZ9Ftivq/iF0D3D4+/1BWsfg4ckVpx/bCyY7GpxVKv8+5OlY+1b6cQavp
 fNLDlYPlyr8aoEQDMD7vhgp4eDEd+c8gEA3kSVzp94v0Bzyxjo08DxIVe4HFDUpLvxiWrQ04UmA
 2rVhGUp5Rly5Yw6YWQP9Jt+O0di8zHuaKNtIjIIk8xdn2ccFPiqc1EYShKs4oEBAipVuYUfIyBl
 UANwv0vBDFQh1WeWW719YsZzB/iwKuO/WPu71tFW9ysdW+lQaL4XyWr0ZHSZbbI4iHzSdEZ41tS
 gCJcsYy4jSyHExwpgleS1A3aDESoAQ61GdJJJoTEgf5PJzSSvVS6r3QfTHAFm2D/R00dYJLg8Sq
 u9wQHappq4PIv3bB23LQRXgklbG3k8+duXZ0r4eWCW0p5zAAidXNx4IqPcenPjjFrnrlwQQymWO
 oDpjj43bsLG2/RRJbWUGMii+yPCqM7NZX13C+Axu/qB3hSjUroIcqh62dNG6ZxbyOfghJAODrvx
 DrnUUuhfZfMFhhIQ28pJWEV3AoTAlsB/BOhZsEiv2w=
X-Received: by 2002:a05:600c:3e07:b0:49c:fc6c:be09 with SMTP id
 5b1f17b1804b1-49fc58594d0mr56411195e9.32.1789782812436; 
 Fri, 18 Sep 2026 18:53:32 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fcd068124sm34325095e9.3.2026.09.18.18.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 18:53:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 01:53:18 +0000
Message-ID: <20260919015329.22042-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 0/3] open16: allow restricted O_CREAT of FIFOs and
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

v14->v15:
- Update comments format base AI review

Wei Gao (3):
  lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_path_defs.h                   |   2 +
 include/tst_uid.h                         |  14 +++
 lib/tst_uid.c                             |  30 ++++-
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 143 ++++++++++++++++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
