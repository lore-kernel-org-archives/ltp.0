Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31816C79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788857663; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=r9Lr1OFFwRxfS26ovp6oHPNAXGcsD32T7r51BPYn3Ss=;
 b=KmsDveODPvVH/QKmrNXO0psnGqzz7myrWltDNrNF9bvhy9xmzqIwCUOyu9IcU1GLa5i92
 M8bfM48Q8iO3QELetK4BoSK/bTWa8NbXQlMSRwqufSsx6bXetcsV8Zcb+gg/s8gq03xofB/
 6zw5jjqbC9zSEy1TXEWMM4A5aVzA2HA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A290F3E57F8
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 10:54:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CECDC3E4D75
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 10:54:02 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9E4F260067B
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 10:54:01 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd6185db7so5256845e9.1
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788857641; x=1789462441; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qEzX+SuqJwB0r7tN51E7MksqRdb/mhfYfgK8AikIn+k=;
 b=Un0vGRhAcCmUqS3PGbEQu1CGk4z1ROn+NO8j9B/Z6Ou3yjGk3RVmY6d08F8UGvs5Nj
 7yWnpZ1Ey2dnlQFtZ5t7eb1TYrsiuZfjcXOcQRgPMSI8oFZQqeIS6aLLlyHyA6VG2lpv
 4oL9L3h6uC1p0X8kqUWt7NaOAEa+MBZgAtEzBHR25FYH3FMrJ3f8pc6utkI34qq0xzgO
 mamiVcD77u0+NpIUQz93FCdSGwtepvY4soVeRvg6XA/RiK0iTu63cyzTXeqmJHPM4eLc
 f8BDMkFJfO16jkINuAsnU48QEkYXiyfFyXSdytuCdbge248Ouo4rW0gInq9sYHQsQsza
 CDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788857641; x=1789462441;
 h=date:content-transfer-encoding:content-type:subject:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qEzX+SuqJwB0r7tN51E7MksqRdb/mhfYfgK8AikIn+k=;
 b=rZYidT06o7ZSWJXy7qk1QvKmOc9gahWA1PY0JZMVd3J4eH2wpjikeMtOZRCqMEeHZL
 aSIcWrmGnMzjDDTK3LcYYDe8yT1HxArafo8crX5sW+VcJbFIzJD4Dtz4C2T23zZ3LUW0
 ZlyKqQuyt31h3J+pKVgXO7/6SFhVbuSk4AVy0lFBqT/NB4BCPa/dFjvg5aweVp9eajBy
 dgAbECfsNmxTlkPf1CnnZ6tdUt3n1ZuqR7twrp6Dz2GuPKh74KPJC19hbFG6L15djfL7
 WRLWTTDlbOyO3va8+g7xhCo+cibioa7j+Ay7C8Ku4w/BqnozUAw9zv8WCi05yjnlsWcF
 ot/g==
X-Gm-Message-State: AFuF++laQY0FfuXrGxtuysfnFEADP8s91MaiKtORkWgbP4kv6XinIdyy
 xpvxWhaZsA4xlDLgXhUTv1Qd9KFCXY99hQGlBuKgg7qcfBWqGaOAtezItCahh07c7g7ClgPw3nf
 w5vHtFwriEw==
X-Gm-Gg: AYBFou2RGS7+v2JeY562h2xxLSA16BNuoezzlvzURqLwObO1KKmr3ds99AB5g/ZHszL
 m7w0GM3R/H0VU1hOq9cmR1WXI9ocO95z3VMpv21OWmDTrTw7guZh/4vTRY3A9b5T0nEbq8Swe46
 XAIKraOpLPsfPC2CTIq3+E1aYm/OMTI+A1dNKdkUlt4KtBhUbCojyNGNlzgyxiNWYOr6oMiWHLJ
 mug8TqnxIrLoCzBRzhLjxvsPUt9PpenVAJasM92uUzqgPIDjGDmYHiMi66uqhmFxkgZomZWTFLg
 b+Ok4/VZHqDn4wPlvhHCSM6A5NzP5z6WBTdo97j/PwbpAvLITA0KoCbi1SX0C+aD8Mx94vnes6W
 7SzMWsqv+OSomttL0wlyYecqqN5KvdjxdvJfQ1Jly/eNAoIXS46OSy/AYvBt/isSGtJh9DBUcFk
 EQa046wMNi2N9SpIsOe6unh/5wSchcvSDTRvOtOxuzSp2o3IATm9yk0I1LzZA9KekIBJb7zaSI8
 XMKSGFXtnDJ34WPcNWAatWRna2mKr5ePF0bLLwuUe6cOHdfFyW2zratnOLyA7c3BS2Q99caAhmS
 iNeb1gjev9NBj6M92kKz9t7uqZg/epY6a8I+iA==
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49d1916215amr32789095e9.8.1788857640817; 
 Tue, 08 Sep 2026 01:54:00 -0700 (PDT)
Received: from p200300ef2f0668003240e6b4eee981a4.dip0.t-ipconnect.de
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm646571735e9.1.2026.09.08.01.54.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:54:00 -0700 (PDT)
Message-ID: <6a9fcd28.85d9e9d2.23a6a7.5d11@mx.google.com>
To: "LTP List" <ltp@lists.linux.it>
Date: Tue, 08 Sep 2026 08:53:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] kirk 4.2.0 release
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi everyone,

I am pleased to announce the release of kirk v4.2.0.

kirk is the test runner framework for the Linux Test Project (LTP).
The release is now available on PyPI:
https://pypi.org/project/kirk/4.2.0/

You can install or upgrade using pip:
    pip install --upgrade kirk

Key changes in this release:

Features & Enhancements:
- Add --dry-run option to preview tests before execution
- Add configurable fault injection interval option (--fault-injection-interval)
- Persist and export partial results when a session is aborted mid-suite

Bug Fixes:
- Fix --exec-timeout not killing tests in the shell channel
- Fix JSON report file being opened in read/write instead of write-only mode
- Fix incorrect log message when test parameters are missing in LTP metadata
- Fix exception handling in the event subsystem
- Fix --randomize CLI option description

Documentation & Quality:
- Comprehensive documentation updates (quickstart, SSH, LTX, QEMU, and plugins)
- Move IOBuffer implementations inside the sut module
- Improve test suite coverage and resolve flaky tests

Full changelog:
https://github.com/linux-test-project/kirk/releases/tag/v4.2.0

Thanks to everyone who contributed to this release.

Best regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
