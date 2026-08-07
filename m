Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63631C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786083818; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=D0t+hz8X5b5kHUTcGKYMbwPebn7Gw7V4hW3BLq3/UxE=;
 b=VnPGd4c0q9l+LNxuQNcmNKmMc4wJRD4kmMkiyuNFTcDvoq9zl4s0sE/4uEswGF78oKD+j
 M5xth71fQwkWVfQQRghTSPLaR73/ffcsNlAZX3OUUKilFwJhQVp3ltfM3pRYZY59bOYIexc
 PmdZLWQ8L785uFeayunnLU9FfxPJzk4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 684913E2C2E
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:23:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DE813E2443
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:23:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2350910009E3
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:23:17 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso19110825e9.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786083796; x=1786688596; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pQbGTQxd0NGghEJlmeFGNJuZZj0CVMzK+enjeip0SRU=;
 b=DOawb/O8YD9AHMyrKpkP5h1PjaVL8PnkHdYOHeTmyh4ORHUy3MIwOujl0MZBShKCZ4
 uPLBi3Kd/+RC37cfIFGXRjvIh/HeWJVGeMohxdUGZnLrC4Q/BhUWWFLIVgZBiD7Y8D4j
 Mm6Ox/wMr/cgW8XXEgdJnA2nhbFGNEb+RWOL1XIat3+krp61BKDh1MwhZ9I8D1QXlRNI
 DznBuVGqGiuTeIwMYA6GuSaZpis+LYthwX7RdDDgLupfAZzK/vVRfGl05dgWaUzLFsLg
 ChtQ5ZNS8T2UdMK3x34rXL438v56fP5cmRZx2t+zRSvVdufmqeDcinCP+4j8q0EvVmoC
 0yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786083796; x=1786688596;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQbGTQxd0NGghEJlmeFGNJuZZj0CVMzK+enjeip0SRU=;
 b=pOHGaNufhmUPXlmmzWOLD0fHLrlbuzZyvN97GFlqnF/oA7/O9JMdulShTQ8EkOukfr
 C0MBjhiSkEE/Odb0lToow0DpkJwWsLFpsWV3ZGyzEDp6H+Q3VIfMuPaOQkmxm8LA3jOG
 QcUZnwNOEL7FfeZQE50DQZeC5zW3MwxbszLbqNXirKXoWqs5Ix51U6HhMZ0KFWrrFZcp
 S630lh3gAjan1iyTJJXShsXuaiyyQlymlHixwoNSKQ2MpIoyKUkBztcPYg6l7aFQzbC+
 oocqSILdoVuEQ3yhsgvni1kqIOTCBTqA5q+YnocZpCnrFGg/CurhUlpbxglLm0FFbd7Y
 P/Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXcRZEChX8MNjx6y2Wq4c8o+XWUahL9Wl8VqhDarzUfD8MVfT/p3Foyy5s0qc8K3YDT40=@lists.linux.it
X-Gm-Message-State: AOJu0YyIHlx+7he7qujg+y0PH0cf8FPANZ5ZtGRU3EYdZyUvQ6PGkH4i
 eeYj9e2/eHt0BeLPgp4y4OOAm0H+SAJdrjaa+IjkH+3XwKTgNwwIYM42/yeMzk/GOSlyrFn/Jgk
 evQ6JtiRUTw==
X-Gm-Gg: AR+sD11lFXbnzSLabBTFv5hU+pzDudqPAuCZS4VHkfrlmetbAhdSf2Sp1kRu9r+/4kV
 gtNq7nrWt33+EyOA44qt4Szd7nSd5PlUZO0h9Nt7nR8TcFGXmJMD/17xAfIBHxup8aB1vhagcDT
 xDtLmVzeU3hoSYdPD3/1uhXzOmwjx2Hn7ILWMJHAKg979JV4buCGO+ycwLXVclidOq2L9xr0i2c
 uuGn6N8g6votEJtqgf6rsUn4QxEnhsj7jyJ33EmbHWtflW74vu8W5K/5l9dYOpKSTy8m4egoitr
 FIgV6zNJQRtwgnC2UlHNF63+IwrY4d2kp0C203BOrKVZWZlhREs0niaS4HCOWSekbIyJtNy4ap3
 Lb8TimJdmWWl4PB5RFr02kZt17w9irOFFxG2VAD06TmmN1T1D2je96Q6uXD/McY/nwIweAqkc2Q
 KCvtywGKZwC4NDefpgHd5YhQpGlX2VfgbBWZeVbS0gAG+phAHvQTf9iaM7J7gtNrq3tv/eENvt+
 10Lujk=
X-Received: by 2002:a05:600c:37c9:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4994e6eacc1mr293753595e9.0.1786083796511; 
 Thu, 06 Aug 2026 23:23:16 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.110.28])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9a4803sm9094255e9.0.2026.08.06.23.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 23:23:16 -0700 (PDT)
Message-ID: <6a7579d4.5dfca4bd.124bf4.ac84@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anSMBJKH8bjhJcs5@rei>
Date: Fri, 07 Aug 2026 06:23:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

Hi Cyril,

> > +	 * Pass old_size of one page while the segment is two pages: the
> > +	 * mismatch is intentional and must be preserved.
> >  	 */
> 
> Wouldn't this be enough for the mremap() to fail even with regular
> mmap()? I do not see what the test needs the sysv shm for.

actually yes, but I think the original idea was to mix SysV with mremap()
syscall.

> 
> Also the interaction between SysV shm and mremap() seems to be more
> complicated and may warrant more tests.

mmmh, any idea?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
