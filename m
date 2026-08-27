Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F9AC5DF9D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787819095; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=28mI2nazffByV/NvRpZ7hzKCgB2Hnljx3vodf15S5ho=;
 b=qUBEwz8gVR6pdi4JNCVh2FBCvM8K3i8QvHDz4tRn8xuBJr2H1UZdYiWBlUf6zN6VKNDLz
 55B3qKIi2hhYnmfjBPG5rr80PeZcBNV5G064RaVkjiNMP2Cpn2UTqCY4m6pCAXIIlRZiQmA
 i7RCxHBpkoMcQEVSqA7edOTdB82Ohgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FBB63CF2A2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:24:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557263C0E10
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:24:35 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D9FB1A002D9
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:24:34 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so965160f8f.3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787819074; x=1788423874; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tRTOXsAfrSPjAEGkNpKqbJHcEyTji+W0e4TM+0ihxKE=;
 b=f9ZGpuabl4liIa+T4EzzCE9blU9Tx4SU4bTElgUxSTWgfQMV19VJdJSf5mlPbc6vah
 NtwTS+hKa7FBCq2FBVg8k1ksVYqxJGexjlcXEjGWoCxiXA1TBgZXZE09/u1k1Z0sIPSM
 VfBlXm72ZnfFu9F9sNnYpxYTP/2mKyTXInrg11N5Eodlp8k/LYzJ4Aqp33ueQq+lZpKU
 H8UhG/6nW9ONCi/VlU/92Faem9imfXoB//qiKw5a23gc2n4GlDVg3y5tpe5Kb5ppS5uA
 K+1C8SKkCreGYr71uswkNCQefkevq1Egp018r2Skwd4jpgtsPLX+ICXtwttB6TWTTIH3
 F7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819074; x=1788423874;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tRTOXsAfrSPjAEGkNpKqbJHcEyTji+W0e4TM+0ihxKE=;
 b=fBxkjn4B6ZOM8uZKv+HOAalAGi9oq/NNsdvRfqqQURh20WGv5LLq7uhpjNX4hg8cll
 RvdvSl5ya5up0yK6HxjcxHAD7Xe16ngf3MoFrFhYDzZCJwh1/IwBiTodas0yDyMbCkMC
 Vfra5R9RHwkUD/4jzD9QpFLeL523gG9HcAwdfN70MjkWvEaVJzezjcOwz4oQuwgPS/y+
 bu9bDuf2MrNww79aWDSE0owcESRk/DXmz3704E+3EyKp8y4W/I0sXEd29d9EPA0H+pMo
 0CTYguvQjEuLse5zPYC+k88sbWZEux71FScoWt42g3yDLCkaQUgQJHtpjdLXhswdb+Kw
 MHMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roj/r31K6l9e2nkByJooqV6yP/6S6VZtDDBFUKL1w0hZhqbeDgSWpuong1Q8yOl7fZIPUI=@lists.linux.it
X-Gm-Message-State: AFuF++kKLMGQbdfQQ6CK+jV77QR5iSlfPh+A0sDLLjH+VXpKK/cijQ6H
 iNMAMw46X2thbBHwe9m/lYR18OnrEOue5ZL6koZhpMPgpFMvSAXuLkPxkRqQ3sQZeg0=
X-Gm-Gg: AR+sD12ioYdo3rN3UBa6odh5IhXjyO7Z1r3DbccSEsi49TWa+sfqE7rMGr/2Jv1Q2mX
 YlS85vVmoCWg4CRJrPe2RAagxWnvAFbp4FamT/pSFPzecFwh9vjvAt+wsi2BBx5nEhFxM7NjXRs
 rYJfvaYJqHamaRrpeCGAHfTzkwhDdVPHRP4slOJexy0NgvWaJjwPMSrFhyUq+N38PT4CimNFqAh
 YwdPfdbVBc/8PqLvSsjYNfw8BvzK88OV0FaTU/sl+5dz3OrQOTIvepo070jQclpwG78KIzOQw2a
 OzFoJEVMbYsi9RCy5CLNgs4QAZDJg4dhFKEc+1Xy5NIPugprMOveL53XzyTjsAkkH8xPTPHZ00X
 K0l6u/cb0bbsT0sqTzFYTaYA9KaJHDSt8P/ILcv6UGjLrl4IHSO260lTzFiWyCRcs36w5GSFEkC
 K2A552JbLHTtaSMCnREux5TaAtM3NXVUPbNvHoNYKfXJhqb2qigwm2B2dfRZrk+V2IVuRVxJOxH
 F2Jgo6jyV4+kYgAolI2zIkMbaS/E35q1jucXhdYjWz4Fa42A5T2IhBNQnVy97XTNQ85LDo=
X-Received: by 2002:a05:6000:4a12:b0:482:e6b5:61c with SMTP id
 ffacd0b85a97d-482e6b50901mr13509156f8f.8.1787819073915; 
 Thu, 27 Aug 2026 01:24:33 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e8499sm7426407f8f.26.2026.08.27.01.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:24:33 -0700 (PDT)
Message-ID: <6a8ff441.16149c93.eb611.2f06@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ao_wwyjEOo4MVyao@yuki.lan>
Date: Thu, 27 Aug 2026 08:24:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fallocate01: Convert to new API
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

Ok, I sent a v5 with the updated patch

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
