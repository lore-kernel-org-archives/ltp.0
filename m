Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EB606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=OS5ZTcgb;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dLVS79AR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575200; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OS5ZTcgbFlV/WlT2bgRE15UglrvtGz0OW1GfpH12dtOESCfPKeZXYFkSDZvaQ7q7vKz5N
 IDpwu6ywiaZ3+FYgYN190k6KWWKOyBD4sY8CCjPRE+8OFJcFfGph9MYZcEEu1znn2BqpV3q
 2eOUmiMXoyxBvk8q9e0oH605p7DQNVw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A7C43C1AA2
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:33:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E35A03C0493
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:33:00 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 663D21A00482
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:32:59 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1dec056ddso2962635e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575179; x=1793179979; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=dLVS79ARVid59ii0G5zQpn81NQ10QEnOHeV+1uQyrLXQggRGCfv/fqAfO0GqKn/eeA
 Chvd2f7nAF03X4oSEWvePNpJvCqtlGadUU9ISll1J/k8P39cEquHbbWCTb6D4+CCiPqk
 yA7WbDdqcPpHcdDCO77Rv04E+a5DMzy0JVecwn18HBBolxm04U5VyLLBD2cdo+Ez3dlx
 /GHVKSsYlEGvPYprD/CujHdnBa5ithNCfDwubgFr7fkFy4hGcCx89cS+Y8By+Z2s9URZ
 HORBtJSgUPi3FA5egdmX+aEiiODZaas6APfJCSWNx/A+QYsZGubpsfa0QVl4/hQjA7uK
 ip8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575179; x=1793179979;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=YEZm5LONJskThCbg7lIH7iqRdNzF3fR1fytl4XKc+PLmKrge27ecd0FbVVO6vClwtL
 +0MLR07/gkdLahryihYEkGMuLzevk8cgMAm1WTib7z7cMIQCMMpISXVwDOwkbpl2d1ar
 4MG/XnSgh0cL8BhIUlMfEUSbpATfZaAfpnoDO0Hx3nMrjGm//vvbrQuirM+f+qket9yk
 7mo/YkytgrGmn6i32UwlBffbeGw7VGaaddaG/x6KeTeCG5tlK/K+atigz1S+bCynUbNp
 dwo368virVdXNdqT8lNVzy2yYfuC7SN2QoP6GHw4VUrZIjbCnA6QT+seqYk8XQ1ti6Tg
 4Cyw==
X-Gm-Message-State: AFq9FYLkt8m3EXPub10ZZr8GY4wXRiCmD53GORd0oNegD2cZj4dc1KDZ
 nNZyqK8gSvfGFAMQ3cLogPmDdFajqXC67dz76A16lYo6U1Jy9eG++p784kGYv7SDbM0=
X-Gm-Gg: AYBFou0M/m2JColmi9rwcM0G9/DmeSxk59U5R/yvwTORwBMaJ+vmgyIs2urMgDYk9ay
 HZ45trdicts8EN7drjEU4xzgUf7vsIpTTvEhmInX8gzNPdfD/6C+Y2uCVxw77m77R6+ZVrvOUDV
 JDVIYmFR+hplXl0ns+CbJFOu9t2TGYTccuO3Co7LO1r2yq5rBsJib3xazi53N15ItC1rL1TS4Gy
 3VIpBMgBbaB7S0Y4GtSHoAMWYf7T/eS4DOn6DNA6Y+++HVvXJlQpVzV0u0lumOcKXXldGdYH9zR
 ++pSDS9X7LV1ERUYbrJE51Exj6Fq4qrR7ZpDzIq9CZrOumUtuZ36skP+/aDTnxtaDII411XYXF0
 FlHt4Qmd1ti3NAoixSQlBnlhvQ6iYmz6RWkon8lnozRNMv/IhCCpYrBUq4eHjWRXOmwZ0fIiGxS
 OX1t9mgJjbym3hcMk1Gy47UM/3FEE0cmvTbN680PN+mzPMqSHJ6xuAXVU0rZ1WhZ5kBszFjk1lN
 kUMec19qBgzP6YNO+XYmdWlDe5aUIrWoAez07JTEcxNEqDuVay9NmvKeKYPzf18yW4UaPsSDASY
 5L/q7LEQsL71kyaPaj0+TnQW1W8htxLR6GqtYVULtsGJ1aGSdb4iQN6NtXg=
X-Received: by 2002:a05:600c:6305:b0:4a1:e01e:1927 with SMTP id
 5b1f17b1804b1-4a1fdaf72cdmr26873065e9.5.1792575178779; 
 Wed, 21 Oct 2026 02:32:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e3bsm4380138f8f.31.2026.10.21.02.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:32:58 -0700 (PDT)
Message-ID: <VyaE8aefyfgmxminaK5pdeYZJqKafiLmW5MG@localhost.localdomain>
To: "Jan Stancek" <jstancek@redhat.com>
In-Reply-To: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
Date: Wed, 21 Oct 2026 09:32:57 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nextafter01: Check exact results and convert to
 new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
