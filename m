Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F71C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786105507; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=e/qSPpJj1+P/HCT7FQ8BB1jBbafN5u/EEaMM9qXU4UQ=;
 b=ZSmdzt4YBsexEM7ni7dKyZ/wSmzvG9mHphxxzoPkdX9PuNfLyow2TXzCVXrA4Zp2WxiKZ
 0MEIweLvlLDpddwa4xgEUJD+wxq1k9ecjy1R1f4KjCTPm7VGfUoZ51E44VjocyIGddRwVRz
 Do3CjR9VWBERgIZLduEA2uCmUz4ZEv4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E4D3E7008
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:25:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759F13C713B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:24:47 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FB29200B71
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:24:46 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so27213575e9.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786105486; x=1786710286; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D89w5HDTvk1+QkD4O7OHSvKT61EK/m9YO4VYzMyEiQ0=;
 b=CmwjbkAzG8k0T8yxXlRJ9juWtVweOy94S0ah01JzScJ+LOVudy17+52rOODJFWQLtW
 wFxrta+d6YSBhepDJxplrYDxPJLddwK6mS/Bhhj1YvKSRhke/pWSY2Q3PlD6EpOzEJGE
 VWFZm3TcT9I75zjpxNQDATiHhETJ9N2wEc57fg5kR6Lt2hHwx5aes232mZzSGpaUrGKQ
 UNjCiqOtE02dgdbWQ/XrvwN41H/vkmCS5bJwpYJX8h3srK7O1E9lpogSkvoobQk9tTNi
 PpJA8sopxtLew2RHXvEI95HIjyJt+QXrFwa6lDNa+JpYYt37wd9DmLfFb9Yi1+OfyZAK
 AC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786105486; x=1786710286;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D89w5HDTvk1+QkD4O7OHSvKT61EK/m9YO4VYzMyEiQ0=;
 b=pJ3EXibA9vTcP1wuJH/G5pvO0OS1mwk/n61/SYp13KcI2BKY5+NqR6rLMnzuugTavX
 bFZNJEgvjnLvc2dvg63One6fLWhQZkXQwZtp0Tq/fquurnNMNOLJ2hWR19JdLnM6uz1+
 n8iQik9oYyOPhNB7RRbtDXWkZEJAYmm2LhSrZMEHLW0hlpn0fkwDCoiJ6UjeDpZyB4N2
 uMYY3aj5Zxn1cBdVG/Q2Iau13ep3YUK0S9/bCo4/X4E8bKAs/W897wfnFTJU9ZnjL63Q
 m5muSCCkR9dM3ENkd5ldw344HdC7LumxSi+bJ1+AG07JM/LinBDYtSQfmyiFQu6OHFuI
 YaGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM+hwHYBQp+3fl7naUhcLwTyC3ZfIsard+n6fd05NpWaHd2k6wAOxR5uRWSmTfTEvo+Ts=@lists.linux.it
X-Gm-Message-State: AOJu0YyzbuX/ScqYynM36rTpRXn0i6MqXSn1yJhzJsg/EvQfRHqOYipa
 mSRddB00l2bzHqBWbDeq4ChV6tSj14eBkvbJZ7O4yZ/OV9SMyzdDartfCH9nPj5kXyI=
X-Gm-Gg: AR+sD1026SNgAK6c4QhcRNFPs14e1brrOBwNUT5Gqq0hEjU2dOtFfolCe8loQFAs4ky
 1sOiQZ3e/xEN0aVYqPLcYOabBF4SipEsqzf8qOzAVqWZgRg8sLPQ0cWaQQLkgwQYFRdZu2Gr1RA
 Q8Hofiwgzv1n6AAvbgCQbApF0yG/ZCsLDM+bzodPAUioMugBcoNASe8viGiz/IczGEHCvOkvqG0
 9AVOceE8BTALsS3kd2Zm0vrFiqFDF8hCCQ1I/Amzj2QyqsrduqwKztfKWg5XK0o2tl4wLtjzq2t
 3p4Xfqjb6YdldBsT+7ZvPfBelSFHHuq2gney/BIffHN2Ywg0UWy8k39IxvpYqX/YEkFw69SvSMp
 Ch+0kSLJgPUqJp8TJCYarjFxlSw5YulsjkqeeYhkH200AllmL9AgpuVxSIyBRzcp6sGQFl2tEXf
 MpjelqRxcBiRZyztfWdVYNWAvIyIAdVxJB7+mY8VPIKDEIo7kkfCour1nN8Ns2I5Vxoo7p
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id
 5b1f17b1804b1-4994e7d21fdmr269861775e9.16.1786105485923; 
 Fri, 07 Aug 2026 05:24:45 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.110.28])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995428f294sm145607435e9.15.2026.08.07.05.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:24:45 -0700 (PDT)
Message-ID: <6a75ce8d.deaaa24b.14dcda.45d3@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anWQedSd9MwlSymD@yuki.lan>
Date: Fri, 07 Aug 2026 12:24:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] mremap04: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I sent a new version of the patch-set where there's a nw test
covering the memory remap with release gap. Try to take a look
if it's ok.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
