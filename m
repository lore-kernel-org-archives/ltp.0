Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1CC5DF9D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787818015; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ewbzEbEXOMiSp3/XxWnA3r2kipyvy2SrqSTrByxaLvk=;
 b=ArijxfC9DJU0CtA/RfvZt1cXCXNasMItBPpble/eGqMKa22QjULwYGoTIKqS02UPg3tgV
 4jmEyJ+E9p0Sam9SfmlpeGrQDad33RTm177bxIvqNR/X87Uny29QqUnOAHKK1qeA9CjjBg6
 inkl2qyqFmdSZFYfDcoyvHT+AiUMgI0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002F83D0FB7
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:06:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 796E13CF2A2
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:06:34 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E026B1000933
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:06:32 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1358961f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787817992; x=1788422792; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YfT4UvdWE/FqFJI1ErLnamCkcSMt/ymge6lQWWYvJGo=;
 b=L+aR/HGIXqrpErR0cYDG0YsAI3rWVjRGnsGWJZL1x34MMzrMc/cZ8/R1dOLG8yVFcU
 kOh49hTB4zvNTG0jOIWF73YAZExx9zeSgpkp9O78M7LLdiV1d4URsD0vmnBOvpO5RHRg
 p8m3VDnhtBV4DygKy7yyBJujjLJW4q/+L6gUkHRweh4hbqPoCo17FQlvpjvIf5blSeAY
 BGHMYLscNSIy7p1BtjK4IRsK96KrYFWsiglxtgJzVLbyyrfgvg4LY8Ijatai3ln0qPYu
 SoNNIfH0U6Mu+wMqfdEzaANWneqY+WE6oXRQLJ01ejdrlfrLYcxZ594dROUqSD+QiUkV
 FxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787817992; x=1788422792;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YfT4UvdWE/FqFJI1ErLnamCkcSMt/ymge6lQWWYvJGo=;
 b=Vf/vRajy9sLOOIDCUjmCOxxVt1bk06ygTDkHq5MuJ0hFZSTZ0IL9JUOBIlCQ0TVuQY
 jF9bmsB7sYkvKPiz+SSUuF4QNIbpASg+FbZW4TlHilqLpLgi/Ig7cCGRS2rVrW0GhLL4
 5FJBG0WSso9Zb0g+Bl8/MTBMypWJSs2t+jz/sMVtxOs1LSk8q9YJBvp8p0v1RJ1R2c6D
 CRwLsQHrERyjk53JTZ1uWELxjWg+jAUDn9qgSIfMDzC4fcVySy1Jpu5eCGuDmYiMfbm4
 TR630ff3PtVFMyc7NdbFmyadfZKnYJDRtk0K0UZsdhnmOi6qQgeeuhNJKDJDXKkEcA7U
 Os3Q==
X-Gm-Message-State: AFuF++kY8Dtc8C9s2Bn+4PuQo/iKAmTRdByHj436GpzK6JWOkOFFuYH+
 E8NCgaNBXxrnn6fkAohcH943LtWPEki0Q+iSbGH9jBBLOCKcEx5hbbGaJw7MncX3JnQHGEHtv0t
 r/MznACSCSg==
X-Gm-Gg: AR+sD11VhVvqUC9G8mNJS9JP8SkgxboN4aGlOvwqJcVwBTw8U//5Bfm7fEnEwhHekIZ
 dUPpuswc8h7CtwBWn4iPuAihwzaJZYZq95dOQg1YxkO0893JL5Rguo0FB1LTSYqGHr7deFBATYu
 i+VBRuUolnc49MajAAIjbxuFaUI4Ra3JpgUNsH5HQ1lOAVkIFtmeWEAsSgWHKQfu4gB6mTAPumV
 TSgpu1uhFR/w6xzUJS6HRkZXxmTJa46UAt02y1aVedp8+DgYm0+MsYQYTMJ5nHKAPQnIyItN1OC
 p+EgMhSOkADWoUjsI8kqX3rAHetOJcD+ht4Mx4h57KdBM7FABoQOn+uI3VyspbB5AfLT7u4UMiJ
 f/5vcQrGW/rPc0lnIzl7trWGq6DbjRGqpix3q+FlwTENkNYZ8w4PO85XQN9LBDSya91wBfv/Tu3
 P84/3O66MJFOJpISNI/tEPugqQVUPeA2Gt22TUoG1NVVsV11kokCZqdy1N1O1RB14pO0VMDDLMn
 P4pk9OIFHG1Pf5fsIqdkSbXoxzVtzF1vvvHLKEeO7YRuR75iSwyqz/y+7rRVyJ7UdYuSN3tTBwN
 jYXFWQ==
X-Received: by 2002:adf:e002:0:10b0:482:e1ce:d45c with SMTP id
 ffacd0b85a97d-482e26fbe90mr12819303f8f.21.1787817992222; 
 Thu, 27 Aug 2026 01:06:32 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f854dsm7065532f8f.36.2026.08.27.01.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:06:31 -0700 (PDT)
Message-ID: <6a8ff007.b1f9e4c6.15919c.5636@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <ao7sDiRA4JguwRUl@autotest-wegao.qe.prg2.suse.org>
Date: Thu, 27 Aug 2026 08:06:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I guess "need to do things by hand" includes totally removing the hard
> sleep time; currently, I have no good solution (as I mentioned in previous
> comments, memory.reclaim is not an option).

yes, basically we re-implement some sort of OOM-killer/memory.reclaim
inside the code, instead of using them directly. That means we need to
disable OOM killer, loop over the current swap status and eventually
raise an error if after N iterations pages are not swapped.

But I feel it's not deterministic because on a really slow device we
might run out of iterations. I still think memory.reclaim is the best
choice for v2 in this case, because it will wait until a certain amount
of memory has been reclaimed and eventually raise an error.

@Cyril do you have any idea on how to proceed here?	

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
