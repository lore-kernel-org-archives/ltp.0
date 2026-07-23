Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC7C531CC
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66923E559F
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 044323C713B
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:12:47 +0200 (CEST)
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C12C601400
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:12:47 +0200 (CEST)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-38ed4d37526so209344a91.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784805166; x=1785409966; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJiVWUyo817kAcqAGsoAqEquj4alVhXrW+TUBNgHQ+s=;
 b=TTocOVnDBHeBKbK9+X1sMQPmTyYunTW1O3DwpmurnF0bids0N8Lq5nZ5BBogcBlolq
 90KU2pUwYH8oMr5uZE2GNkn16M+xb4PddwM3Trk6t5UQnoddZfdQGwFlX1amVfCIyI6S
 kh7rcdaxE1GMh8h4sIXtsiyI6yf4EaMGRiBTqTVBAt3aYumlWbOd3i4ywTU8s2rrI6CX
 xgChrCdMm2hjmKZhAwuEfXbIl7uEiyg5gfFdNgmJz6FJ5wJg9jBSn4+UwELeIfxbEYT0
 T6bsM6dR7TwZXxUZxV3cOAdMeR2fWMixDdyx3SYEwqXiqAAhJdOXha95uRyyGyNxFBCd
 ckHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784805166; x=1785409966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJiVWUyo817kAcqAGsoAqEquj4alVhXrW+TUBNgHQ+s=;
 b=gYIjhGiZ4PbwE1WmigEi1EbNozHPfnaF0lKnIcTPZIomjQ7tFMDofT8j+i+zWe7iof
 JQHB4y2yb/g8iQ5jPxP/0UjsKGiV4WbHgc+2Zf0Kt8ioKidmCMuy4K5gmXoD8L16s/k2
 6M6oHF2pSchE4FgLmINPDE80T0ufRDVfWGl5/sxbI5gJ39wmvRGZB5E+ejnXXf4vH2wi
 u5BjZyBeVF57RAd+ea8CS4vfHxn5yy+v3kO4iCWbL6DPwHH1s+RCQbCLP+NI0GhAQHEl
 OWS3PRkcj8gYN4EN2nC9XEXN7GY7nFLZYH9vw8Gc5yiPnoyzcKnGzvb1Kb2phSjZrW7w
 4FIA==
X-Gm-Message-State: AOJu0YygFbDQGXpU57G29vXGwuuZu+t9ZyZ4JVn5mRcQ+9OT9xsHVm7w
 FK+O0FyZhDtb8vF5SfM/Y4Vt9NJ+N8BDcmwLw/Lb8W6yeLWjMaZeVFi9
X-Gm-Gg: AR+sD10gQ0bmENkz0junykFcsSsUJnxysRK4pwSbiDrIN7lcCz9oHUt/VC3RH/vB5r/
 GRehLJGyCPeZTFf2G+gqw5/AKzhMPqWxjxpu9rps0rznZn5ZsErgg1+zE3+YN7ECTsV7AkMIKYz
 Qi5EbKKhkjWxjyRIOg+wT/63TpBbeo5eaqqh+Zn7eMLz3GdI/fQoDMvKxM1C35uRAGgSe51/d8/
 LRWixk/baA4OVYTw5MlsiFuYMbXivMMOcz1mtVAr2B6SjfWTzKMWZIUATFhYP0/IVxOGE4VnOEV
 4pShJKQZTI5739l7K4c6ZxBfZHyvXmM1DZRDXh0cx31Eq+/V4aMAnOdGa2oogaBNHysZYfRXihY
 RS2DUkiVmZ/jT4CT6T7PNXBnNj/OtuBLwjt8kH+huC7BLIlAVZv/pYNVVjAgtBi0O6Fo/EyvfyX
 NA0IZtIETpzEXlmDalpQSvihbDu3snx7NuWHjjydlhdQFQe0c+Jo3yLlihtoXn2joO+RVLGNNc0
 MM+1YQvCnHk/9/j0iA=
X-Received: by 2002:a05:6a21:117:b0:3bf:e3d6:ab5a with SMTP id
 adf61e73a8af0-3c44b210ec8mr2766514637.52.1784805165479; 
 Thu, 23 Jul 2026 04:12:45 -0700 (PDT)
Received: from
 runnervmvrwv9.ps0ws210rtxenopwlmuwzeo0pd.phxx.internal.cloudapp.net
 ([20.169.93.36]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm20594548eec.27.2026.07.23.04.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:12:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 23 Jul 2026 11:12:43 +0000
Message-ID: <20260723111243.3858-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723094647.5051-1-wegao@suse.com>
References: <20260723094647.5051-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Scale cgroup memory/swap limits dynamically
 with page size
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

Hi Wei,

On Thu, 23 Jul 2026, Wei Gao wrote:
> madvise09: Scale cgroup memory/swap limits dynamically with page size

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
