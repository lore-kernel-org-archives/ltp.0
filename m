Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBDEC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741149026; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xPs7Fxu8PQ0Zi9Lq9sdf8/kwjkx6FkvLSn6gC1cq5dM=;
 b=QJhOPHVqLBq5BTEuJwf4nUcUSXF4ZxXwePYCHFEHB8nts5ShqCEbKclog/Kl12cZQpDfK
 li7AVcdhIka4QxI3PMhTeCNUp5o2MCU8L16xKhXEUVfhTshu95cQxOTfzRYwBSKhwz83XEu
 5m4jVQW+LWF11Sdu7jJCmkLcNUbrDTY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E4B83CA014
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 05:30:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266E13C99C8
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 05:30:05 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DAB0C220B5A
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 05:30:03 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so6973935e9.2
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 20:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741149003; x=1741753803; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BlVnMbd7UqjxZ8mqeQnD/jJJ90HuQv6mGv27CTNw0nU=;
 b=KCGJgQIwDRsry+lCJShuXFi5jAcPLIGuJ54D1jrj5rmvk6YU8+QVKDgtwOY09fXD16
 UakoMQqpLnkRfzER6S1a+GpL5R79DqYUm0Dz/ZZejsFnD5NItY3U3ZZ+ntRjDAlqnj2W
 GBGdU3ahZLmWB+vLisoxvf716GFC+peHnjXVspWYXZIG3A1j5K6AtderCDPxIswYGkNE
 41LV1wJy5amfnT2Hola/imGTWTo/wxdMpryHVvX7WqVDYat3uh39VJWsFjJwkpZoc9v1
 yVti5KbjagZd9BfjOWwwMVDPFVpXdgPn3GngmsIGfYkSjfsh+LqJ+86IaHipI6lY9pSE
 +nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741149003; x=1741753803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlVnMbd7UqjxZ8mqeQnD/jJJ90HuQv6mGv27CTNw0nU=;
 b=frpSiiuMiVsqfnYkveAoF9PCDVnTcb3vvo3Jz4iCc/RHdNEkL7kWJp7rACCyH69Vep
 4hwiSceh57Spw8R6svtzsRJB3xSTxxqIakWPAG5uvB7ZtSI9hSTDtkWuZ6gYmAry4Ouu
 SYu2wtLSLpKJQILgq8lHF9SS9ZT/w03PspIEn4KdufNBSXua0fC4VacyM8XOuVQxxQcv
 ER/dJHiexUKvMjwaQbUkzzdWg92/JWAHqZAG1TnydplNv4CieyPT0h/s+UFlA1eDpR+W
 KZ2CLiLnYzAcC11iOgntVVIbjB6JzisJjyrZ/oq8C/CI/o4QwUbzo83F+92wgGMFy7+X
 k71g==
X-Gm-Message-State: AOJu0YxkH0t+TPt1DLUx0M14h0MOhxMiR6R+Yp7lf3zh4QicvJ0b3aBh
 fN1mltqTEMELnjfG/VriWTjeBrqNSZVK5GRYjggk4Q4NwTxKB80uZNtA2sAvFw==
X-Gm-Gg: ASbGncssQpwLd5J3zMshpTBkiOHrbkMQOE0lryHLmTWgFn8QWyvMR8FBV6juFd+Qw08
 QRDFe5UoALBO5KF/6KfJc6FG451+712hzsZiakt/mVeaEgJC4zfXWlZZCLEYkADUKp3vVCrIpGe
 ubDHC7uFbzLK8OoFnTfTP0P3aOZfRg6Nt3az1v/9Xn5MXPqU6F5HSlzGWyykgkSyVVakKMym83g
 QsfmmB1K149QeUWdtUIVEIw+l3VEKEhH7Ym+U9RqNg+nq2SzthxzIy4BLxOQqFZ4xOzYW3tFoqE
 64S00TOsPHjtKgCVT0Y2oKGjyKHXqlzjnpbQRj4=
X-Google-Smtp-Source: AGHT+IG3ugBcmS9nkpaHTKsgXa/qoHi1fIqlmkpxsfTDoMW08Y1yECuUiL66dQv/UNUhEzwk9cOo+A==
X-Received: by 2002:a05:600c:198f:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43bd29589c0mr7875415e9.9.1741149003155; 
 Tue, 04 Mar 2025 20:30:03 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352eccsm5085745e9.27.2025.03.04.20.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 20:30:02 -0800 (PST)
Date: Tue, 4 Mar 2025 23:29:57 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8fTRRWqoVU74qh0@wegao>
References: <20240930135809.9300-1-wegao@suse.com>
 <20241209060117.16870-1-wegao@suse.com>
 <20241209060117.16870-3-wegao@suse.com>
 <20250227160450.GE3130282@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227160450.GE3130282@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] cpuset_memory_testset.sh: Remove test6
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 27, 2025 at 05:04:50PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  .../cpuset_memory_testset.sh                  | 37 +------------------
> >  1 file changed, 2 insertions(+), 35 deletions(-)
> 
> You're supposed to remove cpuset_memory_testset.sh entry from
> runtest/controllers.
This patch is hack for remove error which happen on our openqa micro test
product.

If we need remove full cpuset_memory_testset.sh, i suppose we need convert all
sub cases within cpuset_memory_testset.sh to c case.

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
