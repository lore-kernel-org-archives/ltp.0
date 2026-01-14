Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2702FD31A28
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768379875; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=E45P+Eh14VGuQflm6Ohc28V6C0tsf3oGIB2Z9Zn/17Q=;
 b=IRvqSlUyWSIter6Phpxx+3Xj6zSpzx5JRs529wj4HR2T+WlOMwRC8ksFM+tbPU8h4Qwmm
 vDl3O79xGeA57UugBEBAF1ei3NqGV7Q1kxuSpXVPN8T3EN88djksoW86yO86F139ofh1trp
 bSm0glhWwb0pe+Kl84NvH4g/Vl3L2h0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AF363C98AB
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 09:37:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705D63C4C92
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:37:30 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57036600934
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:37:29 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso430412466b.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768379849; x=1768984649; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUWJsFB4yW8EouHM0/GRly+FbEJrtjXUmqA/Ymb25XE=;
 b=ZtaL+6ed7Jff92m8Arrh3Z9s+qcVGqP3/Szqmwjq0dO65RhV2VyI3TPx+8YMcJ6n99
 2SCAyatYJnsNAv1Xr2fxzLKu8pNh7Wh6du4YbsNgh4WfmkHMe9AjSUDiULzBzy8SF7lU
 4/YLhpq47oogKmsD5b086ZY1OGAZQELb147ZeRi5nzj7JrYhtSor8HdtoRmXHFQI7BJX
 z7VDo3s+IwT9NO3vDhbePy6egQNaMZZbMBX5siv4nA5+BfcGmHhJmLF/eYJpt2o+Pk9F
 tbjfdlzh3P2BsRMsbirptXsqwg8PlrakZYBVpA457QpWh8Qr8qGpZ+tKpd9QIwueAL4x
 4L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379849; x=1768984649;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUWJsFB4yW8EouHM0/GRly+FbEJrtjXUmqA/Ymb25XE=;
 b=TaM+pjxcHlB7uqrCnaASesK0vkHDnOIJfugudS5y3jUS/8BxbfiUs+Pv36WV0Qlq+W
 Bc0QQXK1ITydqY7aVuBSZzD5kcrbT2QDg7tiQYzMNXMuJ+7yIU0pgL3k30ItFjxwmFmN
 dfwk7tx3ptHKFEjkwYHJqtRjlDROzkriRWL+38XwbgGuBK4I7OBxnIhS6HkF+nNYrJQq
 SHd7M8VbgkZSvB36uBXbOx9FHcWJimoDDi1eI5bX1apFELl4BXxUhl3TJvHaYSn7D957
 cnClP1/cF4LrW6Zy02dYWlELyN736Bobxb8inBXJ+3HEiBKKxfgAA0wTXlMQpjx426Mb
 IWlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQJDd5goLVG57A3659vCLfpcHhJqy1r3i11SIy0SL8ZM52BFV8zeYvf7mrkgOUmO6kX6E=@lists.linux.it
X-Gm-Message-State: AOJu0YwkKL88aJ8TOnH1HeG8hmd1mQg+FqYHoFtKzM3Wu4QHX9bG9lUL
 1kswNlPBDhiLZSsU9YTGwwV5kd1AGfgBTkez+xGt3DH2bXjbeXe6rrYN0ehVRW9AbYc=
X-Gm-Gg: AY/fxX4oor6KPOD8y9HZq8FnVhE/6Xqb8ylfTvc610rxTwvtD0b5op6IMhp9nCyfrsp
 dfpCe/fVjLE5Lf3gfEFy0ahW6UvWaiU0dqZ+uPSxUr6/6ADcV3lc+JgVwArsXmpNUO2F0qXQ313
 dGY1BfMsXaQLwn8MBGDBm2RM2jQQ00rpdErpCy2WXVtma0/pn+9PteVjTkQsHnjQ+tHc1Eh2x4Q
 4BuYtYfc9rvudMAf1PLrw82cUWM6DMDuTD26odMHIy4Pz5vUdZzA8GDEUyNz+aRonMO0G4xRxr2
 KVBClA0oIaXRCGztcwz1lOgZh92YzsvuwnPqWXYt4my0IE1vLl+fw/BWY7f/h9zfQu9nyJVMq41
 RGu6VXZZbCmgaNdjidVoYHMyqjfBOoEocbEaT1Uz6y64nAIywR/CyrHfa0Z/sPJpqPN48KmJ2AI
 uwE4sYk8XE9/rGxRD/l4bPIpwb0m2T7RESNTO0iUZQcq2R11H/BTSfWZLNzE5GT3Z879EswePUh
 M5wu2w=
X-Received: by 2002:a17:907:9629:b0:b74:9833:306c with SMTP id
 a640c23a62f3a-b876127f271mr142666166b.47.1768379848724; 
 Wed, 14 Jan 2026 00:37:28 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cc6bsm2456622466b.23.2026.01.14.00.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 00:37:28 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 09:37:27 +0100
Message-Id: <DFO6C71QX72K.5V39YITRN86I@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Al Viro"
 <viro@zeniv.linux.org.uk>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
In-Reply-To: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I forgot to mention that guarded buffers should be introduced for
`noexist_dir` as well.

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
