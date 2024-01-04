Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A156C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:17:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 901E23CE6FF
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:17:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE3FF3C94EA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:03 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C542200091
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:17:03 +0100 (CET)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ccabf5a4beso11662981fa.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403023; x=1705007823; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAH5EBQ3IhC9szQRqbNnMhFj+1CMltV/beKrElLO2W4=;
 b=PItVh4+ZvcqnhTyV1jxLKZj+LvlynuDRzf6F0mnWn/e+KBYe7N9eTc9uP1bs2VIDvO
 gJHzBzAb6kJi06Cku60sYwtBPydUjYfdKaapgQx4uDAsWikNeVzYKwzpE55JLxgPRpCY
 GTI6jXa/cdN0ie+zvU8J1C+7APveXL/wLdJFkt3eVcqUwvOAigCSXxIN/tTKec0qFcRy
 8RoErxo6jpU75ebezst45DxqhY1DiaBfusR6EUzecMTg3cOdrjRcgeUCo3BPIZDhm+Ie
 rRr7LMnpncPpXGsS99o13GHI8IPdtE8GFnbPF3Rl09VzHtt707Ni9Bln4Ky0ar6U7EGr
 CCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403023; x=1705007823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAH5EBQ3IhC9szQRqbNnMhFj+1CMltV/beKrElLO2W4=;
 b=XAArY2lQdcFL3yGDrOi+fGKDepjVXKDOajnlydyrX/A+hSkwe96zQ5HGcZZ/pfCr8/
 kDvGHERp+9bMvqYAqjX+Qa3zkA4T5cSij7suHULLsdwNIk226MNb55hItXX4txC1LGxv
 N+yEvgx74wU3ONJGrByH+MyeGtakx3uc2gz0xi/bLhWQfSh2NPQjQa+xvBSyYkt0uyIS
 sY41DJ560fLYmZrN87tFTkE3Uo3ggW3B3Crj0X3u51IkgeJyd30X1vdKpdXLIn5tRSrM
 8rQPGDAk9dcFksX1jtKax+T3ZzeDX04vE1RJvo0Y8BaW7C3GVWqGLi0crNRJZ9k6BG49
 4kgg==
X-Gm-Message-State: AOJu0YzhaMGAXwOXu3L7x06a/W70yKsL9aKmgfabdntYK5PDIkd7gqH5
 Pniap/cL3yD/H6ldiBbypuSHDJO+pwtT+Q==
X-Google-Smtp-Source: AGHT+IHGE5cPmMMnDxFDlRdevkyivrnHeI5q5qwZdwY6Lu69Gj+XjBrEZTS69ChY1jV7LKriOB/4qg==
X-Received: by 2002:a2e:9916:0:b0:2cc:bf55:c69b with SMTP id
 v22-20020a2e9916000000b002ccbf55c69bmr353738lji.20.1704403022429; 
 Thu, 04 Jan 2024 13:17:02 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 b23-20020aa7c6d7000000b00555a0fa2211sm150375eds.31.2024.01.04.13.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:17:02 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:16:46 +0100
Message-ID: <20240104211654.1437671-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211654.1437671-1-petr.vorel@gmail.com>
References: <20240104211654.1437671-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] metaparse: Print parsing file on verbose
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/metaparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2384c73c8..fe6d68911 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -862,6 +862,9 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	if (verbose)
+		fprintf(stderr, "\n=== %s ===\n", argv[optind]);
+
 	res = parse_file(argv[optind]);
 	if (!res)
 		return 0;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
