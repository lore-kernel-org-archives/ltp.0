Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19AFC5AC80
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 15:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB7B3C5A85
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 17:35:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20CE13C2C1C
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 17:34:53 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 16DEE1A00145
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 17:34:53 +0200 (CEST)
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-448cf99c133so3435624fac.1
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786289691; x=1786894491; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4pkC9Cq45JFRSeVlFLgBnbLFq2BwSVfQjTBx9PFFCNg=;
 b=Dg6oAiX06eWaDzTnvobEU7/38OcNQHM2nTQzxqT5ie92EWhc6Bu61aiyDpH0XYegqu
 06QcOFh6GnRNJPLbII+U9YfkrU4f/Z7MtnaDIZgYXyYAdHYhqPgqjgFaA/RnYcC2X35q
 5aQoafdZxb0RfyCg13l2yCV9ICc/yd9iuSikkiqFilBgZb4HGuARH7So26CwrvvN9nka
 gKVygDUDlwVD1AuMRVHpc3v6ax2pXx/omGcwQJ+Ekk0KDIDhEfYGzZn/fQaNb7CJdM8s
 JgnkLZtxn4PZRiMZ3PN+H0ujALyy+9zKrWPOG+A5uwZy76/yup01vaA6M5keqhTCBiJ2
 zkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786289691; x=1786894491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4pkC9Cq45JFRSeVlFLgBnbLFq2BwSVfQjTBx9PFFCNg=;
 b=BR+o+IFcZ3/6w7nfBf1eg9GI19rDFUZ1vF59axhPxdeWvZ4HFzhGHPknjMt6h+vm8l
 FTkd9KlGsPHwJM5qfoCxUMxeMMMeKMCNy+dp1pH6Yey0hcaAiQYuDWwEN0lVIodaJ1d5
 PDl9JTQsmdzIjigXca7Awo2+bi2xzUq/sEvFnQ6bhqgOtJLyewsfyWWW4/FDyAcxpyqk
 44eaBC3rqJLQso931RzVQnxbSiFfDMrLVxmAMLgKCJs+wh/BIHt73nK9ge6O/Wj9x7+4
 lrTtDLcAdqJjhhEcXfRL5VqZ56mMtj6KB/FmOZc8HyI7nJ0RjX7gi6w6+ciV9BwRsXzv
 9+iQ==
X-Gm-Message-State: AOJu0YwR111mfuV2eizckhY0CyOC+wjSLmGS6+ZD8fvtvsuGaQYHhJlr
 m13imA6rCPjhuQqvmPtiQnnvYtwQVe2lT72TOVyNbLje3Lpj5C0RoKTf
X-Gm-Gg: AR+sD10cwyGDYk3F5iscnD5BzrymMRk+pLWJRXV0Sk7iOC4rUkktXg0/mgdNgetcJr6
 K9bo4e8YUjT4ZqzVgTj4rta4chSHFEVmD8MWVG/EOXdQX6wl+oyeFzgS6/SvtqOBBqwN7U36oMm
 MW4rGzFdkPfq5aaF/DvCCqDanajM+IyC21CCDrrUZO4bKBcklZSKxYbNOheONceUlwsB2o71Jq9
 PCJkFw9bosOhVLZxX1vgp6ttpt8W/CLfM8tLK/C945hUCoT3OzgmApfFhqu4h9O8y0Xkm2lYRdO
 QQ0tcdoLFQf66aFtxm+lbAaWp5ceDvuDtEHLWnr/ZvkAfBLi48/xfJDFOAW/HhQ7lZytv4zJtm2
 E8tqNTMVw82ftxPbXQZAhnwdkPjtfnP3ZZAeOqJWTn64E6rrcmxoCKvqBThDJZmfN/5ApOgp2is
 /kqWLxi5VA9m/Fqo68f/GGOob1QhRpL28nn/mhImvhvVNwBhp5EFMyoJnlRegsX1AwJnXT9ER/O
 6H8jd10BTr7vDdLlsVuvjou5uaOrJ7sK5pCTbsKY/0aLTIHCi5xjAxbpnKAjFzFKuK5XeafxvkT
 7rQ=
X-Received: by 2002:a05:6808:151f:b0:4a4:989:bb1f with SMTP id
 5614622812f47-4b1af83fc02mr6460421b6e.9.1786289691473; 
 Sun, 09 Aug 2026 08:34:51 -0700 (PDT)
Received: from
 runnervmvrwv9.ym4jgw421ayufkt5pkdtwnlkcd.gx.internal.cloudapp.net
 ([130.131.255.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af63f393sm4265685b6e.16.2026.08.09.08.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 08:34:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  9 Aug 2026 15:34:49 +0000
Message-ID: <20260809153449.9165-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809151559.1797774-1-pavrampu@linux.ibm.com>
References: <20260809151559.1797774-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

Hi Pavithra,

On Aug 9, 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

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
