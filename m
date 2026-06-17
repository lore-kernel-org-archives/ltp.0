Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464B4CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781688262; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hZzCbT1cDjyWVM+GISapOIQhF0Ug6PGS48HoS2GJ25U=;
 b=WVnk2PjAfQIb359b2MARjL681G0qqaa2CxHTDSx64vkwdxshndBcXweRbIdd0klS34938
 s1Zs0Ye1hO4QaQGd1nN7udBiHFXGtfRjM4WDnN+2EP0V533iETHjjUzIIiFWPNk+dm6qlzt
 EJJff/NW8/3sAjTfieF4d/SMNnF2yMQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6223E5933
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 11:24:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 584CF3E1FBB
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:24:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B7F882009E6
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:24:02 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so52243545e9.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781688242; x=1782293042; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4WCko5AgA27qvtz2uAIX39pdm2M7yWl7AlJO/RIC69E=;
 b=bsqy6xCLfH0u1NqRjT2O1G9UZyslNC/fqSYwlhwv5TRoAnKcbARWeLy3B5qVLsxVGF
 WVnuDhySTLKnojsZJc6nWPJ95UFNM0SvrQ6iIWtVwO7w59AKf4wUKm+aRRk7wM9ATNQs
 DRnySxGxEnG9K9mL0RtuXLs8YvXE25HGv8bfRljzxuVMhfNthBuNd/+RD0MYKuA62Adk
 8f/ECKaGA7egq+3e9LL4SVfyNFpypQyUn7q/mjbknyg/OE0X9Jy7ODjzCrX6rOefujrL
 mBWFtvS5ibK2ojsy4YkPW/2mLEK0WXr/gxtUiwvzZXETwgP5duaWDlWxm3LrTDSa7Fgh
 9TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781688242; x=1782293042;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WCko5AgA27qvtz2uAIX39pdm2M7yWl7AlJO/RIC69E=;
 b=M6vzDDnpI+7V4plTDhy+s2u7IB/ObrUNcAhm8F/dn37bNpTpdSiLj6NLMV8GSORYMS
 AZA9ztvp5ODnhrcrAeZOcJmfP/0HCQ3fOlWh9a7fHRrbEX+R8n4m4qQJ27q0JQKbG4j7
 eY8wypMyLmkhu2AdJUL1vk84X8Pr7yUAQBLuia/Ajt5KCp14o7FudsVi0VpE6rLP2A98
 KT4tDYKKR81yRkDegznlhjr84b06tGb5O+r/m7iMG/83kbn2TNAt/W25dUlqzMAC7oUv
 bXaeknwB7UxeyUjQ9tciQp1+OqT8FZkKEe5El1NmN2HrNtSew3PwqqyLJduiF30U3nQQ
 +SgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90wmCZjcMPRh3eA7WC9+DGAFYOUACIh6i/B4bGrfh49Pn6+T9AuJphwoW238TSODIYLb4=@lists.linux.it
X-Gm-Message-State: AOJu0YzG5j7/vCJWc+2vBewauDjhplb/3iSEOda0aHOAJtx4go5IGG3A
 zhkfQ7DdKgSRpdvyifQCTa8pN151kALslWcAjHW0JM8WMP3RevY8G9dQw20DbQVlJJU=
X-Gm-Gg: Acq92OElbECV0LYH43tHltLpHVzP1RWd9YSrdLv7T3fjMbUE+ffl1IacLh2WxrH0P8G
 t9UfFkUAQJuodD3SKhSKFG2C6RuDoYEfNsi92pHtvgNBJjZqFZyWjM5sh2oiMQvvvD5Z/YZQ4+l
 QJEpiUDw9bgrh1ZRMvvgH2QXMK7kgKZKIjgbEtcAl0LbRgczXgZXr3TU3+w/WplJ13nVuzUgr/n
 WsdA7o71NEHBLS1qsUxQfmQPYzNT7qF/6Jvf02H4EO3Adgx1EQiOEungJC+FAcy5NugEOZFDog0
 7uPUD6ycYueXQO33ctUipd+00h7/oQSHrVLFFjsv73gfbrU0dUEmQeDk1I6sXnClWZSPkf5M/k8
 b/2JIssbX5IJWm1RjJOUpnd2LCfXnkbI1bVaDYDkiZP3yta31WvVFAqVTEm5INR5Cjv0ch5oRt9
 yvD+OIQlrcc16zqQTLNmGTylOMoUU6k8JCoNW9N2Xwxp5Ghfv7PH2fiuHiGjmE3PHS8C9HEYnYA
 2c/BX+uyzb6tomMf1a4Kj6nTRM09lOFW0xtdkoWgkokijetjYWQ9SAJH4D75/OJkF8=
X-Received: by 2002:a05:600c:a319:b0:490:e170:b80b with SMTP id
 5b1f17b1804b1-492333debc8mr44834995e9.32.1781688241970; 
 Wed, 17 Jun 2026 02:24:01 -0700 (PDT)
Received: from p200300ef2f13eb00c15f82d9757402d3.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm24204438f8f.6.2026.06.17.02.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 02:24:01 -0700 (PDT)
Message-ID: <6a3267b1.40769b9b.2d25dd.b31b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajJgQmumLAfPLWGk@yuki.lan>
Date: Wed, 17 Jun 2026 09:24:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This depends on where the error from kernel is supposed to be returned
> from. For files that are generated by kernel such as /sys/ and /proc/
> the permission bits can be all enabled but you may still get EPERM when
> you actually open the file and kernel decides that this file shouldn't
> be readable in the open() syscall handler for the particular file.

Thanks for pointing out. So I guess open() is ok, we can proceed with
the initial approach.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
