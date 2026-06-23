Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA7ECDB46F
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782221757; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ArwU+taNTBKHYc7yxcsIUW0IAffIHpl37HLJUz+AkpNLlwrmwaoszYgZNSo81KgR0w63p
 g73npeAo0gZLLvqHq7tCq6eHDvCu1wJe0QZU9Ap6+eAhNRGvHxbLyK+vvbq3AwHej6iros3
 a9Y61QwZGs5710K84aXoq/5dBZXBv0U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26CB63E657A
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 15:35:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE5CA3C311C
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 15:35:37 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAD866009EA
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 15:35:33 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46255b269c2so4286742f8f.3
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782221733; x=1782826533; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Gg2k2r+N9FBLFkxFLthiVdTc+V1yqG01exZlfvxQkiGM98Q9ZvN8j8vL9+g4Us1V2Y
 mRIBl+eqVxx5P/Uie2G6Cfc2zeJmLxCvDHllESWodZ/9K8Kekib6+KEAdbAVQDHPHDUg
 OuN0BpM730i3BEoutou87WnKG4B8eFddBqz5GwsiLfUHRN/ciiE7KkgvZtSxYF26EQ8Q
 YCVX7qDXGwATWpLxB43sGluliCJQCoTQo6hPbJwcUSi9XJWSEMd+DcUSy3XhsIdf9cnG
 zNWGHOpOK+Q4hh5a8P1/USDfKYe3WIV6Fi4pU2A+GnwJEHGYaqoQyqRnkDPPmPqGxrXN
 tvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782221733; x=1782826533;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TicTka1j8FpF5JsmugaT6m+134uMDzQCnf6EjgU+sn18ZsMc/UZ450tY5vykdNibf6
 wfK1vg423VOkmOyD9MHWq3gh9ObVaAav8WKfvWTWvj7GbLTXHPAm0wh3zKn2eeWasIB1
 hX+Tg5QvdW+G0GO32lqnsKLVwbXZMWkUqkIcyck3Uuk8yX0uz078kdKjoWGhKkvGa6xw
 zSBDYv3KwYuuEaPC0fse4k9YlVUR8de8lh6LaJWrofCyG5qowwqIyX+Y8rJj46MwJYBP
 jBuYKlbBIORYn4Vp1cEo/apGTvkPOuc+lRqKwXGEl9oaE7EJgyf3ZHNBN5jyJ+8ybSS5
 Ysnw==
X-Gm-Message-State: AOJu0Yz3mxcW18BgvaEMwmBuG3oFAioEP4ADCopUi7h4PFYNv2cLnS6g
 p+DdicRR6Y8gufnFE0JM0KK0VjE9nUIZRj9slsU31UycRSzM8u5Y30btaZTw85njXwxUk3zvxV+
 wslowPEo=
X-Gm-Gg: AfdE7clbSMeDNJEty7LJs21Krnt4Bf/aZNh4qarpz0PcmX9/3FS1OFBxh120SDkN4jX
 RUILCu0tFhExDibLRFnlN5mxp507o1SlT7uhv7n/+EdPMquOSlX2wqTmadjS30bNTkIWcZYTh8c
 wchC6nUW6gxfaZydCc4q8i2PzzXY7nTGiOKN6AV0UOXtSFZiiGDVOhnSjf5ExH1pMD7iAMi1/WZ
 u+I4V4F2zOfSD1qMzxz1w/qGfctQKChCFNu1tHWyVGaDozbLZhmvTQ0f4AhBQXGmNYthxCjgTuG
 1YpN64RO26cVrf/h/DdLc0hEXo3rt9KhsbgxkwJH1tr99eZ3V9EdXYyy8/a6Pi8473jbzX9UGPH
 n88yFDn5NVGqiZXuX53tNttHY4nKPX6D1Qp1B7ScTqZWsnjbRYwSzcIt3+ckYVkW0vjDxEFKpqW
 JKLIvmTQ6Of2YARTb7pwd9TeMaHKRDHwAguzExXXkbvGqPVT1hEPDN8fkIrdWvOZjnlEMNeV8Pj
 7qpim+/R8RvIuIwUY+Y6SNWzqHv9FN0zFM=
X-Received: by 2002:a05:600c:8b84:b0:492:5cb2:aa54 with SMTP id
 5b1f17b1804b1-4925cb2aaedmr31248795e9.34.1782221732899; 
 Tue, 23 Jun 2026 06:35:32 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm395373765e9.15.2026.06.23.06.35.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:35:32 -0700 (PDT)
Message-ID: <6a3a8ba4.6161eb1e.19ac6c.3b06@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260621150951.66407-3-mmenashe@redhat.com>
Date: Tue, 23 Jun 2026 13:35:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] futex_cmp_requeue03: Add EFAULT error
 coverage test
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
