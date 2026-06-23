Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63421CDB479
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782221717; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lj32xdI4urpBGF7kWSXqB3IYPHpVfvJ9YRgPkYFVCle9Yx/zEF69Ue7BXBnNx6k/YklvZ
 W46EcUwJzNVTszQnITutNbOJXMrisbTVn3836rmEttC2oWEk0j0TCuF1dGPtQ/iHgSxAmgY
 KFIFDgfgMfZUVgZ4p1/9CrPmVQjMTe0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936643E656F
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 15:35:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0193C311C
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 15:34:57 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C5051A008B0
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 15:34:57 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b7866869so55792455e9.2
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782221696; x=1782826496; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Dj/P36HKMjWd5rlHdxRX4zs4HdXSPt9E4oDCdey/DxYrKG2CG9rs8oVCIQELt1FCIM
 0kgw0klJfenf55bouP2ojZvGq34plz+QYbN0a/ovlHnkVCG/M2znM9azrgaxn9Z4ukN2
 AvnJ8Yw1bq0bb9ZxN6xYaLNPL7yyuTvq08sFwNmgITaQ+UO1QAvjAulGmY4WEAlHb0Rb
 aXv4cVH4ckiTCmKGDqld6YLa92iBf0LShvfa7SVxzIbXi9Ixje9nmLB35AOXMJu1x5by
 hDh3QP6nAr90R77HRNrWieewhr+ePV9QfpQByBHtGj/UJnuHEuuSopp02AulnogouKja
 c3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782221696; x=1782826496;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bcSke7TZ3HAVRx7DLUdU9uyUPEOo6zOpDCv+Mg8AkPsAXSgY8AHaiw/BRzl0UAQ1Rg
 AsYi6eYOyEby41M+sCurBZ0q6JVcDqVsTHkfC7b0x2W82CRPIyLJ4CqAI7ggFUK/JK1G
 FOYmNFIQkWBDZOdReVwcdno+X2jhdCRP4qCkgz7Qte8eYQCa4ZVHeac0rpA5PGL/g9z8
 JR2Gc4kV9La4OgMiQK+GkwwSGaBUpS9xjhykVGYIPxupLMsLsjo+i1RWP7N5IhkQ95Eg
 Uor7fNhPvKnoSv7uEaq52NsDT9pYFLXypuQO742Fax4hV03Vc+WoEKQqvmAXUpAbUCAf
 kz8Q==
X-Gm-Message-State: AOJu0YzqIo3c59JHvF9sXcJll+U97fAfRBovbANAXk7nEk085vvzcXi0
 rXLDe2ZwkaEJXHPEWK9hYogsUIdBd3GzJHd7vZnWflXd55Yyv6cV1LqTr1u/aGQ59aND8/tH5ds
 b8dinXBg=
X-Gm-Gg: AfdE7cndK1VLjS1pYBOeAxShjPscORUKPeqCPV+bQ58QZ8+KTE/DNa30++G+AxuS+pF
 /JmAA+PCGIH33i2C0xMvpYzRCLL5iL+37beN3aTQPn/08velWnkBXj7q+ZGG7zpsYOsiRWUfYTj
 c9xmd/bnRN5Njw2Z9pTTbZABYmvQntsXNK3n3rt7mKzUzJ2TUACXRs/g8U9qaAgR7crEb7l2+1s
 /s9tbbbNimpv1qa1rR436OgqrkoaicGAx6cdv1ssagXFb2Gly9FAVsxrMkaaKeYK7heB820J475
 T7cK+86rfCL0UURKrKO6ufYAAnMTcmgbBeHh8PAIhtz4m4n+gAhh0bYbMI0roXQdZB9e2Rgm+aq
 CeK7km15itnpjmJElcCvOl22gNLzjypZRrc+31WH8BuUyqB7tmuxM5RZP4l5hiF1QfbXH2vNKFc
 0M17H4MWAoKP8rTusGf39gasI1e479qhQS7+a3+oVJXttQSoU+PzISktg6jhgk2JkpNEJTYA3+h
 rH1C5l3zX9E7oF6iAy0xI3y
X-Received: by 2002:a05:600d:4452:10b0:492:4caa:e2f4 with SMTP id
 5b1f17b1804b1-4925b39c123mr32421495e9.36.1782221696321; 
 Tue, 23 Jun 2026 06:34:56 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm395338325e9.15.2026.06.23.06.34.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:34:55 -0700 (PDT)
Message-ID: <6a3a8b7f.6161eb1e.19ac6c.2cc0@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260621150951.66407-2-mmenashe@redhat.com>
Date: Tue, 23 Jun 2026 13:34:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 1/2] futex_wake05: Add EFAULT error coverage
 test
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
