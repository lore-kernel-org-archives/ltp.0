Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02096CA0FF0
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756712919; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=/5uWSDwagGcHf2vNsU4QGMBuU+8f0eE4dPeK65qDi/c=;
 b=di8fifyxZ2KGQd9Iyf+KkBS1GmG5B7PebTowlKAisWY/+BWKIdvxnsHR+fsenFS2ByZC9
 ZnU1ug1Q500KXAFtsNarT7VHumnT4FaZYlFOi6FKi9jjjviHXMjvXgFuJUM//53j/+MJS9H
 d4eks1Zr6/UNI+FNyMdJySef0je1xos=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 021FA3CD280
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 09:48:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F7D73CCEC6
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 09:48:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 454682001AB
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 09:48:15 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-afec5651966so101846566b.2
 for <ltp@lists.linux.it>; Mon, 01 Sep 2025 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756712894; x=1757317694; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yyvKscizB5thfdJJkMXe5XQ2dmAh4w+ovcdEjnTJK3E=;
 b=RSYhKdHxhYkmps9te401hRD7k+uXrPXgO4rff4ZzEy+6wU9LlQHTtsmCwpPxCa+5UL
 9KKMJcIamqyU151fwa40EyC7oByW63x9gl0N2atqH62DFDpu5eX97G6l34UPllCIUFHg
 i1I2vQnzBJZmu5vk3gtdQRg+8pei5Oq4G2aTKZAezSHfRZBvDNmjuuJT/P8nWPBKFc0q
 j/0WdbtfYYQlY55hBmovuC5307E0EvrQ1ds/At0XXjD823dtOhU90srZkY48yMI0h+iV
 CqN/MbNtYOXIY6pFDnvLpupRB6Z4D2paIvZtnk6UdV2c3DEUXPrVAtv7MNG4ok747mxj
 tHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756712894; x=1757317694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyvKscizB5thfdJJkMXe5XQ2dmAh4w+ovcdEjnTJK3E=;
 b=XVBssMEyGlleEMDspvz1c9iFGOonoLrpIoIu1gm87jjUXwhCjNX5XmL0TIQWCwixV/
 lT8d/HSBG8odMGYY3EQ3zmQikygMHPBSABzn1BNkcKl4yRezYR61eA4VgqGcImLoGWCk
 tcGop/HEQvyjW5W3uet1tamYuXAu1p2lK0CGYrC1I+q6XOQE874hvKRp3QTmozCL/anv
 FFlVHLyNTtqZtCuNbRhnooRK2OBAh7y9yUuLd+F/QZHOWEc8Yv/3FxlPuK9IqmYjZcCd
 azHpu02+7S1j6eyFMwa4wmcjbwTUJUzvUorKXB9d5lEcJ8bgzzA7ckCyra3nUULalvvR
 YI5g==
X-Gm-Message-State: AOJu0YxkFlH+Mhbe2SsHu8BPk4L8MrSaHpybDPugN0zpTwvAHBKTPrhR
 6DfHxCXezEsEjxL0nnigQ9uFT/5MUwneMB0MwPbnBV4gpckj24fXIAi/E8URlKFmCwy0syiMrlT
 ol3I=
X-Gm-Gg: ASbGncumS6SQSTwSqjiGHHT5lCd9cwOlXqDy9jsje1MhhuVdi7rLSTw0dCRju48H844
 o0ssgDhqRALu8naFHWdAh5hdV0Z8xhaw8P70BMJDFhDNIbXpynH9ZfgKKm3+0HdHNVO366/sfZp
 vf5w6vWDIOUlQarYMyZ4nOEzvi3WHixCBmqDQBNKHjQEMVMfNOUjF+JofupgR7ZfKH9RO4m0Kfd
 GkxTVAm7Mf0rM+gnt6XhWoZuCJV/R53wAO2vSLgiZnxwXc7/SNPFMabjNoSWwlDkaphCNvX6xm0
 4yGO+dlc2K6sQd2D0eyT+3NRqEp7wtKLtrek3qDMyPeH3/S7zS+IgodbJ70whDCIkYXbAJtxq4d
 n4aSXNLsui6R0VEXP8VRe3ynpi5/XlvkMOZ1bGGDiIAd1U4Tq1s5ahQ==
X-Google-Smtp-Source: AGHT+IH9z6wvAWIcXDcZVca+FoPKxtjxKgnRdEMOH/WOXTx9bGmXvvmkbuWE2uFBzfDYh6Fu+h0qCA==
X-Received: by 2002:a17:907:7f90:b0:ade:7c6:498a with SMTP id
 a640c23a62f3a-b01d8a26df7mr740710966b.10.1756712892067; 
 Mon, 01 Sep 2025 00:48:12 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b041cef6b4dsm301985466b.65.2025.09.01.00.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 00:48:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  1 Sep 2025 07:47:55 +0000
Message-ID: <20250901074758.5094-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl_loop01.c: Use proper device for partitioning
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is same patch used on ioctl09,the page cache of loop0 can cache old
version of the partition table which is then used by the partitioning
code. Fix the problem by calling parted against the loop device directly.

Link: https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c9137bf1e..5ee7a474a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -98,7 +98,7 @@ static void verify_ioctl_loop(void)
 static void setup(void)
 {
 	int ret;
-	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
+	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
 	                                  "primary", "ext4", "1M", "10M", NULL};
 
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
