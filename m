Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCDCCA5FE6
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791124500; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hNlYw6+Gp+7J24wYsXmmiB7eQXgo4+U729d0lEUi94I=;
 b=BypzwFheHdf3JOX2773tPeGZ9fDpAcD4J574k+6d0d5IOIPjSQtX0ltQb1XT+LvTl3aLY
 2zpAaMZqAY73DnxWJrkwAX8d/Dv5jQ1UpzkUqQ20avF9vu5BaFlHhOJCATP3qT/7P9PaD4v
 R/BmAv6cyY0/33SqVqbyaF5/yLBBMV8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99AC3E4E58
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 16:35:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5683E4D60
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:39 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 737331A00269
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:38 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so6928755e9.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791124477; x=1791729277; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bp5GqJNbxIaTxCdmhu3lHkqH/9mfEqpenXqQfGSOAJE=;
 b=AqiCwEm1GM4eHC6lVmxo6Srrc+aNt6XbNfZl/EDvk5nBc+Y4fVqONVFWFOCDR5atuZ
 kTI0G5cNpNCJRq4CxWmcANbYlg9CQ3hAvHu/5cIA0wlQP+l6RfleFLoCTpb8eoeqpJk/
 Ory5y+dEzK6cwHhG4TRGaHzLCN6P/wjwPI2SIr1KPU0oJ/A6dYqScly86VP9jPifLC+K
 Lv27lxlLKPLgg4tQlWYS5a+VnQLG4o1MhCcPOIWBUHTbsfvjcizn9XeqLgKJyNkEhxRD
 PAuLj4orYEuYaBVw6WWLgZgNsVtvELDl2PnX5e4x5BUav6OjsF2e2QrwxBOqyqNGEgu+
 lSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791124478; x=1791729278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bp5GqJNbxIaTxCdmhu3lHkqH/9mfEqpenXqQfGSOAJE=;
 b=H64RrNcMhpkr+a2zerUouqgMpOe2GQCfqz6UJIa7NCTltAN+NnjgHTKoQcqKS/i5fr
 AF06qEs4YryPdH1ST5yz7OQJsu84rnj9dRHqUTTsrmaLKsmKgveOw/5MUffMFt/nnRRw
 sEc1eSQXKzbnI9UE2lNO7svlWlxXPDlfccXmKLcxYyo01EulPfwwBwWwixJL08QSBzo+
 VIaoCKvqHzxvyue2pDu6QIjVTEb1x06Si/4XZ6Qo0qJ7o/c8Gcekifcvb9+0B7jkCd/3
 BW7q5Q+SbHHXQkYhFYajecpg9ePBAUKqBVc97A7cmDhA7EQxQRSPSfovBIisRfRJrssa
 9Szw==
X-Gm-Message-State: AFuF++nFLd8IV9IzP8Q+28x27Ot9OujDzkgoP3aa+5exTGaJSZteciJz
 1M8/tPB6f+GAaW7GiwJ+CfCnGUU20FOhEMSORD6KbyvX3wTC9lFrkODO8VsaWGQFPBpCQQIbfVx
 ZjMM=
X-Gm-Gg: AYBFou1LNs2xF9jCciwaLN16u+fGgOEjKKGFxZsKV4rNursUZxQNG29IShq2HegVKdG
 mHSjy9bWWQuHufW7N6OnDJGv/W0JXnD+5gsYF5Fg4jrmrPFwcZkN0BctrlUG2bH36OS86OaVK5P
 gs83lc1iT1dJmIurAUqVJlqsV8hqV9qnn8cjI8KGpq4YrJiltD57leovqIXHZauKAxe8UegDpZn
 3SFLC/pgw2dYtCMnhtTRHRpJD2w+c1FdSQNQhV6puAZLjD1e74PllCXCb74aXgLnyArALA19bTu
 mtfKckCWPIJurWDH/hZR9RwpBqaNpuQcxe+EZVEeNWULgE5kttwvIgOPT5watR8PMO2oNGgWEWF
 0zl9nj9qp5txR7V/0b7V3HnIuRbgY8Q/TEDwV/vh5I1NNAthOFwQjtp0pjrKnJYGVpXNYLUwkgI
 7qfF4cNlCniC+wmmvt+W2+VdWLWRDL1pveuBBfZaAHxFsQiX8sNxT5dnr8d6DsEOmei3fvybq5W
 y8h/NZlhXl4Ky/DGFSl7GH1RAAAUfRiYHCvBCZoOJJgozKGfCn3Ya8=
X-Received: by 2002:a05:600c:3490:b0:4a0:1b14:e845 with SMTP id
 5b1f17b1804b1-4a0274d1600mr140100005e9.2.1791124477616; 
 Sun, 04 Oct 2026 07:34:37 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a03043fae5sm157168705e9.0.2026.10.04.07.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 07:34:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 14:33:25 +0000
Message-ID: <20261004143332.25978-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] memcontrol03,
 memcontrol04: Set protection on parent cgroups to prevent kswapd
 over-reclaim
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
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Wei Gao (2):
  memcontrol: Add helpers to set and restore parent memory knobs
  memcontrol03, memcontrol04: Set protection on parent cgroups to
    prevent kswapd over-reclaim

 .../kernel/controllers/memcg/memcontrol03.c   | 20 +++++---
 .../kernel/controllers/memcg/memcontrol04.c   | 19 +++++---
 .../controllers/memcg/memcontrol_common.h     | 46 +++++++++++++++++++
 3 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
