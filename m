Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD84FEE6431
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 07:57:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4495D3CE678
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:57:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB5673CE681
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 09:56:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B5A6600330
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 09:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694764607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xdfD9/8uTOOUxl2nq+g+dGrm6s8tmeDc+epf8vuyM0=;
 b=WYibG7zR/H6obJWTGw0PDd4wBPON45gZvLP4CNmo182gWbAgenmM+vo6JScMoiSgS01m/a
 jrOrmECTPK+ESoncwqxJca9h6fqwEldKy/McMSoaaIsVBn9Wl7B0pUxp5eN4+pNXqygkq9
 iqivh5TJqDoyAegB4WJaavrblA8JAe0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-4Yn9RL49NTmDIZ-PyTw3ZQ-1; Fri, 15 Sep 2023 03:56:45 -0400
X-MC-Unique: 4Yn9RL49NTmDIZ-PyTw3ZQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-502d7ccdda3so2323823e87.3
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 00:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694764603; x=1695369403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xdfD9/8uTOOUxl2nq+g+dGrm6s8tmeDc+epf8vuyM0=;
 b=Cb7MORhoqUuzf/TwXdfvruApkEVhzqE9YUwMZ7i86/ZBOe1F3riSXICbW6DZyifbA3
 BAQGCLhZaD3YfXRd8ciY+ndDTmsxmKVJz5DPX+9PCpGthMkXN3j3prwOndkggeshKMo2
 fkJTKVEpJm2OeT1cPQPVW8ENq0TEiqPRzytX4XPLJwLymprBw5Xr3fANv9wK1Fmk02ft
 c5U2TpxpKhodJXdtzzFWd3sp+A6MHl04XvljnW/yL5jeemP4eJX8ct/EsJ5QKIPIYlXn
 zVUQv4ExpCUd59unSeVYSo1E0Vo9hdaZ8wLCfZR/jsFCKMSb3fbZW/fTKQ0Ri9qqvaZu
 ZntQ==
X-Gm-Message-State: AOJu0Yzlh4KvjsXttbTxGjNjTqiGCT1+Oml+4obSoxYYyIlDnUKS8B9Y
 MMm/e9NbX4sfsmSZBdZVcy3j89Ml9XfzRJnpzTTXGl7tPhsf7a6PD+G7v2qXmmQO404jLamSeZW
 cmmMsq7+Hdqv0Y2nPiI5vjF+2oitkKuv9cfzm9w==
X-Received: by 2002:a19:6d10:0:b0:500:9d6c:913e with SMTP id
 i16-20020a196d10000000b005009d6c913emr660595lfc.52.1694764603277; 
 Fri, 15 Sep 2023 00:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPGkTjGHzZ+7pp4x5tvbxtxMuhewruqAXlVnc6Jvd2ck7JdcAy4YgqX+LTyk4t6HithxPV0smnV+MiJspI/k0=
X-Received: by 2002:a19:6d10:0:b0:500:9d6c:913e with SMTP id
 i16-20020a196d10000000b005009d6c913emr660588lfc.52.1694764602895; Fri, 15 Sep
 2023 00:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230915060425.47337-1-shichen@redhat.com>
In-Reply-To: <20230915060425.47337-1-shichen@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Sep 2023 15:56:31 +0800
Message-ID: <CAEemH2cY_-ecfw-rJUfSn0iWq=JnYWZLP=MS7OvxXesW1TOVXA@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] numa01.sh: unset default cpuset awareness before
 verify physcpubind
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch applied, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
