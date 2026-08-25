Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8698C61DBC
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787644244; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=XUK89VtQViNRyc0+hw5UR5zEBMK+m0EgRxFqir+C2QWwRCOSrz8quEO/Zx7khm4urGy+B
 HLe+lyxZr6q5BAQnyBzJhjZ7BpKlUO24vrVZ1WV2GjJ1F6wSFSFRnZ0zA4ljDWKwlaMjl2C
 IxbWL02uwb9Z/esDRLt9cTVW9mBFkRw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4145A3D0630
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 09:50:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C10F3CC02A
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:50:23 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 082376009D0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:50:22 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so780677866b.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787644222; x=1788249022; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=En0FjBrTGOogxfzFc22OYTqbJuTFgbMFu9GuxJP9zdcanr/Hmo9s4pN2j3j3ffYvaY
 aVmZfH7HuVfO1D3QnaVcCIFuZ9VljrbgWnZX4os3WkH7qvqsIIPZVgWg6Wc0Zd2Sb2cG
 r6izLNqmVaDLi1Q8vJwPJIGcaC3lOn0Y/3g+FqvYh7bkc+Qzbzpod3eYVvBRaD0/bwwj
 H58wk/yU3gjQeEPodvE60jbVBG5X5tBvMZQlVGgPtppUNKQavNHAa+HnQ67xVl4pAnch
 uHul+GRayi5m4Cv2/3tcdqZkdDFIzezWWMY7KLeoNqcjSKE8N8m6jSb32Yt9qDS8HJME
 VIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787644222; x=1788249022;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XbEKQOHGyL7IrcgJ3JMCysytv5TxTzzOUZnDRLgZBi555w0nQJChjT/XnVkLtbAoKr
 JGyZvsmkn5WqC6qzQfseU2hQa/DgAaq9Nr1kutWRecIwK2cQeQ00GyS/knA1bFsXeQVB
 +lFScVXqQw/PaW7TYoUrc/aTQKIbG2mX5AiYexUr5FJiXZKxs49vANEoiPqXWLKIIgpN
 zZ7H7dv1bMw05tuEspD7q1G748Ew1RPiwS9prnFihL7V2SGcSKpDEUHtMgVuAiV8qn+J
 /u3OzFaAzJ3aCXrbZSz8XDF7jM//Kug6ihdcgyboT0TNURE9CoASi9YVRT+yuimlaEGk
 M3HA==
X-Gm-Message-State: AFuF++nhkizj3fb5wGYBbbFi16nyFXRdx/+/5Ydg/b8i9OVOWAmZdmyk
 S7u+if+1QS79C1NenMbaGBxb1vImisxYhydL3urmBvCGmw536bK0RPkSdxXN0KsWlmuVFXXwuna
 /MEq740M=
X-Gm-Gg: AR+sD10wGmFw9SVnEoVFmngz8+3UiyMzb6QPAYBBtHax0gB6BU+ZLctS9nT1aqIYMVB
 4WgX317HuX0blJzZhYJYQ0EGyxf1qYJoiWcx9dCpEv8HVaR5ryDb5lvrR8gul50tQJPBKrBPxWD
 aCpEw85bx4ybpwvpQ9GPj8uIcWxivxLs8qarDm6oV3lB+GpYBxqRLWoObsZuwxxnyyrUMXur+6R
 1g8jj0R7/reJpbZu047r6PHYaMpIYvnDIWnse2cP6VXYkXAzGRYxOsdp/NXXFrh/p+9TcJgQILt
 ZXJIz3CAVbw84aD35cPkm90M0LgnVZfqaYrTSuHkFS2hTGg09xDaHHKMzt6yUH82X7Hacb6P0eb
 a+6c1jkvQlD8EloyHN4FQCFfGiV8cPaXS3eKqXDbtK1En/ZUacEmKW5ibvtXAUK+JdKAIpyaNXv
 OFtTDkvL2lDKMl5PdOiQU+RfMjGz+U0T8jOebg8T+J+ryC3BDCNg/wDus50QdZR+WILpnS/FBRV
 ldLRl8aXi1/EqQwniW3FZL/fzboEF31MQCa3F2w2a+ryNF/oqRQseaWnZUVtBLgccBeNIs=
X-Received: by 2002:a17:907:94d0:b0:c24:8a09:8195 with SMTP id
 a640c23a62f3a-c249238cd91mr2411786866b.3.1787644221699; 
 Tue, 25 Aug 2026 00:50:21 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ab63sm1593467366b.50.2026.08.25.00.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:50:21 -0700 (PDT)
Message-ID: <6a8d493d.f8bea21e.221909.5082@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260825045515.24503-1-pvorel@suse.cz>
Date: Tue, 25 Aug 2026 07:50:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: test.sh: Backport tst_cmd_available (DRY)
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
