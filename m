Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830CCC4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 07:07:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C1E13CFF7D
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 09:07:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B19E43CFF0F
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 09:07:11 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EACB7200A03
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 09:07:10 +0200 (CEST)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b10c9cdf4so19900076d6.1
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713856029; x=1714460829; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lLAQ9MoLIYYh4+8HD1hSAvsWUjXIJ8Pv3hNCw5QkQ/s=;
 b=OBlx5nMJE2z5gnyYSR9QrHpdQVN3wspiarOXiLisleGRDOLD//v7YmpsSKHA7fdEtr
 E878Gx/hxBq8UUbpP8Rzp4OIUrGQNYmgywBdQtWjTMbUCgBoJTKuZGUYQ8DO75wkh8Hr
 snkypBe/LsG8+2Zb87BX7JWdrwFaEXm3Sd4Vxy62dpZ77WQSpVAbu0ZsgNTJ0jp8u5ry
 zLRmcZ3Orsl1HwokoqUnWIDJYvvXWBqZMLW3h5xL7JXZT2Ne9y1efdagnAT1ReD6dIXV
 WXUe0GRAn+0Xf91EqOftCSn8D14vqKxSIZ02fNiATgS9q8Wbk0IYX+GZgaaWqeH1Nj9F
 k/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856029; x=1714460829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLAQ9MoLIYYh4+8HD1hSAvsWUjXIJ8Pv3hNCw5QkQ/s=;
 b=W+UR05kCv+SkvzFCdGpLfdhEtPFXZOqVECfx1aQ6ajJEr05LYwf3+h2cML0lEFq+M7
 p722S5bqXBRdPjdJOmDzsG/T4K37Pl6fXRAkKXv5/fkYL9+yY+9mxvnHfluCIdW1sJIo
 II1PJhXnsNjAN8rCaKfLRZTahw61fHGY7eZBjPGwmTC2tqOB+hrbKKyTobCVzYWhg2uU
 fdsSYEUllAi0I8j3On/E5UZjfkblYjp7VDGbZtH3KtR2sVs7SYgmtMRutr8SUN3CXDEp
 QcvPn7mV++Oi28wG9m5ZWgCaEmcS15PmnJBX7DFu15KD89WiZjATCCACFgw+xLXGBw7Y
 BYfQ==
X-Gm-Message-State: AOJu0YyhDggM3bfMwf8WjTcIcXhzLqb8yIbmMO0rsZ/BG0Eg1ufKlmnZ
 Vl+KptT4r+BOaccysU7VVELI6DPTqyb2Jz/+hAAI4A3HHv5C6jP52WfGnyI1
X-Google-Smtp-Source: AGHT+IEYsGeqTt9BzcMrgjptWLicAxbBQ5ReP1xQRXAl6N5Q2U3nEcZOkx7zVNAJghgYXWmiL/jypA==
X-Received: by 2002:a05:6214:27:b0:6a0:6668:f3f6 with SMTP id
 b7-20020a056214002700b006a06668f3f6mr11677602qvr.21.1713856029463; 
 Tue, 23 Apr 2024 00:07:09 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a0cf00f000000b0069942e76d99sm4898156qvk.48.2024.04.23.00.06.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:06:56 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 23 Apr 2024 15:06:43 +0800
Message-Id: <20240423070643.38577-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead01: pass on pidfd
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

Linux kernel added pidfs via commit b5683a37c881 in v6.9-rc1
release. This patchset ignores readahead request instead of
returning EINVAL, so mark the test pass.

https://lkml.iu.edu/hypermail/linux/kernel/2403.2/00762.html

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/readahead/readahead01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index d4b3f306f..aed8e7f31 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -53,6 +53,7 @@ static void test_invalid_fd(struct tst_fd *fd)
 	case TST_FD_MEMFD:
 	case TST_FD_MEMFD_SECRET:
 	case TST_FD_PROC_MAPS:
+	case TST_FD_PIDFD:
 		return;
 	default:
 		break;
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
