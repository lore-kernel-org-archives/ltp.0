Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C3606A326
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fHxG4LmC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Yl2n8FhL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575373; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=fHxG4LmCiXIK09sZERM3L9LmT5U8Vmld0PU7NlKNSpQxUKorAieTwCHqMqTevf93Ktkut
 Lr2tEMjy+9E1S449CR4doRn54XXH4CsHk954sGhWxNvl7qYZ4MctCwTDr0ICa8H8rXzjDwA
 RmSCkviEyOZqk/dg2BfvaOx4EGsGDaw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DE613C1ABF
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:36:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4B963C1ABF
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:35:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4BC9D1000998
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:35:52 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1f68a9855so3038215e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575352; x=1793180152; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Yl2n8FhLTCEMaclfr1UC12314d6Cvgls4jIJkbn6LtdEMv/ev8pu4shg0lkdkWS0jA
 YX/omNu/VGyOMLZLdhNjJmHGJIQBgBjsvM8YDfi61V+v3jejXdKaZuTNdM1H3lVdyfgm
 wvC7SeyB5++TRtX+yzu/Rc40wXqwxSL+fGjbvRhMMeHbYSzWxSoqxijTDZPCH3JlpZqG
 xGnqRo5iMtr631WBTmUybNrzXSILzGDRBSIH4HK5c+iDFJxu//hL840Kvh+1JIbOKfEs
 3C+WCvIROX5Brmtby5nduvLC5Lahm27RWHhHcpr9oPH10jOeVRy/sM/tO/DDINtNZV0l
 pTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575352; x=1793180152;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MNYjiyvPq4VTZPckGw3nNj8sqId9a11hUvMr1HW+Oyt/wFtOJQ76hrTQjbUZsbNN/B
 KsF2vZP52PBnqMEEkdZaI4Eioc2ANT9rP+my9DiN5TxiFNziG0m5sEtf6/4Tb4h/cmHF
 FYupvSL6VvnW+Cc4TcqQXQ2O51C+7N/sJh0qVruOF3qD3+rGWV4dA/zwBQz5fYo/tPKR
 kLlVJExlIvY/1DSkS4JYEf9dIt1gtefS0iA2s21P6MPblEEB2Nn9hKNcEatrrrW1zwVd
 A6nMB8q+zy3pACfVopbu54U537WkPc3tweJtauUgfdmRDzs091PC979AhYZXXKQCbZCE
 akdQ==
X-Gm-Message-State: AFq9FYLrCa0naN5VzbDjZQ+EUVZZI3zh3oj59d/sYYK3JeXP435OtLS0
 0zQJ6CF3yby2kEkgdTT0VztVAzzFTUBouacIcDdVo3XssaOCgcZbExEPpqgi+GLQmkvD2WWqxzY
 f13OJQ6g=
X-Gm-Gg: AYBFou3+q6E8QkeJiQu7BwCgb7xjH2aWIdGfQfajqGRc/XFfCTeHD5fJtiFgjEWNeEm
 2FHlTe8XG+yftIEbcFroUQErWcYEapPDouVG9nW5HsnsFID0FlShsakAEW/0vcO1Y/iGYY7KxAn
 FwVYrZOlYGw2fMd2Q7z/SabsxZc/XsQfFNK3JX0DOA5oG/EPhcasZfW/P//PgZGqTCTxIgC1Nuy
 XoYmWPZwGXGG2YNg1l3p5ibwM1xJjMSgvGAkaZV/H5TP3RIk83uIv9mW1Hles/QMKvrZO1mmIyU
 0LSqQ/h2QBVLTiDzCloLO1P1ErHwC8Qdr+C6dllC3Ji1Hmb2mbhCyytOmguLZKvRNoRkp8AJcTl
 JI+dDwm1EHS3YnRfU6q5Xvw4+74Q4EmYYNfycgqoxzJNDMJzX0nt8uMxkblCvos5GM+doeiQETZ
 0U4wMK2LnfogaPtjjWZEjfn8dN05dEs9WDP+EevCCNGerXtgih8MCS8EymJHTLa50yvkBcZeFaa
 PfScNynZ0ZcY+U2DJ0ehdAXXdZZ01iECloOCBPnqWMa516uOKxApwNIy3TmPcjsNPVCJr4UcyHa
 19KL41lXWWttA+j1VDr6Akn9ITQ8o3T+E9jhBUdG5eaPVdTLZtmSyINS7pk=
X-Received: by 2002:a05:600c:4e41:b0:4a1:fabf:6f22 with SMTP id
 5b1f17b1804b1-4a1fd8a0681mr37416525e9.4.1792575351622; 
 Wed, 21 Oct 2026 02:35:51 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a20230ca3esm124885e9.15.2026.10.21.02.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:35:51 -0700 (PDT)
Message-ID: <zZU8OZ1mFFlin04myuq1yZGwlSwEgcJ83sAx@localhost.localdomain>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20261018160115.154430-3-avinesh.kumar@suse.com>
Date: Wed, 21 Oct 2026 09:35:50 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] openposix: mq_close/2-1: Initialize
 sigev_signo and check for EBUSY
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
