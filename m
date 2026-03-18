Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B7103E179
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773841240; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HStZkNfz44htsRcYJxWDHy00Jf1pDE27G/ZpxoAVCms=;
 b=YhNpHJRLlILA2VnSNpoa1QKHzAHsR1Ng2PO0TqF37/TPmP2sm8r2qLaN4q7ObOUiHmcEN
 9MjCmgNFNfqYeSRbPXTVq5gKY1lr4C1Sp7e0dNK6cIL8DlBpNpSQBmvDc1zLnDezLWthqNB
 td9qAuQJf3mxTkzFMa6JPknXc5nL01k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0818C3E5CB1
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:40:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3141A3E1107
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:40:16 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B424060064E
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:40:15 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-485409ab264so7213635e9.1
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773841215; x=1774446015; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AhCbi3Si0YSWtD+7JWN/ETf9j+CjQDTEMGJgZmpgI78=;
 b=FPcKy+WkAxXWbeEvnl2tfz5VopbdMzY1cQTD2PibInQ6J2ivVQ3Hk0IBj4/tnJou0C
 Pw5sdYqatBcPKKPAi4NjwWs0CtJt0IWPUQVG6mtnJrMKFyzE1poEkUqazPai2RMXy1Hb
 J7CIUD053gNUVpT9ZaMWSwu9gu9bJz6HOeGQWOsM1mdXT7Shx1LHr21Z9KNg8boTfsuF
 JDri+r29fw7/fybrZeE14U+FEEJlC6Y5yjDbIADwIFrcryfTGS9/rSxI5l6zYorXVqg4
 5fWbf38MzzQ5x2GHBkC+Jg38hOnoPRBDmuhn8WVIgKjSdKVmt9gQabcu0sZiB1yTlk5W
 cjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773841215; x=1774446015;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhCbi3Si0YSWtD+7JWN/ETf9j+CjQDTEMGJgZmpgI78=;
 b=KlDmSzZghSwu2oa79GCJ9H++yjRr8bI/OeZsbfOaL046ZaNGXOPgyLbsOC2kN4kjpi
 Ffk1NIzTkOoIFQtXQQok2eSMdYJeBn6yUg5f93CwuT721nPmqMPb16SArNBMNTube7D3
 Ov5iUmiEZuumsPUhjy4MFVDLryYCnl2wG3g51XhlAXLFuO/uGbnM+0qBwHmtdM22/VrY
 01Yl5WtECTHH+R8ieA4tbzwlpV7n33LYCStL/UEZtQP/B7QhJbbHGc8WhnQii9A3Jstk
 d+82Cu16+lubtZXpVDkqZs4owDuLVEHGz531nm98/Isgzplin1lQ4q+QiKpnfUshLbHk
 Fx9w==
X-Gm-Message-State: AOJu0YylgQX6zCI6CdXHttGDj0XpRGbsZJORdGeTpdK87NPk3NVCliKS
 SHhIkEiDBUgWpD5XxNAbf+E2GkgWGysYUlT1WnR3EEOd+R+nHzC7x7m4/AXa6LNL3HvvLyO8hiK
 XnkQa
X-Gm-Gg: ATEYQzyiHqIXTZ1rKAsSX4cq1L9m0gRY53rtQdbGY0O+v+4dPbaFg/wCjE+OYq1f9I9
 HSyXZb2o6MrjU+lSxv/hhMOGHB8Ce9Emn69kZ/UiJMiicOcoXe4Z2wKo/js1Eq3EIGHyvQYE/Y1
 qxxaajQ1ZNnf/CUL2QtOBQftbzXmof6MaZTN4Fklc8zGx6w0+m9JFeDdCz2MY9bRUwSKuBh3G9n
 +roedUw8iI3GWVVlFBaqDxlNmJXqWVEKIchvuAZb0bHXz8Kgv15VIsWF4IjYOjyca389R/crr8c
 3XitvP1LXYKuNVr0NJfuiqtapOJ/ENqydvebqeOtOcZOEvpp0G1AEFfHPjUCkd2V3wPb7BaxSK1
 a59J2mO7/qzBuD8H1MdhXeQuro3gMSDD/Pi78PmyiSNf2Bhq4aEBB0JyvruRJNZzFC81OVGl1sL
 g/Edr5AgBhizK5YqOxwHj29AzJ6oDf/SW0Rq5pS03ATuPVgsRRdq4=
X-Received: by 2002:a05:600c:1d14:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-486f40c19a8mr59309995e9.11.1773841215022; 
 Wed, 18 Mar 2026 06:40:15 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4b9beb0sm40255475e9.8.2026.03.18.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:40:14 -0700 (PDT)
Message-ID: <69baab3e.050a0220.20c44c.52e9@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260317170058.1229-1-always.starving0@gmail.com>
Date: Wed, 18 Mar 2026 13:40:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify: replace strcpy() with snprintf()
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

Hi,

> 
> The -Wformat-truncation warning still occurs:
> 
>   snprintf(fname2, sizeof(fname2), "%s.rename1", fname1);
>   snprintf(fname3, sizeof(fname3), "%s.rename2", fname1);

Indeed, compiler might complains in this case.

`snprintf()` can't overflow, but it can stop adding characters after `PATH_MAX`.
We need to verify the return value, but `PATH_MAX` can be still a valid return
value. I will cc @Cyril to ask for an opinion about it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
