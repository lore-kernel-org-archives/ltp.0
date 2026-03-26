Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32042106F315
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774520167; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=UGHu3f1aBW92GPMStamUrbflvOy4o5k+LSjM9f3kHjbfvOEg6ZR8gKM9XctpM/dy2L75B
 DmaGL2XV+d6G0M5zwZHnff6gB3Lx46l7sXewYBNphySbeWtY1hdZVnW1B9a4RVuv6ZGEMjk
 NU2QpBlNVBZJrnnosSCj+vMts3BwdbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D43E03E2FD7
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:16:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 014363E2AB3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:15:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9DA4C600BA2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:15:43 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so9421935e9.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774520143; x=1775124943; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=OfpGpGlEIYvhbELHHX8lUT5nVGV63GABzCe86SLONfLiJjJqpxraBsAikO6cBjwY91
 LuYsKIpShOlfyTf+fC2PnpzR3KNu8A2lwhsTuBnsQ9YUEIgZvCFpOndX7Ju5EJ6cI2is
 daMoIDDHIW+BNTYxKCAQDwPvqQYd0Knbyf/9U1F0pEK7JwKm2oEes3xxLa78KbhBgy+u
 SZXSCHLzQQIGEalY1/7S98IYEd/XYMzcqoa75Gq26YaFclwAvId75o44TTv57rs2ZHHn
 HNLgGkbrz4NSmFpaalddobgzfvNXYlwMdEHYlJlgWHoLcsIsRV93oX2VpcZ1WveRtKM3
 UBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774520143; x=1775124943;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZKq/9ah1Yd763oSSnscIw5PAFywerNNbDTfYvkBYB+LvaRxsloLqejrUoh6oPmxHtH
 grhk/MiQ8rVeF72qZ27GCP5ju/2rQHcOcRnejpoJkMLoCrtwb7C5PotM4VbE5p2dXpng
 898EOsiEs0mnNGCdC4Ro1MgeeJ2W7klMXsgxuEOTXjzvhxDZMsTrYN+JGiagvCgFtInF
 Y+W/MXzPDD60rqvrKkNQbn/I79phtbOUdu8842hrstJjUr7ZUqbZo4EtySHRmeTcHFU6
 0shVzW1+/XNx/xpn9tlQU9uLkrvbz+nyS9zEL/6OnpmWu635ENUPt91mtzrxX9lMryxK
 SF+g==
X-Gm-Message-State: AOJu0Yz0JVyT9xl1mb0HE4i+8g0a5Rtx5wIlZeaSDaI7TaV0JBm8wjrL
 VgXhiynxckrN7jRzgaB9EanX5degXhS9vn4wJ6P39vGfcvz75ybrleGnjc2nnYBx1i5Cmr17InV
 lReUtkCST9Q==
X-Gm-Gg: ATEYQzxL2ETqXFGHvoIJ/wiTK8MMfBhtMYS413YaqAeuSzqzRiXCH7PByfYuK1Jn0yU
 pCxyaNgI3lkyiA2gekqbsCg2dLIpbCjXQcUyVb9SKd2lKxCQBKh52+wAeybem+rwAvhjue+bAVO
 C6WThDyqIHBszB9UneaOBkoo711FdMeL6y00Xe1pe13BIaHD1GYiJUIhplyAm4+VcqfUOzxQcwc
 ZuxpyKyb2XqxpvlNYLugXWSoZt1Bgmbfqe/cIl07aQH2/UwJ0znfJM/w9V3rRwvkrJ2dCJ1Ij4/
 b24IACMGB9ywP71FRcbdipGRb3teZDFV0rMlGqydt0q7T3H0zcqHpCW5lbNRYfaxr6v1pMYaINR
 KolIZ5ZcvJJzbhSkgAEV2JWvo9WnK3rYX1pYThwazwr3PmAQzNJlsWduHYrUtbooqXUor5ZpByw
 ALFjDEqsUQlR0cMXuMyzCkAe1Ewy0/ylYkBM8KSt9poxVEctwLluNrnovDEQ3xUkqZpCYbmbeyp
 m0bjpwAiAHtMLu8Tr8EayBGjuCJEpzJ6gU=
X-Received: by 2002:a05:600c:4685:b0:486:5f71:5829 with SMTP id
 5b1f17b1804b1-48715fc3870mr107562015e9.5.1774520142942; 
 Thu, 26 Mar 2026 03:15:42 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c789ecsm20539575e9.4.2026.03.26.03.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:15:42 -0700 (PDT)
Message-ID: <69c5074e.050a0220.5cad5.435f@mx.google.com>
To: "Gao Xiang" <gaoxiang@kylinos.cn>
In-Reply-To: <20260323074954.3393-1-gaoxiang@kylinos.cn>
Date: Thu, 26 Mar 2026 10:15:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem/tunable:min_free_kbytes: fix disabled
 check_monitor flag
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
