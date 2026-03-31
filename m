Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246B3109B47A
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774968033; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ELnSaMJmguZlH6CcUI45bNnBxjC9O8WZ0fJfldhOo9A=;
 b=HNPqXyqw9Pz42HchIrHOJ+GHuNy7CSHBlpGvxzA6kzLjrVCwV28t6X0xhsEZnYOnYRuTV
 10sxiqT8h7oQzg/wPO2dhMt93yNhaA7QW2VvcAs8mi9snvzAjB2+qIPgJZ4tRL75EF1WFMQ
 CujuT6kMblpgPQveV6SIvHekBbJYPJw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AF343E54E3
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 16:40:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3417E3CC2CB
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 16:40:09 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6184200987
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 16:40:08 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfb723793so1545246f8f.2
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774968008; x=1775572808; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iU4iknwEGWB4XOgHWVNETy5kgGxUMSw4cDkWe/nbxKc=;
 b=d3dlzE8A5l6Q1mF4wAaF7PPduVH+p2DZo0/57K3/745o4Y89wfJR8nHmhY28DqR2L/
 VhX8VXC/x8mPaqpq0+PEfF30gVqf3OO4fixiX9v5roSgyk+HW5jNhWFY+Hrg7eMo/yCx
 xz01ErkXkxFSWwm1IXiZutCPm3+KxXVfRcKqCvc7RKwKAR/ZiEATjJ2nee/8Hcf1E9fl
 hL2A/NvjtgDwA9k1l4LKVM9fjybQvWkAEiaTtmWkd9cIml0N4A86v/uxTPevKhi/lafU
 bOJTRRibYUJV/2l+V7y1Pga+AEucJlnF9vWlNQzRHzYkeqfJs6ZYbSQWCApilg5iGyLV
 8TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968008; x=1775572808;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iU4iknwEGWB4XOgHWVNETy5kgGxUMSw4cDkWe/nbxKc=;
 b=FGYGBBc/3hiaFTRyHrYYW2ixFP/+1heqU1Qmu3frtclqWIlv5QYZxTpHc+f7OQ+rq5
 zaM3IQtjZRmMPL0Yc0R31ePYLlQv9a24x4p3yHGJmUsmAMz8jxK7ihgLrKbscHZcDh4g
 b0KoCddnFcJH0BN/vNcV9IOy2TiNVNoTsRWWSOIf9N5sPLY8EaMOzSLZgH9p4FhQY+5m
 WFgFS/hsERInzUCj5ncDXU1Gr5tYS7lxq+QbxJC4sIjpI23/TcokJrsghw/8znPxIrCC
 597fz58vNCfs6oxAWGuU/GrhRNBA6hy4cMy4+dpMW8cKURScPaoX/BIdE5gOLQqFxdYh
 LkEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV///B8m8BlogPob3oyQw5d4XXzX7sbuJIJnsOlUPHXqVJEWpLNNFHRH1pR4FV1ctJAZ9Y=@lists.linux.it
X-Gm-Message-State: AOJu0YxY+OwpOp+cgfsV8Obje8gjX3fc5oWsW9pc+cP2tC8BEDfFcB0w
 Y5HhJk3KEUaUXAo0UlGxbQ7yXBA62gFHWUsH8IbpWdMPeRMtv7l+++oalQx/zZkLgGSV+MyucaY
 A/GJI
X-Gm-Gg: ATEYQzyv/yn9qK55VkCn15nKyW7tEerBJU/6/pvPzf5WxocO8tlxf8AC4cyUGwpYVr1
 r4fXJnfsWiTepr9lW8Wg/Gep5DyLYi9tyEAvCgB46kP9XmhWgVtQTyU/3Tjb8hvXbl+SB7lugnz
 rTKmOAP1n2Vvju9CCHfjcYEvZvbkkh5kKEJzoUOXe1nRCHRkKmMTClShxPD+HfkkQQ6X/m6ofOK
 bztc0JxDwIfsGE4BE6JC5CcqAV9I/8iOU8DAL22dzR0WK0ZZACJxakeK/2UhOimK+DXZ38iachM
 VmiMq3QpzZw17tMpWePFujwjrwv6G2+whB0t36lxHLMS100naM2QaaI365jFI0cLVMwc1E/ImeW
 EoEUe+i4jHKI8Pg5fyoxHVW55yrNoEcZdl6ePI/KxTXdtilPMV+AmOiocuLRISv8w/kEJidaY9e
 0ySvNO6pE83ssjlJrZH8Z6cO8KVnMxrUEFf2LrokFRs4xxYQOtIXj7+dSkqB9gk4Mrt/Mlad8Jx
 l0DiftSy/8Gj0O1YxXs84cWLGGsCUmAArhiEzbOF5mc5GWaDxgyclPTC2HatpQnQDvo72sEHP0M
 q8eFnpkn2A==
X-Received: by 2002:a05:6000:238a:b0:43b:9386:966b with SMTP id
 ffacd0b85a97d-43b9ea467f9mr30123315f8f.33.1774968008213; 
 Tue, 31 Mar 2026 07:40:08 -0700 (PDT)
Received: from p200300ff0f085301c0e78e36bc9a819d.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eba4dsm30193910f8f.11.2026.03.31.07.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 07:40:07 -0700 (PDT)
Message-ID: <69cbdcc7.5d0a0220.14aa0c.1811@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <acvQqucbBwf0a_xW@rei.lan>
Date: Tue, 31 Mar 2026 14:40:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] nanosleep: Use CLOCK_MONOTONIC for elapsed
 time measurement
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
Cc: Claude <noreply@anthropic.com>, Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
