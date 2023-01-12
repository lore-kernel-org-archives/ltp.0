Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3992BC5479D
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 02:46:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D14CF3CCB06
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 03:46:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A7C03CB56A
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 03:45:58 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF8AA2009F6
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 03:45:57 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 g19-20020a05600c4ed300b003d9eb1dbc0aso11046496wmq.3
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 18:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0dIgAOVaOt79gY0PVDUPBMzxfLQtYY90oPZN8/ULUvA=;
 b=i+alyyeM1mBb5gryilwFnoTwnFgcC9yj+nF73yvcTUL0YyzpjUPns5crbl/HvrIQ5L
 wNTjr1UtPKZiRMQOzxCnFgYBCoW+ohlUMtf/XPRGgwgyxfSzGvIJUNrNWA2EKUVKUHxj
 NbqWKP3k/qet2XjwouDZk0ddnXVZGgrts68Zts9C1mUOGsDFANbcy+Lalg0lGsyeeLp+
 JykTFYrT394PE07cUtwiowBNTvV+UB29QQdB747Wj8wY2NMx757OufsguTjTtJnJf3Pz
 AzxbRVs5XOWCkiMCa4/aD642iB4ZmJmYqFjdCgf1/XO+mcZC9HysiwfwfxwYTGQJg3UB
 bMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dIgAOVaOt79gY0PVDUPBMzxfLQtYY90oPZN8/ULUvA=;
 b=eYmYG7EdIkMDcdwvxRQ4Dp2cPNePFOM5PJ0dvzq06W/2os/frxSTWOi7qtJS868VW3
 Lcy3CipS+XnXzROzKm9KwQqt/SK3EDScecNnjnaoUCuuyjOjM5VHW4tp4/+srE5TK303
 Bu0mckV7TFjOcRIUrzQ3NCrRXRT1Dc/hNAyVZxC3eoOONfvlJL2U7XklkBod7A1XMTZQ
 iN697I2rtJuXjc3OOZhQfaCDSPxaTABgVx6rIBkyTtA5ulXBRJ8q3KxRJ7nS2jIXqtCG
 BmutAmTqzwtJLcML7hHm0fRPo0tL1bdPR9uisqVCkbOFo2S7EJhw+DFszP5GNe8mf4gZ
 eHrA==
X-Gm-Message-State: AFqh2kpV4fkKGDtAtA32Gf4nXJbSOn8odjXPD6ostqtJoxbn4XDjyWGa
 KhOFLVdNZk3ad/ZB8nU0D/+iiDig+mkwIw==
X-Google-Smtp-Source: AMrXdXteHCDR4nLgMGQ9zyFihHTL0R8bihaimFV5GgERgX9zdn4SHbzeoyVA9BAtjG1N2c0StohMvA==
X-Received: by 2002:a05:600c:538e:b0:3da:11d7:dba3 with SMTP id
 hg14-20020a05600c538e00b003da11d7dba3mr644517wmb.5.1673491557316; 
 Wed, 11 Jan 2023 18:45:57 -0800 (PST)
Received: from openqa-migration-qe1-1.qa.suse.de (nat1.nue.suse.com.
 [195.135.221.27]) by smtp.gmail.com with ESMTPSA id
 bg23-20020a05600c3c9700b003d1de805de5sm23008208wmb.16.2023.01.11.18.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 18:45:56 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: ltp@lists.linux.it
Date: Wed, 11 Jan 2023 21:45:47 -0500
Message-Id: <20230112024547.4121-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add more strict check for tst_require_cmds
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

From: WEI GAO <wegao@suse.com>

Add more strict tst_require_cmds check for init_ltp_netspace()

Signed-off-by: WEI GAO <wegao@suse.com>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ceb45c98d..e6bb09d81 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -131,7 +131,7 @@ init_ltp_netspace()
 	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
-		tst_require_cmds ip
+		tst_require_cmds ip ns_create ns_exec ns_ifmove
 		tst_require_root
 
 		tst_require_drivers veth
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
