Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474A01125839
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773239242; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=NcypZwk1vS5NhGJB5ivjzkNFN8p51FdGn+1n78r0Udk=;
 b=TWYYAXWDAK28N0r+2FJ9F0H4bQPst+VlRIB2VS+1W9Uy/6zmj/syTDymNmf0PEOOFJ/kU
 tpqKPMSoCVxHNeJ6d3I5M5juuiSo43I2uitU54EXFufEKmwx1Jz1DqIsM6gdRLV1A/c3ZiJ
 ia+oiW2DTwWBWD+C/seTocb0F+koFWM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20413E491F
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 15:27:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C37393E27A6
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 15:26:58 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03AD91000234
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 15:26:57 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439baf33150so943948f8f.0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773239217; x=1773844017; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:to:from:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=odz8rQ7TMIzDu5zFWcLKA0tyt4TOvtW5QIaapDJ2/BU=;
 b=ajMvpgY5N6zBZ73XuIwVgnDiH92m5eQre27j/nwoeNpCYBmo58MGNS4PGmbT9vi/aG
 JOfaepJSLAC4nRLiK07pKeWVxLwz7ul2p/sSG7r6VkYRnnJCg+731RhXnqpuCUhALYGw
 sgAzcboElnfrWCjZDl5pz4qdSx0tPKEcdKcSw1eGStq1YQhmaAUCYDqwnaIO18FdEij0
 vVKnzHKRbaxVnGWn6Z988CgBiaFfkM32GeFnhlB7QF2zn1A+8pDmEDzb6Q46ukjy80ui
 kOgFGAFJNBjhLERKxZexXOQwaH3dPgmrM+Owg5kSE5PAHP9cRuIMe5Yj2wjeYvOAO2za
 0UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773239217; x=1773844017;
 h=date:content-transfer-encoding:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=odz8rQ7TMIzDu5zFWcLKA0tyt4TOvtW5QIaapDJ2/BU=;
 b=nkECuJOt841hKd9TnXgkRhQrBwn8BRHYMnniJkpW6AEfN8vmHmRrN1zYs8azZ6Smy3
 uH0wSQtD+ruzRERsSyz3lBHu8JgvZESBWny463YB0zw11XBzgaQWYWrk1IsWqT+r3hkM
 dNIy3X2JyKsSFI+yfBzruhebVcliVCE8dzZ0dqY7ezbKqrehdksLrPPVvjTO0VZdvko/
 o42zTfcbehKzRVB8OLTuTpcjtcu+VBxYc9IA5rWujDX7C7kGCPe0BCQjxVva2qOrxLfy
 xHzm5Mv5W/xyKRCMb3/IJA9ceTd5ec5YaXJhPH2nVnCoz7/Mx5SOhj17GPntQD1m9sY2
 rz8w==
X-Gm-Message-State: AOJu0Yx6iR4EybFVmfhMzvWTt5MDdHL28g/CT1hl58rRKyjslH7pBPJY
 7XJcbQZWjilbwsb9Ike0HrvDkB9bAxFUEXZC6DI5YHUFiqKqZhbaT95TJecu++G2G41vdEqRPzT
 WJlhw
X-Gm-Gg: ATEYQzz3RbfmpXjG/MlOcnJF3i0xJYvzcPND7Kwsw66jXg8lkDzRIWpoVh6eAupsBKj
 /TEZhxy6bzmuYuZzxIt4nAAgu2M+/fAdXliYAhJefmZZ/5P8oP/ljUhym4KOvBMN6/a5+MkQSCt
 BHUZZFdLNE0Yyb/wE1OWDB+kU5TcRDrM1rxYWlrxHaCTTDXsf0xz17Oyb8FpeWpIG6E7GNL4Nlc
 wduXj85GFEiqByYqF3eeQQ3GwOdNgK1c/bBl7/1uIlMk6xSFS8X2hpLunlDzDxt6BD8e0eQcRVI
 uI4hRWuCcHLTOlJYTR+YMk3zIns93ftFI8m5rxz7SRdcPKEossRvmhiL9lD6jfhU5fcTDAfr4XM
 SQ97h4Z3q7o1qly6gLPDUJPXajEXqxq240g/dDzzbFPZNTdIblgyqEctMlKCeV5bZqEjeFB2AAA
 9A+nJysWc67iULND808sLIYM3GLsefe12/mIbVxreT
X-Received: by 2002:a05:6000:1a8b:b0:439:b704:f684 with SMTP id
 ffacd0b85a97d-439f8b5db0amr5085337f8f.0.1773239216900; 
 Wed, 11 Mar 2026 07:26:56 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81fcd65sm7527842f8f.26.2026.03.11.07.26.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:26:56 -0700 (PDT)
Message-ID: <69b17bb0.df0a0220.20bfea.42ca@mx.google.com>
To: ltp@lists.linux.it
Date: Wed, 11 Mar 2026 14:26:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP - After Release February 2026 Meeting
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP
meeting.

As previously discussed.

Next meeting it's supposed to be on the 16th of February 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
