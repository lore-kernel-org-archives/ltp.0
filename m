Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C202C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:10:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D083CBEEB
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:10:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E9F3C1D84
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:10:00 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BE331A00A22
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:09:59 +0100 (CET)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 386EC3F214
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676545798;
 bh=STYwgULn/Ev6ukqdh3387r21W9A+8wVjTzUprIu58z4=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=Kv4FzD30ziDewe7A+bd/QLetaj+7uvlN0MsdqnChitIanXTpaHJA5FY3q3xbXbv3x
 raJkwkko9deQDw4EszVfQXTVLsQq0ud/s1VMV+4u0e4PliXnj4qqGjQOU0g63A+rUy
 YbXPvZgooKDpaYEbkCL7Dco4A3CRVNJySAZCM5jzfl1ffCNavzS7CDQz3xmpCpCNzl
 6I7fe8akxnvRunhAWiUr7NiQN77nKdR0duF5SIfNcbjbHxGuNvtUagvYrNuvDN6j3I
 B4BavWrX3scZCup58bwnJYCWeICrX6AWaHbPV1xRiajpC6veTdfHk5yAU2Dc09AACE
 8z4QSnD8CSmPA==
Received: by mail-wm1-f69.google.com with SMTP id
 d18-20020a05600c34d200b003df901ab982so684985wmq.4
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 03:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STYwgULn/Ev6ukqdh3387r21W9A+8wVjTzUprIu58z4=;
 b=TWkJsXpsS/X5EtnnDfZVUAh0lS8TfidhHr307x3dOPdXM/vwBsxo3pqHafG9fiD1kh
 z30Y9ONK+TfrM/fTRP03Jg/GylF8d4ttbAq7BMTFqw5MEIxZKh1ZxbrYkG37Hx/r1OTq
 LEYhfov51OugsGvhP5uK4QfARabGoT7qPpDApbkTwhYNb3LFV8YgMvkiA6SMImv6miWo
 P+zMw5ppclwzViOwQfv+l0Llzca0vfVqZgucn5zCaO1uZ0tAtwatp9fuznkqhMNOA3Ji
 rXBodAEQZNueA1CZ2AqAiIjS0NnZVzdtFmeaXQMsscsdcGIxo8doHiDNQKYQGq2I5TLs
 /K8g==
X-Gm-Message-State: AO0yUKUuDq0hTICrHmmqOB5oVO3CizIEBLdhhGFOlkmuP6zBbeMJhtUs
 dBexI2F3JPxKiYvx8qsFQqi69rYIADQh/qr8ZD3HC7CefX8iy0ZCxCL2+YEc42vT9HEMRQkyIcT
 k8t6wL/iirEO7UikTruugrkSI3oEG8g8oXVQIaZY=
X-Received: by 2002:adf:dd8e:0:b0:2c5:55cf:b1b4 with SMTP id
 x14-20020adfdd8e000000b002c555cfb1b4mr4285358wrl.10.1676545797551; 
 Thu, 16 Feb 2023 03:09:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+XZjWrP/H8eTgbcUfFvPipaVqNJzwSoALRnXly3xwux6sm9sunMjOpeSZOU44i+HUU4VHEgA==
X-Received: by 2002:adf:dd8e:0:b0:2c5:55cf:b1b4 with SMTP id
 x14-20020adfdd8e000000b002c555cfb1b4mr4285342wrl.10.1676545797305; 
 Thu, 16 Feb 2023 03:09:57 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b002c54737e908sm1172104wrn.91.2023.02.16.03.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 03:09:56 -0800 (PST)
Date: Thu, 16 Feb 2023 11:09:55 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+4PA8sAFBlBo1R6@qwirkle>
References: <Y+zcqqNE01cNcm1Y@qwirkle> <Y+38qMc2Kdh2DPA7@yuki>
 <Y+4GEbRopmw5QA5r@qwirkle> <Y+4KJ3tgxRiIr7JN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+4KJ3tgxRiIr7JN@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP fs_fill test on vfat - ENOSPC
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 23/02/16 11:49AM, Cyril Hrubis wrote:
> Hi!
> > I did consider this as well, but I haven't proposed it initially because
> > I didn't want to come with a solution that will switch all tests to
> > Fat32. This is a limitation for tests that create a large enough number
> > of directories in the root of the filesystem, so I wanted to keep the
> > scope there.
> > 
> > I have tested, and we will locally go with my proposed 3rd option for
> > now. Does that sound resonable for a push to upstrem too? 
> 
> Sure, this sounds reasonable as well.

Great. What's the default in LTP: GitHub PR or mailing list patches?

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
