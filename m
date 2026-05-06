Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF8CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778064960; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=//mTCYemlqqoW1uzlfB2w60e+RkOWZNxoKMcqiGGUKQ=;
 b=IK1iRsCQnWoSI7Et//VmsMPW+KTorw0yX3OTc7e7YD79/n+5wyb91uHKs2E4QEf3zYJdV
 iReRBeKHxbYn3vwuduPA/FTeg1Np16I6GWW9I4aGj1RsT5GkswWSCCHuCN8yv3yTTbAM9dd
 ituUqF6PKQKEhHMTUtlomyOfi7DzJlY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B9BC3E615B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:56:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F26143E2CC3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 12:55:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D10D10009EC
 for <ltp@lists.linux.it>; Wed,  6 May 2026 12:55:38 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso53318455e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778064938; x=1778669738; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2HrMMLMGtYZj7lUdP6BAxTo6WOmUw1f0pctX7fMYjkg=;
 b=WzITIZZ8eFyGwW4z6jhToHxIQEDvO+JXnia5Vmfc7Cfnk5J+nkYJrI4nkxEeT2oYpr
 zdUkcTtNBeubVPrgAt8TJX8gXnIkgId6ftP1a9UmpSCWkKtk4i1VXzkLfcAhDw2/9OT9
 0hSkLUqCtuFNE5Vql5SRC3xaGKGTtkSk7ck67D1pSikaQoT3g7MDLJGM59+3oMs0tfsi
 hC9vo/R2B0imZEcLBLAxEynjFgV8B13FMvdOFWghZdEL+JMjYex3kWnQrRerXqZ+OZnP
 2JI4/PPszEo4yewxXPEFCw4+AU5xknRdAHjgOPdT1EzA8QvKURtGNMMmX0DBvPLOgA4p
 FzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064938; x=1778669738;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HrMMLMGtYZj7lUdP6BAxTo6WOmUw1f0pctX7fMYjkg=;
 b=oR+pzC/OlVMUSEEwjS122ilvl1QLNMTaKwhrBPIKKFj1N2+jD4uBQUY9+/BthWOA1O
 rLyFupg6f2e1yztIkQudDIGcdGiJwVfgIz4dojcbwczpp2paNER3qA2+3jxms7TmjYnQ
 v+KcdL8MIFHBEnDVVx5NUQcbCyzhcRZurEQNhevh6IAD41wMEPv5u4/QCZb30wYPtv3i
 IzdkKtJek/ZgUHkTWT99FVkyX7TVVId/52McTMGJVpjAixstOOJTG+2fg2vKOG3LlCKW
 TGnbifIcWvddD69wiK98q6SgLqtdkZ3gigPo60zb4qQDD0TnD9IqKpP+1QAoQhhhER4Y
 aTgQ==
X-Gm-Message-State: AOJu0YyVv2ehTL07EMwTcRmb6BmaLaeJtLRyTx23dlihtb0LkD8lPnHk
 rLypMmDMBak/Xh5NI5D3ZmJp6u0XpovnCqR08EN+Of5cfGvSC1CXLlEtblEPs1qlnGc=
X-Gm-Gg: AeBDiesAvU5rQjeOfg1psvieQmuJbgwke5zy/YbKytonz1CKDygH45UsrgGQCXwRbUP
 YVIu9nkCsZkHkiDqVmfSQnIO9TQPleh5X7b+Qz6rXLT1QvnFsVBC61CJHtOhHXLMvUUONGZ2LTl
 2Xc92okC1n6Q2uv+HeOLwGchY6aGqSHJvkHKignEjKQPsSuCrCwePCM5FeS0PJQIxHVYOW4pxpk
 VPOwdQ0S6qwEPixwujWHr5K0iYI/vvr/7nVyZIvrhPu6J3amhotqjfmQ+nj2L2buxX8rd9JKUpZ
 pND3agIpddjAN6aDbpidj7BLEcc2iWyKBWb2zQUT+DtjVg6jsWNyc5a/amSKw5/muxOG49ihX4G
 BDxrszuxyfTd7nKvsqrpWCmmz3vEmFg/rTdSEGSKcFiYSlXphgVIpxqUCr/vY0va3QjBApjTj2f
 D/FPdve340nUqjw22CyOxkLKodFj5Cd1G5xu4KPc/F6UUTJPVC1Q/0YNxfKCfP4xsV1DO0gjle+
 0H2JrN+XwkROH45toURQ7hRCzSB4L+/TCcBdBp+0dEf4ofvNYZKr65hydvhZsEdyfObHn3PzTCz
 EbvjO8eWdQiVldVrohYyjkk=
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48e51e1804amr45586245e9.8.1778064937700; 
 Wed, 06 May 2026 03:55:37 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a517bsm41543025e9.4.2026.05.06.03.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 03:55:37 -0700 (PDT)
Message-ID: <69fb1e29.050a0220.2040d8.e2aa@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260505131538.21645-1-rbranco@suse.de>
Date: Wed, 06 May 2026 10:55:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Minor fixes
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

Hi Ricardo,

> +		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);

I think Cyril meant tst_res(TFAIL, ..) + return in the previous review.

@Cyril am I correct?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
