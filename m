Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA0C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:17:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7593CE70E
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:17:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8BB3C94EA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:03 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40C1610009D9
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:02 +0100 (CET)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-556eadd5904so1045904a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403022; x=1705007822; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dzfzyX80VDqHnC3HA3YxeciHynte6VPZm1QiBOJYQ8k=;
 b=Y7ZQrd0Nq81yRkyTMsOTY1ymasba3X2xYypYe5AhVYLitnMQ37hvL6NYEMqBJFEkan
 rFKZN36UveP+7MbbKLbDFuuXe6iC/HxvjA8CZWmzKxyGKvaee1YjitXS3KiGnBWGHx86
 lbkcXhtmCvfsgufcqlXSAK4gyAIUmQFhpPnvpIYmsvnOdPR01/QOociJs3Bv2RYlK13c
 bc79PoawGOSm+vnObHTZOHVDQ7WpjmqK97MOYQTPGThFJ0D/Pb3QpJIlf5fIKUpgdyPn
 lZGYWSxSIIAE1nCFbI6YhGmzC0f2CvqO6b2LIb5lS11DwSLMA1tCASvFQENuzaPOHVyh
 Hrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403022; x=1705007822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dzfzyX80VDqHnC3HA3YxeciHynte6VPZm1QiBOJYQ8k=;
 b=gSapOaLm+WMIE0nVCLoonUWuvkbUvxRshQD9xHZQVclbZ2Aj07uhzKZzSheQgF6mCQ
 rcziQBy9XlPtQ/4KxRXs9IyveqL5U8tXOqEHask1528mlrnIcdaC3ifrrrXIFJdjtDsl
 SlvAZZLuuhGC7PPzH/zf63mDAqjcJw0aM6s/6TQ2gVYu02e4QaR1ANuNIfZtVGUV3zOR
 lwAp7s3LwvnmSFond0zeZcQNOPv7mgIrXXu0Ml4X1zkjyacklHTiUt5LnLJpOD+OCjHB
 DCZiz/2XaiXYczCENHlO6K8Z5lT+SbflHcfeIcZyp1OKmdbp77bCjpAT64GHpPE2CqQh
 39/w==
X-Gm-Message-State: AOJu0YwqiowNmd2eym7eV/FMgvAeroKJg6jpu/F260q6AbXutZ/Y/X49
 JOzaWoehSzhL+WaQnVFvQ1vHXG+yea6NGw==
X-Google-Smtp-Source: AGHT+IH0/2mWkIw1VCdiCAMhWqO0eaEUTyg9DMxkFw3UNNmvQWSNgIRqtnB8kQ5oACBh73DIuy0xgw==
X-Received: by 2002:a50:c305:0:b0:557:1792:6e96 with SMTP id
 a5-20020a50c305000000b0055717926e96mr176303edb.78.1704403021455; 
 Thu, 04 Jan 2024 13:17:01 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 b23-20020aa7c6d7000000b00555a0fa2211sm150375eds.31.2024.01.04.13.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:17:00 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:16:45 +0100
Message-ID: <20240104211654.1437671-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] metadata: improvements
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <pvorel@suse.cz>

Hi all,

there are 3 parts:

1) The main motivation is to avoid having to fix docs manually,
implemented in commit "metaparse: Add missing blank line on the list".

2) Add CI job for generating metadata, to catch the problem early
(we test metadata in docker/podman CI jobs, but error there is quite
hidden. Having special job (which is quick) will show the problem
immediately.

3) Minor verbose output improvements.

Kind regards,
Petr

Petr Vorel (9):
  metaparse: Print parsing file on verbose
  metadata: parse.sh: Allow to pass list of files
  metadata: parse.sh: Pass -v to metaparse on VERBOSE=1
  metadata: test.sh: Print more info on VERBOSE=1
  metaparse: Verbose output on V=1
  metaparse: Add missing blank line on the list
  metadata: Add test for missing blank line in list
  ci/debian: Allow to install packages only for docparse
  ci: Add job for building metadata

 .github/workflows/metadata.yml                | 58 +++++++++++++++++++
 ci/debian.sh                                  | 17 +++++-
 metadata/Makefile                             |  4 +-
 metadata/data_storage.h                       | 36 +++++++++++-
 metadata/metaparse.c                          |  3 +
 metadata/parse.sh                             | 13 ++++-
 metadata/tests/list_missing_blank_line.c      | 14 +++++
 metadata/tests/list_missing_blank_line.c.json | 18 ++++++
 metadata/tests/test.sh                        |  2 +
 9 files changed, 159 insertions(+), 6 deletions(-)
 create mode 100644 .github/workflows/metadata.yml
 create mode 100644 metadata/tests/list_missing_blank_line.c
 create mode 100644 metadata/tests/list_missing_blank_line.c.json

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
