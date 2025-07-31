Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E8EC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753981778; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4ugx6Tu10JLRhFbZyr7nwoi8FruHgawajcVupFbKKN0=;
 b=D8g2hm+Qd6IQiBwy0ED9lveYhvwHrZJlwj9XnTp6qQ6iZPEi5c4efo37pq7afntU9C4rk
 BM0c3CjX+hP5ntcKZ5uVHI4XK8ubcwp6JW+eZZiE/A6xhUzPgQkK3pN8Mwqbfy4p3KO1IFE
 JQIyHFAhqFBT43YYhPIilx4M9dRTl8o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C4253CC209
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 19:09:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2BAC3CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:09:18 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B231600749
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:09:18 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so825223f8f.3
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753981757; x=1754586557; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=GuH1lTH6wyHPlAzEmjvLLtyt6lkXDAyy8oWsqz3khszZzSwgtAbJmKu2T+c0V0guUh
 MwiS4y/olSgY4ym8ELmwVSskq8/N1TnlOad55DpBaHKTe9LdOE+aIJj3+FOqBNNzF5IE
 yXuvKeFUa8hgDoVBo9cu3++pP771tTPjPjOWPek3Vcv5sqdRR0qnETm9ojMv8YUZpZJK
 Kx6dM13bK6EVazdRcD8CLNTbvNU9XrGG9JVSs6wHyBUeianw+yvrRX/8mOBVhnv7eNyK
 fYh0L5WrA90fUOcLQf5rg/oKmWp9NG9rSOatlSSJjA+q+pHYUobYqtBGelKys5fnzTJ9
 IIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753981757; x=1754586557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=Es+uonS7kcFjxg/jC/+PI5S1XM1v2MvmwcdUA8BL3Eb2Or1xVZ/EptMK6gQ9pyqwaX
 yHkEdkspnebXsgo/z4GvCbofJqvn2TQu4kx9L6DMXJN8OgfxeL/kHnskDaG348WttV9o
 WN/PWZFOTeSFsF6sBFNKizWbjDi9UogYqMtm5OmWZaqjdXihan0gsrKWVGrYkpD19VTN
 ekD0iPL2+S8zVGVwEBja2N9FZ6DL2HlXempOTxUZcUIWKlBl3S8JzJFjKeG/SuJ5116b
 P95yDjUeGo9fYHW/vNKNdrFANW1H9e2tSG/eF76wAZkaCRxag1WNgBKLJhRsnP0KHFA5
 B8Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg9Zf9ql1CvtIudB+BJBNsuaKPScR7gvO5bA0+YPQUg3RlNNvehZmuPmxW5gEcTFECy48=@lists.linux.it
X-Gm-Message-State: AOJu0YwQHFD/jWHXWnp75m0NHRVESmPbfHAovcqdCEI1zyXAy9MgeOuB
 +2eJpO8xxG2QSRjfS85Bg9Y+Fpr4DUc0deh0g/f+ivW25VGyJ8r/Z7ATvETTFrcb6rM=
X-Gm-Gg: ASbGncuU1ODQr2YUzS8G096n3NDgri3X5eAekcZVEeiHkhP9xth1CgsIX+sZRKSH1sW
 S/UR0pUSPMKy96BLCaNSlfD1uZQkRnr5bgE6N37Rc8kgT1MRApn6r24hhuFI4IfCbzuqAQtKrT2
 1vPKrBVSgvVOsFcyDLJ2l6IbVLvt0uDnoNFPoTEKjVer6+SdQwEFH1Vi3c5vqWtlgW5gIN1aAPW
 LzDtNcP0v+weXc/vH8zv5OjXeN1QHwNhRPDkXRzrr0tdngjBIZccPQKaDHGepHnp+ikUYEQN6N8
 qOc5P2vlo5pKQ0KN47ednLp9L0eVetHmz4dDQPnAS8Z2mee5+1h66Eg4CtHUmUQwfRP4bcZrwyU
 00QcPawNRRhfYX/F0C7woCzsMmhIMx4zrg6TouCwRKBx6
X-Google-Smtp-Source: AGHT+IHAOvTozTdx+Jy9ZdiZ4vP3SaKhEv6uCh7r68scLSpWGJmES6K9YOOsfdPcs/U//ubR5rim1Q==
X-Received: by 2002:a05:6000:2481:b0:3b8:bb8b:6b05 with SMTP id
 ffacd0b85a97d-3b8bb8b6deemr1903369f8f.29.1753981757550; 
 Thu, 31 Jul 2025 10:09:17 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b77ecc4sm1987260a12.4.2025.07.31.10.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 10:09:16 -0700 (PDT)
Message-ID: <160da84f-f7d5-40b5-996d-513ca2a971b0@suse.com>
Date: Thu, 31 Jul 2025 19:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250731143358.1035685-1-wegao@suse.com>
 <20250801002918.1751299-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250801002918.1751299-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mount08.c: Check EACCES error when test under
 selinux enabled in enforce mode
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
