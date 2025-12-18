Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E804AD6ACF1
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766060702; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/nuuvE9jZP79xpMpZkQmex1Yl0SH6Xd/IBbZsSgCDRo=;
 b=LVDdRu9kSUjXbZvjlZL5NaTaDV46djT/ihvogZdZthbzcCv5feDrzvmHe73ODebFMkJdb
 Y03jpgflLKdHx+ItEmLAwg9r5WMG4NqHhn+IuKydaD4kzNj/aYqNzYJV2hnY73au5+KmuRw
 NMap6/4Hjn7Smy2FVlz4x7oOCb47uQM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87E473D0490
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:25:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483CB3CF136
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:24:40 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1BC9E1A00CA0
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:24:39 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64979bee42aso815929a12.0
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766060678; x=1766665478; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9KTt39V3NS+5A2V1a2BvrQkIqNao8j9RXPJcVWnS8A=;
 b=aarfrMXmu1eDM6LriZgc1i8J09sgFaOzLJU+sjKxjEZcmz8ViAw+Vo1ITdgr06U0WE
 5injQ/VOfMnCzYEIkM5YmwSQ6Z2etvsBrkrpvvxL8v5DLj5OBK9ryUWoxKljI4AYrhCR
 xGaZ1//fVUYoBptMfnkZ22qE+ZDh/eHsOkX1GW9zqBXG1GZOi4zVDjlSHTAN6e3HH9bG
 2x29WcfrnMru8YyjYXXbAk5BesQKayC7R/Rp3B2457937Tl2JN/he23ZkE+wDi2rbAFl
 Q4799zEsRukP4zaIZO7Woi0onkOill5XUJwWoZcZsA58CdrRm25Yk9BPlzQCoOyb4sj4
 xLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766060678; x=1766665478;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9KTt39V3NS+5A2V1a2BvrQkIqNao8j9RXPJcVWnS8A=;
 b=p0tDH2ZSEUm+w3disWiXJ2Dr/HdR3OXNW8hriTqFg4y4fte/1UTL7LrL/Pu0V64OkI
 WzSjfhr/mA1cZ3QhigLV86dB2vxM/FESpkJwaMJ+prd/++dnH5zhtc/SAJ0hNo/C6Qyv
 Io3ThvHJpU/y6jY74aDaqQYd7Z3XdipSo9XuAcIYE3f9cnTfapP42J+biv82nOtpgIQb
 V3tTK8O90XwSzHPkp5To1MGR0Me/TUCIUgLffSpl5nIeM4N1Hc90XdVxNgrePdlhM2q/
 B2f6FepsXBObAtmFpj14DrjcaxEcuWkdwjLC7W5Lr0V4GL/lqZQcIWgCefGjaK7/Gb4T
 AcsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw3xdiW0AB/bxFtLPgwK5z03NsMjRwtkISwMM2G/8TP37O0JzXfO0BXSRoBGBqT6JhrqE=@lists.linux.it
X-Gm-Message-State: AOJu0YyTcygAyKmlVEQzoGE38xSSQNjykaK8HUxqUrwO48VmCvN9tXrM
 9vu6s4EpuTaHDi2schQSLjy+TJUoDVJC3rMIa9vAMiuitkD9CTFBqiPAQpCwrWvQTNM=
X-Gm-Gg: AY/fxX4z6Fw1gncirJOhTpdjCmU82DADtqVKCyzLqL2X+4nKDvB9h1/m2V/23jAcJJR
 r+50uTNJpqSetsFnT5pe/CACmbhq7avTh1/yaCTucca+5BRwG/FH6H7fuxIiobwWseS4G5N4Oab
 qse6lWR3US2NsiTKiI0Zm8VPX6onEPRK5ZfyPfYGzfNiIaaXwveeap9DqOBt52/sHzAFgrjWCt5
 OEe1VAc7hZupe0LL0Dsy/ziRi5c/fWRgAwUF7KyjnvVYiAxDxlPa9YgCDeTjQdrWU6ZHiQz827s
 bJAyURDoTIxbXd7brYiFWFsmacEwoga194BxfiQheAgvGYORPUBJ7Fa/KFNUHA0neF1MmC64WoA
 OMl3BiMlcKd74zReUHIm3ZWcnPsuXtA4H0Fno+DkaWntyPKghDfMSW0RasZkcWk20a2H3dU7CCE
 DDjYHoAsfNxx7+r7E=
X-Google-Smtp-Source: AGHT+IFYbQsFpWIcY9VoCqLKC1pY+7jaaIB3E3Dj3O2XNwYquvYOqynzQ/8crm8QfOHUIc/BlzQ6JQ==
X-Received: by 2002:a05:6402:1d4a:b0:64b:474a:d295 with SMTP id
 4fb4d7f45d1cf-64b474ad489mr4171360a12.18.1766060678476; 
 Thu, 18 Dec 2025 04:24:38 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b58884fadsm2361597a12.25.2025.12.18.04.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:24:38 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:24:37 +0100
Message-Id: <DF1C9EX2ZHUV.3CWUIFSYFTGUD@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251010113014.309433-1-pvorel@suse.cz>
In-Reply-To: <20251010113014.309433-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_cmd.h: Convert the rest of comments to
 kerneldoc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
