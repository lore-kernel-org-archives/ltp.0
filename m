Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642ABC55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A1B63CAE57
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 19:35:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6A1B3C332C
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:35:00 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67EF8140006D
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:35:00 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 d75a77b69052e-51e47c6269bso4330351cf.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785951299; x=1786556099; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2g9pMhjMsf/0iyN7KStZh+TpUbH9lzeV7NMMTLzGWFw=;
 b=VAI+5PslnAIwc4w3ZBUAfIf2MAVApskJDbkH0eSxwSNJS+UXjSSxoouteE8PJwHifU
 9clRs+Sp+DS3GudduBTyax3/Im34pJ/9jXPvuS/LI+lhJZiLHmQDDydyzgs3oxqJW5eD
 WzWKi7kiMPMXRJBh4gy3Plo1xxc5RjHkjUJ212N3XiDXcUCAe+URXZXUqM5qbUAAu5bE
 ddsx2Kv4IY7S/AARKqV9kl+y1ujnOU7n6hOCMW73Zs9+QPAqoHFDrn/XPpSNRWasAS1s
 E0VlPo0p3kQ7wFryZBViXFoG8FeBrzpLRccqptBUnJ+KENC46im6EUp3RBAYP0JwS39X
 /mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785951299; x=1786556099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2g9pMhjMsf/0iyN7KStZh+TpUbH9lzeV7NMMTLzGWFw=;
 b=SYTln+cMyWnAWNlbDX+p9/B25Bnw2r8lxDsenx7oYh7hS6bP8f9TMLZ51s/hnM4rnB
 HwwfhaOalYgWH1jFY6RrXXgLKg2FzJmitqbq/r83MtQPIRtENetPWbxbGAumkUzkltbe
 zZCNUuAki9vzjK8tB3LPqrqE20c6FJiGjQGQ33hcNXk8jSEIBf9Dk/EHEiueh2ZNMJju
 azKXxtsQGBvjrWbTfAs/wlq3eR4vg5xiuOaaGIiFoVkeqP62xJdBBaBlFWf6GXHKUl1t
 Y3cbl1Ay30Sn0lbXq6eCUBsqlMqOeXixy/yAMrY8Q0UJc9HTEDZmI1lr1J8UvnUQBtei
 5DUg==
X-Gm-Message-State: AOJu0YxgnsM0urcOW7pJa/iEvAxsQcLB/j2DI1V2xnofkVZOspR994Ry
 PARHTXuEsNzr0AE1+3zkSBr31SX+/80VVamglTeuBP56dYtYFbrbDhvv
X-Gm-Gg: AR+sD136l2pqiJOoDQxOTT43LPRp1FV2broZxjRhn7K2B3sye/t3eMqiqxVizyNQpFG
 3C1EEEmw7t6O5aTULAx7IkH6looptNIygVA/R9K5YDR+4NtAi46T8HuRo7fuRf1v0j0vyFSxJZW
 Ueq3uZwVvNoi6AYO4G0OrTyYIK9tbiwpOpYMPdMDvYrenMRP8liwDd0NLbMNcTSl68jE15F5Lfi
 X4ZCpBFm4SmGl70lQtIKw7ZZ6oCTW03CYJI8C+nEDYhvLr1+WlXlk0TnJFZB/1k7Yl1ZjVVXxBU
 N1HsLhWh0OWnDt9BvyqyKoU19U1JFxmsu9WsNUplKDWwDeggq0QoeprZK/Xd+IUzSjrnbkoV7T9
 glNqaf7v1d4k9Kr0s1eMAH5SpiyInklGxwGyZ/kSAdvZEOWw53/oBqM2h0+3oRsuGsYzvAJBgJ3
 rHSwIosQWEXJFoAq8Mhi52cGWQnf3oyMQY4vHE/tksjcrVY9RyBlTSb2QhySui4+Hh1+5evu2XI
 EIXVn8P7tTVmp3fseb/bZg9evSNfJpO90h6SZ6ZA/0+yMpQtjQY2m/rmwgIX9G6BlzM9C2utEeX
 Mgc=
X-Received: by 2002:a05:622a:1c09:b0:51c:1a17:eba4 with SMTP id
 d75a77b69052e-52ce612c1cemr91605191cf.24.1785951298874; 
 Wed, 05 Aug 2026 10:34:58 -0700 (PDT)
Received: from
 runnervmvrwv9.akelbcx354lezf21v2ik45greg.bx.internal.cloudapp.net
 ([172.174.165.224]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce84a280esm26289341cf.0.2026.08.05.10.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:34:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Aug 2026 17:34:57 +0000
Message-ID: <20260805173457.4172-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805151451.648990-2-pvorel@suse.cz>
References: <20260805151451.648990-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi Petr,

On Wed, 5 Aug 2026, Petr Vorel wrote:
> tst_kvercmp: Factor out error handling

--- [PATCH 1/9] ---

> +static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)

Could this helper use an unreserved name such as parse_kver()?
Identifiers beginning with an underscore are reserved at file scope and are
explicitly disallowed by the LTP C coding rules.

--- [PATCH 4/9] ---

> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "creat() succeeded unexpectedly");
> +		return;
> +	}

Could this path kill and reap pid before returning? This patch exposes the
path on affected 6.11 and 6.12 kernels, but the child remains executing
creat07_child. run_tests() then blocks in tst_reap_children() instead of
finishing with the reported TFAIL, and the test eventually times out.

--- [PATCH 5/9] ---

>  static struct tst_test test = {
>  	.setup = do_setup,
> +	.max_kver = "7.1",
>  	.test = do_test,

Could only the FAN_REPORT_PIDFD | FAN_REPORT_TID case be adjusted or omitted
on 7.2 and newer? The second case remains valid, and no other fanotify C test
initializes a group with FAN_REPORT_PIDFD | FAN_REPORT_FID |
FAN_REPORT_DFID_NAME. Since 7.2 is already stable, gating the whole test
immediately removes that coverage on current kernels.

--- [PATCH 6/9] ---

> +static struct tst_test test = {
> +	.min_kver = "4.4",
> +	.max_kver = "5.0",
> +	.test_all = do_test,
> +};

Could the bounds include kernels used by current CI? On stable 7.2, and every
kernel newer than 5.0.x, the library exits with TCONF before do_test() runs.
The test therefore does not perform the CI check described by the commit
message.

--- [PATCH 9/9] ---

> +	if (min_kver && max_kver) {
> +		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {

Could this validation use the same two-component maximum semantics as
check_max_kver()? For example, min_kver "7.1.5" and max_kver "7.1" form a
valid interval because max_kver "7.1" permits every 7.1.x kernel, but this
comparison rejects it as min_kver greater than max_kver.

> +include $(top_srcdir)/include/mk/testcases.mk
> +metaparse: HOST_LDLIBS		+= -lltp

Could the required helpers instead be compiled with HOSTCC? testcases.mk
builds libltp.a with the target CC, while metaparse is linked with HOSTCC.
During cross compilation, the target objects cannot be linked into the host
executable, so metadata generation fails with an incompatible object format.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
