Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8EDC36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743502297; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/FDUvSl5Vv/8QwMEGpOQLMu9xmLuNS7v2935kI9mR4A=;
 b=K9fd9BbJPU63YTm7a+ta09Mg/ur4DMpdqTjXCINcW+KieJrU08071gZ+E0NZUKh/yRZRn
 8SQd7c9Ac8NahjwMsSQxRs9F9bQdBOkELzneYYRscS/9I7bHUN/XNqWtAxX9lNB0VklbRWU
 Jab/UQA+pv+uKVO62srdbODAnkwqL8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D22533CAFB0
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:11:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AEF83CAFB2
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:11:12 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E17910009A3
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743502268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9FUPNt5K1lDGmtauLfLXUf15SHwNYLAb0BNtGPhV2io=;
 b=TbQTRBk1U+SY/UhkG1xiylelY2GPNzdHslDnYlHMfCDOFdBbaTn/Mo2sdYfoJzVdz32qY6
 6hZ+86D40Xk9vpvdyz4sTz7dwc++hDrYSXHA73yIMIVOBIKTvunqgARxtCcK8rRcr0BC0M
 beRQUBQjm0XSIqAXnUZo0bS76yC7lco=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Umdxx48SPuWfSO5EoiPvRA-1; Tue, 01 Apr 2025 06:11:07 -0400
X-MC-Unique: Umdxx48SPuWfSO5EoiPvRA-1
X-Mimecast-MFC-AGG-ID: Umdxx48SPuWfSO5EoiPvRA_1743502266
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2254e500a73so72796415ad.0
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 03:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743502266; x=1744107066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9FUPNt5K1lDGmtauLfLXUf15SHwNYLAb0BNtGPhV2io=;
 b=Pi9Azsjitu+bi/z030nV4hK3Ldl9hoXbMtFdiq3uGg3vrJSsSFlUhVGDP9sVIYpsHX
 qtLZKYjCLGz0ZdryKSZgdje5B8zeG/8TdFBilusKFT+kV0NSOhlMt+aeAeBSy4Mswb7v
 sYCreamfrpnsCoPHeRlkGMlk1jV2eJNr00L9o+6mRv/poXiepfjJ02qiBQqVqZ5ISBw+
 8fTRkgoTQGSSh7rZqomPSTUqJB05xwxp2TfSoktpkNQqzsbgMeYUHqjiRNuZMKXgzPXo
 /b81hZIM0bP7Ufon7bebJGDlid/J/uWZdhuLCPztEQ8XK+pxIoDmvzp/nZ5yS1/Mw5ae
 RqUQ==
X-Gm-Message-State: AOJu0YxG9myJlESk4AXRZuHcWDqL5DzNCbZgd7AuCzQrHOH6exvwadf5
 TyHJMasQfPzbOhEsPkKAaRxOpBfKUpwm8HF5kQDCENy6z1PheXeGcIBJfHWyAdGc0NUshVxTA0R
 6N3zs9Hc3wvFvmC3ceGVix/oEu9gzIcZYOBz3pWH+RTDl+bOrp7THsAI+5mY6kzcEV9esAy6QQp
 /0wEtoGJwWKgBGTSWvBv25fCw=
X-Gm-Gg: ASbGncunUSsIpuRur+OJlDviWx6aYhJ/DWKyaF8ZF1kelbVxUT31UfP67b58g767TsW
 SHDPIyK+HKWM62CiEoVMlmC2/hZ2MiWKYJmZ45gJdCmbPyVZXzJbASK49I7FO8BEAVCVOPevslA
 ==
X-Received: by 2002:a17:902:ccc2:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-2295bea8412mr45032525ad.29.1743502266080; 
 Tue, 01 Apr 2025 03:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLL72EMP1AhpNmiOwq3qckt59SFczyCO2a0Fyd53bxr2N/+bIeRxEgXBcGTG7YG2EjV7LlwskVidtyHVgZ9hQ=
X-Received: by 2002:a17:902:ccc2:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-2295bea8412mr45032195ad.29.1743502265735; Tue, 01 Apr 2025
 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250401075909.3545483-1-18810879172@163.com>
In-Reply-To: <20250401075909.3545483-1-18810879172@163.com>
Date: Tue, 1 Apr 2025 18:10:53 +0800
X-Gm-Features: AQ5f1JopPeKw5qLOYUf1ww-VUwyWDttgwicuLlU305JXrzeO0R2KZUq44hUDWSk
Message-ID: <CAEemH2euLv6ZYf_kqojs4tjrR=FJQsnxeTotJgJoN0i8THQX9w@mail.gmail.com>
To: wangxuewen <18810879172@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vSXtckPV4MvDAwN8S6D46D2MwH5qL2EodtkhSFI3pD8_1743502266
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugemmap15: Add support for loongarch
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: wangxuewen <wangxuewen@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch applied, thanks.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
