Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA88CA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791193402; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=hxJRDaHZM3bVyunFHwn1aOjWGdHohSfX/WthliAz09gzcU7FdytXPxwdI4Ubqik6RUXCV
 yyjmOmBz1CVQq9bOn6EQFkNqyaDPUR5Dq6o5IeyUWJlOi9mnBxxf79mZ9RQy2hrtqBKFpQX
 OFcYuiM26xqSfLnfYxid78/REhu2fng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049F43E4B55
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 11:43:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0CA53E4B14
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 11:43:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5733B100044F
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 11:43:02 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so10677805e9.2
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791193382; x=1791798182; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=FTfnqPwuMK/DqA08PDuycBtndr0M36StieFJ0pMy6BmCowTFL9fkGPlmsVh/9Vt2+X
 xPNylkCdM/ZgBCvoOD6IbkjqenMUTHa+t0JWwbPNrXBKBOfHtL1O7w2iCWdetdTddXbi
 1CBwnWmpHs2jQhrm+dT14NOMWYdfbeHZLOtiIDqwUc5eUSjGLN+gtkwKRjvqcsalwfEO
 v0+jZiZnkpa/PwfApVCAXJP2CrmIy0WFZowrGrhuY9NXpQgvOBJZt20SRLplWTEINga1
 Q7EgHf5TNjK0TIyB0HUCq+3ErGOpNM9oJf0K3LmAgiKXKsd+iIxWOybdpSs+Xe41zYIz
 v6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193382; x=1791798182;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=NDUzI1q9cj0rl+Vihn+FFn38nV1NnleIbdMWIZU40EY9y/l1f21FhE+ideuA+VffQm
 7TeWTRSXsoJ7hHqThUzGh2SbNb3KzXN5mNNVXjP5dXPZCeEPfmp3t0gHhyVDGFzD1I4n
 lW5ZncVhW/YW9tSJ6/b3op+PHQDM2S1KLk6d9xflU9MlEOnvxCvb1bkUD2moRcdFLbiO
 L9VxrfrJ5p16AQM6hFEl2HdOl1DkWg168IZiXY4InLONfd4egTn27ZKY1iaPqbG4VdNl
 pf0eW6MG6qKmtNYbtrAV6F5qww1eR4ELixLCi2EqkYHVgqN7F4lPfy0TPDrvgd1ssy4U
 avSA==
X-Gm-Message-State: AFuF++kx39pAxt0I7hVG8by8sgDEBEX+aDq/NjSd0eFAWVuDRaC480+6
 cpmBQ8SHbCfhnGNHylADc2T60M1plaK5PNfDfCYxH095YiJ4qwVr0rRGZHPqhLJ/MqMlcxBqbls
 O5X/eBcrV1w==
X-Gm-Gg: AYBFou1+fJHxp9JM5Sh4RYdynDuvFcIsV4YdsbAM4A/onfJZd+YF8Ch07FvkWKLq1Yw
 Kh1+6bgU9C8ZqpPNO387lbPdPcbz1hyCAQjhwHX0Yjb5BeMiO91AwGKcnPmD2+MEzzGnU+mkMNP
 oKCiLTDcP0BzF3LDTPbSF9hQD5O+V8bOKE0PfdNmYiGJAAxEma19TWvOwmIqzakl59EUm+XZH3+
 in3rUWuSfs9kGOXZNdEkgVX9g9ocq1RdyxKf+Q07RFy1z3lZceXs73JtiVqCLWH8A3Ott1N7F/8
 7inFR4Q6gjPm0yhPP0PZJx/ScgcVgyD3kjN/DTK8XyojtD72XqJ6f3pi2I3yGcOy/FAj8SkCmt3
 hDn7fvU1/yo6uY8nbE/nKCbW4xYtITjF2OqlSbUZXSV1KgKfifG10GNqn4/po0Yws3/llPCA98P
 IDZETdtZTu837hEv2FrdDMsMBmqJrjL6JFGgiCsWJIC+NNSq+WtDNdO4EWW0/YxbVo34aZi7dou
 j+5bvG0VCaVFvZ7JN8i/8zorLN1ijslzjobFwzUmwr+tJo6xNi5uZMHvXh9SWbmTBKuvE0WHTnS
 Mg==
X-Received: by 2002:a05:600c:1c01:b0:4a1:735f:711b with SMTP id
 5b1f17b1804b1-4a1735f73a4mr31637835e9.6.1791193381679; 
 Mon, 05 Oct 2026 02:43:01 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm261601465e9.4.2026.10.05.02.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 02:43:01 -0700 (PDT)
Message-ID: <6ac37125.4e3cbcfa.1d848a.db12@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261005060345.1019330-1-cyyang772@andestech.com>
Date: Mon, 05 Oct 2026 09:43:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
