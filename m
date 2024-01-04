Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C5C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:20:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 762E63CE717
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:20:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8C6D3C94EA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:41 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41B121000DDA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:41 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a279ce3aab9so116630666b.0
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403181; x=1705007981; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV/IA+diQLTUv8nYZmUrVgLIGtSdM9HXijihrW+y5Ms=;
 b=H1MFa70B5GKu9COAimgV0anD9GUYa8+N+Di5W6Qz9+T1QCCU/dw7S1UKkdIQ9xGQqw
 G2PMon50tO3kpZDAFBJoI3kVxqXRXBvs7P36lS5acgtiogNJDlYK+owbBq0wiG+5wj99
 /sFwz3g0m4BNVAl0Tbhr5vNbMe9Q5kuUvbnbQVEu3JVJkkDiLlLTsWCfVP7jv6zfqtg3
 rmOcDmfeVg7xnjBxH7XfcEsQlVSJAXoiuWkxYrlMzOj+pWW3Dpg7hfaFdCdKCbCNEeY6
 160EjjB49qD5Vf1Z6aelk4xU+VT81yNKj7T58mlIanV56o0FwTvPBK7yM5fB/1p8Qbmj
 3yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403181; x=1705007981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV/IA+diQLTUv8nYZmUrVgLIGtSdM9HXijihrW+y5Ms=;
 b=Cm8wnpL4NlqcrmJtLaSah5r61WWB3gF6dHifXMsNzZj3QpjNrSuERoMOYxdAyQBaB4
 hBX4MkpRlEvYvOQDTdmzHn0y8QN+ZHBmA31zkKOgzL7yxS43T/2Oo6WLTB5r5tjG/Ojp
 ixbuxqGbDZaXMlzC4+ofBW4Q3fQjgm8zOECzOsv4A9A7j9q2mBQ8KmYdR8/TRyDLiCDk
 nwmY1nVaMOT56lTB8BplTiOSAH63hfPmto4WrNmJzfd93QoSfMc+iQGvuo1Yxx0HrCsa
 d2Esoo7Zkj46m/ncr/m+wBALXbD4FAyntrpunAn/EqdSAEo9QjxcDoH+3KDi8z/F4nZY
 3PQA==
X-Gm-Message-State: AOJu0YwFBFeDycfGVJ9TABKnyfFZBH30MHYVCi3HGVx5AjT8ednmDsN7
 /7wGyi2bj3Qr3WiTFbRAD5FMDOvqB79HcQ==
X-Google-Smtp-Source: AGHT+IFbsGQaj3E41KNNqXa3ih7sk/4gBS9m3oi+NJXlFTzI81DmLHHhCRX5j9BUeMtALb2Pnv42Mg==
X-Received: by 2002:a17:906:4c41:b0:a27:3ee3:1916 with SMTP id
 d1-20020a1709064c4100b00a273ee31916mr260923ejw.301.1704403180699; 
 Thu, 04 Jan 2024 13:19:40 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 dt12-20020a170906b78c00b00a26c8c70069sm83058ejb.48.2024.01.04.13.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:19:40 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:19:34 +0100
Message-ID: <20240104211935.1438103-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211935.1438103-1-petr.vorel@gmail.com>
References: <20240104211935.1438103-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] make: Delete gitignore.mk
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

We don't use this old functionality any more.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile                    |  1 -
 include/mk/gitignore.mk     | 51 -------------------------------------
 testcases/realtime/Makefile |  1 -
 3 files changed, 53 deletions(-)
 delete mode 100644 include/mk/gitignore.mk

diff --git a/Makefile b/Makefile
index ee92e64ea..49d91f4d5 100644
--- a/Makefile
+++ b/Makefile
@@ -13,7 +13,6 @@ top_srcdir		?= $(CURDIR)
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/automake.mk
-include $(top_srcdir)/include/mk/gitignore.mk
 
 .SUFFIXES:
 .SUFFIXES: .am .default .h .in .m4 .mk
diff --git a/include/mk/gitignore.mk b/include/mk/gitignore.mk
deleted file mode 100644
index 475206dcd..000000000
--- a/include/mk/gitignore.mk
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-#    gitignore generation include Makefile.
-#
-#    Copyright (C) 2011, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2011
-#
-
-CLEAN_TARGETS+=		gitignore_clean
-
-BEFORE:=		.gitignore-before
-
-AFTER:=			.gitignore-after
-
-IGNORE_DIR_EXPR:=	egrep -v "^$$(echo "$(AUTOCONFED_SUBDIRS)" | tr " " "|")"
-
-# NOTE: The underscore is used in place of a dash to avoid implicit rule
-# evaluation in top-level Makefile.
-.PHONY: gitignore_clean
-gitignore_clean:
-	$(RM) -f $(BEFORE) $(AFTER)
-
-$(BEFORE):
-	$(MAKE) distclean
-	$(MAKE) ac-maintainer-clean
-	find . | $(IGNORE_DIR_EXPR) > $@
-
-$(AFTER):
-	$(MAKE) autotools
-	./configure --prefix=/dev/null
-	$(MAKE) all
-	find . | $(IGNORE_DIR_EXPR) > $@
-	# Set everything in autoconf land back to a sane state.
-	$(MAKE) distclean
-
-.gitignore: | $(BEFORE) $(AFTER)
-	diff -u $(BEFORE) $(AFTER) | grep '^+' | sed -e 's,^\+,,g' > $@
diff --git a/testcases/realtime/Makefile b/testcases/realtime/Makefile
index a7491654c..61663bfd9 100644
--- a/testcases/realtime/Makefile
+++ b/testcases/realtime/Makefile
@@ -36,7 +36,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 ifeq ($(filter autotools %clean .gitignore gitignore.%,$(MAKECMDGOALS)),)
 include $(abs_srcdir)/config.mk
 endif
-include $(top_srcdir)/include/mk/gitignore.mk
 
 LIBDIR			:= lib
 FILTER_OUT_DIRS		:= $(LIBDIR) m4
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
