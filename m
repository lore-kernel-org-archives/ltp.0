Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A849FC35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D632B3CADFD
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:28:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 405CE3CADD5
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:49 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B571B600CE8
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:48 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so50545425e9.3
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742412468; x=1743017268; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42UZaO2vT3X7fC7qBWmIAFzL/5exUXcP+BKjhYwfLtk=;
 b=l/xoTliLu7BvOUlaqR4Ew4ObLPoOz53APttCS3IOQTPt/csb5omXVfjNiAYZHpn7Hw
 6PF8AF02kPvjpbh2+PLLqIU51ZMRL1kNJb+D2VCSMo1tjVhp9XbG9TNe50CcMhMAnQqC
 0496Rtynznv0mzze3Zj1PgST3BNTB96OHZSbrjy/MF7VjPA/K05EnHcD4pky/dN2MfjO
 yGNZC8soRN1hGnCcxTBvD9qC1vTS3EwhVea9EUITpO7zBzGuvr8p4zAuXOwFbQTIiA7D
 zafyWkEdV1G6FLfP16mVP5YWf8vGV1AjAGKbQ/YQyX0aGHaPr+W+wO4JciaUwHHzfvW0
 Vp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412468; x=1743017268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42UZaO2vT3X7fC7qBWmIAFzL/5exUXcP+BKjhYwfLtk=;
 b=JKFP4J/g4AqK7PrhTS2t+lDjR06Ivf7lXFy3moQ8d1hwAnbSsaiKXR5KQNPedWj3/A
 B01xp9awnDrInj60V3/2RUQowvN8gZraJ+SRc3MglxJ18lhYMq6gvojsQISsqnhjlpzk
 KFHAdRJmNfoF+3uVPTG+BvuXJ4NoGJkrnJ1uN1nD4xHcMyc8AUiUN4ciXSuivMjtPjo5
 oW6sTQmjFKCUeaOXBLLnWYP9aBAhUbTN8UyjbzDVhXKj05eOZ01PdqKHn0Yt1+shkQcN
 nNYjJMgEnXoVxQZlCtt/FagqmEV1fb37tXjOVbHxGxi4Zb0xWV4vlbo3zBYEPHVKPCGt
 57jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6jpCJJc3eoQbtaTWENpt7pBZhRHRruo8yQ7vWNcKoVQcsCV458gY5btQWwZbfi0n5Pr4=@lists.linux.it
X-Gm-Message-State: AOJu0Yxvb+J0RP27/fd6PVF5ZNwDoDOZxHkQs+UmMTvN80tR2itgOxOE
 b4EqklMqwW9PaxoOBUp6PfQ88Ff3T8RMslCrd4SoMpOl1XzTEMqE
X-Gm-Gg: ASbGncvRF/bmnichCDQM3+sO+YOpwjK34R/m35qh5BcoxzDnWpd9aB6sAZYmtXWyfI8
 hQkZbS7rTGJlkf8fqDuG4rRH5PLfaCMsA5SLtU6FjscwcMw79lhdQnjAIX809vmEY6IVYlyIU1X
 xTQgTZfGYbWV8WxPZh21cx75WoTJL2jqkD7RTau+2oTrOmdYrqrVY0pljALpqhEiH1ateSNi36Y
 MsuBugbOx7CMRU/GTV4rPtgwZqvzMQwB5jJYPNZYhK987+NLKhEC4qixngd/2rEhDUt+FxpZE2w
 yvUeP/5VSE4ACM5qOOrHAF++QsQihxYzRugqSdKDQmERiG0mSc0U9pPLW3XFOzjox9e73sGw9un
 Fea7+5bDcZrWZpkbDYhsuwkKhbkSTe2XVTEKTmO9Stw==
X-Google-Smtp-Source: AGHT+IF3JVViEchE1iKzgwVXKqbu3zUWHDm8HLN7pXhoEGVGTNXTpX58fL7NACKRWfZ07unkWxEs9g==
X-Received: by 2002:a05:600c:4f06:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-43d4958de2fmr2453755e9.22.1742412467545; 
 Wed, 19 Mar 2025 12:27:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453225bsm26531585e9.7.2025.03.19.12.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:27:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Mar 2025 20:27:39 +0100
Message-Id: <20250319192742.999506-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] fanotify tests update for 6.14-rc7
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr,

6.14-rc7 had a minor change of semantics for pre-conent events.
This change adapts the pre-content event tests to the latest
semantics.

There is no git tag annotation, because the kernel fix is before
a final kernel release, so no backporting is expected.

Thanks,
Amir.

Amir Goldstein (3):
  fanotify24: remove redundant event_count field
  fanotify24: print range info for pre-content events
  fanotify24: add mmap() and user page fault to test

 configure.ac                                  |  3 +-
 include/lapi/fanotify.h                       | 12 +++
 .../kernel/syscalls/fanotify/fanotify24.c     | 90 ++++++++++++++-----
 3 files changed, 82 insertions(+), 23 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
