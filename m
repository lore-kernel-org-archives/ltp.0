Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A875DCD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 04:04:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF8B23E6BF9
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 06:04:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99B53C537D
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 06:04:19 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73653140074F
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 06:04:19 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-91ae31bbaa9so54780185a.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781755458; x=1782360258; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/yJwom/BsLTtuZHCWVADwtP6Q1HPeCgN/plRQVROjs=;
 b=iE4Th5BgpCxFtTc/f824Z8cPAMolO2A9UU7lvDdouz2u/fabS1TFWZzSnSgLuvEhEw
 MTN9WwoZzTtVNtjkBouH/FazB1Lsf3qCsp+NTmxRw8EFFDh2+vIfPZwPrKVfa71jVqw0
 QltHyVojfbxXY7MxSSc6cRFeCCC3EMPd5V8sT68yX9sQp0wJ086f7MnEYP1h/3+pS5Xf
 3K1VfvJLdJcRJtuc6e/rp+Ocz4H7LcysLJeenJ4PIHwhIUsEwKhPPd5kX1AZEBxzC1NL
 mvXZMm4/rvX0WMFMQ6jIZNM6KP368eRsDoqlFGGw7VtjNeNYmX6Ux9kAcFaU2iMwYvOo
 C7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755458; x=1782360258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b/yJwom/BsLTtuZHCWVADwtP6Q1HPeCgN/plRQVROjs=;
 b=HNZ6QinzEIkAQPjHWN7XtKHxeHk0txmSEcQJ4szqySGkfkhWiixBAh29eUlngaJex/
 Kd1tYyeoPqwH24hldQ4pp/tW8ZLESHKMOa2VjEaRCJD/o2hCgJV4bxCCnOQeuOzLmVJ8
 ygiONpf4zbu80PDvs+4zbinKK9j2lUP2Ci4KEmIW79ZW5KaL+EYrJrGMvAwdEYnfEueW
 red6QgcseAgS2RjcWqBVnCUCdkkGxI34sZM85J5OnJM+AFyFflK+fLG4GdjVBbI3V76P
 S6u5AyKUYWRVPQXoIjVySYuRhLl5lUjFhxdmRGMrcqMKXg0UqhpGObeC149wzau1LCZO
 WM6A==
X-Gm-Message-State: AOJu0Yx0NSnLhryzecpJdkFk2aKDFEspekw5mdCkACNEte55rtlu//SJ
 cDHAlR8Rqb6Jb3jm9iOSF1aC3Of2YcOCq3L71xQkcQO7pWM7AhullNxe
X-Gm-Gg: Acq92OFLg/G8z9HrCts6DuEp6UJgKHf5ptBqpvvKtJ8anD8tdmHnXKl8m73YMIPBWA/
 2MCoBvI7UjpWWPMkXM96FhY63QyHzgfgkBSPC0tXgQKl3rStSQJmsDIpTz9OUftp4eyxgRUKrVP
 RZ0WSauJMokfNb2mODTgBzOf2ZqbE2BwjVdjVhnIgH8CPzYvDg6kGJgZfg2Bo6lwYdcBntq9LFm
 8QrNDcUW+OPBXB3M67Gtsomh2qPoH3IteCEoa6IVd3k18xpvOVxHRIM8nzAYgN2mbSWeJJjHm99
 15wyksbW9TkmhpFlvEj/i1cNhHmPvW1aXHSWZAdeM2oWd1XWxcS1/OaatHWlPSJbuAN8IdFjrG9
 5dhnjRb4hWWzpp9y8pTze7dRo6PyyiX3wQ6GXFgeTm3Z+BuSwEt+V2qp3tOrTbqU4v+k3HG2XLQ
 ADe/7RKMquog4XVdix5Dk5KV1j2MVKB0P8kuQ957EBTzZ+/1uguch9gymesQ2GOuViv42ZBjAmF
 sA65asZmpeo3kPqTEN+NLpvjZibbmowB7lFn0FY9Q==
X-Received: by 2002:a05:622a:2611:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-519ac38fbd1mr96627571cf.32.1781755457942; 
 Wed, 17 Jun 2026 21:04:17 -0700 (PDT)
Received: from
 runnervm1li68.i3bvc2db5o2uln5sftk5ylwv3b.ex.internal.cloudapp.net
 ([172.183.135.145]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb61d948sm179301451cf.1.2026.06.17.21.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:04:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 18 Jun 2026 04:04:16 +0000
Message-ID: <20260618040416.4044-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618023820.9823-1-wegao@suse.com>
References: <20260618023820.9823-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

On Thu, 18 Jun 2026 02:38:02 +0000, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP) {
> +			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> +		}

Minor: the inner if/else branches are single-statement bodies, so
braces should be dropped per kernel coding style.

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
