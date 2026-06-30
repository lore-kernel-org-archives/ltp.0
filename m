Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D673C43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782806406; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MzqSRXm9vFkjJu5jLcBs3GsW9iUrSogNQb394Tp1i4Q=;
 b=fsrGmYsdsrH0Z7ukyApZ1pofgDZBm1Y/srRtrz97FiFXvU79aE4043bjIwrx7uCoBhbHK
 up0Nx7wYMo2ohDumBj1Qad9amYs6Bvc+QvfzDD8euMfHHvSXSKhpejLfv9d39yEZC/98Sbs
 +lDu+F80uEwGxAP7ztOVkycGeTqO8Js=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF0903E2F4D
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:00:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C83203C1ADA
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:59:45 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7266E6002FB
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:59:45 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so35106625e9.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782806385; x=1783411185; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/LLcUkBZ3i6sAKKWH0GHuUKALXUuIIADhiNdMNUk+Rk=;
 b=fuI0NJWS2B7zmidqBZlqn9ES7rgV2TiYENWjEqX1s/fIm93hio6GTV22ZNrczB2jL+
 wFq3HiRrzug0SN18QCwLjI7o2OQ+AA/kNJny4FGgA5qBf7j1lt1Ep5kC1qm/43M+KTBK
 MF8u6k422HDNqQV5mBEIrPraDFzphbdg/TjvJyt4LWM1TxQ3BeihM8Nj61srf8ePskH6
 n+OrTUZA1LUJBZLz6CZTUhn+4gfbaB6NNDx2twYfXkKGJPi0Y5kfOp3G90Fi3tjLd5qg
 ACQ5qPOjsWYzcdSFiZFW3+Tpq2DEGBSOEZegxqNGtgpn/mO986G6N8fve3G/rDMby471
 Fpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806385; x=1783411185;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LLcUkBZ3i6sAKKWH0GHuUKALXUuIIADhiNdMNUk+Rk=;
 b=DpKovC6z6N4fwdMRaBDghFdh8DUXpWBbz5BIgGjcoUkA0jAWXpcMDWsDHOQvzSHbuY
 QOHHwS/+D7C4v1VhIvIN223syhRi6hABJjbm34qUk96KCPJJ9cvGXVfw14mrHVWFlRxX
 aPx4f+v/on2BeJS4u5htAlQua0TAxvMDYOKVwxkpJOWTo/HIs3HiXjyCCWJ+UxYMZlE5
 SIx9ZlS7kDs8Rb4OAYkVtYIDnlo86wxvZJHORIXdqmd1LU6YYaYY7xro9Ky7iS//cTqk
 VpGD4BzX08joXtPipFBk0A0KpUyYtS8fjkQfpO2MVBbcEZ7O6AsfgqPvdc1ulYqDrv7R
 nUDw==
X-Gm-Message-State: AOJu0Yzt1VwcOYSVxA51PlOEFM5++8oT1oCTumwy20W+COkmvDltBNOy
 t54dfhU7QBhB+rt3f4fjO1Z7TjxhEsgfwc2Kvdyu5jLlRlDQge8c2fUoEKTfJ5dpcj4=
X-Gm-Gg: AfdE7cn+ao0m8rk9o/FrOQbCtUQ6kt4/R6pA0yWeb2KJLbU0CVTzxtNEhhCo8jq8PK+
 6/AQ+HvatJ57QYz18btGT2tq+oNIs3QYqY1gDnXyU/hfsUhAcc4Ja+BIxKTk/mZkIEI/0DfheoK
 aVpAV5aA21gm+frJH16YVgjbWbGXijqx2mYDW3h43mrCSKEPnNE4TXhikpROaPeY0yAHz7N0INE
 FJTp93sDwCQaQmsgEtqRByvCEh5FIvPjz878iImcNfRl/KjoMoIqezB/QQX8TB3TgyBIyMOFV5z
 QfuyJtTbuY0weiHEADZikiD3u7fiCAmgDYlGVIgprY0R7OLzRlu4/z+HiabhyTUMoyOxa16mIgY
 68O6zE9QpBIj+x72XnVx6ovV7jyJ/mYu25CMA6gw7hn2HafUwgSJWJxtPEv2H36DMzCyzX2ozbq
 Ghd/VQTeONYQ3bv5B+8ID1fpcePvQiwD4Jq/bXigxt8qhGFTFkuIUZwYfH34dIm0a+zN4gb8e9S
 ug1HCma0V40Z2TbzrEzpyofPlj+emVfUArrRqCcBEPHECY2tIYzR5rjTvxOPGKauko=
X-Received: by 2002:a05:600c:8b03:b0:492:6f96:b60c with SMTP id
 5b1f17b1804b1-493b82aee04mr35174465e9.21.1782806384783; 
 Tue, 30 Jun 2026 00:59:44 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bc7aca88sm37910605e9.0.2026.06.30.00.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 00:59:44 -0700 (PDT)
Message-ID: <6a437770.903497ae.11b5e1.e8c6@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260412141039.1075095-1-samir@linux.ibm.com>
Date: Tue, 30 Jun 2026 07:59:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/hugetlb: use SAFE_SHMGET() in hugeshmget
 setup function.
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
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

please send a new version with the requests, then I will merge.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
