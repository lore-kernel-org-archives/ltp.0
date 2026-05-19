Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE38CD4F3C
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779200767; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OBDUZEBY0YIK9biOOQ6ibl73IlCiHiMN/4zQTj7/lT6hkJoH5EOKLINl4PA/YRItWGv3C
 bfh11R7XwRDK6e8QmWng1o3p4sbg7ISssx+chtbaq2bKQ62qhxX9JleHhH/m66RUlgzL5x2
 dcAM/7QE+fevOiZTqxvDwOLcz0o/E9A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 004A83C6FCE
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 16:26:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B0C73C6FCE
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:25:43 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BE7302009CA
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:25:42 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso930245f8f.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779200742; x=1779805542; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XOgqEzpA0G8oX74cEfCPZ9RTMN2MxsKDO3q6QmdO8GQt+etYiA7QOaL8d2NoAof8l6
 YzGhQ01Stapdf90NAyAqJnE7qlncj2YUsoDFc8hM+B8mMimuQP/eF+QJqMwvTF5ZCod7
 7qCUtFhHf6jGdgSUozQfgr9HaI/60QRU16NXDX5RGmVP0PPpGGSo0VCfpueQe4ruWoMk
 jzd2RQqTVzJISH3gZV8fLhN1tSezOISgCK38hq8Y7MduOizfebX9lxDeN7i/GaUyVV/s
 G1Rl2WBImSREA5ohMsUieWZ0tqX9SGeJTn+q/JheIzXNbGIA0dwpnDA5arOrY0xlKkhG
 PRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779200742; x=1779805542;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=F/y7o56GaYfyUMpkspt24qqFuU349GAty80YANEgK6yy0p4wXUM66AjfFkGjsRFPoy
 L3EQ1wG90AcdihMOEnMUvJ3DPbkRaK2LmEX/IwOjnJNm/fANUWttzrOYkRdn/BS5vjze
 o6k3iWeMYUeytc9bZ8SVRhYhDGLO/jtHQ/j0XSsp1xSYfiwPY21EKpgOqjI8zNiJP8xw
 CdddW7TDU0aoh9eFuadgnziQjBFc7IZncf3WpeHEeY3z/ZC46VgOGb2wyUC5ydnx2OW/
 4WpE2T0YJ/CzWgk+lWzKbQP11s91FNPIIvNCI+s8X6rMQje+5xxeN5KD3f6ULXEaB/s3
 m5eQ==
X-Gm-Message-State: AOJu0Yw1gGJnsCvzEuuk9JgZt+Mzp+H9eWwB7ayePMzmgTwa17mQsLbD
 E/qXCsqsNbKeEuoP21oKdjmHhp1+bb11bUnBPNK6nviL2uA58/RQbctj3F7mZPwIwE0jidaYLaf
 Qo87K2vW30A==
X-Gm-Gg: Acq92OFFkEllU8OVBhlVaN3P0nwHuZ9VW3aoZuGbMylAgnL+N/TrL9X+w/ZRSHQCTVG
 qbc+PQ1oELXOz/yssn2Sf098dYJI6Xs1aLMH6d03liSjx4j1yZv+FbaL5yDD3brUZXNeY+I5SJO
 5hd5DqhrftHhDwJ5Xmy4ZayEP9vEbEmCsmHOdXAGmJ4Ssw/5taA4qRk5lk3Fjzr/VFeJdkWZgCw
 JWd7LvYz3/JEUM2LCdIShqFrroEMRGbusMXLgZwf52PLGqhCgh/l1kkfl07MSuJHmuFVRHb41m0
 WiichN4JXYgK74FPr3ApbvKa7ZLj9tjIpflQESl5/aDEQHXNZrhj9MD5pdRhgplHXaEsTBPi64M
 LWel5IZAN+hbpjCcVW25rnl0bIQ+hJXHh21F7Zn4fimmZb5qY8Ns9jTApUk6hOjSWW/eXG7F+vh
 YkFVPesmyP1V5P2kyqvg2mCViKmF9iKUjXrMCilClvqyNbXAAo+j8it4n4oLAMLA==
X-Received: by 2002:a05:6000:40df:b0:448:69c0:8da0 with SMTP id
 ffacd0b85a97d-45e5c35dba6mr32892545f8f.7.1779200742058; 
 Tue, 19 May 2026 07:25:42 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm47430415f8f.32.2026.05.19.07.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:25:41 -0700 (PDT)
Message-ID: <6a0c72e5.0b12587d.10d2e.0a43@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260513085124.12324-1-wegao@suse.com>
Date: Tue, 19 May 2026 14:25:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] nm01: Fix BSD vs POSIX format comparison
 failure on Power
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
