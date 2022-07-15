Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EFAC43334
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 07:30:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77F5F3CAAC7
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 09:30:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08333CAA68
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 09:30:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 950A61000F44
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 09:30:07 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id w12so5175755edd.13
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
 b=AVIZkYqmlFqGyQyc7TgsQ34JecaSIs4T8qLG5N3Hp0xrVzxcXrS3uzP60Pb8HTdcmT
 NNGLnCb4Z9g7363Stm9NWRyWEhV7UQj1cA1KUh9ersScVzQznP+DuLsHeTVH54CzogV6
 sDh41C5MSXZZjAFvypRAwrByZXHmsniHxPdoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
 b=6K5yUBwpPemA7qoQSCcYv8ihk/eUyqVNPzcahyCiyGTInHNFNsE+Xri5ha/3Inl/tD
 8doEjMUzQJ12f4eDP+u0HHR29mCv1Gs86jxG/i+Tsu/3CJfp7h+iWCUC/s5FOn7KVQT1
 wp300Q66uE5iUKDp+z94XZ3OpA4489aiUvKceOw7iFb18gqQNybcxmT0BJj1z9PgIzOL
 qLgR/qflSdcK1tUaFtOp4bOCkBos19smzHivdfE7JNGF+3EWXZcVMKBaqVbrlzgVlhli
 Id3ERTx3D928JlcoI+J9P/0JzLyw7ernURIYIBDnMbTxjpJNcp7WOOeDiVXWAxvEHmW9
 Qsvg==
X-Gm-Message-State: AJIora94yRltzgYNpz9ImUQg+uzIAr1xdjYXn3UlzHR1p/3gLARjsufn
 +WvcQvjV1tNDxZk+ja3bHTEPgw==
X-Google-Smtp-Source: AGRyM1veMbMMZYqaMJnj/C70UuvPpYLJnS6n0L96smOnFkBPJaiYLrr37MwwvBcLdyxnSZvMMZunqw==
X-Received: by 2002:aa7:c585:0:b0:43a:725b:9851 with SMTP id
 g5-20020aa7c585000000b0043a725b9851mr17229990edq.399.1657870207114; 
 Fri, 15 Jul 2022 00:30:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch
 (host-80-182-13-224.retail.telecomitalia.it. [80.182.13.224])
 by smtp.gmail.com with ESMTPSA id
 lb11-20020a170907784b00b007246492658asm1692756ejc.117.2022.07.15.00.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jul 2022 00:30:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 15 Jul 2022 09:29:51 +0200
Message-Id: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] can: slcan: do not sleep with a spin lock held
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
before calling it. After calling close_candev(), we can update the
fields of the private `struct can_priv' without having to acquire the
lock.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Update the commit message.
- Reset sl->rcount and sl->xleft before releasing the spin lock.

Changes in v2:
- Release the lock just before calling the close_candev().

 drivers/net/can/slcan/slcan-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..d40ddc596596 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
 	netif_stop_queue(dev);
+	sl->rcount   = 0;
+	sl->xleft    = 0;
+	spin_unlock_bh(&sl->lock);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
 	if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
 		sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
 
-	sl->rcount   = 0;
-	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
-
 	return 0;
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
