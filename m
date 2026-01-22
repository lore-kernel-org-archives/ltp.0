Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E960BC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769081205; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bREHy72F2u7yJcTDa/wkUqrpermibqIZBuRoflTU6BY=;
 b=W4QA1OLuxv2Pym8ktzdnPkp70oeDuuysGUXV1z+vHepnNBDik65/2CTaygIS7CD/g6vYL
 c+uP8HbnOklkwhLnQDL00slRn/g60uDPVvQbvQzjpDhF3594nVbk6oa7nL6afVFcNOXTdR6
 UH9bjDqfeH+N5aaXA9HheyOyTsdEVTE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80AF53CB3F0
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:26:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEBDC3C1B59
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 12:26:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26134600A5F
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 12:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eV3NG5qflPd6t3N0Hm1RnirkqKHXr0TvtWFDO9l9vSo=;
 b=KldNBV7UfHXfzvfov2YDEhcZSAykyBJgCJe5Hi8nEDX9bZ+sNxIqNB25Ya2wtwNo5CIW40
 ZZ44UDL5HuMFfvpjXZErhfm9yqv9OLvgjWNYI9Mm7gJea34Q2d4Mud9HOrf9IkZ7zcjHEu
 XMirEpx9OmMiy2jtk3doQDQlbZYsg7M=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Gq4CIJUZOgifqY1diXv-QQ-1; Thu, 22 Jan 2026 06:26:18 -0500
X-MC-Unique: Gq4CIJUZOgifqY1diXv-QQ-1
X-Mimecast-MFC-AGG-ID: Gq4CIJUZOgifqY1diXv-QQ_1769081178
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b708fa4093so1841416eec.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 03:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769081176; x=1769685976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV3NG5qflPd6t3N0Hm1RnirkqKHXr0TvtWFDO9l9vSo=;
 b=wy3Kl5rBF4R0OY7V314CoisfEZMPqbyMBs1hgjpJ1d6UW5EkbuUwDP9yvh09CNGM1F
 1w/XKk7zZnHtGy4FmwU8Jk1+TfAyAh3+IBxT/tqEUaHZa+v99uXFDEZj5EhYVyYVm5aP
 Lcb/zpqGZVjg4SE6gE+TYcqxh3tc1GbD3rUaNpkm2BfPdyVZKzTWHWVokTlY772khHRd
 yAfOhlhwZI1rI1jqcpbsJZSvABUmUs6ewxRrL5dTLL1DaXf+o3+gbCkBgV5GYaaugNWI
 UdH6MaRiL8qXMs/2itH7Ixys0RSTq/Axmvye/47AxflThS6xNxgRhC0iVMT1bn8fDg1d
 Xkmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjqUF9zaiMxy2PRHtN7dSYCX4l+6gSohKTMKdHx4fz67jnrvFqzEzphpdL3RoLZ7Uihls=@lists.linux.it
X-Gm-Message-State: AOJu0YzHzbCVLwWXSH1QLAWNFLmvDNQwXgBOQQyumOuRg6+kVSL7xhh8
 VKVvBeSqTnHzh78/mSz4kISrVRp9DIXatQ6rR85kZD6IZYpzbjNdBvL1hfpLyopCYC/qiiKHgbt
 Z64ESJ+62iYu1oBKTNkSYGUmm6k6qYf2MTcxdpflq/ZSm6fCSkvKkdVaDfTgDi7BsmhFK7pqv/O
 EJje6P+wAdAn5bodhnypY6g/d9oDVFcjrmGM9M1A==
X-Gm-Gg: AZuq6aLf3q3goVa7LWpb+QveDbIJdEmSK5FWlGuTcbej5e04EBC+W91NjkVExjfN52V
 j0fceOn+5n5dP9aeyiQSa1TPd3wTT8L8pfUS5jfD3wkNtNEkcWJ/uxjdYPJWVFEid9yBWMsdkse
 rJGunn8P+YDfh3CuP7aV+RbFiqggZnsvqkRQmN2LVcvayBHWarsHssJr3WVOwqirswLXk=
X-Received: by 2002:a05:7300:5391:b0:2b7:1abc:a6d2 with SMTP id
 5a478bee46e88-2b71abca948mr2695278eec.20.1769081176116; 
 Thu, 22 Jan 2026 03:26:16 -0800 (PST)
X-Received: by 2002:a05:7300:5391:b0:2b7:1abc:a6d2 with SMTP id
 5a478bee46e88-2b71abca948mr2695267eec.20.1769081175750; Thu, 22 Jan 2026
 03:26:15 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan> <20260116072020.GB556902@pevik>
 <CAASaF6xyVVTFtLHcyicMZsmiBhiq5f16d-nhHTfLw3Nis_TKPg@mail.gmail.com>
In-Reply-To: <CAASaF6xyVVTFtLHcyicMZsmiBhiq5f16d-nhHTfLw3Nis_TKPg@mail.gmail.com>
Date: Thu, 22 Jan 2026 19:26:04 +0800
X-Gm-Features: AZwV_QhFeclS8dgzgyqEwB9FanFL1DqXZLrc1smlpFoxUOrtWQEUX4AKm5K2B_s
Message-ID: <CAEemH2cVjrLmAQRJOf9gAC5epUkbtviR72zKK+PdyCTPQ+93Qg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DbQnppK4ceQwfXKelU3EP5xxFp_qmUHSTlPHOaAmCvg_1769081178
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>,
 Liu Jian <liujian56@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

These two issues were discovered during pre-release testing
and should be resolved:

https://lists.linux.it/pipermail/ltp/2026-January/046231.html
https://lists.linux.it/pipermail/ltp/2026-January/046238.html

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
