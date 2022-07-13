Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DECC43334
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 15:20:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F50B3CA8AD
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 17:20:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C76B3CA52D
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:20:15 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CC65200B91
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:20:15 +0200 (CEST)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-10c0052da61so14361970fac.12
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LKNJ81XHX1rVWPGtQSPsv7xkRycDjY6KgGLmlaN+gNY=;
 b=UGv5W4X0AgNs0e90Jxbuk8yoqkf1YIvPuG32cxJaOFdhOKMYtLT3UzjNMyJo3NmCSB
 h/K0iglgBA1TRNjZsaY3WPDnmRX23YpSMViygd9NRIhPlSo9yiPb+fbPadGOwbmeYz9x
 0j6tumQO78ZJbjdyG1XX+ZjluB6BIV4JYujzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LKNJ81XHX1rVWPGtQSPsv7xkRycDjY6KgGLmlaN+gNY=;
 b=hEjCRxOtnPd60JhV40/gtqfOxp+dr1/7Lp43OEX5UxR/jzh7TRICepMrY5eCGsiUSZ
 2RYkpFbwgFt3pu4c6Vt6LErAprrNam1qldyeUYjnZlPqbSB0zV1ZWLTLJ+vKGDQzCULR
 eaDEFvcYz4JURrKWXhVvrUyCrIvrAL9odVE/cEVuQ2ugSSwJirpk8WSV5il/gyBEWF+m
 YuNrMdjKZlAuuc5OSY2AsMZSLRhDUkXecl2NNDpGgdxQj9ffCPmfnbKJYqmSEXLt2/4z
 48SDyB5F+z+nA1n7ihU29ylTv8xFyJVpa3uHsQgngAd5T/Tna1p5UGKTYyOZt4nX0Kqo
 DlPQ==
X-Gm-Message-State: AJIora8zsMJ9+ee9X+tM7HTP8vsigJXFQtrVI/EpvQtYwavWFYj09rtw
 DvSDOzggGvA8kqtcd4t7Odct3w==
X-Google-Smtp-Source: AGRyM1usHml13CDD+aHqFlxY8s5H+Eng7j9UX5kgdAqCwghIPyT60PRhwo1GRoZ8vA6nrb+/q/6Bdg==
X-Received: by 2002:a05:6871:60c:b0:10b:ee7c:2e28 with SMTP id
 w12-20020a056871060c00b0010bee7c2e28mr4774059oan.21.1657725613728; 
 Wed, 13 Jul 2022 08:20:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch
 (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
 by smtp.gmail.com with ESMTPSA id
 x24-20020a4a3f58000000b00432ac97ad09sm4895477ooe.26.2022.07.13.08.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 08:20:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Jul 2022 17:19:47 +0200
Message-Id: <20220713151947.56379-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] can: slcan: do not sleep with a spin lock held
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
Cc: Paolo Abeni <pabeni@redhat.com>, lkp@intel.com, lkp@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeroen Hofstee <jhofstee@victronenergy.com>, linux-can@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kernel test robot <oliver.sang@intel.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jiri Slaby <jirislaby@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 ltp@lists.linux.it, Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We can't call close_candev() with a spin lock held, so release the lock
before calling it.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..6aaf2986effc 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -688,6 +688,7 @@ static int slc_close(struct net_device *dev)
 		/* TTY discipline is running. */
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
+	spin_unlock_bh(&sl->lock);
 	netif_stop_queue(dev);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
@@ -696,7 +697,6 @@ static int slc_close(struct net_device *dev)
 
 	sl->rcount   = 0;
 	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
 
 	return 0;
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
