Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B8C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786431896; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=M59VxKTASypmre7V8cXyEkE55ghLMJOPWkLe6QQ+kuab9isUpU9Eam0YyET0Zjjmoly5+
 tzS/GHOIfaO6IXyjMrps5Jx6MPngnvlQrDp/Hb/LstREKgMa7IWVmgDmITmuvCfyHmF9UoY
 N+kc63UFKggWFidZ0Ha17OmJTRrCZP4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD90B3D0649
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:04:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22AF13CBE80
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:04:34 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7728F2000E5
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:04:34 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso30768225e9.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786431874; x=1787036674; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=HOUje+xEbTzBfv5v76dzcdtB8NDFNVxtt2/ABfKMMBG1V8JZ7r93j+Qevnlu0+J5y4
 r6EHOaSHP+MnwHvQt2YaPUSoZAOJaGfunjF+el0m3K9ezWliyfxbImzBopiUVvu3HxV5
 h1klz7vN9s9DAgYmdYvwC0/0SWZ7ePPPv3FizOv7jJy/T18NNiPj4PzW0B716JBzSGsj
 zsdED9ZMLFlENKmgWs4qDZ1Zrrny4QQou0jGrMUdKoL7tEyE/Wh65rjsl8BB2qAI8olF
 6Uahp1PNGF0X0YHXOpG8RdQKLRZtxRD7kIrfu6URf+XklPCw472gxKAKZ1jWNg9rLniM
 Fkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431874; x=1787036674;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=a/JaGr5sbkmN+iGtWdqEEO1z3i1KJM6BwDjxzg5ZLRZB0r2Nd3qR96brh0Bz8Bgyw3
 jJZLdkJIxPuOLmapSX316ihan++OHvVam5zjB7T3k8U/0GUmOiPxQVQi+imrXZYa1m4d
 TxYNmyhkKALq4xcWNFGLidvzEufiTgquExsJ2zJSv0lxs5dev1JNIZyANmg/Uw6Uzpf8
 1e4MlupOmdzkNdteym8i9b7Ahb5iVvyztD54nyEHhMPZ9Z9rNHhwi1ZluKZhUzTxHUo3
 njM2sOBCQt0495SJ9Eg4/yYrJSrHCnMQDGn0mdDysYG+mkxnxq6vkB1dBmfKSbkwFCU6
 HFAg==
X-Gm-Message-State: AOJu0YzAk/BZbLzRGECcX2gRAPfVqMKMkRvQ0C0eojQqhjd6alR5xCwk
 mAFqLx8QJYZHLo5872stXsxBFPOsmv6aluOvN8xYw8dypCvQBr8a7JYMH8eK+1zhIl4=
X-Gm-Gg: AR+sD13Dn8L5IOPRmAY8D+LNhfxxfsgvOkcuV5V1CQ5CNGohTfR6qaP8LoCNLqptr/L
 TUzlGYBiVBSfeShPTt7Zc82S4NsE4Kbj/GnPjBazYe1Mn3obvyuzY/Inkir1bsQWRAbBg300sb9
 H6Zz+RVuon+xaaNBSvxy2h6lpKzTNO9o/K8SKixU3A44CYCNAavvq50XNqSnvY45vReJPVDoIiA
 Vk5zSYAkQCh8hSDXOiXnfgOd/Gk0rfkGqnGHf/+nc7WirhzwWO5XTGniD/HIDpESuXuzG4aq02X
 Ltpyxp7jZRoPq+6bjQs1q4NTaRZA33pKRmGBFfFfsUuGH8sohDiYNCU9PUX3h8th+/j0UmN5cA0
 eijCLJ4PA8vxIV3NdPGZw3T5v2aJOhW21k4CtlKoTLTcKylYV0J0YxnQGi5JrXTm7eojLGrZLru
 oBIpA83Tmap0GSqULzWvvDOPJA51izF75BMiy2B4IcYeiT797o0qdpAlM2rMSDqbu+eGwKd+ugp
 FJAyC5g
X-Received: by 2002:a05:600c:b93:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4997846a4e8mr16846265e9.13.1786431873745; 
 Tue, 11 Aug 2026 00:04:33 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977dfab57sm18549515e9.1.2026.08.11.00.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 00:04:33 -0700 (PDT)
Message-ID: <6a7ac981.fe7f0a4c.56784.51af@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810160048.1040517-4-pvorel@suse.cz>
Date: Tue, 11 Aug 2026 07:04:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
