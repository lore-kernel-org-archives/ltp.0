Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB9CFF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777362881; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HyZd6Es2ZllT+tWOII91Z9SNRz/weajIWW2hl/p4xS0=;
 b=hr7+Ftmm+Bag2sDtQi7VyzUWdiZG+6a/Lj30TK3oStvvDkN8Z8E0IJxCYFrh28OEd9/RV
 /kgalte1Uv1wj117jJCVB9M5G3tsD/sWoat8JVfpVNE5HPavkcbTCpADWbvAwHYdsrylIJI
 QTscRhYZAUICJQ+cX55ZCLWhdUz34GQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFAE63CA104
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:54:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7212A3CA104
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:54:17 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D04EF600959
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:54:16 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso5426402f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777362856; x=1777967656; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=YoqjIPzEQvK4eRiA9G9u6TAXOUQUkl4eEo1CAd65ZdBqHiZ62nXOmwbkxtbsv62T5L
 OJRQJCP1eZjBK/VX8TmrPjeTVVhhYPVJW5GhD2Jc337R7UkG2nMsCv6NhnE5aFj7817B
 vmIsusR1BuyEqZ7BVfGE3bpfpty7975CWSdhCSpPDtevrVBwfNHUBTcZPFPVX7A/IbFD
 gRl2ZhtsqOUIgCVwsXXMUD55xsI4y/7quu0SRj4RHrMBqDg8OM86Y+kkRkZLNelHb1iW
 pbjBGRvbNr3eQ5EwA+yLgsrcZ8MduiG9NXyI0DD8+o1PlGPBVt1MQCaz8NSHEu19Zs0g
 9z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362856; x=1777967656;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=Sbm4DLQAEHBbV6QlQLsAz14vjSctA+D7KptAqVLgRw7vIGvgB76jjia8fEFwEDepTJ
 oRqzjjcv05HiFt/XlXQTG6oTB0JNpEb3YvTNg4fQVJeZI0tVFp4VcmmEqBLLlysIFuTm
 A61GJQlzRLiCYgaLeWspkrmu/SiS3sqr9chF9270CvKUHQlB2ZRr/sousnJBm/I7NFWK
 7+ssZxgH5nsiyCrLWIkCFQLTzuV91u0Ac6TDNgfcgOT6c9Qt4MkjeC2zb0COgldcZdXa
 2GDMPms4D01SUYirZFVirorSS+iP9aeubfZQzRqEZrC/uf4klJrBaJAoGHFfzmpkky6M
 3Yeg==
X-Gm-Message-State: AOJu0YyE+J9dgpwpo4U+TZV2dGTH3jYrNJALLQ20W4NpbSIETZHDr2uI
 StDnF4S90OIOEtuhrimwtm8l+SlCGWlFjOdgsbFjF1qu7iUYoVMnrsImjp1Hy+EkwYM6jPcUIfg
 Wnkfr8zk=
X-Gm-Gg: AeBDiesj9SXsWHaK3FXr3Fa5cbZ/gTEypBCXtsuU7KsQ2kICQl1vEbQNViPbtlz8lyU
 A8dMeIANMMT8kqgVy0um4iFZCGnMrB0oT2JVF4JLM5w+lyDqVeECZbNHq1nl5O+VzFoMKv2Vn5P
 NDfDgfUyt0N+Ru18Tv39kOjcUMK+jCkvT69MgjdQko1ZMngC4SuGRenXRgoeVtjLPNCrQnwyh5J
 WI18ATdTtQq85XGqV1s3qLZWQyBU2asEKNCFTKheGOemLJy713BT2mevOycPKUs3J3jgP37y3t4
 bXAT8RUv0ZpQK3xx0gT3FfJRGoXTgQy/MN6JRQuwU1gfXJ66SUwwyI3nm+fDcwQauiagG3bg0KG
 uqDq8Awsd8iJtpi5YJfsSMI0gq1PoGZVzwH8jVl14Jf1XhQUsu+Wi5EpIjsauLXc/Q9phSJqoNP
 asTl5rf/YtLCBsDbVw47BrYvnx2OvqqVvDgt859B2j6va/6on/2i6W
X-Received: by 2002:a5d:5d0f:0:b0:43d:7b90:fa23 with SMTP id
 ffacd0b85a97d-4464a447024mr3682422f8f.29.1777362856177; 
 Tue, 28 Apr 2026 00:54:16 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d404f8esm3692453f8f.14.2026.04.28.00.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:54:15 -0700 (PDT)
Message-ID: <69f067a7.050a0220.248b92.0914@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-7-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:54:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] syscalls: Add epoll_wait11
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
