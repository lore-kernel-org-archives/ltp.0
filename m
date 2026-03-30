Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5020BF3D60F
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774859540; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/AeS6O5ca07u2wBYHnw5ZFRQA4RMaeS96qmnoES3wnc=;
 b=cOAGvbVvgYWqx9Ld5rsd9VLIlSi8J2s78E1W2V1BjBcgSPHIkE7lfvBlHUeOceJrbC4Sr
 0/Qn6MMaZGs9fqsAwp6e+XUHyRjg4l8jr12hMOmdiDLSSNOue60wm7ZzKBryEp3/ZPWybku
 9gDzhfzYpKlggnc8jBBE0xPgRp7/97k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF5CE3E131D
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:32:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DC13C1014
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:31:58 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43F3410009B5
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:31:58 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so36874845e9.1
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774859518; x=1775464318; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ovGaIZCppCA25SlBG59vmYyFrLOY9sqrZJSfC/52hSs=;
 b=U1eLJ4uzBVouVqxWFPeGbHaekg7I67TKB9tKSgHI9K61K/4VCw8y4Xgx1WTgKj5mOP
 QkEtuVdtyzUttNPVU+LEhGJBXbnE6XnB0Gz6qgKvH644t7O6ix5yAqfSrft2UkNPEvEa
 wMJeqOVXfxjFeQtnhn+zZ4qWYbMdz0UvCY1Gy9ivC8i1km4h1Ez2K7OJ7u+StriJyiXN
 txBpxRBXnGqIBCFwfWpyWhfXFgaIC5oPB5c2xTdJjCDHgB74dJPIbJNDz6YZ5NlgfZNu
 p1pDAtDqDxcxdp6kA/vUnFsUvolhG9jQ7BxBKtDfgubN2lx7sOePiSU2KRLfBqEmY45T
 oJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774859518; x=1775464318;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovGaIZCppCA25SlBG59vmYyFrLOY9sqrZJSfC/52hSs=;
 b=cF8DnL4Xa7A9Bn9GN0vKKfad4aO12ZW6YmfVwXV7odSUrw6lJK4ELfQ4zFw3evRnoN
 1Lftk1Y7M46ypFX+b3zT9JHqaDflnAA1sb59Ws130XkOOjhOOjkmrK8CtO31gRU7EBqQ
 LLxQJZ77ZYNSuY6chZkNTvG1lqDMO4mPFPv7i8HkbvYrajYbONgGjupphU9J7j32UpaW
 gIhMb8ixogFJbROCg8C2QRbFXR+v8pMYazXvwtofccYmo921FVKIHGsizYWEFM2wGT9o
 felngVkyGvNyXmApgvVaWWauDH6ZkRFcPW7fy1/pWFW7W82TlSCO6kpCtfTJvViBX3sH
 /qGQ==
X-Gm-Message-State: AOJu0YxRcVkBMoZB+7wxVkiGsP0/gIoFk4naVtfkuW5TP9yqgjX3NyOu
 lRMFPGOIXeq0z4DcvBmrOdeElKqBbqEejubpdld/2RgaM3xEaKng0qGWm46lFZalHPVMlsbaQuY
 wpf2ApnE=
X-Gm-Gg: ATEYQzwCpOMvkgZGj3qNnB4oTxOeVLIxBWj2Eq4EoRahpz0W8ZpAbEo8ozTPtcmC+Zi
 CF625Uj1Q6wILMS05JjsGnzxsPdbwt2nosKZhaTUKb8hyNlZhM8Qcg81wX9qdN2MdxdLS78ZN/D
 MD9LRV0mi4iMzce3EWoard1VoyHoZSLVQEFLc+BW6h5G27LZbe1N1c4EaryMaa68Ig/FJE/KLH2
 mjqDapSQSGvtM5CCKIsXKcmP910WPIRZrKbV33Atq06uxLi/7CZl32zpL0wz3DjDCUeCucbS+/k
 l36SZMFCXrzaJ1mXpK7HD8Yk5jYCjYRuY58iKd/WYJk6zqeNFD6QgoSlwQHlWhhHewNel4KXbNO
 LrHfcDDfhUSuV56X+j4IX4HBRF7ThpYOy9ml2YXtLDxUhUVFDMMXQ1Au8ABj4F32pA9dkOYX7kV
 Lkc+ql1QVL0X9QYQX7B7cU9kjUVQjKCMmVChicJysq3yME7nsdeXRyb9daXCWwDaor3qwmiHB+d
 wP/IqPFxMuCTdTs8r/eLjvAceLafP5/FuM=
X-Received: by 2002:a05:600c:1393:b0:485:3c8f:e4d9 with SMTP id
 5b1f17b1804b1-487280a09a2mr194527215e9.26.1774859517524; 
 Mon, 30 Mar 2026 01:31:57 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm254167775e9.7.2026.03.30.01.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:31:57 -0700 (PDT)
Message-ID: <69ca34fd.050a0220.3c7430.fd79@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260321195817.119695-1-rbranco@suse.de>
Date: Mon, 30 Mar 2026 08:31:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Add test using UFFDIO_CONTINUE
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

The commit message needs a body explaining why this test is being added
(e.g. UFFDIO_CONTINUE with minor shmem faults was previously untested)
and that the missing UFFD_PAGEFAULT_FLAG_MINOR fallback define is also
added.

> +#define _GNU_SOURCE
> +#include "config.h"

_GNU_SOURCE is not needed here. None of the other userfaultfd tests use
it and nothing in this test requires GNU extensions.

[...]

> +static int page_size;
> +static char *page;
> +static int uffd;
> +static int memfd = -1;

uffd must be initialized to -1. Zero is a valid fd (stdin).

[...]

> +static void reset_pages(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +
> +	if (memfd >= 0) {

Use `if (memfd != -1)` -- that is the LTP fd-check convention.

Also, reset_pages() is the .cleanup callback but never closes uffd. If
run() aborts after SAFE_USERFAULTFD() but before spawning the thread
(e.g. TCONF at the feature check), uffd leaks. Add:

	if (uffd != -1)
		SAFE_CLOSE(uffd);

[...]

> +	SAFE_IOCTL(uffd, UFFDIO_CONTINUE, &uffdio_continue);
> +
> +	close(uffd);
> +	return NULL;

Use SAFE_CLOSE(uffd) instead of close(uffd).

[...]

> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);

Consider passing true for the retry parameter. The test does not need
privileged userfaultfd -- UFFD_FEATURE_MINOR_SHMEM works fine with
UFFD_USER_MODE_ONLY. With false, the test unnecessarily TCONFs on
systems where unprivileged_userfaultfd is disabled.

[...]

> +	uffdio_continue.range.start =
> +		msg.arg.pagefault.address & ~(page_size - 1);

page_size is int, so ~(page_size - 1) produces a signed int mask that
gets sign-extended when applied to the __u64 address. Cast to avoid
relying on implementation-defined behavior:

	msg.arg.pagefault.address & ~((unsigned long)page_size - 1);

[...]

> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
> +		NULL
> +	},

This test uses UFFD_FEATURE_MINOR_SHMEM, not write-protect.
CONFIG_HAVE_ARCH_USERFAULTFD_WP will wrongly skip the test on
architectures that support minor faults but not WP. Use
CONFIG_USERFAULTFD=y instead. The version gate is already handled by
.min_kver = "5.14".

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
