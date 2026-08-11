Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5894FC5B569
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786431920; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=I8vBFpMC4jky8IvW7KEt8NIJiQ2eQEselDmXRBuiap0NTWuo7A4v37ODmX2pSIhGZneLO
 NgZBlRM9J/2n7gCvBarIamsD0HMa2sJK4IAUdtB9eYskfUEhOqVZ0PFt990XD/eSrAqBMRP
 tJb3a2EfFGvOk82ItEjy3HiK0pNgnV0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D66803D064C
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:05:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D18D3CBE80
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:04:58 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B5511400441
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:04:58 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5237575e9.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786431898; x=1787036698; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WvD2yojTkvcW89zhPCKsIuTHNpFSvrBEvs9OHpPKTQjfig2Wnnqpa1DFjvt+Em2qAx
 1Fjb4l6KlLqvhzug7pt9he8+wn8uYtejneoFGARXjCKBaL/UBJPNj7qmYu/s1ZQx+Ngu
 hAbSnqIx7P5wi6Wv8l118jUbNAUGLOktIquotNkO9O0U9aQQPVqVNAn7CXxBtEjM/UDj
 hzAYVz4w8IvYlwn5CoZWVbHgML/3+r7q7wRkWWW4W53Uk61exg9dd0+mFn33gJJJTHNW
 wqyqsWAYTF9XEsxGNfdD27rJtCDH1dddZftKsVIByJ1fCHQrfJx5zmUbVwZObulTYIDW
 zlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431898; x=1787036698;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Em2TrtnQB6Q4SqFiU/dUj9co03n0iIFz/CmDvkFGbDxUhFa+9SfCMrQAPsckpwC4xO
 2i/WqORFFoLiDEeJC2+nqKlrjRtIH3YLf45Y7mFoS7WQdgXon0oX6Zq49YWO9yiw3iFT
 xjFLMkvGxIVARbubfgFKlF3xfVWnLy2lMgySgAA3RAKknN8ejcoFFsRDnivYDYBRzBJS
 E5gqY+pU8lWyolzP9Poorl/tFIJ2cZINhc5WebzQgwaKqlvM+Y1P4PgRpvXFeDAOvv4n
 LzMI8wwn4AqZ1sl3kYo52RsqoFKZdc/zOaBeposPXXsoJK0jwJX8nBkrQMzWrw9MT/XX
 RI+Q==
X-Gm-Message-State: AOJu0YyE57JafY1EnuxsUxCUHZWxFXxOq7PDuUv+6olSbGP32Hoa/e1F
 HQMNIaP1juHJ38RFU+cLvFkmQHv0UFc/egJ8G6l+5YhUA1w71hGeWAxBqZK82dTYWN8HV0ekPez
 3TCN3RNI=
X-Gm-Gg: AR+sD12Je1e96hV4DCQL3OCMBiLVSn/r8m0TCViz3/HPvlS0oXEH6qq8MOBIR5/lXhH
 Bg3vNw44VePjaFWmbi+YT6LidabAsqJJDLpNPivEBF/zLllv3s1xrXv2TWF5jGbX3UO2ORAEzOg
 fWtQsLW2JDBZOnHZoFNx9PyUeoaUdcOMd69ZktJvym5DUAFArNQlTtkpSEbU9rLQMs/9nE1pz84
 58nBps7SdaCsytGsl7B/IvRiRs3EG8VeSiReEO8rqcoLDF+iLoE5hK8J5v9NFWxsStossrKX15O
 cdSl5ujTjkyer/QReZ9B3yDgEZFP/WUMvDgOP+22lQBsYG75SbCOvQDqmNRf8cn1Iz0IWn0rvOa
 bleXzBOcI9KJynFG3CF4/HYuh07N3/v5z6KMma/QI8oopR8OFVcMeolXXtmFN/PgJgWphiRBv7w
 f0qDvuqj9EQ3NiudMj7+G8EjJe4k3qu8uuAZQejAo29wN+m0Iy/cBgRBWAuar/RGCNXzalbg==
X-Received: by 2002:a05:600c:35c4:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-49978eb961fmr14407545e9.2.1786431897710; 
 Tue, 11 Aug 2026 00:04:57 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977dfacb6sm22106425e9.1.2026.08.11.00.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 00:04:57 -0700 (PDT)
Message-ID: <6a7ac999.b39440a8.a5757.0dd7@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810160048.1040517-5-pvorel@suse.cz>
Date: Tue, 11 Aug 2026 07:04:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] creat07: Avoid timeout on the test failure
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
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
