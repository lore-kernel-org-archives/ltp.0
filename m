Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A730CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781691527; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BTmwFxlOy2CI5FTtLOGbp3Ta3NJt+TJ9T3hlmD8IRYQ=;
 b=k9zdVKlLlaEErgUOqQHpgwwXQX11f1ydnl+Fc0NRM7uI3bG2hvMvfCXV/q9lIcKCYNMvE
 AB0gPTVdybJobRGIzPUXZiVGWksGzZ+MWjix6CC4JZDwxJpWhOHCtur3jQZy1nOmkUnr5Zx
 WcQzADZBw9LQQdeVen8wTEWkd8u6xQM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B9973E5932
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 12:18:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72CDB3E1C49
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 12:18:28 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A488914001ED
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 12:18:27 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so490147f8f.3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781691507; x=1782296307; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vPLlOX1gCxhzF7KfwxXod1UVHDfoY7uLLda4mK+f0qA=;
 b=PcxVMzQMbiDmhqdKS12VZohJbxwHYvPEelJw+Ae2uOeozz3lw8aaza7kCcYXpYK6Jv
 2dVb6w3aIBM20TcZAuXy6y1vm6YGLvZtj/VAS5bvfMx2YW7muYE3TiYyBJzP2TT2YQBm
 EkAWtTu03WVRxJFbGnu02hq1qRN7eUkXcQsgeGqS4oSvGTAY7inm9Tqtvc389aFn/Fj1
 cq6aR5MUeMInmBWwLUUNtu/2W1b7rveyKgphCbDot0FAVx3OvVxHmpISXtEaX/TKg+3K
 nQB/bTkb7XZhEDlNz3BObWOFPYkDHvWgzppfSxnmThaK1+5Oh8NyKYrCgWxdIUqYzuNL
 fSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691507; x=1782296307;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPLlOX1gCxhzF7KfwxXod1UVHDfoY7uLLda4mK+f0qA=;
 b=DoJilSsmUE+2L9XIlWLJVKsu3jdZdZWK3ydX4lYX/9QZ0eNNhJif3a85zYKMmud8va
 o4+91PctX++6JHHx9C40Wnsnv2wu4/wbUhiUikbk/1o0i/5jG//+HjEiADs07mYb/VDU
 seZR70bb6kI41W3a8gzJ8fGWhCCUJPAB/va1SJROcC5+zgyv1M4qxTSmvWRQgETQ/MEb
 qcIwbJPE0qTmGQ9PR5xePmpapuitR5JpAfRnxLEv3baTQHsvoim7CjIvaVSKgmMpALtK
 S936COns0/5Q7UczSw3nSVW7m7d2HyaChaRLZUmeykDScU/FLeGeXXSEaaHNDMFifSP7
 4Eug==
X-Gm-Message-State: AOJu0Ywp9Ykv92tGpRKfVelUHzHDGG4z5kacES7iOxhVy+1ejwKnjEm5
 ROAd24/xoP6jBKFXLYUVCCt3RjcrNOoUhGeBRUJ/2Kj+hTk61rSxzBaTR4OORdDWWRE=
X-Gm-Gg: Acq92OH0X+YUFF7pbajMsWto/by5z8UySOWPY5q/pY1XUOc9Joidh++oQgFrn2sTScS
 Um4ni3H+9ykm25Ah7fHNsRfBobVzATZBScZqO/RNkDind5PNTAH2khuADe81Ry+IcJ0ebM+g0kq
 DVyJGgkq7RZKt3UJCRXPB9otwJCtNqDSQvJ4GEk2LcNN+5c25IJo7zsfaZ48AySAdV8n+uaDlkf
 uEUmNnMh3Q9TDAhT+pKyhiy2/V9T9NU6dGWGuXjHz5LKmXfLW5MWt/5UgwLxxEijyRpshYxfflk
 0rEiFedg6OvoT8vWY+ScmehKfnJHEh8CaskpIw9rD9RYsnyFju5ZWk8ag0ASJB2tXOvgHQ9HKo1
 n41wyXX4r1YmZYvc8evzXt8GcnTFPcoz3TF+S+RHRy4sU9hkdJLNEwOE/I5nTV1jorewtzZC5qr
 2FIrn1qEoYmReehYcbKlp6fg8zrGOWGs5PNWu+C8WPHfWj6BRhYDGlIHaxhKgH7Vl/k4nv8SZKz
 ssHuI5G7zAT9Q2ySsu9VBehJscn/jupFAqWbZoTzp3CGzMU6och3YhToL/y13DyOZg=
X-Received: by 2002:a05:600c:c3cf:20b0:490:bf1a:ed04 with SMTP id
 5b1f17b1804b1-492333ea3f3mr40360645e9.1.1781691506970; 
 Wed, 17 Jun 2026 03:18:26 -0700 (PDT)
Received: from p200300ef2f13eb00c15f82d9757402d3.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm52128536f8f.3.2026.06.17.03.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:18:26 -0700 (PDT)
Message-ID: <6a327472.fc4d66b3.38d513.36ee@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
Date: Wed, 17 Jun 2026 10:18:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in
 cgroup_drain()
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

Merged, Thanks!

With suggested @Cyril TINFO message on ESRCH.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
