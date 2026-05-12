Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3898CD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778573948; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=f64fJsWe0G05eio9j4JnhqKZcGRIvmYJ15pRlonhkx1pCviwiCldB2iESCdNOAFDu0upT
 3L65CDw1tqdT6kNUY3vo9uckxRkEXYkURY1kqgtTg/X1bysvaCFpjlwtzfc8xUWQSaiYkpq
 PtUtGWinhUtTGVODgtxjfDvghwJzQqM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A53C3CFE6A
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 10:19:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6933D0381
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:18:35 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C44E46007A5
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:18:33 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so55169315e9.0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778573912; x=1779178712; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=EolpVT5as+E/Cq6CPQTiO2rZatmrIQRlvfglxE2Nwvfvi13qJ/eAuc9V0VcwsS2MXA
 vnJF0JilL/uWCrvGbE7SHCjWS8tbRRKgzVp2aCeX/1Ws/VF07Am891rMB7cnYj3zQJwE
 bN2cLYn6KvaqM2hsjlg35Si+G47UTMnuXoo7FW83R+kp037Z8ZAa2GMv6CQJREtEoxaF
 PnC5jCJL7NjxjEVR9ZSyq2qJPmx5uApXelVsrPIXt2jEnxCV3dTI2O9CVpdJ4PLPYFxI
 tEuaYdHdMFNBAqHNIUsrJykXQJtbeUM58pg2Mbqj0Ezmnkt47VRy5reEyh98rnSoI6xg
 1oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778573912; x=1779178712;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WFEHbxITbFyfhzUIHvbP3gF8BiyPIDcwlJgR2gcQ8+tV4iDMimUDCJ0nj6KTFDMjlH
 j/EmeBa2LRPkoy4GaGp1KCQRA4KhKCGspbdM+2I7CD08nbSBUDnI9xO2IE/v4s4rm/zQ
 QhDY7TGVAxfrQ2cpcvuOw2csIKqWxmzMdyJEb8TBCZXJ7HOc4dxObiE2TUwiND18W2ME
 dJt0Zn3Tx+ojDXPuVRIjeQ+qcpvjgI0bg9trgXR/UQQzlq3v32ChibuJ8x0dhjRfXQnP
 uHJFuxfW6fmS6XFu/sCs7FGU9u9lWuZlVFuetSIDsX7iRdwHE/j6kNSOg5uSxjhQFbDl
 sAFw==
X-Gm-Message-State: AOJu0Yyymw94Kn475lcDWR9cDA7OqULgI+W8Ev6ledTH/EJ6GtjLY2XD
 2nyfiGgAOcJZCuBnFlWLsaqwwvR8Fz/UzZjXexL+7iUZJaTGQnHafBxbrMfeJb7fl10R08n9TIX
 L6BghOMA=
X-Gm-Gg: Acq92OFbDhaPUohlHiaIdGsyFjdYAXTdMJHydvugb0d/WdgWYQ7BGgAbXFgJhFKConK
 R6i+a/gDnfLxOMWvD7/pr0M0AhhiSSYLST10POD9Dz5NrSBXj+I5QlU7Th3VD0OCIUWFYJfiNqO
 7TIftwqXIk0NSl7/BlxESGQRhIE34rPDvRLT7iyCOqR8wyety2nqouzcNbYnW3x5T9gz6fxHhst
 B6R/HiZyTlIBHZCT69epnZvAT9zkSDCxb2V8e2mT2mh4q8Gl4zCImZc79ss3BiIvBlUW6c/8MwE
 02GPJ9WQbsb2PZzAeqxIAqfl1Q1mHSyV+BQlsH7nry0FEG1dR9F+uwsGRQ2ZzQW6J2ksYz5680r
 9Sj0vAyvLjfKskgdu6cY9LCLnYvrMx67oIiXVKaMsoxHK7GpEpAf/eBtdGFZnCBiRN03HBZiL7C
 EOSZ4aSZymk/MbVvR4cDNHztbJW5V/L4fR1Qvw3Jkkl1JIRQJn33kRsqGsBi8cuGvIOBSXe/mY1
 YhhBSVLsGgtb2gg+l9VLDOcLTszoj9gPsA=
X-Received: by 2002:a05:600c:4f8e:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48e8fe7d245mr30163655e9.24.1778573912472; 
 Tue, 12 May 2026 01:18:32 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e5f00e8sm14100135e9.2.2026.05.12.01.18.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:18:32 -0700 (PDT)
Message-ID: <6a02e258.543a7455.12a722.3d6f@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260509082649.8533-1-wegao@suse.com>
Date: Tue, 12 May 2026 08:18:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] OpenPOSIX: Allow 0 return value when detaching
 or joining joined thread
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
