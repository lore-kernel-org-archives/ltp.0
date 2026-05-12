Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA10CD4851
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 15:39:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA7F3D85B2
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 17:39:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4B393CF005
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:38:49 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C2572001A0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:38:49 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so2079189b3a.3
 for <ltp@lists.linux.it>; Tue, 12 May 2026 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778600327; x=1779205127; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwi1v7lIrw+wA6EKDbAJrNNnBLBA+OcQobBBG2t8NWA=;
 b=XBgXzDw3AzuDOl38lb0gLVpIBHzoEFDFxbof3xRrvNtH80XmsX2VSlz32fnu8G33Cl
 M+5loxHHAyRG18ktYruQmiP+7Xub8qHIhw7QUOHFeJ0ozxczyiuN+YRaydsdTGnYecFN
 x/sePSJ0yf+3KtsB+hq9sU+w3RaWHz7U+HObwJ2jogaxofy6Ln0FcjwKRCmm2tbpAN1g
 p6weJFv8fIhS0LjasTwIERio+D43zNGu4tX7nnpPimB9UDvZzQL+NtfsNzFMpCzKxDTG
 W2rLxaaDz/xL4EMwJ5OoLL0EUh18YhZudpyZzLust+V9lrmsY3ryr08Xy4oMpV4d54cC
 uQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600327; x=1779205127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwi1v7lIrw+wA6EKDbAJrNNnBLBA+OcQobBBG2t8NWA=;
 b=NfVdhsDBDJaW0pvrNcSOAtCPSBbzJK/OB/unVv/XSdZ483tOqK/ev12Kyx9HmdcUx7
 Dei4ivYkFxGXw7ioiYtUAg8BBKF3AmUXYtu0ucV8JC9Hp9pNFhN5HbVjlBA5HL3DQXwQ
 VreqxSPtG5IbbJ3iBHsbHGO5OJQ+O9Jo+R+pcQw9MkBPamcigBmx9F/2SpyR2fhS6dRX
 VqX0cbWySytTg0RDK0r33mQTeR9CHsuCvCDAsV709PYIFiYqoKMvqaqTPGv6zVcW4Uls
 Ldh1vpsRUfOjydQ2SUnP1rdHh3vI99t4/NdbMQ34D6ymtNMLh31xc7i90uh1nfBQLB6/
 kDnw==
X-Gm-Message-State: AOJu0YxYGOhlvuH02WFxSKOx0iQnhLd6U5JFdhXcRuAj5+Zik+9EdCyU
 e8vjJWU+xXZs6N/8tTa8/1ObjA9zT9n25/vzjp9xbR8OTYux3UnkH38=
X-Gm-Gg: Acq92OEwbtRZrI7DGP9GVwT606WF5vh8X1xTCfeAaVuHmzO2YRA9MTqmqkyYPiBVXC+
 sAB8DGn3H0kMI8cITTApI22Uyl0wao+eRS1GCnSB1S+EvL/2JEtfyIJMLvPJx3I9Z0eVj5vIoXD
 fS4k9/8yqYeazCIIrNVBIPc40wufp+ZSfzd9OQ5Ht2we9blr8w+C0yfqm3Mnd5U42/PPusgXhTb
 e3UqatWznIeNu/95yq8J/QuiggXQHzRVe/wReb/Z0NC7oeLG+fQCQ8ksgCL0FV8QpCYzURIy9k4
 X4vXaOeacRZqr/LF5YeHne3yQVAG6/ST2mBDj/6pX1uCpETTR6vnCkqbOaORX9uk07lCuBK4GVK
 KG7TjElusF9qPajNeCrQkAC4qR7A3cOEnOeVfcN0+ZZRen2VKvTgNmKze8ITDxtaD0G8MlinYGP
 8jAy7Eo06g1kiT3e7WS3BxTIjIfmRwuFr1Ml07xuWUjQ==
X-Received: by 2002:a05:6a20:5493:b0:3a2:e510:4231 with SMTP id
 adf61e73a8af0-3aa5aa8a037mr32910746637.45.1778600327464; 
 Tue, 12 May 2026 08:38:47 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c826768a27fsm12536579a12.12.2026.05.12.08.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:38:46 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Wed, 13 May 2026 00:38:21 +0900
Message-ID: <20260512153823.4507-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b7f80c.050a0220.cd9cc.6c67@mx.google.com>
References: <69b7f80c.050a0220.cd9cc.6c67@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] inotify: fix make check findings
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Gentle ping on this patch.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
