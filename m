Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6F7C2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 05:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786080912; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ScdbJT9s+bItfceNpBA/QvUokbJI3NFFM+v7nOYJvGI=;
 b=NmINFh2m9LN1O0DmBSZnLfVfXgYjEejWrMLFEMMFkyNvlb+Gs7xfRMHkxZx+4nl6RR0/0
 n+LOllcyUozOb0gCVvJTzhD3d1cpqV6ZynX1iyYVEinCSNEkg/MrrJimluitKy40ngn3z3C
 VZOXshGpf0Ho6Ej0Yldf6rXUyIeT7l4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAEF53E2449
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 07:35:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B738F3E138E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 07:34:51 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12B4E600BDB
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 07:34:51 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1940407f8f.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 22:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786080890; x=1786685690; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x2acQjmnuumYwz9b1jrEEchBqsJjvaKqs8dsCiX+9Bg=;
 b=A+C5sy9ptXnBlYMIkHjSb4Gggyo6kmOv4ra/C4OeVfa6pjFp8sFEWDDzCl7YxZe4Je
 3MKSBidnxS9F0p6v4jjGnwAhicvTUTqHsDDr6HT6ym/Kw5wDnh0ylfqtZfTkzZV68MNu
 vxU1dC7xStSEroqrnSMLfHa8n5d04MW5O8ygEbieuxBDiul7nrYmmNJzDyTI8faal9f7
 Lng+GGt07FwXcN/SM3AYWSSIgcIcyKjWFbKTkj87zxb4wBE24KBcDbh/63fGn2Hj6sWt
 mDlbjPB+DpFnwkR2CRAZwXa0J6PgyOQ7Hat7h6UHKcGTgWYraAplQRNtIeH5UIlYi4wX
 EOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080890; x=1786685690;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x2acQjmnuumYwz9b1jrEEchBqsJjvaKqs8dsCiX+9Bg=;
 b=ogkzpGtcELSDbS/I/GL+qI9bHIjEMqBRlAWCOqS+LaBYVDC7mq+th7px2DPIssVfwg
 3hHmENr4zW+eG5QueFlBCp3oKQhngt7ZWQUDxnGgBElu95d3NNOdLEzZ3wBqGt3Oa5Go
 066ZtnN7WluSaUMdAZd5hIa6KLJ2dYL4AEYpjSZNKxTQkO01JvDIqYyyT0HNpQgJz7qd
 GvKUXZ5O7STlVRMEUn7Wb5/9nHIAuYnkQuz10RlepeuMnCGbfO1bbDbfGWSoz0LYfS4j
 RUymtXDTA09Ijus3kQdGv5Axbi5klgVW3zXxffIh+0aUO32rHF8x279mfqHhucNEVUH4
 D97w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqodAbdCtYP2J5KIFf3PllACuYtuoNYL0vTN5o5A8gYEoIueP2Wk+Hyo7fMtC/qP5oikzQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzK6X2QQK55mh5G4Ynlg3eAtud/65lUyJBjGlc2X5dYLeDaNVa0
 XidJPFxy2qJlA/tNOAfe6wmcj3upismbb2gv0k1OqmVMGJDFUFevECijgL3I5cCSNvc=
X-Gm-Gg: AR+sD10lg2CDHATgmWl2MAdaz1l1txKWJ3VCgNRUarnmzpSeWPoi6P7WF7DfubDzAtx
 +vTVZsg3WtJpI4jVuAUcjt2J5SNw3IHPb5eA/hSs6bHfQEBI7riwAPno+p9+udJfLshXGHXBrkH
 vagre0K9XMX987iErnAo51xLOxfe18pl92VIuOhXhr3dn6VJK2bVY6Zrhoop0XrOhNFUjt3s1f2
 log2fCBDeT5AJ6r1Rky0OegAJrc5loF2G/qran6blIPFRzNv/FOR6ywY3Pd83OUkG+whrNnTDRd
 7+mLBU+PELLPwzJnQ81rTS7Au99qtxHAvxXDcsZ4BWl8YpmoyB8AeQj7kqS0V5y6mY8cUVFXFte
 DemY4YT6BKeyPkxYGBYvgaRuClA58QAtJ1rnEu37S3dMWu2p8h1uyW7UCvFaEJyOlSnSh1gpC+V
 qwv9DtOjzACsmA9S30XdbZdyDkfP3JWAiaC5phv7CsfleSmxnzmzacpAC/4eQvpfmgZrOy
X-Received: by 2002:a05:6000:1787:b0:47f:8802:c182 with SMTP id
 ffacd0b85a97d-47fec63cdd1mr30493843f8f.29.1786080890460; 
 Thu, 06 Aug 2026 22:34:50 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.110.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021457ebsm2311088f8f.6.2026.08.06.22.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:34:50 -0700 (PDT)
Message-ID: <6a756e7a.cc089686.309364.c33e@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <anVWjUOj6Oi5sBbz@linux.dev>
Date: Fri, 07 Aug 2026 05:34:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/functional: fix memcg_failcnt intermittent timeout
 by disabling swap
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
Cc: Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Fair point that ignoring the return status defeats the purpose. But I'd
> rather not TBROK on a swapoff failure, that's an environment limitation,
> not a test failure. Especially swapoff here is an enhancement but not
> a hard requirement for this test.

I agree.

> That is a bit over-engineering.
> 
> If an inactive fstab entry gets activated by swapon -a, that arguably
> points to a misconfigured test host rather than something this test
> should work around.

And also here. Unfortunately we don't have enough data for shell tests,
so AI agent is not really working well in there..

Honestly I don't know how to fix this but adding more examples which
we don't have..

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
