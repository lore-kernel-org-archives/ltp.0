Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2227AD78320
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96EA73DD45C
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:34:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0CD3DD053
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:16:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C71C11BC09C1
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733102206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/6MnNg5l3sSP+EaErq6fiK52g1SIbAbRkJqLczW120=;
 b=NqABEkSsv1uKeV7CF4xNzzNPBLfAcAhiZBZl5uhVx3pKEVFaGvDyBfXLBj28XoDBKSh6cE
 oZtJ/wmPJtqmkN+BB5Db1QmThI/iJ/WBbmIK0f6OXJeeGp1ZOYAirNjW+8p0UsEiF4acwB
 7d7NUaJ6v4i7N1LyzWEFiaBfMCKwwuI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-wkPITwrkO1imVGImsyRmwA-1; Sun, 01 Dec 2024 20:16:45 -0500
X-MC-Unique: wkPITwrkO1imVGImsyRmwA-1
X-Mimecast-MFC-AGG-ID: wkPITwrkO1imVGImsyRmwA
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-215609eed66so11321335ad.3
 for <ltp@lists.linux.it>; Sun, 01 Dec 2024 17:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733102202; x=1733707002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/6MnNg5l3sSP+EaErq6fiK52g1SIbAbRkJqLczW120=;
 b=nYo/tj7LEKRcRKmCehB1KzT56/VfU38XTjlNDQtGY/h/eBPzDj6TS1FqPmjF2wQtWG
 Vg4PQ0Q9Yb/7vgaY4HfNLax7QzNiHQrc8/0G0dXw3aQHiX+L9nQFz4W0H13tUl3IVFCK
 z7qjOOsL3JJbWDAH25zdTG/pS5okAQARC+fBR5BIBfwduLUtz8w8T/9gejThE19z/SQ9
 FQcDIbzSMRZgHUzM6L5WNbc1ecnO2M0tz1GY7uS69vMzfqfOT7+3r2oyw4yK5OkYxHFt
 MU3a0FTFL4IBpTgvYCD1NsSICNXCSNV9mypgza0aQyxkzRNHBMskRn/xL/NGmDSIik7R
 ucWA==
X-Gm-Message-State: AOJu0YzhzeV4TWqF2/9tdJ+wEF9Lp/qyeLNMHVLvVBiUj3cn04DI81xd
 0aKK9FEW9mx53kgYbp4biBIzZ/ynKd8fZ5ksR+jANb14z1+wuOlMYx/IJ7nTMyZHo9durMc0emP
 /aPv3QOl1OAlJ0t9yWwONeuJ7sqDFDI/1QX2eeztHBbH7ju0dUGfvWkq3IdEE2lFRDHBs1WpQzE
 GHzFxd8TGHIQf2MP2jfNmL4oCxbb8uLg==
X-Gm-Gg: ASbGncuU+UjBwFmBZnkbpALxLZ7G9wRpgkt6NxjHVcoQuzkBacadK3rl+fAZatcNmv6
 yAbkMFzFU2iGuIc4Xg46ZxakgklN5R6eottOqjsott5PHvppyb0zA3QRKBfK31ZGHWu4LdnYq0C
 8Hl0xiFKsSIUmQO+Hu0n3RO0hkjyJkjnbnYoPMXII/pex3mn2Mbr+Uz49E5zNI/MoNJ5YaKbfxD
 94e2zQKzDzDMqxt8ToXn+mJFExshcxDIW7SMjO2UAdB71OIGtQ=
X-Received: by 2002:a17:902:ce05:b0:215:9ea1:e95e with SMTP id
 d9443c01a7336-2159ea1f165mr10346645ad.13.1733102202418; 
 Sun, 01 Dec 2024 17:16:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdo1IRK4QsahuSkUap52DApEedDEzSlALQzgg+guZJqRNIEVNXJK75esVMQ+fkKQEkeL4deA==
X-Received: by 2002:a17:902:ce05:b0:215:9ea1:e95e with SMTP id
 d9443c01a7336-2159ea1f165mr10346265ad.13.1733102202025; 
 Sun, 01 Dec 2024 17:16:42 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566738ea7sm27004195ad.31.2024.12.01.17.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 17:16:41 -0800 (PST)
Message-ID: <bd3640a6-c2ac-4ede-a00e-a92e7c7910d1@redhat.com>
Date: Mon, 2 Dec 2024 09:16:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241202010012.1266775-1-xiubli@redhat.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241202010012.1266775-1-xiubli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ACHzdQiSFFDaJ_UHekYSdYJzTnytdpdBiTRmxwQjH4_1733102202
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
Subject: Re: [LTP] [PATCH v2] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Please ignore this.

Thanks.

On 12/2/24 09:00, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> './configure' is needed just before generating the Makefiles.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V2:
> - a minor fixing about the order, thanks Cyril.
>
>   doc/users/quick_start.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 1581b1f0c..598a95e2a 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -53,6 +53,7 @@ generated first:
>   
>   .. code-block:: console
>   
> +   $ ./configure
>      $ cd testcases/open_posix_testsuite/
>      $ make generate-makefiles
>      $ cd conformance/interfaces/foo


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
