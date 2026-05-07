Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988CCCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778157446; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=UNWiqtfCCQXX8lE5pdx6QSNEkvdqnxQh4mCdI8gj2n6I7UEOKuPlxm+7oAQRsL6wnqWuG
 cx+r84DAKvK9SbU8fuoKgFeBGCSpX/7N/8pvOXEK+kl0ytaAm3WWrmmTXW4ZlyeYgTBef8f
 2R3Llvtx8OUENZ+dj726JhuJoinzXrE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 471223E24EB
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:37:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB143E6149
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:36:42 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 10C7F1A00493
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:36:42 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so9971605e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778157401; x=1778762201; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=dr2i55ivQ5AJaQT58OP1412iP2RRJS+36Vstqbj6NjNLnlSzbFJX/q2Uzx6D2iZ0wz
 N8pqlaj/Qm1IOX3YhNPfEKFmNAem4pUb0UqDAKRCsqc4raQu/1BpvnpK2vywk6Dwexgm
 4ZHUy+BNUXO+vmrdy4fm6ICKSYlm76x/NgCQhb9Jf1JZ0wBTcfrso/8rJ4aVBlgt2Ifj
 5VLKYuG2t4I1AecPZkptK99ZjtWHjAYxYVFOBUdTAt4d1GekcstX6seB3inp/th5Tydl
 775elvOESfWRiYCWsYwjntFVfK3GfUOuzxgnGmBjSrd/qLQXBOqep5lm+7W8kvB0jxSC
 Z2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778157401; x=1778762201;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=S+xJymQQaKvj/8O6PjsFttuHhT5NQZlAXaRhfkztjTdNuVZ7G6jbgkqfRm0WYq4QIf
 Qfm+YZgnmrEn81IhflzvYmzAcYMLt52TunvSj6fuKVw+CAsKAz505OR7oE9h13ZHycb2
 lPI+fsyvpzBcnzlrvtMjrFHEheT+vSqkzs/p7FV5NT0nXajLD22eIe+jaKu+mQZ0lQol
 kFuDcBQ9FabpFUX8jsocZizdTxz5zy9GG7kWZXAFeko6ycxDIeUeOK9HoQAgkcOYgs80
 rcsG9gAN+Lvi0LotFz8HCFX8F4smK7H0VChPIdp1Vxk88PamoiOd+uUfxWtAe9mO0Vz6
 fXfA==
X-Gm-Message-State: AOJu0YxeenSpgQ+653sfwjIcDEkRy/6rZJrQEnSoa/ocusHtBag5pnDz
 Tb1p4P2I+2/oZYl2JrafOb1O382Y5vDBjBS8Hvu5ZCPTbepKhqFXvivzt7F2qkyKAwQ=
X-Gm-Gg: AeBDieuGdT8jtfEyhxNf58kPtcS4GzWSvnqwWBfag4nTMrQJ7ecnll00Td7XRAk83Tu
 BBrgj+Ye0KNxVdndOnMLV5m8zmlrYqAVMH4HIWJYkftxYozNq2zt2Bu24cmIpkztl/p/mvxxhSN
 THqsAzxPgfG+/SpdLeGZAIlu2LdR+aQXdTeacdCP9UgZ4MCLBfjXEMvFJq0q1Utv1uJJ5+Bl07k
 +JO4lOQKmen5Y7yRsjDIU/erQvTeCKz5T8mxFQVNNt+LQE/NmW78qCm4u6sv2P13Q250c7rHvVd
 D0Z6TNSD9t9t4spGf18QBsd0bzNrwB33tnV1C+Kvg2tXOjEE45K2ydYl/vupXgEb0aW9QmnMbYU
 Sdceyovr6u5OV+sEewcu4A3nDxvm3wsYja2SBxZ2KoZZUKzZPWEPrnog7S4bjZkMc09nIc2oiFi
 MLo3c/7VVpzaDLzmaZubc8DchjTGkngSuXH4aWHwNLp6LDNK7jc6w=
X-Received: by 2002:a05:600c:1c26:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-48e51f5c282mr131516925e9.29.1778157401200; 
 Thu, 07 May 2026 05:36:41 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e539109b7sm112845105e9.15.2026.05.07.05.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:36:40 -0700 (PDT)
Message-ID: <69fc8758.050a0220.15cd0b.891c@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260507122858.19670-2-rbranco@suse.de>
Date: Thu, 07 May 2026 12:36:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] userfaultfd: Use two-step handshake to
 probe features
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
