Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61BF357D5
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772005160; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tS+m2gHypPAXhNwfKG9OjtzdRwEpOw7ZyD5SX+F8PRY=;
 b=opQWPR+EdSX73dG7doDDNk2tzZMBkaxm+MUOxbpD9xIs9iCJdj5raVKijndihFhYftlCT
 aozwkZP7w9wLpWrqhrortCZ81c7UJ2yVz9jKtM5z06VGN+iuABrfWYeYLdjYOdXtfutwr7x
 wHElIMbpuco1OQOlxTgI9GEfPYgyWnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EF543C5489
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 08:39:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF8703C79B9
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 08:38:42 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99275601AE4
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 08:38:42 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43991cc3155so130271f8f.0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772005122; x=1772609922; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFPn0X9TWrQL2YYl2LrJ1BVpRMonbh/em2rrgnTgB7M=;
 b=Cvws/nsAMULhNiOGIdkaiwZFHTENYund9ftBhxIPUhfE6MPbNK2uszBicwzEArvgtr
 kRDBJNOQw7IyaOYT9WPQ+fYKBR5PNQlT4nQKTBlJDlaMuBoCOi/7PDplY0RvNOQQhMlC
 TFz1ZL7+2/k3mbg+WB5prN4oJTDp53FQxKND/Z/+RPdGShDHcaqtvHjJXB6k+Euwqrrk
 2Hlj4vAQ8ENWDDC75T7sXZX0Au/yT9u8LyNXcVWH/Mj1iWPntET9hTs3RlgyNKPjj1Lt
 MPODzxToPHqTvkUMR33WYYf1rVQUdJHB/uZ9U4tjkrV+gq2dbomlu/qaaCdYcanPMTed
 qQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772005122; x=1772609922;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFPn0X9TWrQL2YYl2LrJ1BVpRMonbh/em2rrgnTgB7M=;
 b=XqXAV3tfefBYHs0i+cGKv8dxELEcsyRoJhmMTd4bVI9KSvuQJM9DntM3typwjbJYLB
 iTjarfwb059McgdMYDkciqbye8ZZmUfPRxiq/foWsuNS6CeNRXwploWYKvpTFuAnREK4
 mipYPIZB4QHjLKH65lD7C55AnvKxgT5mT4gFeaIi7P6OyeigfmX/yqt47i/rzi1IK8Ep
 V5JWRV3veSXSJuOw0s0kqmTmzgPm36NomchHPHT8Jp5BJDkYEPNvhQhB1Z+HNQB4YgOX
 DQ3i6EwK8ZiDgFgESIp/dfJOmaZMsT7h+/e6KwCdAdYHJc0dOMnedDnx4PErFg96potr
 Q9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsf8CoKLjhinbASqvsMTa8r7GjcmLtcXpG3JF0s1neHDdeFlt9+/VOxlgeSY2xxDCFnBw=@lists.linux.it
X-Gm-Message-State: AOJu0YztAKvOgFDuNoEFVQQzjauRSznmHFmm33qKNGEJqaeoryYxw1DK
 Q9ziFOWafAHdY1cKW16b8Bht7fp6uhgvdnzTuOeR6Gha8IHQPc0ykTlgmTuCLToAxHc=
X-Gm-Gg: ATEYQzwEHq5PDaZBodpKd3FxNT+gvktikRTXI9pYlhtzhFuUoS6qXnDwubNb0Y8q9Df
 l+GGfZEkMcQ3V8Z356n4/TLKjA26BzHZuMKo0roZmZp+ANzWIpMWVGVr+udstPlwG2ESORYZbyN
 ucVWU3I8UAOHewc2eVtTcl0QcO+F/ocgvy8DTNmx00ZxHGUIx/M08fBjtGf33oAsg68xuph0kDC
 DTpw7CA774FJj2dzhscklXdMum7KquGsfc2KYAIYtlZt1vPxxrGkYIjzWxn/46iGVDf0/+vuz28
 qWsZs6Lf/v/dDDZYgFqCelVagCv97lh0+8iGZwdjJYki5x29PXrqr8kSQwcRC5d8bwc5U0Djt42
 ANmgRNbCGG2pKzQm6+Kyknkic2jWWnLyOj0Mse6d2s5xXloiuYnyvxXJbhBf5sZl1F2w4aXiwFL
 ru9HwYx7xfR7nLv82XzK+KBkwOaZsZzBUKBdgM0ZWZeU/ejK3vuHEPYO7wZGPie71jL4uPyimaa
 YDvspVi3/naC11wCUzqQF9oLU1VDg==
X-Received: by 2002:a05:600c:1f8f:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-483a962e459mr283710255e9.16.1772005121980; 
 Tue, 24 Feb 2026 23:38:41 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6854c7sm134581855e9.0.2026.02.24.23.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 23:38:41 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 08:38:41 +0100
Message-Id: <DGNVE2LMNZ8X.1L1FUKFLCPKV4@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
References: <20251125044057.20922-1-wegao@suse.com>
 <20260225015044.19233-1-wegao@suse.com>
In-Reply-To: <20260225015044.19233-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
