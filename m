Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206DEC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787568106; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Piiro70FM6H2JgPEdo1Et7XZd+a5d/drhsUKuQiuAamI3vO8Ju1t8uT5/ZAy8Q86UUthj
 sDLiBnuSPPt3VLcpFmC6hjI85o5OZk1n0IEI/sKH+OERRC66qcj7X6ExUIcKyiK3wQuvx8M
 Ri5gIXfdndA2tiCHB6089ITji2Sjlqc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0EF53D0844
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 12:41:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDD1E3CF6C8
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:41:26 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18AE41400760
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:41:25 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so369708466b.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787568085; x=1788172885; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=dG0kVmsIJTTtywoaHbi3Zz6Qnzme28zRkV3Px3gwEws3Jw0dGe1Vte2vBnrPHfuqTD
 rNh9YAiPTp45Wl4ELo7mhlACNANZGixTqeY6ltskP4d93lMzSf3sYEa31VMKGA4m+UfU
 3N9kGSNHGbHMO/zdTwW4GGwwMENVE4NqeBXvuJeCAVjU8VHLSB9xDwGWcqb8rSt71DOm
 yNxPfSYdRkDUV/KGRgSUYZ9Tgs9iC8vdYLPbn/Ke0xjiDwgAa23UyrymS1ODF5J4bcp6
 vELbwkDqeG1BWHxXU2zEhJU3c35uTVV1GJ1pXD/G/1klmK+4PU7ze/1eda9NnlWnYBkE
 7RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568085; x=1788172885;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=EfJSquZzdfm9cBmK+QMVCnHyjVhuxcOmx0QC8W4OvY2rxOYzBlEBLLt/77Amkkb6oU
 um/YOdjvaLPCC+TGW9EaKW3dht8Tbm3NV5IPOIGEO8Ruf3+R4Ha08jgHX2StJr4d7/6L
 GgieoUUDeMraS047jDl98TV/s8tV/Kl5zvRQ7rGOcF858me9Y9dGDkMvvXHDKXqY+02m
 fQidp5pR96RSKSyCMPkcHGae7chCmL/Q9ksqI0vc1TaJix5v71du1pjU63IODTYxcW/k
 rELR1CE8GECeo3YzlGVl/SsxqevvC2SnnGyyCVCVMNhkjCfv1ECg8hz0+b+Xu/su9RP2
 c90g==
X-Gm-Message-State: AFuF++mQpoth/JrvlO74SGD0UK4DcYT7YzFqDZ2Z2dngpLm8CRc6Ct0H
 k2ETgRtcvj7rHPHPNNtVaUdbcRSuQ1g6AkVTONefgg8qqahWow2BzripVgoJ93+neEkC2frE/oL
 5WZIkYig=
X-Gm-Gg: AR+sD11D+Pr9STracp/+m6ctsZuJsswxxPt0abJLHz/oUDuYBKrpRRTNHS20KnM75c1
 7mEsdyPr9nZUYuyTEX5qnv4wAOqPz8doami/6Pr2Sb7nL+Aqk53rrdVbYai+JmZmz4ops/WlPaR
 sObk/VFU7I8TBIRdIbBr1D8T2aUvg1A0qIaoxsi2jIiYByVyYRXPyXLEkCN/y10A9puojZXel29
 koyJVB1FJTFnKWHC65XBRaetWct1TO5oTi0A9IzXRnn8JrYAdPAMZZ643S6HmdJC0OfhMdv88wd
 QVCsaJf6E2AEDNwPr+YPpeKlNh45aoA1X4pv00R/MMy3+23usH0CN3cIY8sCXRJQuwH06PTozwO
 fDo7hKPLMqlNvZGAEJqoLlTz3dMWwHM/pcdC8RepnmECSeL1XSfXhknPSV951MONT9yyCAXSp9e
 yKUNGhO3govzMTFEYopgVAKCCdWuX6hKTwlIpN+bjCcIk7M83aQ9NLyGw+M8J1985poZhHult9A
 nkwiP99yJCNMvq7Ot97n7yZQ88d6ia8OOH7
X-Received: by 2002:a17:907:7243:b0:c20:5797:162c with SMTP id
 a640c23a62f3a-c246a62888cmr2725945666b.16.1787568078237; 
 Mon, 24 Aug 2026 03:41:18 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968a2183sm1163412666b.58.2026.08.24.03.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:41:17 -0700 (PDT)
Message-ID: <6a8c1fcd.9c218f23.1e791a.dbb6@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260821055341.2079284-1-cyyang772@andestech.com>
Date: Mon, 24 Aug 2026 10:41:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] starvation: honor -t instead of calibrating
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
