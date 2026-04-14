Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A3AF9D0EC
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776188719; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=z9hU7eHzeINI38Vzud+KkSjUOLSUraXxkgqB0GjhGUo=;
 b=hf56s1N5wY4nexrqfJ9kD7XfcGCM/ZP2dKrO/RirgdQ9zzrXfzksHC3Dh9ZiL+WuPGiYw
 NywhIP+zhdu5plF5emAfmmhPdZryfXS/cpzxdBvs8gISJViym7omLBqtetTFXjz68I3KsIx
 PiQeVc8AAFxYoe1FKLwQUajcDJtQ2zI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 280013E5E0C
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 19:45:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00F343CDC78
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:44:55 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A8BA600483
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:44:54 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so78978965e9.2
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776188694; x=1776793494; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XJXjEJMmQbUFcG924ocO/D1VJWbqWWnQ82ICUB2H6BE=;
 b=G19q3fGoKSCUowGosgFmWw0PcgFmOdoBB5so+RJ9iiyQyhjgieKPeelKeuwfAQ5mNf
 yO8tTfdhuEUyy5bd9QfMBN4UgHhU4HpyloF1v3aM1FhBFkOVLptMsNuS4lXXvdF7V+r1
 HzDsTnnN5ew+13hUD6+NTcjWyTVO6HVFFmzz3ehvrqX0Qo3pHGeRJrpLMYVafL9EC9ae
 9+mc+jtL/oDM8AmWkSnJqZfMaZyn7uS0+4ea6IW1LtZzJlO7pelNOS07hvRMCsD8WlVu
 XBfhLf1TPqT/YyXWvKURFM53yvWBgfw7DY21j+z1TnYl9U891eftbDJHi0PPNV8IIta5
 HSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776188694; x=1776793494;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJXjEJMmQbUFcG924ocO/D1VJWbqWWnQ82ICUB2H6BE=;
 b=rqcH7TxNmL1a2OkdB0pGdsWJyGAJ3BJQcL8EPosuCJOWnROhO6DdyEZ8fhFH1x191I
 1aiBQ7HHdLbaz3iFJpnydy9cRnbYgR709U4YL/Aa/Rx1Yx09RAOzwpD+ZfeFQzl5hZlM
 d6bgtnrOS0A1KQS2A+K1rbwA+KqFx59uxTDSdtBCuF3VSiKHhCXTRMrA6sfIxkE64Oqf
 fkN65cCwBYEtINWpEEKBuPOG31GwLhXqJqxzwHS6Q4/9CFji1aBBR154JRK9OCri6sB8
 pPusuhp5FlVRKWurZGDxcbf/tnHu3wLdkHa1nkUPdWl/JeLOwi8znaoqHazr9jY+5s7W
 f1yA==
X-Gm-Message-State: AOJu0YyxlXAgvJpVSKnK6s5qBJbVjiG64CY9DjWZokVJTrZjklikOH9q
 J5C+ZivXxv8jWGmaNGtcBHekIFonUjRJR2Z/11+V9SuPGaowvjuu8fD6ta9jfl4aKy8=
X-Gm-Gg: AeBDiesC3MIkorApK1OwB/+sUnG1O/+jNTUTyD6g6dAddBINFd/yJFFV2bLoJXmpO1X
 4xAUV1U0tBCIqPObMLEUJe3KhqiOEYn5ggXeIcU2TBKClmUJOm4hNNgMc3/L+/ojXX08RC/lZn3
 kDeDnkUvx2NUsJaG5XUWq6OOi1xDUUZX00+KDrJ+3A8SNCwxzALs4YiRLaQ8wK0vLpE/VFoRQVR
 GAuuzLmlobW31fCE7ij4LzL+5c/ptVY+/NQDnbvfe28R+X58Rn80h0s4jgFIfxn/XEHz0mlZLQk
 AzRiyXzEGN9ZCSen3b0lC/tMLWIIopxHeT6ZqzHDtNGLH+rlwK8Yih4DzfJC7r3x8OXcGsFot9Z
 iHlMyEZ3FZufPrAv1wH8fFljotbdHsd0PEAfYQ/Am6QtPBbEXWLXO9fIYfFzvKhwLeDYAakGuez
 m1j42vC0qurJzoRqpkiYdJryLwbJnULKS+sDGzI0HVXSQEssqUdWPcM0dAFNH5RpSD3yTqNq24k
 BBAKWlsmDUauRhLl7r6v6+HdtzRKqddLwE=
X-Received: by 2002:a05:600c:4504:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-488d68684fdmr259386115e9.19.1776188693953; 
 Tue, 14 Apr 2026 10:44:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f095e6f6sm2255535e9.5.2026.04.14.10.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:44:53 -0700 (PDT)
Message-ID: <69de7d15.050a0220.36879c.6c6a@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <69dce7cd.050a0220.18678b.446a@mx.google.com>
Date: Tue, 14 Apr 2026 17:44:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] AI review agent
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
Cc: LTP Mailing List <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The repo has been moved under the `linux-test-project` ownership:

https://github.com/linux-test-project/ltp-agent

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
