Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE196606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Dz4JLlut;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PUNg1xTr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792490619; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7T2jCXu1QflBKSbfmdPryNCAxeNNJLq/lDv4avtCYgQ=;
 b=Dz4JLlutZn/EsL6aSkvtJ5trcppQHxQlSZjlAbB8EVla5Zm4lXZPNiiZXQYXJutgda0AC
 tEQLT32yJsI910X0ahPnf6FWKVjLrEhNAYqvCpKhmXR1jXCIYv8qyEvaaFdoCpUqXd7M3FK
 GVribGmtDSLxH4uKVfnRuSwGGzna2Pk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411873EA60B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:03:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 066503E9E10
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:03:18 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 857291000947
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:03:18 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so31111565e9.3
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792490598; x=1793095398; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q+yc3UbXgGuDmBEzyhCdOo0V4hNrLktBNZM8rPazUzo=;
 b=PUNg1xTrvQZjC9McuVAQb/9cow1Kf8S+9A2sEs064BUHghS3X3svy0nwxeasf9BcEN
 GW9+l41nJp+F3g9QMTAUx+9gqdg5Eio4UTYIBysHAT9XJfmteqfde0uQwKRlN7So6j48
 we7gnEcGu7GbRlg0zDPQyMSoxgcMOkPujf199i2QpMq7Cj/21kH5RF6XoR1hk62b9Lom
 UU/Lz/DhW7Bc4kkl3xZEgKf4K+wfwUF3uk/ZTX2N+dlgz5fvSJAzrK0u+d55AYzHScMd
 zpGcoKwVkJje8wHRI5RfmHQRZ45esF49BPjjv6og84ql9CTA+aSAOscyShpp2KI7YGIH
 g4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792490598; x=1793095398;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q+yc3UbXgGuDmBEzyhCdOo0V4hNrLktBNZM8rPazUzo=;
 b=exWooCxsUvmOSAeUQdZzp5Do6Ojv0Xkv888HzcCcXC1DuIrRdMoUqF6c+P7ZRaoLu5
 fI6ECq27aMlAilyNJEtHA/0a/aocdRW4Kz08nz4rlrjaLqH0UWo41Tu7hoRMyJznQXqP
 dGvRAVDjv0N7qMG69kTPXFCllCFCZo1NBW3+64Zp029gqNQ+z6u3ZpD/4zOvZmdFvdPN
 6sB9n6dYs8HIJW+w9v6l0VQujDx0Qclp0nmca/UwiVeEoOC7yEKdGYNYUumVIR2WJ6uu
 S3spo/uNSKKqN2xVwdtLwdpiTziM/zcSta0GQaWzP9RGMhmbAjYBVFGX1O1r72TZbEi4
 3Tdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW4a8qVuGMo4XNGG5vVempXjQA26WoDYWsOohzWzNbENZoS9VnDZta5eQl4ynNQgeP1lQ=@lists.linux.it
X-Gm-Message-State: AFq9FYKA4Nb0mHlKQ/AOU7/kODmOqZ8/WS7gRLtyg1UEUG1dY474ToqA
 KaI8V9s1XEm6lI8Q9R2LHKMa/iwK4iorGVtCuUNB8NJTlZ30ACCLENZwqrmLmzplf2w=
X-Gm-Gg: AYBFou0ub2NKSj6/EUchq3JGFiR6aIEiZg4Bet1Tkq5aUvLgxuDPWgLUfWehtozwwzZ
 H/pQZ81VPAJN2jZZaVn5K9AAWrdMAZ4n88GGnwK4VgmcT5FICrqfSzIvKDGZ+Y2omk4ykQUzPpk
 GHN1hLDbsLAhqPzlpFfx0r+kg6XZtZnCz4BHUrzvjvlPJZf/UHci+RlKW6dATgEQrdrne2bfknI
 OcHTHtUVbZuGkriL0oPmPnjrLAVEsOV/2DizbD3EBy+5Z+9iU3BMILcZwfIjag9tvRPl2fv6rEL
 g1JU1yXL4G9PV6k/hfnkI4Ruyw9Uge8V/2mDt8oH6nOp23JleZFBExr+R2eYpY+6+hLmmdbijdR
 TRZ4J2EselWw+etpnVXWb42aFcixVMJpROym4tQ/kwnxwuAfJcmHWpjisJm6W39BQgKf4cpRCCc
 brtT3b0AGMUhhn8KrQecDhfXIl7ByXBvgdQtixegYZjKMHJadKqJRWsQTxvKKD5Kgv6meP9aDsJ
 LKZ+uamw2nv/T7y0815zS7Hn2jDYqv1XVyk8eUWOuRmpHaloi2WPBTNvp9rf9hXzDm+nDKjpVFt
 sz7EEha98vfc
X-Received: by 2002:a05:600c:8709:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4a1d76255f6mr191077345e9.18.1792490597740; 
 Tue, 20 Oct 2026 03:03:17 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm5402370f8f.36.2026.10.20.03.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:03:17 -0700 (PDT)
Message-ID: <N2K8VeQov9Sg4LgN54hYWPRvgHd1PvbTfIFF@localhost.localdomain>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20261019131327.GA63027@pevik>
Date: Tue, 20 Oct 2026 10:03:16 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

Hi Petr,

> ...
> > +	if (ret == tc->exp) {
> Hm, we still does not have TST_EXP_EQ_* variant for double.
> Likely not worth of having it (not many tests comparing double).
> 
> Kind regards,
> Petr

actually I think it's a good idea, even if we don't have many examples
like this one. Maybe we can skip it for this time, keeping an eye on
patches to check for similar patterns.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
