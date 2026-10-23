Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC0606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=gjWrXfZf;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=XU9Qupz/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792761978; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=b1BCXILp64P83pqjjY7JRH5fJunitx8eV95WZyShAPw=;
 b=gjWrXfZfbjx8874WZOCQW6Byq8LmBnEJYXIHdHH9+GQb/eebmEV0oHZ2FsIDiEysBOiEj
 UR7djZrt4zMPBLSyE+yyonAi+svYIu+23yC8vU1UKINsdR++S/cVojdyN3KK4B+HVi8G+09
 /W9tu8n7+k+51R+/liJBKbFKU2YDgok=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AB343E608A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:26:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57A4B3CFD76
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:25:59 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3938B14052F2
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:25:58 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so3170065e9.0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792761957; x=1793366757; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bW8n59m/updvadDl9R07coRItMTfEVv850IptXENspQ=;
 b=XU9Qupz/oghPPOA+5ZhbLtphIUrUmgqcOOyeIO0JboWhdpPuSWw6m+g4Na1EBgdv5L
 yrmmQ8ymtFoxnyjUjb1kGcBZKiK1foU8rBLnwFQu+JK70dO2QafEV4fXe8ku4jnEqL6q
 +snVZN3SBK7+65LFHxpnbyWPOBZK8A4PAxpIiH9RGD0tKN0PAorb1DLI7b8oSnPXqF+4
 nPApGbOc0btzL1PlMFPIlr2R+kjk1D+13UumfMZqyTnLT8Nbz2H67sq/0j8H6rdOXAeB
 WJeOMAZYztw6zSU8AUMxynREp6NykFztZkeiSxrWIzP6iii6BSXUt/CtkipZ758x57PD
 L8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761957; x=1793366757;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bW8n59m/updvadDl9R07coRItMTfEVv850IptXENspQ=;
 b=UfNOf2Yn7t4bi17Zr4YmYkpBX07xRURGWNjwmHGLFqsy2clMmiw9zW73xfyxPytRri
 5dlhwJVKrzmnsdnSsI6amaU+hrtmtqP3uddL7phEMycOnYDGouhsBDGiHgEcBhe91RaK
 XOPkWHI9qY8cL4rLzuRZn2AspvsQitUBNT5jckbgAMzQmwCrGo7O+hSLn+d23kWvfsXJ
 od8fO/cqAhmTXQ5sIOWN12JEbbPwdSK+zb/WKE/LhvwEPkDqz8BfcURbxf1AYaYt4ntC
 iBijZAh9V+V6ShGofseEjEHtCI9cpkzmxY6PDF7M0FRFqkK3EdeJ7nb9sJkd4oJ+OjU5
 tTRw==
X-Gm-Message-State: AFq9FYIQMDkbEgxxFTyhWCTSY05v7vuN0tMYTef0kDqBPWgcM5DXKVqA
 hEw5c3B1LMiOPCoukXgdxA+7j8E0Vj8BThTms3De0t5iuOZe8qxrt3LUgjqeeoiUaSn9KWB5/hl
 H4q5bXow=
X-Gm-Gg: AYBFou0og8T0cA6T5EoLZ1HC7kZjayVoVqEAZDJb04QlHvu42nzQtejnZzRNCx89LgZ
 vn8qEZx1TpfoFCNg4L2ypX+PwqHais5u59aBRa7ZMoHu7KQlecLuU5fm0ag9oJbgc1SRpdCVTEc
 CSqnVdE0sKPiyJlRK0JtzmZuNg8W2nBtK2CoJxnyhS9j0qW9PkNgWkPrvxiNjHoz/a0u7/y60Iu
 U9WYfMa6krdUM6slekyLjSYSYApkKee+JLayT67NiH8pqLQGzL9tp1LXLN3WhSPmd33y7RKE5sn
 wC4wo++xCmFyUXhQ83j9O1j1g8h87dvaxv5OLMYZnzxTX3u9VRUFi9PRT1BqJGUnGKu6rrXJ3j7
 RkZi4XgD+sTA304EWYSQ3tqt9Xub1Sa3Z3MargRUrVsscS7FDVPfXl860dyD7xRBtb7mvnDo1ej
 Ctb0Hn9V+qnOgKO9XpK60YB89hxUMb6GF7uNXFR3ZM4SB48kEGlie6wSAVNjkkBynOIoWSaFAfL
 yNC+E4V0WjK+BmWecBMpSXxeNOgAIlpQwqToeqE4UTD6E0IXdJqaw+cR53RkWfXcnI2hwx3byzg
 ZOUvtyElBtP2rCwss2BqOxAmrtv9IpVBQyo+6FAJBLfkmD0KcA==
X-Received: by 2002:a05:600c:350e:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a211c7fb6bmr38615985e9.4.1792761957388; 
 Fri, 23 Oct 2026 06:25:57 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cda986dsm5026745e9.7.2026.10.23.06.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:25:56 -0700 (PDT)
Message-ID: <bfJVtsQDsGAU5UmB2dnOuGX3884EEwLe1KUm@localhost.localdomain>
To: "LTP List" <ltp@lists.linux.it>
In-Reply-To: <1bR3w8ntAnNcr5mP7PK1jexPEO1duew9nEsW@localhost.localdomain>
Date: Fri, 23 Oct 2026 13:25:55 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Li,
> 
> > > > Wednesday 28. Oct is bank holliday in Czech republic, an independence day.
> > > 
> > > +1
> > > 
> > > If it needs to be Wednesday, then next one 4th Oct from 10 would work for me.
> > 
> > I guess you mean 4th Nov. Of course, that's fine with me.
> > 
> > > Or we can try to find another day next week (26th-30th Sep), e.g. Tue 27th from
> > > 11.00 am would work for me (meeting from 11.00 shifted to 10.00).
> > 
> > I vote to 10am CET.
> 

So decided the 4th of November at 10am?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
