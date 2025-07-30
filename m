Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F2C87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753867756; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=zdzW4MQmFcOsbs2pwrgxp/N1o33lyO7nxwOvmgHrXfI=;
 b=d/KyO7GFpBVwgInQOPPqiTHzYe31JQ5C7fl9KfR5BcvG6Zx0JMUKw9H0V4RCt3zxwh0np
 GCm755ct2U1NDfXcKlJRHuK4MsbmKgojFwbV7hqplRpG8ZQ550nYjY1sVZ6Oeoze94vs4C+
 PuMsI2Zaf+2GBEfnkCVgAYMe/CB1HJA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 810453CB0C4
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 11:29:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A61F3C06E9
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 11:28:54 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2A8B100037F
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 11:28:53 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so395991f8f.3
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753867733; x=1754472533; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60Z6vdPyo7gssgfEgakiBbFwIRojLa/lBgozjA9HMxU=;
 b=Y0jtyD8Igsc+9e+EJfMiCpVcd1dyfqc1veJmQnpzSQyC1gsAhKgweJLmpus8Z9KzWl
 n9U75ZQQMG++j0XdyZFxzejQJ/lDF0u+RrxGOcfTv4cpHocRRv4/v0KoJUF9U5FJWh8o
 OwOjI/sV/blMA9myEusfFNbo2xB7RGY+A72gWNGjU8buuoie5fNG8G/p/RoFW23nr+jM
 2pSZLkDZ2aViybRiXmaiN7j4JAns0+oohilbQplMWQ2s6qxxc8htrk0NDbQ5dnqyZO2g
 cFCL0agXRCo34TVOvWxarm+wmBru1D8KpdbnF8cdqjdeCXWwruQsJtTReqaLy76+cEfz
 mmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753867733; x=1754472533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=60Z6vdPyo7gssgfEgakiBbFwIRojLa/lBgozjA9HMxU=;
 b=nPDfat5tdVTtrxjD9I9MvaxrCMVuHb6Vn4h7CWeKRs4WDMNmH7VHLznX5myLG4mMS3
 FBCGsnlh+wrnBezR/AfNCLh8iFTnP+Qqh158mQ1COl6cPuQ4wBWrfft9pzaTfIQYUhsl
 GNlywFcn/RULi/FMmyUzAYWGkR2fVAOUvQe+mx3a14E61CT0ZnQf77F46hp/PqADsmNs
 YkdkRcsMvMLA3ZeToPx3WPFWnhA7ohuH+cIPMMFsuO8bM3VuKXmy1Zmjl1dnCCtz3EX8
 iMvAFAf+sw8Sf05GE3RRcSFRLUwfUhFQrbvF/Hj2nf2/ipoQ97QmE13N4lSKl3tkjjtP
 6qZQ==
X-Gm-Message-State: AOJu0YzHI13jFTfLw15AC170KP/L40HiCSgX0Jv6w6/PVvoGKEaYLBH5
 GNk5c7z6VBN+Sg2Y4tSTzpwFT8s52aX1eoQM4PyLiohj7dm8heE4mUQl5nQTBxowEmM=
X-Gm-Gg: ASbGncvbrc7uVxfVrG9+Jqerzt4+IjNDyB9SIQkhS/IO6c71gzZsr4JBGgbeUjOjySV
 8GAJOAogpgMVC1AEkg26Idtrs4XaNTMaP2YiqBem6z4s4A6cdOB2MwRI2u9yCihIjxR0BhJacpk
 YI51iUv+dyAz8CEjCs8lY8umlsJxzkfn29NwQgLcCi525sdAagK+/DzFjISIWZn3LJciC2SUhUK
 n5xze2wRO+TV1qnZapUxpH3hs/p+/1myk/tbKl9gXnDO19VTm+ah8MXDSoSw+LghzJVFP5svVPx
 MrjSyfLKNZVuT4Zmw05/3Ts62jQLCXzw/guHWZkNP/AA9L1qkwDa83TJ79+Q4+ZL7eDExD+agcX
 t/wEq5eKWtLlEN/F4u1gLbXdASWWr9z5sCA==
X-Google-Smtp-Source: AGHT+IGnrfkO/AFrw2eGy7gLFw6WA6e2dzFUUo711Xq0vZVNgNxvOvWNdLQTTAwCuO4a/4Lc+OHnEA==
X-Received: by 2002:a05:6000:402b:b0:3b4:9b82:d432 with SMTP id
 ffacd0b85a97d-3b794f887ddmr2095570f8f.0.1753867733036; 
 Wed, 30 Jul 2025 02:28:53 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76b6288ee35sm780849b3a.74.2025.07.30.02.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 02:28:52 -0700 (PDT)
Message-ID: <f7dcc11f-6833-4e26-bd2a-0ac9ed819745@suse.com>
Date: Wed, 30 Jul 2025 11:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250730-ioctl_pidfd01_selinux-v3-1-be5a56358b78@suse.com>
 <20250730082435.GC54941@pevik>
Content-Language: en-US
In-Reply-To: <20250730082435.GC54941@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_pidfd01: check EACCESS error when
 SELinux is enabled
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/30/25 10:24 AM, Petr Vorel wrote:
> ALso, we have yet another bug on some older kernel versions (found on 6.12 and
> 6.13, but 6.16 is not affected)
> ioctl_pidfd.h:32: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) | (((0xFF)) << (0+8)) | (((11)) << 0) | ((((sizeof(struct pidfd_info)))) << ((0+8)+8)))),...) failed: ESRCH (3)

I'm gonna investigate this bug now. In the meanwhile I merge the patch. 
Thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
