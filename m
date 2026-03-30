Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B708FF4959
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774858050; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Vq6eJry+AGWtNBE6Chy1bPzmObUjOKfzOtemDvGlmp8=;
 b=rM4Uhs407qbajh38bezub5wC3GFZ/G6zD6FUnid83jM/BhGgf9NLMdlVqCGj5jYg7HI9N
 V7wgNtXNp5jD1S6xvPj5wTVlXyzkq7o0YD5Q1AnV0/Vm7fqmRdwMBuQn8yIW7Dsd+DCBoiA
 GESaaCJ9ymyFaSgWstjWNxZYHZxwG/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156923E4F03
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:07:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 602F13E2402
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:07:07 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C60E2600283
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:07:06 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b9d3ebed5so2803641f8f.1
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774858026; x=1775462826; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=z19gBNvjBYdhq7vbrZx7rguJX90FByX7NU/07jyOGPM=;
 b=bLJqHYUO27RDvR6rkgpYm42HhdQ1Lx7pPWy6qVbyljNzhBfD6sPgw8s0RZOV9Up4cQ
 +tiAfCBhadl+1wiVFdlyzcrzuzuheFzg16OoWpxDK1OjjIPIUJE71zMzKYrdWw4aJnG+
 j1fq4As9xfk2LV8FqLiwGm1nO5qjcvV8jehoXIXJcTYmUj0XO9KlNtBgqGbv5Qv3vCqA
 Jyr7MYDadR01ivVQbzZ/5EGjNOQ/gbVTPWBeyndKxan5pnUJQUujIZ4zYB3GA6BhcQ+P
 8E56PLCmxUAhqXEBMtpvrYg7RnRKNuIsjmsNaiGaaZ6JENTKGrD6XSalDz16Pukv/LqW
 WvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774858026; x=1775462826;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z19gBNvjBYdhq7vbrZx7rguJX90FByX7NU/07jyOGPM=;
 b=gqMDeUvtOksZa3C/dt4yrrU5P1TQCeslTfBciU0lSnfVZYKUd2gk4i1kHi30IctWdu
 Sd4Jwn28uCFvoPu5+OIaZyW0NLn3E7tmqlLV5RMSJUgrcuyot/jGWAvxkyWBzQUXjH5q
 y3+NXX8yoBYAnf5Vdabsrg6+HLBPoNJtr9sCvSGFM1ZglduwkU5j26Z7KlnmTrI2ehmS
 HwV0lXNVTdlPyPnIKABSrxzd6Cj1NLBE/0Rz2CJNx0UX3MQRs65tu7ELbXPmt3uZ+Mfs
 96yL8Pe5NlwLJ0c86I7quISmcb2DUQZ1pTHxxIN7linCLBZbKf6Ux3jeHt2BluBWYmJl
 EeQQ==
X-Gm-Message-State: AOJu0Yzgzn+uXdHIeXyBzI5sVWT4G4TB5VqKnhd5UKU7DxdKfy/zVgxz
 tu6m3HZa0sE1fxUcA6ruTP+BXZb1IWgUP4T6LbmnF+IOMLCaSgFpXId3EGyH73TKzAw=
X-Gm-Gg: ATEYQzwYqYWFNjOl6q4NG/y0FcbDs8D/qZKE5Up9yFygPwZbOnE1fGR2Xt3YwHiNzib
 73fRRMasB+xaNGjoFfFR322u1IOyuPYBVRPeEPRHBFRSpNbZutbhfmso5Qi1pFu29P82wKqMUxR
 jo0FbFzdWxqcsREnWUeRXiXdMVpvojJcCPf/V7velqF1Y15ugE4KmVLG9TpfvXXsSVv9X55PPg4
 1nrE3G1ygEQoI81qpBypipF9KTNQCwNWbrNwJZhS8mdR8PPIvkSg1m4q4rwjXhC52N6cNsrS8gB
 gzrhOP4qOsgPjGQp5Gaf+egFcxNWHtL0F6sG6O/bXWiRjMbONHbGh0ZEZLAMr6jytoXFzCHzINV
 Agqy21k2nTNO6mIUvnpDFQHz2fhTbdIH8i5X/dycE2ct7tDo2XhGjOyH25Ewoydphtk2ahtLGW+
 S3tPo38qGe1a+UZvKLWcHjpiwLvLe7FkPOo3EdqlxkTyPcBVPmwrdVTFkfSZay0xL91fvSH8HET
 e/r6ul1BcbFNG0ij+J7iqlklTJgPkdjGTs=
X-Received: by 2002:a05:6000:26ca:b0:43b:7ff5:fd57 with SMTP id
 ffacd0b85a97d-43b9eab1b92mr20044288f8f.46.1774858026097; 
 Mon, 30 Mar 2026 01:07:06 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eba4dsm17952085f8f.11.2026.03.30.01.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:07:05 -0700 (PDT)
Message-ID: <69ca2f29.5d0a0220.14aa0c.77fe@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260327152751.3637-1-always.starving0@gmail.com>
Date: Mon, 30 Mar 2026 08:07:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fstat: add test for multiple file types using
 fstat
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

Hi Jinseok,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
