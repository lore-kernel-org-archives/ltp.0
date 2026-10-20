Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C523606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=UeWw4kg3;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=bYEJPxKM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792512850; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AYZOQOnYZYrEIguQ/PBb/WoYysrSgXjf/o4yrO+bA7k=;
 b=UeWw4kg3ykJXgAsyLxebI57Wu/eizGNmnPVgA7R7RumvcivreZFfnepYOr7eviE4AL2Iw
 9vVUzvxJ/8TqY+RsD5Gd0Q1PihSMSaYYhTuU0K4m4vcBAlh+n3RwcFIzttbjVeRQLygiMf3
 Dwkf+jLTZ13Km7P6S+kU+CD0taOR/SI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F11E93EAF76
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:14:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 343F13EA629
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:13:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F4311400994
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:13:49 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso37698485e9.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792512828; x=1793117628; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJB62sejjadSRZyAeIyKZdp5awzaFEQUcLPmXMNUHK4=;
 b=bYEJPxKMQnMyBv6tEPemxICt3/2G3HKQ/4sHWt4Bp3xwr+f8qo7X0qxuTJtrDWVxPB
 GXU6FKJeRAtzLbjBB0nriqbugfXiXbnkXNrUrb+L40Li8s8oaWyd/HXeheiPh7oiu3kp
 VSz2OWRt3DYhLmtlldIPw2/h8Gm6gnrrItxYNgNjI0r0O73AWfnZDTLb6x2U/ZT7F0Xy
 aLQwn1A8fFVL0peJjSYK+ohglPoCXs8zILVmRV9XE82CsEnSevZSajjK8g/I4O+mniir
 mdZKG8u2meJ6x0zq+dGO8NskRiPermAPV/m2LeOe7OP1qH4PxlGFUCLTBJ3LagCFFcKO
 +zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512828; x=1793117628;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yJB62sejjadSRZyAeIyKZdp5awzaFEQUcLPmXMNUHK4=;
 b=GLOOicpRDPqXYV1NKae4yVZIyOzucaL08SrEZNNllsO5JNcAZ3cwQScGpIpI3ahYWA
 FhDc8iaTvQQkDQd1WibxrF8EFLFZ8CKOwgxmsFx3+C24aBaXYUWGsQBoHfOypYikPdVz
 +QZ1ALc+XhkhbsJlgei71hPYbx/YdLC+YSdFBN29XD2huSvBGlE8etZIXCZZi/lz8kOk
 uXsRa1q0NHMZCA+jiBD7ZpDNswiXB75aZbYKk/dZsVWJvRDfup9DSNiU/UcC9QTS04mD
 FxJK568SJx/joY6s6kOzA1dLa77hevUGCGWTFVfD3zjuC0ojvPDncY0qwNvGm8SXsFRF
 1fnQ==
X-Gm-Message-State: AFq9FYJlKQd98tis28csP26eEuE83KC/AAw48aCigOenxpvVUvtL/lhn
 HSvOP/HSUfMHzGUdNgGdhmJHhf18JC6I8XEp7ur+k2cwXeNxBVeFw1jIesHAGjpimm1+ZySYdwn
 57wn8/JE=
X-Gm-Gg: AYBFou2iXJ74w6fPLw2+3vfqSJPYaSKUvB/EMJfpzxk3hDkw+RXEQbXX/SJV0dqwIWO
 notyupL7Wk8qqEem5Cf5BYrtLoFeI6SDxtUQx+m0N0XW2PSsMMb8x4CNLV6orsNXgzzIPBzNi9c
 W9JvOLrMY7pIJzrg6erzS0rJWtX6+hHtR8OGgNHpmrF/vlvRQY8fD9boLA2isHcIznlZWw+zVmW
 SCZYAChuJQT0qVT/e+Dc6WGMWTATCE+MWgBP7uYtS7Mi7KOViEGxj3oG1Lw0GXJuacT0ZTT6GHE
 DNfJg3+LDswrTB1gbyO9917SQ0SdX1xVWCJXzC+wQreufoGZcf55V5F3ADDjLB+Zbj3jfVWPkFK
 neoTwdxX/HS4vGaH9PFXqTRZ94V7sSLKZJPDcscHqEudUTwcBhR/it8uXiJBwp54kPM87CSgkO4
 YT/DtviMksJXkiTXyibKetBNM4QLnOSX6a60Ewkz6p5wf0APFUkmSq0H7mBvTn4dJRy164SF10J
 NpsYlz7OkJsecPWN7Myykx/SxkelAmiI3TDjUqi1eYN7Y8=
X-Received: by 2002:a05:6000:29ca:b0:48d:f498:91e9 with SMTP id
 ffacd0b85a97d-48e07bb592fmr17885897f8f.9.1792512828328; 
 Tue, 20 Oct 2026 09:13:48 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fea2sm7583300f8f.10.2026.10.20.09.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:13:48 -0700 (PDT)
Message-ID: <JRHa4cKytSzf1pEFtImN0nn23YlZeNU3zipc@localhost.localdomain>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
Date: Tue, 20 Oct 2026 16:13:47 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 00/14] fchroot: add fchroot() testing suite
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
Cc: Linux Test Project <ltp@lists.linux.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

With suggested changes:

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
