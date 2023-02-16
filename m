Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C264C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:50:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B4043CBEC3
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:50:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFB893CB10B
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:50:20 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 272E5140004D
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:50:19 +0100 (CET)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 318C43F4A9
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676548219;
 bh=wttm+JQNZDrvQCLVRKfLGHoHiFlBTYQYBoAWw0o2+VY=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=FR0rX1ifYDiL/QWu047JxxilXhiK2DW6TI8hDhEvmHZySVnjnyXNKGGuHYvthzJ/9
 crHFE2vgdUOo7PRVrU4UCmeFAE/nmEFIThjDn/PZXyAsDm3pasyXDsoLID+ekFyF/z
 Y8G1gWjulHe8IPPk/zztyLcfbqJ5u/+YbQscTlvmcPIvDsA4uwoVYN+8+8xIGJTMu3
 sEe5jM4LvBc3WGw0jmxEK0avrmdWzyEs2JgGIHYxW9BV17AdNLeTmV7mpzhQJv2y9I
 M1HPhQg+OxU0wQizp9JyHPs3k6zxtnYUD3Yr55Xv5f75sorV0u1Fx0iPRFvVeVE11K
 VJonQ5J8NoWNQ==
Received: by mail-wm1-f72.google.com with SMTP id
 k9-20020a05600c1c8900b003dc5dec2ac6so3010111wms.4
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 03:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wttm+JQNZDrvQCLVRKfLGHoHiFlBTYQYBoAWw0o2+VY=;
 b=AsWYO6PgqMNdah3t3KdNKgCUa5nYCkeerGHAWNYOM57NqdFj4x3ot7asAAKQs+uey5
 m1A+sMiW1pA+tlumT0JXNXlBCSJyafn0wFeKcM279i8hnO3b4jqqEaCRLtWV9KeyZjGW
 XNClrdXT7aDp0oevOrNlx2eXXqRQsf7UqLti0aIGvDnVrKRQocmIm3u8VNMYDIG9r1lO
 Nv/nJ4JvqxIKKln5InUVNbsFh99NN5r9j09StWT5obOFLF6mBqKw9+mACjmgjRiITWBx
 KHDa7oI9lfW20Bx4F9rblTszqH+D9EGwBg39Tm1Blc4ZLiDhuK2X77Z4Pt8RxYNhLf7q
 ebVQ==
X-Gm-Message-State: AO0yUKXQUU5EDs2ot0e0+8KobpcxkA5msRTuBcH2u9Vc8TVtgDXjztDQ
 yKs2fHr8OUWFZ4QxcA0u5ChLAFSjdWFwPARc3/lptPdhHu+YkAiH02deeOm69QVF21CR3uuWxfJ
 1Zqx6K89tmJwTZSPKsGwnNEPZvO9k
X-Received: by 2002:a05:600c:5128:b0:3de:e8c5:d833 with SMTP id
 o40-20020a05600c512800b003dee8c5d833mr5124036wms.22.1676548218934; 
 Thu, 16 Feb 2023 03:50:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9xEhSAsFG1jGPzw7JrCNryN3AYRI3lj1GU2cR9xQiHLyIpti9uGeCE2lt9SesFUfPNfHzdjA==
X-Received: by 2002:a05:600c:5128:b0:3de:e8c5:d833 with SMTP id
 o40-20020a05600c512800b003dee8c5d833mr5124028wms.22.1676548218658; 
 Thu, 16 Feb 2023 03:50:18 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003dc3f3d77e3sm1483847wmi.7.2023.02.16.03.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 03:50:18 -0800 (PST)
Date: Thu, 16 Feb 2023 11:50:16 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+4YeAk6PKevKPhZ@qwirkle>
References: <Y+zcqqNE01cNcm1Y@qwirkle> <Y+38qMc2Kdh2DPA7@yuki>
 <Y+4GEbRopmw5QA5r@qwirkle> <Y+4KJ3tgxRiIr7JN@yuki>
 <Y+4PA8sAFBlBo1R6@qwirkle> <Y+4XIho55E7quLTz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+4XIho55E7quLTz@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

On 23/02/16 12:44PM, Cyril Hrubis wrote:
> Hi!
> > > > I have tested, and we will locally go with my proposed 3rd option for
> > > > now. Does that sound resonable for a push to upstrem too? 
> > > 
> > > Sure, this sounds reasonable as well.
> > 
> > Great. What's the default in LTP: GitHub PR or mailing list patches?
> 
> We do prefer mailing list.

Thanks. Sent it over ml.
https://lore.kernel.org/ltp/20230216114745.2389810-1-andrei.gherzan@canonical.com/T/#u

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
