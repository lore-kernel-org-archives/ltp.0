Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0C3C3DA7F
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721990155; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=1qMWxQBumpOEYCnu1NylhEQ4a2hO9kxKFUv+l16rr8g=;
 b=oojOzJckkZjLuvmgL0TG9FFMKNdiYzTOGYPrzSuWTNH9TTh+csDKCEO0lhus81zENA3RU
 tCx8Gk+ABKIvo53Tp01o4laTYvaPm+Jr8H9jL//a6on9A6NrouG1/JOksNCWR8zzTIbWsfI
 Mvh9UMcE1IXa7MSU1Cd2P9Lt6IxcTeg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC94D3D1C67
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 12:35:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EB93C0350
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 12:35:33 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 87F1E609699
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 12:35:32 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5afa207b8bfso158411a12.0
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721990132; x=1722594932; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGgzgBzlJKYiVn0zp7l2gzhB2+Yn+5h2/SLPHLi3MwM=;
 b=PrI8P0CdvDXVyTkXcqlXn/X7hhbY9gR6XmNxrciYFUq2PQG6IRHzjfCHPtG+6xOLSN
 9kt3tdlroB+M/JS2VyUprOuL/FIKX8+RhDPdcIV+1OxSBIPOAbvcYq5+KHnQZrNCr2EU
 AaTAD+0PH2SDNN8t6yTrVbGuHcZYb23M4GuIEa6JFuZC9IKzYWJigT343PBvEnYqfEoG
 t5+g30GupSMrBwQM8JcoIM2xTr07gSUrcTTgJg2FKl48QThitL76ghcVMZSQWN2i271+
 GBOkRokDwwUjeHbgi3Up7RyU0eLgxJt9x3QnTOaTk+CviGLlVYPyjgkUzT3ajll4nMOX
 a8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721990132; x=1722594932;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gGgzgBzlJKYiVn0zp7l2gzhB2+Yn+5h2/SLPHLi3MwM=;
 b=Eehzed+Q0J1iJO2fZ4GJnLEyLH0px8hR0PN0dDmbix3prufYIjgBC3YQI5/FkUPhNa
 zpjaMa4+nfOzEzEuyy11g5ZCQROlB2Hpcw7EYRprqZ30qxpyj1AGannv0pDag1GpqJpI
 nOz7PtOai1O3xGlX5afxO7JP5AoyGumJTZFpDLg34QjnKLa58TSYrL7ij5GYM1t/K8Zm
 X/CTO7xTUT/qIn3K44QrfwAwKMjh/UedyNygqDTsj8nNTWthGavY8xB43OZoocznD5Af
 VwTXz+YAeK50HVgulfswVOeNCIoGspVi7OEenzRd2WkMp72218K2313UPXxbVrE81ML5
 BAaw==
X-Gm-Message-State: AOJu0Ywc7mxMJyh1wV4d29mFFvzMs4Cnu3QIzMkaER+5p01pnnpqGYeU
 /Kg8GCe6YL/ZPf5a4V/+r+Kj7q6A5MiFTkA1VRyX7+uxd16S3O+2OKY5+RpeynM4DzoV86EP+Ov
 x
X-Google-Smtp-Source: AGHT+IGpRTGGbZ32Gx5jeMlYSYcbw5kPRjAVuJ8EcC4RuDIVu/z5JKqwU7uPFoQdA4/RHNuQ7i6y+g==
X-Received: by 2002:a50:aa94:0:b0:5a7:464a:ab9 with SMTP id
 4fb4d7f45d1cf-5ac629fbf1amr2978090a12.21.1721990131271; 
 Fri, 26 Jul 2024 03:35:31 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590e7esm1730853a12.36.2024.07.26.03.35.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 03:35:31 -0700 (PDT)
Message-ID: <2a6d16a7-0d43-496a-a6c1-579b9e751254@suse.com>
Date: Fri, 26 Jul 2024 12:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] kirk can be now installed via pip
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKa2lyaywgb3VyIG9mZmljaWFsIExUUCBydW5uZXIsIGlzIG5vdyBhdmFpbGFibGUg
aW4gcHlwaS5vcmdbMV0gYW5kIGl0IApjYW4gYmUgaW5zdGFsbGVkIHZpYSBwaXAgY29tbWFuZDoK
CiDCoMKgwqAgcGlwIGluc3RhbGwga2lyawoKSGF2ZSBmdW4hCgoKQmVzdCByZWdhcmRzLApBbmRy
ZWEgQ2VydmVzYXRvCgpbMV0gaHR0cHM6Ly9weXBpLm9yZy9wcm9qZWN0L2tpcmsvCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
