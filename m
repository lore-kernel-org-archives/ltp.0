Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0444BC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787816653; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HJsHlc5YuLVfa8AC5vcF4qlX8evbnIO3rBTjMkR+n5M=;
 b=grrw9hZLKiPhjTUxOc55BHlCp/pka4Lpv+JA/nLVF9kE6BHrTJkyOqiIAazvCF6OWqcmt
 N5dUMNk7xzb5fLsu1h5JvS3tYFZW1CmYKNEOzE6nnU7t42nS4CkLvQB76lroHbn32au0KOK
 GgO08gABC/9VuCFTFzMjZVIv/2LA6xA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94AFB3D0EE9
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 09:44:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833D73C20C3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:43:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 772242000DB
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:43:45 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so10640895e9.3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787816625; x=1788421425; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kq8lYcolIRGh9KC4ZpgkTZDC5uTTeyYQwTyeQYhSvYQ=;
 b=NKIFbPi1rwq85mFJFsuL3YuaghJ294V45MuNyFdUF654aPpDb1KZlVOGG3ul6E/7tI
 008c5NCugaBm17Nf+FqUgALjmAhqX16JaGPVJhMmSWWoUI221cZ8whnDZ9NisgQqEDEZ
 AHKwWHJy0ZpsQMi4QDxhWWX2w9OvWzwN1UgHqpYNagid56yv2lDXDZ6LNyJy89tDTdTr
 NufUh9FBED+nBC97oCCHlWwcPJKy8kndjqLdkeMH2xOgNIP9LsUKKWtluaJrbdNWVPF1
 ENdV5oBlMDT51+UErpj+oL0tMh7+yz7JbfaIf4IDnvRqY2LHyRE4tTONbsK3StkAOwoi
 pLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816625; x=1788421425;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kq8lYcolIRGh9KC4ZpgkTZDC5uTTeyYQwTyeQYhSvYQ=;
 b=gQsd5dc6QHDQ4Owy0Uw4RMHqi45eDmcO9znohAWBxKloQDCHYk4A9njEWb5R0t5rSg
 vuPpXshMxUSrlLOud5sOtDUILpiju2WL4UZduQrDtDnUtLoRcsQkCvD5nBweErR6IsEl
 QUIftZ7+9OsDE/1HBouxiIjwlXQXRmtpjG+WLK1JJ6lFKbW6CwEO3XVHDFvAyNXaQEJD
 tP/Fektd8lDZtUeqeu1MEn8Mb6Qd5rsVY80+S5c18fFGPgaiCYVXnKQF2KcXOK9KZGO2
 7z7lW48JZmcs1JYoAmtO/qShOhgC5xlrzwS/MHYy3eZPK/4E8WT6g+20dnTwjnYSkqb1
 toqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8pJvRTFeLOfgUzKEHU0vgIcuhRxGUqhcdyOZyFtvV1YZJF5WZ7rQjewTAoFl4mMx1NxY=@lists.linux.it
X-Gm-Message-State: AFuF++mlWwC9bobeD1hX+Xw56+H3I2Uh/WGkoB24qSC9U+i6P01wRoGa
 upSujC7cT8g0Q6yFvisOCzjaHn8APvPNdKdWz3tS8V3z2vlGsT4ifxUnBC8xMX8fgodR5iS7CIs
 rW5cQN34iug==
X-Gm-Gg: AR+sD10c43NEa4z4MnT0hAWNsqEXKvU0hZ/0j0q3+uYlm0v58ekN2xHHGveWtC3C5XP
 H1pmj8rLsIQDQD2VXHf897pgJXvfa5lcVNRHJ75755JrOiMGX4Ac6c15zGICQReteF54XxzCedi
 FKlZGfG+3WyVJ2Wr+zRsWMn+K8bLEBSHRvDyWhQg9utNLjbGEvBCpXGb3sEoy06FaxcWb6We4XR
 RJIgDjIH/olVipfB49zPGR1zt3YYf7ueEWBYh2nUQ9DY+KXccYc3SfOdKAZSGHbXtASe76VyVD3
 VuZnsV70ZkJfTiqmuXeGEacOXsYIRQR+F3o83GIbRRFGhcI7Ei+pznj5ajH8KYSR1qF7FCXYzG0
 8heBPvh94ZRqFDxvLTMpEGJYOH6jWpL4iayYOr6Jtap2FUXfWre0XqlQtFdE/0REMZ5GyZGpZAg
 wHL6KyVEUeTDRDkjq0RiTNv5Cw2VorsYjIE73ngSLViCpY8qcYoOGhxOKvpdI0giP/hnryYyxOy
 Vjq/vo1tgq4ewdd018DHk3QwgchXZE4xdrPNzBxS6TH2bPASRcPNkVZgshgRpPw7dkaadH0rNt/
 IPaXyg==
X-Received: by 2002:a05:600c:8597:b0:49a:252d:52f5 with SMTP id
 5b1f17b1804b1-49a252d5393mr93052195e9.11.1787816613311; 
 Thu, 27 Aug 2026 00:43:33 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f231dsm6711228f8f.31.2026.08.27.00.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:43:32 -0700 (PDT)
Message-ID: <6a8feaa4.c69142e7.26d8ab.d0a0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ao8E9xmRqH35vJrz@yuki.lan>
Date: Thu, 27 Aug 2026 07:43:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fallocate01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> fallocate01.c:103: TPASS: write into the newly allocated region returned 1
> fallocate01.c:92: TFAIL: fallocate(FALLOC_FL_KEEP_SIZE, 393216, 32768) failed: EOPNOTSUPP (95)
> fallocate01.c:97: TPASS: file_stat.st_size == expected_size (393216)
> fallocate01.c:101: TPASS: pos == offset + write_offset (409600)
> fallocate01.c:103: TPASS: write into the newly allocated region returned 1
> 
> 
> I guess that the easiest solution is to use
> TST_EXP_PASS_OR_FAIL(..., EOPNOTSUPP, ...) in the run() function
> instead.

mmmh...I guess we need to keep the gate on ENOSYS and to check for
ENOTSUPP in here, but we can't use TST_EXP_PASS_OR_FAIL(). That will
TFAIL on succeed, so I need to use the same test function for both
setup() and run()

static int test_fallocate(int fd, int mode, long len, long off)
{
	TEST(fallocate(fd, mode, len, off));
	if (TST_RET != 0) {
		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS)
			tst_brk(TCONF, "fallocate() not supported");

		tst_brk(TBROK | TTERRNO, "fallocate() failed");
	}

	return TST_RET;
}

and use it into setup() + run() with TST_EXP_PASS()

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
