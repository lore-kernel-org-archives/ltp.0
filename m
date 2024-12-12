Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCACE7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733993512; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yo5QalW9PHsN3umVt72Ujy6ywao+4+yfy7xhKOCThVM=;
 b=WUbuVg/6l/PIW5aoG5LSPBclFuhyK6b06tP0mFeZuhW5+dC/z9iHVerkEwE7EF+qUsSnl
 qyzyIye2Dp9hJg9JiHFxIbdjtufTd8TLiI8eC+2FbCTlMXtke6c41jXaJv+Kp9qqCz4KW2X
 mqJGdU7/n210YZgrqhzd5fv/V/OaC+A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81CAE3E7AD1
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 09:51:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B583E7AD8
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:51:12 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5328A611F73
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:51:12 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso457232a12.2
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733993471; x=1734598271; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwKNXIqBpDVkg4cmenK6zkXjwz2Ztc+ymmOQkksqsZM=;
 b=DlBPs3dmyySYZ6gxdXIZPQtXJpBcPTDeP5h7mmWwCrN3LkQvPL3N69i+rB7CQ2W7GA
 0Eunga/JEsjGije/Y23Iy5ksT1vb9+G+7VgkDSuCpx644X78yxUad+SAdVgUIbHKhFfz
 RmlAAk8aRmW0U716YeEXv2sZOkhKv+fKaY/5E+orXAgEJO18cgGgwFYmktVz83EX/KuG
 GiAzrWdjwJ951o1Y/n+4cuduqUq6aRI3+jDqgx2NmAs4yh3Fi8AJQSzk2swxcDpG8r5f
 BpcCkAHOE0GfvpM2Dn15YXIY4fnOTZYGu2g+Au1Qs3j1oTs/Z/UUmmI0tk3JlcVEhvll
 B0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733993471; x=1734598271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwKNXIqBpDVkg4cmenK6zkXjwz2Ztc+ymmOQkksqsZM=;
 b=H552TDsLu9m7FN90Eyw6VMXsK6qwCkU//KjOmQgAZOlhkq8yA2jZUSDB5G8jlbr5jH
 FgypAwNw3v3Ebw44LMbwwYux/TPhSyUv0YJDlBruDNSDczYociLaP7t0/34K7a/sTXhC
 xeYqrBc9kX4Ibv6v1hqI2SiiKzxu88KF6H70HGvB7n7EfWU8FKRKnVjxwOL13KQqJMWC
 ZeYpkYUhYPzNEJdvjnHkcOdBppIzpPBnFwQkJn+CaY+ZMsr4nnF7FII6qlMHxRy1IQBN
 2hert0R316dKjs+6f6aJPZH0COzhpxxoUSW7oSejgBAKrmImjbVrbT17Kl+Kexcqsa4P
 KqKA==
X-Gm-Message-State: AOJu0YxM8kKxdQdjgYf/ekZAf6m2UdBG8Bc1Va7Tc5PKYwG1pC56604S
 WKGgF8LqORFr8wyFUQYzY8PuNeGFw4R35OpRJDvBOQbrLunhbgTyGFOjTJgbT7ZUNoM7iuaBmo4
 =
X-Gm-Gg: ASbGncumIzcPLVS24tlc5awmNCKQHhwQ0UGfDmcssYZ0wH/H35LYFvb2c9I3Obf1t1D
 S9S8BfUSYtgPLB+KmlV0+anF2OcpuI43d8pSB6bSfNLIZtgHyTqXRitmcI9RfoWAk9pYksLYUdy
 EqDNkUI8rBAVZhbmEixkhXK9IxueStEll/JB73UWnYQa/LyyijKMEo8b8fdT/XSZN7iWSGzSC+B
 sfTczptVNye+Fsy6qzEac8gLnBya1X6CapU9IIMM9Ywkg==
X-Google-Smtp-Source: AGHT+IHIMHiqys5xa8tbz5NDscr6bZgAxD+O2QSccVlhsyM6SdFEFwtMjddndTy7tg5zOnLu/9e3Ow==
X-Received: by 2002:a05:6402:26c4:b0:5d2:7270:6125 with SMTP id
 4fb4d7f45d1cf-5d4edccd29bmr265120a12.8.1733993471538; 
 Thu, 12 Dec 2024 00:51:11 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3df2fc65bsm7282904a12.54.2024.12.12.00.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:51:11 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Dec 2024 03:50:57 -0500
Message-Id: <20241212085058.29551-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212085058.29551-1-wegao@suse.com>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] tst_safe_macros.h: Add SAFE_STATVFS
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_safe_macros.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f2ce8919b..777f81b5f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -429,6 +429,27 @@ static inline int safe_statfs(const char *file, const int lineno,
 #define SAFE_STATFS(path, buf) \
 	safe_statfs(__FILE__, __LINE__, (path), (buf))
 
+static inline int safe_statvfs(const char *file, const int lineno,
+                              const char *path, struct statvfs *buf)
+{
+	int rval;
+
+	rval = statvfs(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"statvfs(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statvfs(%s,%p) return value %d", path, buf,
+			rval);
+	}
+
+	return rval;
+}
+#define SAFE_STATVFS(path, buf) \
+	safe_statvfs(__FILE__, __LINE__, (path), (buf))
+
 static inline off_t safe_lseek(const char *file, const int lineno,
                                int fd, off_t offset, int whence)
 {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
