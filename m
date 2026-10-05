Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0304ECA6006
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791192236; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=DCCB62v991ixi864A9F3LQyht7G6JAeZPssLOXN9CSFnKnvYOrLpiKmOGY43qmLWw82F9
 +8DSejJUo9xMERxfVJsMwmV6Q4RUMS97KhWSJ/UGp3gNltEQsc3qua3ouaTKfAXedRFoZg9
 fI34twu82BaxWqQ2jBtYo14Py5w2sR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28A313E4B89
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 11:23:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0829E3E4B14
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 11:23:36 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 299981A00897
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 11:23:36 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a169d33ef6so8319945e9.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791192215; x=1791797015; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cKVbejJF2Cegm6jQbSxTxL2FvJ1kZ0SlNhLQbaGiQdeT5HnxbOn8fBlvS0uQhEkAJR
 iev/yOx0U4CmrjwsAnNPsQ3/QvNjaBUUon6sfoiacTrugjPvkv4W6f/RgzqbhdbJ93fG
 xR+yCnUqAf63nqz7qLZP4S4u2DTk3sACu6vIkTUZPk4aj1kLDwqt8XGMT26ebG6m0DjC
 5ytP69GAt90bKRAncoee4W9iwZGHQ4QChIzYtIKwVh2oNNgsCq3CcHp2mSwtOiWq+pxd
 zvmt8VJoG45IGKWcAmfOTXXtt3zfPbvk4w3GMvqeeTBBgJyxxzE7c+f/LwaL8ns8Mk5E
 GnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192215; x=1791797015;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aIbURgY0sbKSjy2GWrJz6BSVYHv2WecFdSscAoUQuFFk1N+QEMqbgydKe9Q3fBtnHH
 L2JLEC6fqpOS8lJxMkjA+HMxVeAPORNWL4ig5c1khOMnQqLRwRBFYVH/hKhbt3NiNPhv
 Xwoy+ckm1xLoDi//dGZiq0QrL+I4KSOxOljyxCk0BR10emZ+k8s94+9bqp19pw2p+RcP
 l/DwYx6KO3cyTEykFpdwM2VcQu0FTEWhR6ctJkuKbFsfEnsIqIiXaQcaDgQKWplau9/A
 B9HMlpEPlsM6oCs7tSK1SOreowjsRAqBBa+y8AHPi74sSSiQoXaI7zXZqqV1ci7qRIAi
 TWUg==
X-Gm-Message-State: AFuF++nQz5gmhWz0Y5wREW3Q8I1RYl+nH1mXvC0idYyxCZT6G8jzPAgl
 4Ajo+8O0K2P/IK5KHPmRz5A1/GBWS0lvTLA43Cplh9kfNLpz6I5mqeIaqf+T7jkJTQhd8d8AsGF
 g4OhcnJsusQ==
X-Gm-Gg: AYBFou1rW5aAfs15gj8Ah8HV5muW58zDXzhUiHD/4/83mciP8/6DOeSiy/GjCctXtea
 Y2LzMKe5kargdTdvzQKp0GHxAVn2CMML7952wLLkw7MsUDvs3H+5PQMfgCUHUw3oS5fa39oW8j+
 J0rssNzB06iXXe8dsWtkXhX9dwUAd6ahnDbXGbJJS8h87D3fz/Ej2/edbZLW1yQ5Lz6V/YMHYdC
 sAjdbExGzlALgiP20NnbS1CbyINdjRRXY907jii9S6fh2dX1F9yiU1V2yO+zfOTBrtTVACUYHF7
 ADZaf7TZkyhUZ+iAF4LQmFb5Tde/vR2I+bFHReKWHJEAAWvncZBMTF69rJ92p8of9aYLQfWSWJj
 ZrK8eMZBxDHv1VeSLgIzRMnb5kcFHYyIrxBSgH4knaK/t24Ukg9wcD0TAqIqev/H7gHLnwqIyTx
 4DFESyC9elEg7vHvzfMLk9wCAz+7iEDjjPR/ABP6z0+tm3RluL3w9Y9urfn6kvdf3d48v2TaToW
 hlLq5dSlNkwNIZaR6NiyMRj1fIjnAmwgtryRDBk/PiU8/UgTdo4eJcSGUvafYTVIE3pxoNnoJDZ
 BIgBZrQYHJEG
X-Received: by 2002:a05:600c:4e87:b0:4a0:3a3:33e2 with SMTP id
 5b1f17b1804b1-4a027567702mr178346635e9.5.1791192215401; 
 Mon, 05 Oct 2026 02:23:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03fef174bsm199055405e9.2.2026.10.05.02.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 02:23:34 -0700 (PDT)
Message-ID: <6ac36c96.87f1f720.eb872.3892@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261005060345.1019330-1-cyyang772@andestech.com>
Date: Mon, 05 Oct 2026 09:23:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix typo
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
