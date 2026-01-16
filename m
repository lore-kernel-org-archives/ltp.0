Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A1BD4A5E2
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768531294; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=BNqpUF05Mnd5/tr/ARMSxKS+/wcqcRffPjCnkOViFV/g5Scx7zYjl9C0L7Dq5u49E33vf
 zWmJ8U4cef2AWgjUt+sAYTXLDe9dEe5wCNX4DNP1iE5xjOxyHIzKGu24CVD+F0s2rCKo2vt
 0dQoc1dMcBM6loBQAgLpRCsHU1SzGSg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 110633CA6BC
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 03:41:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A30303CA502
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:41:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 117E62005FD
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768531266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=T+nLsR7CkGd1b4mC0JHBrQ/inlpehejpEFD134wfU+VgBYqI0YaBW2d/kRLDE9FgffPrVz
 /7oD/BycUI4VHg/FJpe58X3mn83RaVdrRGfHyzo34FGlb1UYm5hNcdXKwgvKmbLyc6DxmW
 wnE7CwHahLcnzVnlhlvtTx8LCikfo24=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-SzMigkfCPzCOBmjIGlJ7NA-1; Thu, 15 Jan 2026 21:41:04 -0500
X-MC-Unique: SzMigkfCPzCOBmjIGlJ7NA-1
X-Mimecast-MFC-AGG-ID: SzMigkfCPzCOBmjIGlJ7NA_1768531263
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ae32686ed0so9919464eec.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 18:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768531263; x=1769136063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=aEEtBnObkWLYLqPOXLcNCRlSfFvIv+MXli5kKNsZ1JWnwN/HZBVBkH3EyFc/kSkjWp
 Rt294WxSBsHFDvtkVctn3OKP5/MiNRL2V5QvUjUgq/5wwDhtx/6TLO/gS5gWNccFHxis
 MJ1NsVSHO5ix4lLFvR/0T9689NtvoNC7spfziJ1G7qR9oUdJnht0Mv5AlLccycJ6JAFI
 hk4N2gUdLJodidFmd1XxMMIzMn/9WtJ0OcBGmkX4eoElrrCHErRjUiOMYbzAIkQkLnYJ
 RnxuxBk8+sIEu3yuaHtvHZC+xARm65lAAw+c5L5v2df2xc/f+4D3fVMTDa3tvzWH6SmN
 KRzg==
X-Gm-Message-State: AOJu0Yy2smSl+k9QladYSbLX4tVBhr5IE2/woGWLrEB/CiJJx+53oE5J
 pwYmF5UdrLXBSwxc0CznWt1DjARIRb4Kx0a7M2wx2aCU44c605wjH3X96kM0WqKn8W54SRxbXP6
 zEHCuTwIttEDhJkV7X6hzREjSpl0+IjSGJUp4QSinfrnyTF5meHZVRwKqFc2Rcq1Jkk4zI4Rfe6
 AfZWp97wzKeVRIBMqyKvrqk+Zt/8E=
X-Gm-Gg: AY/fxX6i28aWUf1OD514RIhZjmwUmPrBnlfMXrtKq8UZ1qqxP9vMqNbKRYpn96K1EBK
 CCysZ5qbiAVbNbdpOVaPUPvLJHLmIfJOwAiObxraFgBcMrsjZu2NIWIW9yUIXxYBHWdS7hECwAo
 Cuw7dYHmTAer4seXDP4qOfg1L5+JkDSVlcqQKvsKsX7ITgOagsNzF0WLSHiNFiH4wl318=
X-Received: by 2002:a05:7300:fd18:b0:2b0:542a:227d with SMTP id
 5a478bee46e88-2b6b3f21d9cmr1929186eec.2.1768531263368; 
 Thu, 15 Jan 2026 18:41:03 -0800 (PST)
X-Received: by 2002:a05:7300:fd18:b0:2b0:542a:227d with SMTP id
 5a478bee46e88-2b6b3f21d9cmr1929175eec.2.1768531263005; Thu, 15 Jan 2026
 18:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20260115153439.13337-1-chrubis@suse.cz>
 <20260115153439.13337-2-chrubis@suse.cz>
In-Reply-To: <20260115153439.13337-2-chrubis@suse.cz>
Date: Fri, 16 Jan 2026 10:40:50 +0800
X-Gm-Features: AZwV_QhZG1v9Z8yeeshEyAor6YqxXLi4gFDf5QDehAyuqpBmPJldemfmY_kMUBk
Message-ID: <CAEemH2d9guFY4R-HCvZRbnkvUBiuw4yL6yz7MBV4CbN9Ow=L=g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IPAnOQLhhKf7UckMZZr69erpqWDpKL60JDO1k-d62hw_1768531263
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc: Document process_state
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
