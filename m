Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85BCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781601966; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=9+P2i4BU2cDQG0MVMxsBgV/Ud1oeuUgfzbst9bcvMV0=;
 b=LYeSgNl2HLGxFKTNSSwmV4yCst2sxf1b8U0CCEkr551dN4iq6Y1JWdkAyMYc8uIrNej1G
 /S6kMwo3mcRYUVqtJA1f7Zhjn06htor7JfRKZ4HNTWw268M6ic+kaxHxejrHt01VLChCqID
 aZtEwFpKGL1wwMXJiUa+odqRlencHwM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3248B3E5966
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:26:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15FC3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:25:44 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 00575600D3E
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:25:43 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so30814055e9.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781601943; x=1782206743; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CQzviF8cLFSDRB/bZpMauoY3zu7rXOBZLmo6cQdHSg=;
 b=MglK0k3/J3cT6JgwSvFMCVILKalbjBIDbnCXNV8lr9CHjrZnD0RWYz1mJcStdu9u3p
 4LkdmosdyljiFDtVg7ftcD5PmrnQOpyx3Ngx9Gamf4H+2HlrLkXMecXoJZXGuxOihQa5
 zWDaqZN4ykFL4u8eM0a8mEFAWDUGTVbPPqq+wghgeSuE0xmQP16S8oe+giQ1rBm3uT+I
 LQcW7TfN3agFVYLx1G0i1RHlyP+7M1jA+loWr70q1L58F1evPAvp1I81oVq5scRnNiPn
 M0crdN04IkfM48gb4705JKrve7hx2VGrm2R72bPHht3oe9QsyDYLjWyMn/zUSrBy9sjJ
 u2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601943; x=1782206743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8CQzviF8cLFSDRB/bZpMauoY3zu7rXOBZLmo6cQdHSg=;
 b=Y13G0zjsvVKB7DWXgCRvY3jez9YWEPyqkFUonrESyYR3TeDcBfQ690mqA9eG7m6Z9d
 YzqQlkS/Zaxr9gNuLkAj+X1RiBqFsjKgyVaFpHEZioWjisHTRaxzAr/YtxwbX4oaHi0Z
 9mAtqCQ6eKkR2WmV7lv99ZqFsZU5e0ryN+TAubg8a+eub5CS1iY3nCf651YrDzk44L6l
 6bgi3s7VKiz5PJDRwipN4W47S2M43Tr0X2cv9R7JsEVInb1g6APF9gIcS/DCeCtc8WtX
 cSB3hcKrs/Fi7eQjwC9thWq6LXCTivi/6lulCn72e6vBGwcAUIeuhAW238dT5e6oVbvm
 wMrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yiXpnIKrHaUfjFc5GDItYMDfTTB5mlVEjXCFxBCnMvIhkeefprKSb3N0asg5JfMA+Kik=@lists.linux.it
X-Gm-Message-State: AOJu0YwgHCcdTDvuxIIpDbaPY9nUIniDNxoR+f6pX4ijgHAxJ8VxmWrF
 9LVh4KRavLRWdUjsWIrTZxiY70tVvCJPgibBEiB2fbP8SXtJ9ADOEWMvLdkoJj2kPdE9QRmuXtQ
 zSdiDb3s=
X-Gm-Gg: Acq92OEzAiEcO1rj2SHGbEaGEI+P+uIlkT2gIe/BiZHfaKmreRDhxTatXWIoyThWgIi
 Ewv6p4/N4aJF6M04CCYW9zhQ3HIqtPZfNV90kBhj+NxdEVLLQLxpX320TaE0KFPsapVOXJrxIZj
 zujXR2fG/ohSy47dG+kuL90/DbpDziY9gv+ZcF0W80qADDGESGLP5zFjBkhhdsvZZc2uumY4p1H
 We7b7NvxqVK65zEX8L1Awz6VRNDhROjVK+qmg7XUp629Gyqbada2Qe4nz9hHwVlW65OrnpzlvVG
 czpqmgQqtv/g7gzGuQxsJuPmsg9XYI1z3tVTTR+4+7bV3kQ86jdmC3OWTDkK9VCzxs2bcVcd68z
 LEFlu9Q2GBlvlYUcH+emJ9UA5kOLt/2xu/q8MvshHyQyJLOBAjypY6LGU+fD3EYZuv0QtMPI+F0
 dbOs7m3IrxbcIZ6uxS4UrD5xYdyVsqMY/dIM8yXdgU
X-Received: by 2002:a05:600c:3492:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-4922fab2365mr41798735e9.2.1781601943382; 
 Tue, 16 Jun 2026 02:25:43 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm49073825e9.1.2026.06.16.02.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:25:42 -0700 (PDT)
Message-ID: <7a2da393-21d3-4a0a-bbd2-99fd325cc160@suse.com>
Date: Tue, 16 Jun 2026 11:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Avinesh Kumar via ltp <ltp@lists.linux.it>
References: <6a310a79.379593d1.36e868.af2f@mx.google.com>
Content-Language: en-US
In-Reply-To: <6a310a79.379593d1.36e868.af2f@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On 6/16/26 10:34 AM, Andrea Cervesato via ltp wrote:
> Hi Avinesh,
> 
> The patch looks good. For some reason we didn't receive the
> agent review which spotted a bug in the test as well.
> I think this is wroth to fix on a separate patch as well.
> WDYT?

Thank you for the review.
I have sent that fix here - 
https://patchwork.ozlabs.org/project/ltp/patch/20260616092300.177787-1-avinesh.kumar@suse.com/

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
