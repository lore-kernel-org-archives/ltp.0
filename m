Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC88C55182
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785760348; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WbRA6QwB7nOVpZCIjtpC14ewm9qluZ1vUsNBECN6BkE=;
 b=f4uU7VstmjMlQWVTt3NPO9TAlfJD0m5iU7XNzaNG4XX2/4G9K0NnELzL7kyBbcrHaVKld
 zv3C+oHodikKvLrdDyxcK1E7mqnd3Xtf/LV8ouWolBAAGSunMusUVvAHfzDF2I5zXmmb+q4
 t1dfylkvSSbYtlcy8A6P0cTZCUIEcR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 650F03E71A1
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 14:32:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C86B93E18B3
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:32:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C642100036D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:32:08 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so9798335e9.2
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785760328; x=1786365128; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ck0FZDe74gyli1Hv3NLkzAhw3n4dT993eskMyEwXPoA=;
 b=WSqXWMX+V6VAFQNmZ1zXyiVivsnXMvn6PGskEDi0jAPVnAatt8q3hxcQXVRzXxTyVw
 /Aa4QbajOO6qs7UUNcpZU5JNL5bA7r2srjG3nTflDKFFqXbSAmOUM+B+8tZ6QxIQpXdA
 A2Pjt8+lFgH1ccUDO2w8aijser7ovCNvrtLvNRjleUQi/FypjWsxpxH170GMVDmM11oi
 Nde7PdaAuC+n7wqBVBxnIyTzbXxX2ZHBWZFPHbb94QFOw/TX/1XYhEwdEWS2dD/hUesY
 JfeDKB6VO2pv6Q86b/bwztzT4SFDWvlgDU7f//FsZSsU3MC4nToa3msVOq8mTuHJO15g
 snfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760328; x=1786365128;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ck0FZDe74gyli1Hv3NLkzAhw3n4dT993eskMyEwXPoA=;
 b=Li3YspOcZAkmQ6VGbejJNK54iOxc93pxUsSwgL5XT5HZFwe+tU/wbmNg4r8giKA6OQ
 eDXqBc/zADratYDT+kwDbNBqk/PiL8oDBedduH/jObpuQtcvfGnNrG28nkcpm7Rp5Ukw
 /rfFYl6zBteq5yK4D9w5tbhRna2irabBbaKKi6Tf2EgtIc/3NapHAKTBClhLqTsZEkmb
 /XvKZDAOYX38skTYPVq+pwcVbBrdrssdUDEZlniM/rPVGHzVdPTTv3zMOA9DKKlGArqO
 n+JfSllU7YTlyz2HNHKsB6Tb1BtD61kuOYriUrqCGCj0l7Xhv/pZVy9PzDLqhp6IzbyP
 Orbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRYRyC9MR4hLagzq//9W7q3B2gddaZ7WfqUwIuVkKfeuK03+hrnd3sP0pCglAVXR8rPHQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yy+exNUh7avIaXGWTL+g+TTcJo7qFkCW4PILbchzJSz589mMp0h
 aVIoxi/nPZ5H4h2PHSaO7cssaKWQN7so1U1JMlBf4R365hbfU8D/DQTAiewZMadlhnGPwCEA4Kz
 yo98LwLIs9w==
X-Gm-Gg: AR+sD12ybUi+Pb46/zO5AyuyE1d/xmT3apjhbawZH1F1NXfqrHnSDgZrbdTFLQykbG0
 4cc7CS6cnCeAsBkUXRaaBP24fD1iKW2cBuM4Ii0vqvwPsDYbe9SABwcFERq1snOmfDP3X0YktHj
 oeyAZqhyhQAc0nEWmRScc7JysXFGPX7ke19QnS72iUC8gHu7Faz6Hb8novHCxZwAhzOdAf2fXf7
 0H0OJ1VVuMD4E7G/SsSQXHhgEVuVoSEK4mhRJ7jTiG98VHiMy4rwPYGYOkt+nuTIolZXZcJkXnE
 G/o5RJUhmcNSZnLGjAM/vs97VVZPLsViixgBWdIsZnNfYvbVXRNGpsMS/cRWV/yixLYzHMt6mgv
 fZgeWFBpXoIGrrK+OEGMZVrH22vqYEHaNIcBlfXfxQp+1Rn+8pKoUGjtInO66eiieJ31iqMecwG
 Jh02FPEmXMt/hZRMGmCbOxV4NQBPDb3Kpsbv+nH68ENblzxSJG2by4E0JmtzS7ZIMG3ax09uXCe
 THDsGfR4lo12vgyrWMU5/CW39wjGyqcy53ncQ==
X-Received: by 2002:a05:600c:8b13:b0:498:8e6:d464 with SMTP id
 5b1f17b1804b1-4980c65cd2fmr231334655e9.14.1785760327652; 
 Mon, 03 Aug 2026 05:32:07 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808191ef9sm253794555e9.1.2026.08.03.05.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:32:07 -0700 (PDT)
Message-ID: <6a708a47.47e43f48.11c1c7.fefe@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803122728.GA242002@pevik>
Date: Mon, 03 Aug 2026 12:32:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] network: Remove outdated DNS stress tests
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Burn them with fire!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
