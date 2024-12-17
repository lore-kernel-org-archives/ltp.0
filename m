Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F908E7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734416229; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1GSoO+E0/tVLA12qMn+eGK5VWlYCrl0M+n1Cb+iSoLw=;
 b=CcKi6T9fCHnmf6BwQhiG37Qxv9LKNe8TjKv8butkWD0XHGk2d/Uk9gaLgkySPimWlnPUa
 a1OnWB6xWlOEbvd7Fg9CjTXIXh1xVVp2FnUckNRQgPhPqxJWAZWNT4L30q32de6mNJO5AK8
 IT3Y9gFDuMilAigiDjL+AEcEog2u4hk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9565A3E29AD
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 07:17:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F3803E29A2
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:16:48 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74E2A142E642
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:16:47 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so8250530a12.2
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 22:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734416206; x=1735021006; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkKXAk72zpzmc8wM6Ww0P3Wd3UssF38v0xVLX6w46tM=;
 b=Svgw0RqN7ozhjRXMSg4IL44dt9Ie9rYXnBZface9sy+Ze/QTchx2ud9STRmAaUymqw
 wSG5p08jQAwJJL+fqJiiIinhv7nRD6I3eA8Fea/DW8FjT4PggXj/MTa0lgkfLdesfYUA
 X7dQdqwuHcjvChrSfWlz4k19GRaLXySQ18vSnUOQMoVNMfPW0QWzfM94gl8YsC4Y0x+m
 BeLmcdeG+4pc7F6E7xXLVkr/CEe5Ii7xbrYcVeun3Qc4FxxhSWg1FpvJ9/FD76zYb1Qs
 doGS5DC6Bucy7ef9XUXPXBvjJYk3O8rEDqfZO9wphX6EQ94HQAswO0sSthkM6zK+5Fz2
 MiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416206; x=1735021006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkKXAk72zpzmc8wM6Ww0P3Wd3UssF38v0xVLX6w46tM=;
 b=rIfoSK525Mo/pzeJi5ugFxgIqun/jshQFD40RjNkxXBCHYK0eZhqKSb80UxJRMb7S6
 0h0iCwzIZviNjPvYEBLfRwRSmU7rzWRwzY4Zc/YFuM9EdPIUnez8p/+acPSza5DcLbeA
 p7vEIwgCz1DuqRSG81w2o/hp72q20+RvvzpSU4lcRAOrGevnDWaD1z/zcs9wxg9ruPb/
 bBY/0OMTFtZoEA4X0utXMzVyLTS+lPVHcmYafXFX2HGKxVpEsINjniZEOeDKN6bkmoYF
 CWSJ5hGmuhLCb2nKSP44n3ETJFN9fF/H5yr46BhXuYmTzEY+4M+4Ivmq+ctGC2n9AJA/
 KOrw==
X-Gm-Message-State: AOJu0YxSx1Jag7bc899JYk8mLqqjxyoGGAePrsWoq68441QocHb6yfel
 Gvx8IDALZaOvW4EGpXsz+yHPGYjJjKWdt6sXEMS728N6tqobDYzvs9tMzOM46j2r+8rxhWUKV20
 =
X-Gm-Gg: ASbGncuCa+0XJlleg38qTtfZnKzQeNsd4Ti9pHH7gzagvQhDQd0sz/hvSIbDumW2Nvg
 6NdabXhvuFQPcrMhs5SVh42MyDRMif/tgHrX+nQyliz1ev0+TFQ1eLXZUkxbSCqS81QLCvbodEO
 sDTV8+EX+2vTyoxv84cARXgccw6id3EOeSopI49YkTPMZ5h5om1ehODHvwLkg5GKSaZCMDRbvtQ
 BLO/wo+yYu902JfZ8wMz0JWC/i53T0dBKd41qyMaqC3Sg==
X-Google-Smtp-Source: AGHT+IFyZLftbokd4dAUZSgoXzdStCTLG7vZN54WcVa11jtl1asOM7q0jL2tb4L4aeWZd9eekXYBvw==
X-Received: by 2002:a05:6402:2695:b0:5d2:728f:d5f8 with SMTP id
 4fb4d7f45d1cf-5d7d40dbd9dmr2233266a12.27.1734416206217; 
 Mon, 16 Dec 2024 22:16:46 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ad19ffsm3912596a12.24.2024.12.16.22.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:16:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 01:16:34 -0500
Message-Id: <20241217061636.16366-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240603103553.8318-1-wegao@suse.com>
References: <20240603103553.8318-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] ptrace: Refactor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 228 +++++-------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 272 insertions(+), 297 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
