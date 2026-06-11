Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A63CD98C7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781164843; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IR/p1nma90vs2JZ4oKyyCS0tTrHJO1sJjX2yBxTlWqM=;
 b=FyCWYhF/LahDRJu/EPTEeTXSEiJ919gJxrInYUWam2yp7qcFtUVJsLRq4CfkZMFjxF3dN
 a2z3YSuWdswykbv8RoFg7oCeTuVz7qdshFH2T7hCfDWMxYo5ff69ESPu3sG2dNY2iAAvhxr
 bFSyu3oeZgT3KACegVh1YJwpEfw7hxc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 230373E2AD1
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 10:00:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87B0D3C72B5
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 10:00:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B714A2005DC
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 10:00:23 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so52010855e9.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781164823; x=1781769623; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MhghjlXcIzmV2YYa2PpPeJdqsPBGr2sj9T5TTy/VvKQ=;
 b=WaNzorYyhzBDULoiBAFYPWxVFwWIXAMvwm9vD3tVG+zBbNeq6ptrO1NM1exiM+WLVL
 j8y7EwX8tmdMEKnKh4m0Xw5zUBuwKE1YqeDu7ZhHOpQSovPFyqrHcXODXQIo6Y4nizIB
 0D8WKILc78xtCtUDSe/Pc9hmf8LpeSu+yyUHQbmUpUFe8GyJjwyPdF9niuSxLOyxapFf
 4j3lC1zU5hv7CG/yR9pSUIM1sA1MU4pcUE4f/eqkyVw3HTCuyzTSed2qpqAfbwfw6oCd
 DDeVS1u8LhICSjXixLJBEtvPZfGUfZX7Gt8SaKI69DTZmwwswkAFKO/8egm5maZ0Gc1v
 We+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164823; x=1781769623;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhghjlXcIzmV2YYa2PpPeJdqsPBGr2sj9T5TTy/VvKQ=;
 b=YMTWtbo8aN46eI0cPUxo2yYz6tk74EKNK3nkmS/gLmIaKL42VJrP3ZDBcUQdCXaPCT
 0YI2nCIWEgEFhCe/OdlfO4OmryiX+M0dFVYaZQihV4bhuRNdW804tblKw4qwy+zt3yrt
 5wiq4cB/44niEP6ENyg2gN5alg8PMhvwPi1B1tr4xHTyx5roxgE4nfDdewc37o9tfPIg
 clfL+eiwDTqTcRIyPKsH7KpYU0zYF6JneNxVSG97bmGzPGWWJFLxSg+0NaADe2a2MTPd
 3Slnul9M8Up2vw/e9JoHjfyaTVaMgPTpVrwrdxtnX7mp9gZ2TPYqqvoCLgSCr0czU3qT
 Fe5w==
X-Gm-Message-State: AOJu0Yxno9MUx1z+U+rb7hjbOW//RnWRIqH3ljsF172VHjGgkHMSLjAO
 Fb42hw7FkS64Z90v+HQF7OMwL40zCAKrGT3A2bqK0ga/8oIfSgAH+YAY7GA4zY/9dWBJXyZEfjk
 NYQ8X5uc=
X-Gm-Gg: Acq92OHpQ0YtmtcFVb//RRX8tYxULbM0u3jfuRNcc7kmuPoOv3Vp/xOiWrN1hp3rLqO
 aUSGYK43rDg/myFFzfI4z6DDuGo4B9aqaEOPKCWm+TmOqRLYfqSl6Jipnhw2PwXQAoMG6f8cZLn
 cvTpM3Grc+Gpw9QzjkU+FYV/daBfJ3u6WQmN07IWmqO4AxYdKGLt4uzcqpZ+mX3evvKO2p0qIif
 Nkguy2aDdbP/QJOJ11Rb3QHn6CN4bvf0rtnwlaMwJC8ahpTvUJinL4rhOULB5syLG9MkWJMugn+
 kbyhiq37Y3tVrPG40wwYzbQMZ1l6xUlkSVJiBcf65QCl+eOiq4wXBgD/T2nMc5aTc9Rgu019slr
 wJ8fh/WnhRhhZ4z8oYjkvEwzSpGszJBwrk0VD3MrYxlfsGVNdzxaBFAYfw2FKc4p3IkP6N3GeQa
 0DV3qukMhNHIU+DN50SW/I/oz0JKlvtLyl1eUwwJfrB4ztPD8r7E8ElDMTFVcwGM1WvRzx9gmpn
 LNuylu1yw0YsRuW83y2JdML1KbDQdN9lLXdg5ZDorkcPg==
X-Received: by 2002:a05:600c:8012:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-490e55d664bmr17696805e9.14.1781164822908; 
 Thu, 11 Jun 2026 01:00:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52ac9aasm29430415e9.4.2026.06.11.01.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 01:00:22 -0700 (PDT)
Message-ID: <6a2a6b16.056ab49c.228c05.1474@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260524154221.2064-1-always.starving0@gmail.com>
Date: Thu, 11 Jun 2026 08:00:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] power_management: rewrite runpwtests04.sh in C
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

thanks for rewriting the test into C API.
The test LGTM, but indeed we should release the file descriptor
at cleanup level. Please send v3 with this and I will merge the
test.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
