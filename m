Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F52C27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718312487; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=FbxE3ZJRXOwengxKEw4J6vt8ns7hLuQcAfAjpi+17eE=;
 b=HZZeO1rzzRfffJrlnx4XdvZicG4pTxFGjAR7Na2jJX4cCo+GXe+2/Fm7s7nh+pcWUgif6
 v1Vqsv0QvVTY5n8V2E9csxKdlDgsKXsqrQceLLA85zqr5ithEjhrvk7BoqmuLajz/1xqyW6
 83MXdnuTc6sVSwr20YBQ93Ul9GrMqXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2F883D0C66
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 23:01:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 045C73D0148
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:04 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43D3720092C
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:04 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-705bf7653dcso983419b3a.1
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718312462; x=1718917262; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=803b65qdGd+KLhkYcyQpG8a8oDlDQWj+IGkMpqb6Gk0=;
 b=fyxxNpNzpm2qHOfuJ1THiyh/meHVA7wKtPtASH5nClFFO0I96gjDaXOsc3jzbNIU2N
 SzMzeSdwANPHosrck7sTOMdnk9VgZR1qTw4PfJa8hCR9ccW7W5YWymYFshHa/qs/rAU+
 QWuwaeFk8qVQ6f+qPeZedVEeOSzSadDED8IXrARjpIjeLjQqIa65/N+lS7SYaxzr3m9T
 pOkiIY1/g/W8/WZO/3+sV00V3G8MqliExvRERbEC4qeqTLAKlHeZnYhTFReF8NqGBuI8
 OgRJ6hLAsq8kmsws9TWg43Qmjn6a+YTo8sWM59/gK3Bclg5eDvwodzkZLsQqorj1qjXH
 0xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718312462; x=1718917262;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=803b65qdGd+KLhkYcyQpG8a8oDlDQWj+IGkMpqb6Gk0=;
 b=lpCYtbWp9p2noIz+J+umSjz0rmga7PYhDJairBDQD/P5cQZkJEn26RRFaLkgOce3+9
 qIzEZX0p/m9VPNSBKn2C/LgkugMDnxXA4KdHSmC8kEservj+aJtt4Em9OQQdSENPGMHm
 vCc8XGHqW0frSnNieW1tNJNJGt6dR+D1gx2NgqYPao9wsZ6E/r29aP2JNIsQA4omSJxh
 tMCCu/Z2L8xHJt6Mot3S89cW1G85oslWI0iUnxhzDH6vMX4VllhcsVeAcLz1j48DkwGn
 ZE440//LdHTW3Avl6BmUCQkSAI22YqqxVgfiCAcnKR28ocTZV9sFUQoLOUjgNhcWb0O+
 uoUg==
X-Gm-Message-State: AOJu0YxrkHNL4JwcbUtYPNv0R0tXgF9q58COBcer2ZaIvH0l2gJR7coc
 jXpo7Q87IwS2Ds9YdR7maKJoHzBhKMucQYZVHWmbx0aiJj86+Tyj6cjzSVvTSnM0/DIqLzP0D/c
 HtwUHpqoiWlZ7yoQM68eu7UJltxn0Zxo1i37k4DXDalbuTZeGqFf2M4hLw4acPewfhMtwuifmGq
 8g+xfzQieUX/M3aLII96F8wV36jIc=
X-Google-Smtp-Source: AGHT+IE7mrlhEihuWn+XdwLdBCNh7etDTGNJi+FHJi7ta5uOcoCfK+Xh7/UxM051T54G6T3YK5geNrDSOLs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:9086:b0:704:6ea0:2bc1 with SMTP id
 d2e1a72fcca58-705d72b0e35mr15138b3a.6.1718312462045; Thu, 13 Jun 2024
 14:01:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 21:00:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613210059.352767-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] sched/starvation: Choose from available cpus
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The starvation test was failing as a 32bit test for some arm
architectures where cpu 0 does not support 32bit applications.

v1: https://lore.kernel.org/ltp/20240605180536.1288027-1-edliaw@google.com/

v2: https://lore.kernel.org/ltp/20240606014022.1425928-1-edliaw@google.com/
Made these substitutions based on Wei's suggestions:
s/TST_EXP_POSITIVE/TST_EXP_PASS
s/TCONF/TBROK

v3: https://lore.kernel.org/ltp/20240606173933.1671989-1-edliaw@google.com/
Substituted test macros with check based on Petr's suggestions.
Split commit into two: first to fix the return code check on
sched_setaffinity.  Second to choose the cpu.

v4:
Fixed some typos and commit tags.

Edward Liaw (1):
  sched/starvation: Fix sched_setaffinity return check

Edward Liaw via ltp (1):
  sched/starvation: Choose from available cpus

 .../kernel/sched/cfs-scheduler/starvation.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
