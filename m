Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C33C61DE4
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788141655; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=T3BEsefM9KatWw6fgTbq6U0xqrebABD/5LNutpnLXEo=;
 b=DkXDcx0HLsq+MIYIg2j4Lb8i3y/TnMqCOtwDQlVSOzpq92MwXeekaO/oHBcAMYQZ4pi4i
 Z79DhCjkK+rcPGjbQaJKiWcmGVFgc9zemvt75ueYEhN80ZjqxVmfsVPVlcaQlFNHTreI5aA
 KX32bbjnCCCPUoj3rfstjK0gfKyY50o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7925F3CE1C1
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 04:00:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F160D3C74FD
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5DFB2003AA
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:32 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso16964055e9.2
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788141632; x=1788746432; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xpaq9QfSerzqlxGNOXbGVyheVTcat/K3pA+OXWRilsg=;
 b=RwuleM0tzlHvmLJ9RQ9Uso38aUAX6iRYKxg8qtQoU+8OiCZcVP5MIbTPGUbWHBDDju
 4vC2PCJrNKKLSGtHumrCP6xow2DhD8KpJGsWkJWGFuyXU4JpV3ekgbnTtwhZ+NOqIRX+
 4KXDg7ddNtDwCWC4rxs3se6cnqxDFe778NVCxOrnWuITEPBzs8IvbffFAr9FxPGQ2kgg
 CZ1QIfEn0aWUSuRGktUxenvXIWrHiXAK4f3KNcTKWbei/rx/unlx8toj6dEB7Btn/Q0Y
 SOlP7EYb85mMemQpqEZ5euI3Xep8Hl/soR76YePy3z3p51NpMlDshA2HXLux++OKUolR
 Ftkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788141632; x=1788746432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xpaq9QfSerzqlxGNOXbGVyheVTcat/K3pA+OXWRilsg=;
 b=djZQLId/uF0F8F3Iq7HCmis49mTUgAZDyOvBxWcPNdLTe7ivO3TGitSPew7K3oN8LQ
 LNwCKxs64cly12RlDRO71isyPdxxLZ58ZbY5vWOcQDhFtbqMml8BkKVoFQxA66Dn3tAJ
 ZNkx/7icw1JAkafcKh03V36nwacdv+lLuRSD9PBcw3xq2qAqJcfn2t7E9bll5j5ZhJck
 1+deH6tiKxjeojPbx1LoWmhZv9yzRQ7iPHUQZyw1F6xhZfQ+znFwabHNWcXljqSUJ4mO
 bYqhbkNgPLjlDcqr8EO51nP2/HQXklRPYTalli/Jfcq+EhYBPDMDr2/5ozPnXwxMaZU9
 eo/g==
X-Gm-Message-State: AFuF++k8f7hH9rdVSG6o33dEStPSBhrgUtfW/FeoPU8YBQCiZnToSNRI
 KoZW9gEtlOLQSiwclXlEtJZW4oardjYHmgekdCAu1lpjNRzdG3cCU/i/eKC0ne9FcT7EI/lVKDW
 Q6oo=
X-Gm-Gg: AR+sD11MvNUBoymQQYGzdpwkzagNxdexk6CLEN/Wu3WmRvVuTuLoq/Zgr3iQIuM8Iy9
 0fPoo8R0Sw5D0bnAB5g3ym6DVJou352JF2HU+gBUXrfAEwuIlf8GLw429pka2ioOxLJWOtDq/4t
 lEGtJWCo35ldzckfyy1Vgo3vjtHctouTt3n6NMj6RDeMw3k9q/gKvMxUZalpdk+n9FFxNZKSL27
 uvyqNtfN0upOEKIo41gIE3Rgal2ek5mAKtpF4X18svALlQg3N4NWGVz0G1EFyqZIr3WBp1v/APp
 iPj1MzftDNNDPKAUQQZg0hSJVUST8slaqIIPjCu3lnoUF+aXnNagxnlgeqznyzRbNlsw32xwP5e
 p8zkmjxVVR5vghvI+fQKZJlizszGi38ZoT8K7LzuSUfdo85ihFMGpZbj2AjQ64Khz3cpM6bPTdF
 BeddBiZ89Zchz3ZfDyuFB9oO5qsQIzPHpwq7058+3/5fdFV+CF8G3zgJX6+X01UIjBzdu6QwuJE
 4MsYdwNI9qqp+BBW4dNF8BIK0hz0/GP
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr368683905e9.6.1788141632119; 
 Sun, 30 Aug 2026 19:00:32 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49b9267c369sm171539805e9.3.2026.08.30.19.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:00:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 01:59:44 +0000
Message-ID: <20260831020028.19193-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 0/3] open16: allow restricted O_CREAT of FIFOs and
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

v12->v13:
- remove unrelated comments
- remove SAFE_WAITPID

Wei Gao (3):
  lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_uid.h                         |  14 +++
 lib/tst_uid.c                             |  30 ++++-
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 133 ++++++++++++++++++++++
 5 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
