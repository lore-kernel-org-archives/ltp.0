Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0876FD73093
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775187560; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nZdFtNre+ceMWUP/yNdy2CJWQ3uWQQD6Y4GHOIkArAQ=;
 b=h9gOCaS1a7EcSgJPb3yXcZo3lNSKe4KsybNJdL2QF8lFacJ4RRE4a/Uh4yg/E2FFedzqf
 i+uduCrGV0Cvt0I6I6bQf6o769lwVW91O9NaXc0wSRAroIMFENAGgNYxzqN69FaINyZWES2
 moeoCBY5Mb7kyN7/w2D1YoehTtBHCjU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAD673CA01A
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:39:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B949B3E2389
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:38:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 708EE601B25
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775187531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCEw7O0JuQWN2+kSAxV2MWknOZPENZ6keNa4Qp2Drfk=;
 b=Vc2GMf3hda6R0phVEJSg1IXvKiPS8DUbuwRDNJeN8DOzCpycns+e92EyofNviaKmXYE4DD
 OsoTBBeXwHht67jpYCEKx8NuwYtXIccHh+Rxu8aTSZg1m0Lw8i7Al37KlLxUY/1GrZCNJV
 pjtvApH5n7rQd46o1Kpk21TLzCCmMQo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-ZvFKNntNO8yDP7fR6UnZsQ-1; Thu, 02 Apr 2026 23:38:50 -0400
X-MC-Unique: ZvFKNntNO8yDP7fR6UnZsQ-1
X-Mimecast-MFC-AGG-ID: ZvFKNntNO8yDP7fR6UnZsQ_1775187529
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358f058973fso1599514a91.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775187529; x=1775792329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCEw7O0JuQWN2+kSAxV2MWknOZPENZ6keNa4Qp2Drfk=;
 b=PrXa+dvlgwNOhm6g1uNUFZc+Qa/tw0DcPAOx21PwWFKMKvuYfOoV5AylBInl5S7oRC
 l7iOnPeRhRsLLh+mQLaIaKfby8DkHxziIWsZM6sLn9ThjUjhP6S2bdVROTtFufo9O9iM
 TXWvV7lHSAip+87322KNrUlI2Dlk3qrX5LBi46TDpi2Z9CQc7e6cnUp4YxbYckNvD+3p
 Pun4WJY7/mgHORx/6Zk0G7JIVN5yUnPtRtYlNAicxUcsMLOftMje15ryyjBpLmmk4STV
 jtkwzBIEoKnRXdKpqNSKgc4DCpieZ4nXy4fYZjfuUfcw8f34wzyrXSYx0/XLU3lrH2+B
 I8jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS77eXHDBghcr/aSmTEH/FohaENx+JNxKtM7cdpS+Wu3bKWATPCY2oZmD+j9rFrUNlH60=@lists.linux.it
X-Gm-Message-State: AOJu0YyYVYJwXZIYsLpRCHQFfP09RkxoCQJ5NHg/zyN9EVN2+/89zZIj
 ISQPel2yq+bVcfVe7bKXH+b/nzRmS1QczdY0v0ZKJySvL5Pd/3EDJqWytBk0tjzbiI2ox8LdduP
 YXWe7Xtar7tScUrSeGf58JeJb1IqoIqJimVR5rJD06I3V5p+mnf9I
X-Gm-Gg: AeBDiet2hv/R7tqX+7sXnhekTVS3ene+YbQCtV7b4+nMMDTR+mPPx18B1TM2IYn8Lmk
 KypfFYxZXHyfvX/qF9q2dasZ+Pu8BcYsJ5hxEWc/tSL45rsU1HRF29VsNt0zq9V1VsfQ6YsRbgn
 irjK933NcOiGJ18BiImdjd660WElvx9l0/5K1X7PBLrksYIyXb9k+qolLeuBEApkIZyfAGvZAUf
 FoFq977GhiOgqa8E7WRTyKx+sgQWoSm6Da1GBqMAr87VlWmjEKiEgDJfrqY37AhcnbScuy0hBsF
 ++VtZGj4QH/ANJ1t/UR783SA690nz01x0KHE0XMvRMCqWEZTg5m1Vpb+gJTj9ajkJA7Qz+m9by4
 KAu28J9YmzL173xZb2Q==
X-Received: by 2002:a17:90b:52c7:b0:359:8dfd:64c8 with SMTP id
 98e67ed59e1d1-35de69702cdmr1044726a91.24.1775187528859; 
 Thu, 02 Apr 2026 20:38:48 -0700 (PDT)
X-Received: by 2002:a17:90b:52c7:b0:359:8dfd:64c8 with SMTP id
 98e67ed59e1d1-35de69702cdmr1044706a91.24.1775187528392; 
 Thu, 02 Apr 2026 20:38:48 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm327125a91.4.2026.04.02.20.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 20:38:47 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:38:45 +0800
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <ac82RcLOw_VAN0oy@redhat.com>
References: <20260331200026.244979-1-japo@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260331200026.244979-1-japo@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iUagbXvIh_5auJ-IfJl2eI66OOxpTJVghlPWo7W1Gyc_1775187529
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 31, 2026 at 10:00:26PM +0200, Jan Polensky wrote:
> Introduce .editorconfig to keep indentation and whitespace consistent across
> editors, preventing accidental reformatting and noisy diffs.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Woo! I replied to the wrong post, but I didn't say anything wrong.
This patch is also very good.

I would leave Petr or Andrea to merge it.
Anyway:

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
