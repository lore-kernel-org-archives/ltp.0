Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5752D73090
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775186765; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+XakUSs4QIcl1pTfCfXn4Xisnl1K5yJPbb21bip3OdY=;
 b=U9rEZ5XMIRGRp0ezNP6pf0Jie4F9bSPD+agV0ZsVC/q0TJYP6xH+PCDVvGoQFx45/rz0l
 /9i1rmq3RtB3g0CzaBNz5GZgU2AxDLhUhbmSFKKhLY46/NxqUY0hRTwGc4zdN2yyvEoIY+N
 T0+aoXSvBH8Mn5tnoB5NN9qmTJGQLQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853883E2389
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:26:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854A63E2389
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:25:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7155D1001582
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775186735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syGoEQtXboS/gWfeUtp2zEgJW7tfT+HKhasZ0Iyi7UM=;
 b=EWYHy8HK3OthdKkQ6CLaSiWMDB4pyQVSU406evyw2nrZg5YX4jJJzva4GusdDHEkOhw/0U
 ZL+b5jzxC7DlRyas19AbgD4rOQkrVgA2YYakvx0uM3wFs05wUOgu14+VsVZeN+TggMDzoF
 OvtQdBkp0mfzMGVVEIqVs2TuP6FrW1U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-SoGHECC1MZip2KQPqlXfzQ-1; Thu, 02 Apr 2026 23:25:34 -0400
X-MC-Unique: SoGHECC1MZip2KQPqlXfzQ-1
X-Mimecast-MFC-AGG-ID: SoGHECC1MZip2KQPqlXfzQ_1775186733
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82ce0c07d0cso1008263b3a.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775186732; x=1775791532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syGoEQtXboS/gWfeUtp2zEgJW7tfT+HKhasZ0Iyi7UM=;
 b=Py/Tp1K+h33Fvoalg6NNopoGvNqm/HfZjZNwdkhVqoOcCDWZ7AnMeEClHypW8Gz2CC
 T71eDklZavkfb2Duinr54XWDFZrjeMLbdHE6O5/WAZqQSBDRD4SUINeNc7XP4mkMZbXA
 Q/dE6LksEEoLMbW5jHUFJ+sRZvkKaau90oQEmZou2HFrpBfflniYigxfYL42A5m4f7nO
 +OqoQXFUAgcKFzx28DeWSMTH3kp4w7Z3mvL02zfylJl8cQM0vQ75uhk1hsqGbHxr1pxv
 HfN4Q+7apwZGKcC1L7NHK3VlSbDmzluGmOvpy0wUA8H6b2l2mxviGZX7lwJaqO9I17Xb
 wdXw==
X-Gm-Message-State: AOJu0Yxtfl7sf9WndHirAxwwe5I1ISKxTUte2BV7c4ltATT6NlkSzeRR
 QggZRYt6W4lQtbFpvBGwu81YwigsPhc1/zsEyL9FN3h13DPolswbVn48/av9eIMdLZ68zRSo+xp
 wmyEWjZFaLxgGd9oAtX1oTlOM/sg/eAFyXL/aDpdg5D0SP2x/rnYpf3ixL3kd
X-Gm-Gg: ATEYQzzeZZImr+yKE3I6TAKbzSlrKJWMc8Ke9fDvuWgujSZGUFIXVlcPE2q5KWQj2/I
 mGnxtXsgKD4DtJVgOm7o3ww7UZOGRhP6h7866F/T3327cIry40g0neth/Sj0oYP1rQa4lS9l1cA
 //oHlu/DGuk8LEaolyZXtR+aIgng0a3ACNqwz6Xlir1dFLcRPUSbYp81s205sqMG7tC3C1YRBoZ
 Z+lZ4o5Hij1SULEvIt5rLbcUTNGxIZEcN8B/0vAmGWErxC4sqbMt3HAHIQ65FeCP3h9ClYNGxTS
 YNzCQRxMEMp1SpeaZPZRU/E2M24L56N/wrJWc2bkIlNOdqoC4qs5HD+BLaPR0DI6kekhTW7hQjH
 +TVNd056PlxXiZKNOCQ==
X-Received: by 2002:a05:6a00:3cd3:b0:82c:e60c:f376 with SMTP id
 d2e1a72fcca58-82d0dbbcc8cmr1474259b3a.47.1775186732593; 
 Thu, 02 Apr 2026 20:25:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd3:b0:82c:e60c:f376 with SMTP id
 d2e1a72fcca58-82d0dbbcc8cmr1474233b3a.47.1775186732105; 
 Thu, 02 Apr 2026 20:25:32 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2443dsm5816109b3a.4.2026.04.02.20.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 20:25:31 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:25:28 +0800
To: =?utf-8?B?4oCcU2FtaXI=?= <samir@linux.ibm.com>
Message-ID: <ac8zKFLP7QJlOjGy@redhat.com>
References: <20260401054146.99060-1-samir@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260401054146.99060-1-samir@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RLMNzBRShNbY-GPBwYRZXC4KW-8RtqWqbVfmdWf2TWY_1775186733
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] madvise09: Make memory map output conditional and
 more informative
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

Nice improvement, patch merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
