Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7396EDF055
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770883963; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=SHik/XjOYdC569JhKRkukm4u8lTROh02vsOw42HuThg=;
 b=BmICACWHvdLEIRimCkAUmE0plgiyWjlo2qhNp1nddTmFsNzfJEeKpRlfn8X67blkkKlBO
 MIrIMxC+nTI2lmdNSdYjgj1OMDWUY6CvOLSZbRJslCt5bDeSbU9ISOxC0SDBgHAJ5GVdjCi
 3/kbN8DVwFAzuQ0sQIwNohWnKNvJpw8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BC113CF135
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:12:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B7A3CC23E
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:12:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F073F600684
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:12:16 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f96f6956aso38133366b.3
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770883936; x=1771488736; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpJ3GLgb1ycVA0R1rczUu2mVS8ePVQdQlerO4MHR2M0=;
 b=XgKsZ8OFV/lPg4vWTfIISrM2Khyi7uQe5x0RYKhRr9S0aL61w8Rdvzku+sqwPIqqNf
 wp6XRxO7J89sTSSHqZHijalgqch3ViLnJomHo6aaArcsKyzzrDobBJq4XwchGOzfryk3
 jUNRWeQ/S1/+C3voqFC9QBXoo0cpq5EiPY28qSPti+ytc9AvNRAjtoP7T3vZClgKJBpm
 58dQOm+zwCIzRJwuKAiAD+O6FaNXlexdpQGnx2aIWxNhKoInQkVHQr7KAMKd/DZbzd1T
 6Rgmysk1jlMJhfV0BoCbFzrWn3/0LXgPezM8l4zhK0lg8E2agCcg1M9CnndczX1bUNf/
 yfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770883936; x=1771488736;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpJ3GLgb1ycVA0R1rczUu2mVS8ePVQdQlerO4MHR2M0=;
 b=JSNMDX7a9hthiLuq2q544U+vjGZf9gMaWa78ubVBGD7ikLR3i2riZ/KmjMlgEWkAeV
 LqNpRA+DTwOU2hFs/0rfpDupphEJ80o0WzPE3+pMRLmTAUasPuWWrSt6h+dJ3PlZF0M9
 NxRV2MzkaUSFjf3ykdnWIxfuswwXoDyd0ZR8uzwfcLk0GCAOoLKpzMCzWtVe+xJVTrzt
 DVloIXt4IbnW2y2jIPhj2t3gxNEDosiBGKWEHlgIvTAHL4YNdraDmKEnxfAtBI2xxT8s
 oYE+ZokaxxX/MCrTkb/hI2tHF8Zn2NQw/uosAqk1FxHS6wOxgawz7y5U0aEpzWXJI5N4
 fBsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlT8UmhE0Fk8Ngy2mjtdaAVWLIyu9xJ4u0q6yb53tNsR6bGlGGEele5LzGkVmxSGAaPEo=@lists.linux.it
X-Gm-Message-State: AOJu0Yz70YrEkxTV3zf6zt1R5V20DOriv1rFrL8Z2185w7o3w5Mgi9i+
 k6mF1fjgZC+zJyj8A8RNNRG+I0VdQAMkixbDFB8jbc9sGtlmD7fJZ7CxCXX4VREEqL0=
X-Gm-Gg: AZuq6aKceRWMc8vlLjkdeKFvVmbbcYrdrx/48ot5f6BBAKMavLwqH+RIOLvWeQmjHCB
 ktfa5f4qLz6ZGLG/L18CsiFzfXhHC6mvGJmxS5Hj38ftCMRL4VJwMCG/U652WIyZphbTC0epgf5
 +S7CN3IQ4DcE7GKO4Z8YUf3T7MTh4siey6vzh4lnRO5SMMbk6faNMNXWETzCRIE4y3CBL7ZuyXT
 bjo9HaJBoTqNwqX647WEdyZPADLo9gDBXFFP9WRjht2NEFa55sYau6rOfTfVugyBC/7dmFCeDX6
 Dq0TpD7fceQnJPu+tDcNjgaZnh5oh9JVcfoYkYG6RdO2m1ZagHTKO6FhdZJbbajSIojc4Qi16ae
 5rViGv7+nZs8NUAz9EMj1b2Ax++58tnb4fiayQGs0P+SIo2ZthJ8I0oPiQqSwnjjzWco+Wi5ldX
 A4TxeUOSR2fc7vgJv4vsfdLhfwSgLoRC0=
X-Received: by 2002:a17:907:3e14:b0:b87:685a:31f3 with SMTP id
 a640c23a62f3a-b8f92c660femr72385366b.52.1770883936167; 
 Thu, 12 Feb 2026 00:12:16 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8f6ecadb32sm138161666b.64.2026.02.12.00.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:12:15 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 12 Feb 2026 09:12:15 +0100
Message-Id: <DGCTYOV3F3RT.1KY4KO5LAC8O5@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260212080323.137459-1-pvorel@suse.cz>
In-Reply-To: <20260212080323.137459-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/requirements.txt: Add setuptools
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I already sent a patch yesterday afternoon and Cyril acked it. I was
waiting to see the CI today morning for merging.

https://patchwork.ozlabs.org/project/ltp/patch/20260211-fix_doc_build-v1-1-42897785e0c7@suse.com/

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
