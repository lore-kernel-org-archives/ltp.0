Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4560EFC72A8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 06:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774248817; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IyhEf9+MdynShkoHXJBBfApnbKwZDmJ5qIHQVdhwX+4=;
 b=eni7E1aQQBmqtg9WrqXb87Muphk5O87WlsWspt/CMZvS2g/ouTXAO9moQ5q1NEGziUm5c
 d5Dr6THpFaZ0G11NalfncLyujUSFtptEO8G0K9vDuQSvcDoDwVjwLxOxiWoC2hh7q9hEy1Z
 oDz0MvHnYicPdDrSH5Z8HeOv3/LQ09c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCECC3E1FB5
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:53:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649F93C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:53:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBBC76007AC
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774248790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=Ch1E4LoL3/mc6NOBByJruJCfgEhV1kNc3qx2LNf7c96uF7h+S2RfFf0mJPIvc4Sn3q7nbb
 1Jsj//300nIcVmF3OPYNnsiw30ViS7LVwexIIIebo0hGjRR6RY1ElLHLKPRUG1rhdStq8m
 8UrGOnt63xT9J8sZ1Qe6o/HH5SD4rtU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-LO5qjaSaM02MbWB3bVBmZw-1; Mon, 23 Mar 2026 02:53:09 -0400
X-MC-Unique: LO5qjaSaM02MbWB3bVBmZw-1
X-Mimecast-MFC-AGG-ID: LO5qjaSaM02MbWB3bVBmZw_1774248788
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b08025f240so36890475ad.1
 for <ltp@lists.linux.it>; Sun, 22 Mar 2026 23:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774248787; x=1774853587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=pI+f3xuzQoYXV1kapZIAUIEVH3iLa/9Wu4ZTkziYWh+mlGaoOEbc9If4aqvxr0lQ8W
 b2PeDH54vr/NOihxtUv96t5dM3YTEBMjSDpS+3i00thJyK9Huih12fOFNFadhDqKRP4p
 LBPYhI6JyHXOuFgZi054LvqRIqiB7OiX1jmLuXCnfbyLYc6oE+k4yabqmPnFp1s3risk
 anxd+az1s9KMDIJ/60T+uTEe0W2RmPfx0QLxUZHhw4ndO4no6KmH6FKkYADwuxaBXFUX
 kqyO1EYQndyK1XvxpAZBNCmEnnMZvEDJ12RDIeBTMTVMN/9B+Bjd1TEe+McSiebCIrLs
 YVow==
X-Gm-Message-State: AOJu0YxnCUOcyf/Nu2HhYV6dImYyFIGLSG6aIZvknU7UinxSomEAYCUT
 opSypIwOWYuDcOyC7pKxENKIRjeYwNpA4kFUa2FUvgZH8eat9XW8S7gZG+PfCTO8vkIduQX3LXc
 hSkOMxzCHDeXYIkxZeYkvBs3VQzha2Cs+I4bvArFK4vgCXBSeBJDcEOUJKHFu
X-Gm-Gg: ATEYQzwmBdAjUZ/T9hexx/w9bj/wf3JVgf9/bRmh7XLX+CObkW8S7VXtnTAEBjNUpVY
 +Zj0arPVvdqSNuNWCIOTDxx7TL1MUgtYGUKmLGIMeNJLk97lJpoilPIpxXzkU21EanayH/CPYu+
 4mi1TATpZR4d1qUf4eFbRVChuXsNZ15i/To75jUs7P2DJ6c29WMga4UMcODUJlI+bk94V62ZwgA
 ITAq/tOH84yQZgPKYO73Y1xQE+BG80Tt1bcviEwnqR6jE2wq7MgWKDRgwZbrfsdfZVxh44sAJHs
 XVpvM7z5ZZODlP6MtZbXmLcNEGXNaMV1/2ZFZ6XiYeXUC9wK9RfSrHzgIXWgKfD3tNXU7rgS/Di
 J+toCW/cC4q/gGQ0RJQ==
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id
 d9443c01a7336-2b0827bd48fmr98716565ad.16.1774248787239; 
 Sun, 22 Mar 2026 23:53:07 -0700 (PDT)
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id
 d9443c01a7336-2b0827bd48fmr98716435ad.16.1774248786881; 
 Sun, 22 Mar 2026 23:53:06 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083527f90sm95902235ad.19.2026.03.22.23.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 23:53:06 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:53:04 +0800
To: Chris Wailes <chriswailes@google.com>
Message-ID: <acDjUF75Q8jlEE2H@redhat.com>
References: <20260320183907.117127-1-chriswailes@google.com>
MIME-Version: 1.0
In-Reply-To: <20260320183907.117127-1-chriswailes@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QzYSJQskKtsvZplcWUMu08thpFzVCJ7bPJ1SrxcP3oI_1774248788
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Update clone3 wrapper signature
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

Patch merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
