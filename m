Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F5606A31D
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=XJbOpn8z;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CwJOBHmv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792766954; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=5Jiu5AJqQVi+0WY7DVZVuTv377Q1rH0rKI78IzDyCYA=;
 b=XJbOpn8zHu0ThiI9zumDjqnCjS7B3f5kd8zXuNihBQqbXQ8wo/tUoA6bBDMeYU5BCxptP
 ZYRbUuejs5GYagDsb3L77lTQLGFshheL2PgWWfV4EHpaNVLe67aXAhgpG94oFLBzTb4McVg
 ZvUkpRi932hUNBZteuq3RcUP7jvLivE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3BD83E9BEA
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 16:49:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6487D3C01A8
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:48:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9553F1A00119
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:48:54 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so10248685e9.3
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792766934; x=1793371734; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:to:message-id:subject
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+FHl5nzunG0panDOIAZ1/NIAyp2Jqph9E4zuQaioI9Q=;
 b=CwJOBHmvFRZbZZcyd9c44fRTKqKYjV/PXnZ2CfCQaRPlc1WQMK8yqc1e53ALVm+fzo
 xcx9o4dkAsUpobqJfWA75BkKYyL1dlvqODbQvE0K3YHlpo1J2r2ZQ4f0KPyuDB+4dVfx
 gF5lB+m+R5zHDoyOrwszUJhK8KiLTuwgwm+REdMGi2necX6m9qmZzoVYI66GY6MBuq0g
 f4ZXTFkGOKwdmfj78QEXZc6Ag7no3LjmjmU+Fts7gPACfNvPKqLbWN9mdD1hOXENWxxj
 ZSOuHA7uzpL3RsvLvPMTmLco2HMDS6A53WjJ/8ejU/DZmjsJj3znpkLi3PmjS65xczEE
 1Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766934; x=1793371734;
 h=date:content-transfer-encoding:content-type:to:message-id:subject
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+FHl5nzunG0panDOIAZ1/NIAyp2Jqph9E4zuQaioI9Q=;
 b=qOroM7k+1GXTJOLs2jo21BhiuVYLh1GiZdBq9WpS+cag3AKIAQyeTfqUzpTO+Bs8XF
 Es/LX2W2uPrQu+pRlgjKMSvwm1ea4TYJ7LzPtntykWVP+uVangk/ecQpQG/3jmnigpBM
 ZHhpndUsTVHqPofS914fVphcMUfyPsVcGLg7jV1fp5DL5apxu8KHHMzIDq0EeYpX551h
 wG8+ZGQ+4qO9xYSL14kt/n1DV+WLXf3nyFVqUG0Ibv7pY6CDuQexChbLumpcTFptQULr
 kOH5Gs2qck6I4L+Ri37zMV9ifRXfCEN9y8EpTZciEqdJOgu+J+DqnU8VO3QRNidcw+68
 l5Hw==
X-Gm-Message-State: AFq9FYLdgp81Yl/KGJwzgFU/+TG7F7uXsZ1efwNMFNPKSCeg4tVAjeL6
 EgduGTXdh0PX21RljMZxD/cLBsqAbRYo1haoefvJkjdd2r65v77PFM9bdXZhJcpDhqIN+Jy5qFs
 htvw+oOg=
X-Gm-Gg: AYBFou2TnaQxHn44uAUXzlbHcxpxLr8NzWEne9jZonDB3OE47gHQ4mpa+aOqjBHA/y4
 8nTh0LtBwb6J42ngvsQk/DbSSiha5QTIRZy2nusDjT7dsMvX42bzJHi86OdTMvUIrZpa71KgvWj
 1hDA0xe9BbltqWMdiXi9WK5LMn35k6nDRwJOxUj6wrri2TGswZViAtCJrI+E6tEG+cQK1jGbGhE
 9vV3kQjiwAG7iIc50au2Wqw/dqDQIU7DwE0AnuM5RcfDMbwfY2p17HYvrv/ObhZ8uJdsqCy8XrY
 iyQDaYroa52A4N1sq23cTHiqmOKT6LR0wkewp+fj4Xi3mD1tiY+jFOyT9BHOfQGQX7WcX+ZipZ2
 y20tAcqP17fbWgBHc+jRqyNpfWHPwpfDEmovpZ5KEOZydq8T7jvptvxEoYoM3K/ZPjCBwi0UtiU
 2uG2iEymXl1toCnXnu0sVe+N4UbJfjOYPSTBkDvCt3GJw9pTqDpOGY09tvQd2VnDD/x9c6XqWkw
 3dySlFpbY4kwL4Oh2mpDuxCJwybFrLqaI69c6VFpD9RKKt2/v1LaVNN1t1H0XNV7IYKbAPxcQcQ
 OwvvjwD5aQ82HioHkO5T29N3VyQM
X-Received: by 2002:a05:600c:8b02:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4a211bb8928mr46113785e9.0.1792766933726; 
 Fri, 23 Oct 2026 07:48:53 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6ccsm247554f8f.18.2026.10.23.07.48.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:48:53 -0700 (PDT)
Message-ID: <qMNc0qsS5fB4DdGRWa5zRdfe1Tyh5BQQN3Hc@localhost.localdomain>
To: "LTP List" <ltp@lists.linux.it>
Date: Fri, 23 Oct 2026 14:48:52 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 4th of November 09:00 UTC
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP meeting.
As previously discussed.

Next meeting will be the 4th of November 9:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
