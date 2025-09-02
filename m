Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA41CA1005
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756821103; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pIcTEG7BzacLBJDQREFd9qS1Huycqn3gXCVyB32PzCk=;
 b=TNB+gbHejd9p3pXCKMuXc9Eu/p4cd1AJXK8TgamB3MOAdvFAYBU9kxAxplloUh+8PpejF
 CrTIjrZ/WmFt62e9DYaUaTAtY1Yrrair37QQWoHhEfXIz2Vs0dxyRn0XmzJK2ai5/R2SAsD
 zChb9XprdY7y4A1MLCMQB14d+AeWAic=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9912A3CD195
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 15:51:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6903CD195
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 15:51:22 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D52F720005E
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 15:51:21 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61cd1046d42so6581510a12.3
 for <ltp@lists.linux.it>; Tue, 02 Sep 2025 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756821081; x=1757425881; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3TfXSXobbVU/6IpYdIHeNjUcUm19jFxu8i1VyRTPiR0=;
 b=g81PwcRqTafvmcg2mH+7MASOO3xeI83QOFeTy2GNp4GKg0791Jefrl7TtwRYeuD+10
 s+sz16S9XcLz2XyO+zX/ZmKltuhTPx7C/DVz5cn+wiAcoidBzeIHrx7tRnEDcS1VMLUP
 k4em5rsw7HLMC1fDkDAvqv9wW6SeU8AfDvNnvlVi2xIM7kt9Kzr1gf1SAI3jraWXDbZi
 mQPy2tfV5749t9ndUH7z7538igmy/8LsuDmgXgsjKMgBQ8OLv3C1gObYzCbH186u58eq
 /+mxW+a910Pes4uz9rahngEbqnCmSnGNB1PRgQxeo2IwaaEzF53OqxRjqDV5qdU9wxcy
 bB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756821081; x=1757425881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TfXSXobbVU/6IpYdIHeNjUcUm19jFxu8i1VyRTPiR0=;
 b=uUyr36NpGwQc04AQSl2ilEW4wXikC8rrnxYQ7Rdvl+req5WIeJKZiyXumMGpVAPLre
 WGX6mlqMVAc/li/HzH7dXkuOMJipgdtU6pALXx1Jes0b6TjlzvVBToymLFhVYEm8Z+zy
 NkMpwMOPpzuOg6oyBv8V9BjCGg0/g9nSz9kdX/wJCB/ZenE4AW7sJzaG/GVhD1oy2OYC
 BoIiDZO0lbIFmTiatYgKw7FajvxSK1r31J7F79HZ61V9tPkZ8Lygmz+6GrBAgQLbgUBg
 EZdAaRDc10qbB34uuHS/vwl48SQqL3+LKZCEM8KrY7Q6yqf8DGMiNqXcH4tH3RB+xOpI
 +ZYg==
X-Gm-Message-State: AOJu0Yyu2VucoRX+M4Bi2FS7MbzflQv7kdm3qwrRGAxAvoEzoDWGURDN
 rEWaq7KNPqgwVDufTniZJEMnyJO2YPmWe1q6LiWv6iiksaSdWrQhCkBDsy9t5tAaooStnOZLVwK
 ZRkw=
X-Gm-Gg: ASbGncvcNqYyLzKl8ch5CE5+6ntg0AeX8KYhv8UiI6JWd8Mhyv/vq2+EKZr0xb8u672
 nNEYHG2IFH9ihSXmBvL3qskNCIveg89f8kzSUwpbc7+ZuDYl4Y474Z5K7gUjEEWCb0Vzv6Hw89+
 F+3GOqNek14ku5zESu6ZrW6TVzCmod5JZK3drCgDTnOfwgE7eVCF6u8fD+hfI2piZ95H5mdfrFh
 l4BUBkAlHrAGzGYFweOuC5eVioNWQErieaxrKk0wD7F1lP9DS9pO/noH1rx7aS5JAChYGh35UFt
 ZmoX6tnVF3zTuAPpIb9StIR7fgjCJL/2JZYLlRkqqawJCncRNT04LrcRkG0l++12H5DDAr2PiI7
 YT0T5dlWg0AqJ0hxuk1CMf6rHR5zjiAjMkgtpGd+yoxI=
X-Google-Smtp-Source: AGHT+IHEnL4e0vXpnhpW+3LlKK893hGQnsPn0tE1/Y1YjKCTPZwmU1fgL8E+FlCmTBc0+l0wQNBpMA==
X-Received: by 2002:a05:6402:3228:b0:61c:cbac:f6c with SMTP id
 4fb4d7f45d1cf-61d26c33cc1mr14315824a12.23.1756821081021; 
 Tue, 02 Sep 2025 06:51:21 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-61d322b3854sm6689873a12.0.2025.09.02.06.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 06:51:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Sep 2025 13:51:13 +0000
Message-ID: <20250902135117.6222-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_sys_conf.c: Report TCONF if read path trigger
 error such as EOPNOTSUPP
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

We encounter EOPNOTSUPP error when read path in old sle power test env, the reason is
hugepages are disabled. Detail error information such as:
TEST cpuset02:
tst_sys_conf.c:103: TBROK: Failed to read anything from '/proc/sys/vm/nr_hugepages': EOPNOTSUPP (95)

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_sys_conf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 80cd83569..30b0b67a8 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -99,7 +99,8 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
 		if (conf->flags & TST_SR_IGNORE_ERR)
 			return 1;
 
-		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
+		ttype = conf->flags ? TBROK : TCONF;
+		tst_brk(ttype | TERRNO, "Failed to read anything from '%s'",
 			conf->path);
 	}
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
