Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F2FCA0FFD
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756722547; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=rNSatSqRBfXOJ5b3Y7X0C0tRaGZQ/3jX9/wIebH5Wjw=;
 b=SYx5sl8Wmhxw82sUah6LGp78US9dZNutyHFTjf/6yDbE7YiOARL/OT05jqBe7lfl4Xnlq
 5Z70nwfyP0nCo8xDthzBlZ0u27oZ7e+0TAXRlB1KuIIph3+7yHujH1zC9fM8ygVA6+RjVP9
 NtSu/gvjJ95rn72/zIePRHtfRnvkHWs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D984F3CD2BC
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 12:29:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 308C93CD1D1
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 12:28:47 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B07610002AF
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 12:28:46 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so138165466b.3
 for <ltp@lists.linux.it>; Mon, 01 Sep 2025 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756722526; x=1757327326; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NabhGWuqH6x6pinxqldUjpdXJbxe3nVwJktl1izeu2M=;
 b=KF19N3iUU49CJiUVe8c4jbfJLU3JZE6VzHDMIwsPyyqLD0p5bM4nJr+Xkr64c8YcrP
 7HCwTWmrHv4TOT0V2SVb8ZI0ix8zAKZVGD/dgOnVnSNoj6HKnNTJmQzN5d0AuRGGUO9A
 WAxQ+EqorsYtHUmDvWF/7jWIcNBCnaiQo/5bV71FqxSwuFvxhpktJdk8Yxm44qbwLVUf
 F8UczjizBb97/W7bOYEBQ0lMFKD3jxg7z7SawkyhciNNrSbEu9XXZf8AaLb75QvVbVwW
 +bWB0nxcPwadkj3YO4fLfr2Bb/wEVIUZa87JTYgfGz2tIpZSABuup+8ABuOM34hs8PU/
 ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756722526; x=1757327326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NabhGWuqH6x6pinxqldUjpdXJbxe3nVwJktl1izeu2M=;
 b=LhPeTShxF+H4JtrhboPoQyPZ1vDlRHdbskHASz9nGIlYfG4NpYXZG65ug3yBANL23h
 JNHtbawL715m/fPe8nYQNaknUJfhoPiK64XGOmi3ZK3CgWbRAu8AkOfyj2VzOWHZMJtE
 veqimQ3jtyYTxDElsdbVtV32tQo2LjBP7PJxOLXk5uhQjD3ycDCXPMYJ43CtrSvtAonk
 qmh13CHRlSSOyrT9zp5rY00a/WGXyAJJGOaP1ZtSHmXeWL1SDcMxltPTEtzMQ8znCaN0
 urwDsD+wX+lw8lLl9b/dMYFdEOiyaVTt/SZdENP5+DiOXU5WeLRINDyHW2ck8ZB7q75r
 zkrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjgaPKKKrkEf7QpcHbXExkK38Fwd9l9OAV8GobS+bEz1AFrGA2N64QDagqSm6tZHAOY1Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwLXW2q1JO1fUICmJhc87RuoGU6C8IFGVvH7WkIEIo7J+hix4Kn
 ZUSwd+nMg/kuFJoXWFMAJcyS1dp67UKO9ukFZXi1y1sQBVzQO80DcICNjbpHHwr4EZ4=
X-Gm-Gg: ASbGnct4aGn7IBqxMrumzQXl/W3HAC98ckilHv/caCPLQWUxZopep8YzUBw6RxPcmY5
 uG5FHxS5OCOKSobJZzl10c0XcYCo4suU54t+FN4vz7BAK5kE+UsyHf6YRTZrpGeVx2ZRm/CPIg7
 GwT8KQYtFeC2mc4cRqwZLvKujtCyID77HjGAZVtVuarzF/JqUZL9TfzSDkSPZSXxIOZ25MkfcYO
 Arm1OeXZZskZvUdbLGyUdrMsuK0DEwDBlz78BKDpWJvuWDFCXchULHxiX2cHlbcldt+n6XSnKFp
 CcurwHdJv4Z6U5tzwx09Nr//S7UaPCVy2MKycoauUtIvBR6Rtf6Mixzdq1Zr415CQJ88P7RojGJ
 uZfAaLfG8yyZMDF+9SDzdk4ZyZZXFXOUXO3H+phlfu0hw4R2hIk9EdNZBzO179ScQHz137xkDz7
 sIp4zYfw==
X-Google-Smtp-Source: AGHT+IGlEdutMEIVWhx6BYNY97NTu9ffbUPw42Oor4xmbWXAoCeY6pYGZnJ6USYDVectBTIAV5tNrw==
X-Received: by 2002:a17:907:7250:b0:b04:35c3:40b3 with SMTP id
 a640c23a62f3a-b0435c3438amr177810366b.15.1756722525931; 
 Mon, 01 Sep 2025 03:28:45 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff08b86833sm748283466b.48.2025.09.01.03.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 03:28:45 -0700 (PDT)
Message-ID: <738b08ed-beeb-4fe1-8438-803cf18c6c69@suse.com>
Date: Mon, 1 Sep 2025 12:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
 <aLDhgFRA8ppAmYlH@localhost> <aLFzZ6xGsZh3CO64@yuki.lan>
 <9f626db7-5bf0-4376-8b4a-a643569f41ab@suse.com> <aLGjXEcSFhzqLiUd@rei.lan>
Content-Language: en-US
In-Reply-To: <aLGjXEcSFhzqLiUd@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 8/29/25 2:55 PM, Cyril Hrubis wrote:
> And does it work correctly on kernels older than 6.15? I do not see any
> checks for the open_tree_attr() syscall availability.

We discussed time ago that we prefer to have a tst_syscall() TCONF 
caused by missing syscall, rather than checking that syscall is present 
all the times via autoconf.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
