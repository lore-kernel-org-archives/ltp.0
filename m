Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1CFCD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780920497; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lBZMhwVBC/+7Ct1a5R34xoaRa7Gu/DmP0H47EFXfu3E=;
 b=euwnYcolCieRMQuE0DIuMtn0CPGsDHJRPAMoSPdnzCOzKLjuVLgxV5JUrkTGqVqB6TwDU
 ABrA4VET2PkFDBIbDFF37ggu75gTF7LgTLAjjjJLxRKryZlKBJT+nUiPnYxlBcfTsigmgUv
 nqdZGHpuOnX4nDHUNWmCpBVHkOyumXw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11433E4E74
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:08:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2C43E2FC1
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 14:07:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1428600F3B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 14:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780920475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79SYEKIRWU9gkQ5moO0i5qPKkFqx6LosnCLWjjB5Mhc=;
 b=XQ0s420oycIpZ/ZeM0rWfRxedJJPjCirNZpuRlbxjv972HMrnj7Pi7UJyIXo0EYAKl9Z4a
 8ofWHyrQaD0Y9gq7LTcGWcxbJttRmEMTeMba8oke/mPBUygTOpazOdxA4TMctqRr4vynHf
 F65C6vvPW2fK391GVZAZiKjkk0VnV/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-oGDpQ6EyOxGDfGplQitJqA-1; Mon, 08 Jun 2026 08:07:53 -0400
X-MC-Unique: oGDpQ6EyOxGDfGplQitJqA-1
X-Mimecast-MFC-AGG-ID: oGDpQ6EyOxGDfGplQitJqA_1780920472
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45eec2badc4so2080740f8f.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780920472; x=1781525272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79SYEKIRWU9gkQ5moO0i5qPKkFqx6LosnCLWjjB5Mhc=;
 b=CHnvJL5SREbjI+oINGSYHYhHv/gVKSJRSVfn/OHvUcWXB0NpqiuLWbyJ67usKsd8Ql
 gpE+vHhnpZw80Hon99hWxsCEEZ8pdMPCLNM6l958Ye5Qp6UZWMuwBLm2dd8FvX5Dlkk1
 446TN5ciMIkKvRNYQa66tYyUyycQcsqJXaV/g+9zEsD+uLzbfpapv+7JKZsemd+6/SAA
 X5/rKGkLqd/pJ5ld3IYI3N9mSiK1G7LkNIHVo+CkfAV0vdk9tRyWUtA05cWxEK8CBuHN
 u71VJiOQ5fhMsezIT0D8lH/cPPjVhGe+7toouPdi31ryUErqwprjXq8hXzVNl5e8x+FI
 9YmQ==
X-Gm-Message-State: AOJu0YxslcfwJjagWDuYGhAllEyrAOmN+DpYuikoL4CYIn1flNY0FCP4
 sd+tMIjN/VepEkv0XDVfU2I/b7zpBA9LAEqGL9zNfzURNp23sqkTgzVg5mD7xSFUDdt8W7+EIck
 UdEeC+tLj8ZEC5pu/7q8F3E3Yn0HNWzSuZLbvBBWx+KsD/nl+18FJmJbZ4e1kdztbhS8tNyuhyW
 8KDguzCOJwvtyWAlTt3aaSEY5dL0EHR/k+pvb1
X-Gm-Gg: Acq92OEEbQxfJurNzGsiMe/V7ZEwK/RLE0/KiH51cjxmYt1qhZZ2tZNKfPfvOhOQq57
 HSk4RNiqFRyq4e+UkmKGUlStpN438vDsCOSy+9hbT2aRqNB55hWuvHfDm0ItYJPiMM54ZgcnJCG
 4EBfBe/yf5BvKoTbX6xGok/ei7SMf8BF0Zo3+e8Vjkoj+TG65gIj8ZEK5XftpJS6/5XFaz3TVCy
 OB/nrj9KrBB4Fzcc+rq0QSL5kE8xxY3gcI89qd5WImGsUgIkS0CPWMaKC41jRtiuXHfeCNAarp8
 D+IXFmXS5p6VPr3pI6xVF5yOUnNubWVhBwjfA4a+7fsnY4gLbXm6NgeQEFQ0+UdY5bRyORw0n+m
 eHLyhSqkDqkARlBgcixNrAuhj1LR1iFt3kztKc4OIM3sU+2+S+e/lV8QQhgcef3TGIsiPuwm8E1
 /Rag==
X-Received: by 2002:a5d:5e08:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-4603062afc1mr25899994f8f.33.1780920472304; 
 Mon, 08 Jun 2026 05:07:52 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-4603062afc1mr25899940f8f.33.1780920471858; 
 Mon, 08 Jun 2026 05:07:51 -0700 (PDT)
Received: from fedora.redhat.com (46-116-121-128.bb.netvision.net.il.
 [46.116.121.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm53343399f8f.11.2026.06.08.05.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:07:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 15:07:49 +0300
Message-ID: <20260608120749.15043-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKf3vK-BKnJRharYcV35E7jDaeSzXNg1gDezCPil1QU_1780920472
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Just following up on this patch series which has been in review
since April 12th. We are now on v14 and all previous review comments
have been fully addressed. The LTP AI Reviewer has approved all four
patches with no issues found.

I understand maintainers are busy, but would really appreciate
someone taking a look at this when time permits.

GitHub PR: https://github.com/linux-test-project/ltp/pull/1301

Thanks,
Michael Menasherov


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
