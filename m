Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C4C88E7D
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 16:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FB743E8CCD
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 18:24:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14BFA3E6997
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 18:24:26 +0200 (CEST)
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76915200063
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 18:24:26 +0200 (CEST)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-8046c3d6e35so1059266a34.1
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789489465; x=1790094265; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H3mxLaBF6rBJy1yu2i98I/Gx5Us2vyVxynnVqBh+Ic8=;
 b=ImUfZmhAzJmHpM7+E6tjUttjP4zSeWhUN7Y+l96S4C0KTTGXHjShGfsjXVzJTwQLhC
 4glyeQmhjI9up/Ptes4WKHyGSSBOEnhzuEGe7eMCy4yghReVKjXzRRWIukcoEJAGSHfH
 pHcJHJ9vwwjRclLsbavIE7NKLgURHL6UnSoXK8GVdxDFp0hDTxKbsY7TEdR+JCVllvru
 /Zfhzt01vVDfHp6vp14/JdxL313xN/eG/0RQy5vrPnFXnT/Xtf9lBPKFRGBaaMRynQk8
 uUYkXX+4thgAAsxc//weoYYbl3KPrrOy6Xlptm+XACTCbQcJmhAwK+qlW/lz81ahp/4T
 ucDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489465; x=1790094265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H3mxLaBF6rBJy1yu2i98I/Gx5Us2vyVxynnVqBh+Ic8=;
 b=GCf8ru/xLOpR7LKmpT1yGSxwUOD4jJj4N32ksMbS3m3AWdrQ6Mud+7tXMA9A6evCl1
 PXuyOYAoMr5Roz01Wg/bRuV3g9x9sjvw+mHTjbfTCslwGC+SnrxmVkL9yv8KyrdZXhJj
 XApLyfKJD99jcdPiRrKh8WrElD7e0ulQ5z6Zj2PBvD1ZN5jCfSwPQKWg5z+xFPDqzqKd
 +uQ++XwXVB8YdBVt9OJIZVy1b2jrQ6D33PlYZjvPPdExj2vsjmUsyHCalY6nHw6+qsRk
 8q/9p3QH0IHupk7LH4H576KI252tFw5sFd/sCJJvf+8Hrd5lO+X6OzNpxmPIaNkBwRpo
 l13Q==
X-Gm-Message-State: AFuF++lbi66ZfSAP+OIXZnfPP/9tjpbbm5f05B1grVoME361lgdkcHIg
 d7RwvptguUpQzVsOVl7YTD9SdY+tUjxIKxWHtUWBl+xKMobvi8Kkq85n
X-Gm-Gg: AYBFou0xTM1m5+Onn0yUmWo9hP+nwRPL7b6q/PQJ0KUzrS8RPNzL+IG0/9Okp3X1v4A
 6z1JTsxcGcvLfrTi5kmhdzY7iMVZXsrYiaqJ7jOZzBoY1GRv2v0MFRu2kY++p0ymv7VQx4BmOFv
 tkEMDnF79bdxa+ayW4CKP3FjN7aa6ochL65QRuYJuOSM7kWQMiVXk60d7YXfFoMbr+xuwXESHEI
 VoFEHRUK6uNqB6aPEeiZQwhBxQZ5CLgsojzhjPnuldgRXc9TbtFHX4yUgMDoBbhkC9baLVNVXj/
 OBK5ohUpqlLJU65gmc0PJy7Q642A+l01uD6TStTmpw2xBrkisPV2keFxH2D9+iendCEuNXXvPyZ
 kq3m2GdL3Opy9yznpLai9Eq9mZFX2jTuAv5Uh630nqxXXEIKnolV6vOfGXkIU1Xp6BdZEEj+u6Y
 ia24a9EDNdDz9vlUZh01IeWR85sr4VoUI9O4jifNm6PGxwqHvXQCvujuZr3XOhcsArTNGQJikpJ
 ersDUX7ZuM4yPUTxq2vIqHdZyPW+1Tal6zYCuQWPdmJNg8d1QKla5eSXbZL7JDKnxN4nGqytfIp
 Rl9JQengIL+g
X-Received: by 2002:a05:6830:6d2b:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-80a7204866emr1420206a34.0.1789489464901; 
 Tue, 15 Sep 2026 09:24:24 -0700 (PDT)
Received: from
 runnervmlun5p.jjt3rdyyrj2ell0hqm3yzz5wde.gx.internal.cloudapp.net
 ([52.176.137.217]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5adf69csm15042000a34.7.2026.09.15.09.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:24:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 15 Sep 2026 16:24:23 +0000
Message-ID: <20260915162423.9003-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915153738.78189-1-avinesh.kumar@suse.com>
References: <20260915153738.78189-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] uevent0[123]: make check fixes
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

Hi Avinesh,

On Tue Sep 15 17:37:37 2026 +0200, Avinesh Kumar wrote:
> uevent0[123]: make check fixes

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
