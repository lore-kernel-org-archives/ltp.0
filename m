Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8E5C43334
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 15:45:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A35C3CA8CA
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 17:45:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C944B3CA77B
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:45:03 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46928600A63
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:45:03 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id e15so14641555edj.2
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0RDV3LfY9Xy3Jm7IZZiFccn5WkHlef0xh/HmK2Mp+Vk=;
 b=LmfgKrINvMuZlEn8iqQZ6HTz4/4vGZBsH9SLwcu8sX9PonQhZBiBxh8DCeWKAiLQC+
 /BzHsdGUcTbypRZkH4ipYSSiPo/BXDKF9BzxRia+hgVobwfLaiwTbS/MXU2oIVMvfUbQ
 L9nfav3udmn5ekoPnxs4iQq4PKnO+U5eZx0Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0RDV3LfY9Xy3Jm7IZZiFccn5WkHlef0xh/HmK2Mp+Vk=;
 b=JZDaKcJtGpUGip2HM6EbYs1G0hNbu0yBFxnRWtPZTZYytk9+fawr2LD0VdiAa2pIkT
 H33w0Q4d5sY3lUTmvyiEb751fbkP7DXYjZ37W+uVyluRJa6sH/H7Z94DY1rHxVnmzELg
 ROR9rtc6xBER5/82FRr43hm2c7FQ6ERetZ54Y4VaeP8dCrTZJ+85MIyXXr/6Wxg1wsfO
 MSWCLv78ac4KlJwauO2+3jU6m94OKphmUYlKOvPurKrp42RnsRUzOD4rs7RSdWhbNFam
 rsTJb7eWrWx7C+QhN5CyVdUO2oEW/+uobBDqBOHwWyZHHG6VWplToYgvOsikq9VhH+HV
 E1Qg==
X-Gm-Message-State: AJIora9mJg64x2ceZD5OTSa0rUqFFV6SFgjlEaBcXsP91Mlb5qjcoKVg
 XIZpqDp03R9bgoTFp+jEf+ksrA==
X-Google-Smtp-Source: AGRyM1t3DmASLYur8LXJjGGYj+/MpBaNAz/lRVvtFJB89fZFe2d4pgQ0c2/XFlStz8o/Fp8tJfUASQ==
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id
 ef4-20020a05640228c400b0043acddee047mr5753304edb.368.1657727102841; 
 Wed, 13 Jul 2022 08:45:02 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170906300400b006fe9e717143sm5122181ejz.94.2022.07.13.08.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 08:45:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Jul 2022 17:44:58 +0200
Message-Id: <20220713154458.253076-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] can: slcan: do not sleep with a spin lock held
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
Cc: Paolo Abeni <pabeni@redhat.com>, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeroen Hofstee <jhofstee@victronenergy.com>, linux-can@vger.kernel.org,
 lkp@lists.01.org, Eric Dumazet <edumazet@google.com>,
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

Changes in v2:
- Release the lock just before calling the close_candev().

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..5214421dedf3 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -689,6 +689,7 @@ static int slc_close(struct net_device *dev)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
 	netif_stop_queue(dev);
+	spin_unlock_bh(&sl->lock);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
 	if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
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
