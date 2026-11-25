Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E4606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sw+FZ1iK
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0BC33EA02B
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 02:10:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DEAC3E9197
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 02:10:31 +0100 (CET)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31A996008B9
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 02:10:31 +0100 (CET)
Received: by mail-oo2-x05.google.com with SMTP id
 006d021491bc7-7033e26cb19so1626448eaf.0
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795569030; x=1796173830; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYnnFFlGrlqu173L2qV2EB9eE04XzLQbZCpBVVTAaE8=;
 b=sw+FZ1iKl00abvXrz5glZPIr7ap4g0vVxn7y9rNPP44i4JAkLvxv2WLaCevFJ0JT+B
 fC416LTuqtOPpgCOPNhTQNkC0kETlstv4CZZZWGXC7r0BGSL2Xm/gHDtRPPe0ocnq9VS
 +YLIYdDffdhjDougEn7rCHHf6yduu4tkuJn4TJQJ39jmLAEoaOpaqL9410djnU9ITlaS
 uUbXu2Oab0EJGeiy3UcCuxlkW7xZf0O61exaa0cr3Ee8EWF6Uc2uuU18EKVkRKrq7SpD
 qdinDOq4HeffJNM7Of6cHMsWVEb8FzPUDE6qZ6ZXfhgqWXuykHA7KTBxGATF3c/tEf4M
 7b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795569030; x=1796173830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hYnnFFlGrlqu173L2qV2EB9eE04XzLQbZCpBVVTAaE8=;
 b=fExGmKn86wEiYk5mXjH49NWOeGm8bj5dp36EQYlxlFbawMLBn76tVjrtkQIHwUx618
 S4y9v5Pg6zWRHeKd/agr9FXIfyoNFHYXz2CuR7aEtoKgAybiD90H1lMhGgmtGTnO+9yJ
 YGaijAzzuNt658G6I/qmenX2Rh+4RbGSgkJN63Vx7oy+KcMjpTvGWdnT34j/OkveNZqQ
 754s457JQ5eSR361ghYfe8UwEhthvDHB+glFjvI+Ldp+SEIZRJnAvQmBXXLrZFTpLcXW
 fFWEhkH6yRoJdpdM2KkBnoHgFN1cnKEoW4oPzWFPGWqW2I4wNTRz9dRt7rY0pbCLdvLS
 cNkw==
X-Gm-Message-State: APuU4Z+j6XhbWusHLvPo9DuAINhvazE1Azra0SSwu3an38hRjZ/7U5Xj
 zyCWhjkD09eOtgsIpJWM+8xRzEIcJys4ucDIfXSWyJ1zEkbvBgDBuMJy
X-Gm-Gg: AZFdTZc0yscFP2B0s29jI6f0FIEXedG1t9+Lx2UJ9Da/UQzNN0aO5MTqZcJjyMpm4BS
 qoJ5vhL3EjsZ1wGivj5I1PaWnZCvQ8XWo+BUqqAUee91Z79Ch9pCRu9ATo/ylWnFb8S6/phh3hV
 mwwmUgU3iWbKkPwtr2QJPiU0p0g5Y2tNX+k5P9wbLehFx753R8VD1KIMhc9P4LTUkT2uPDTS8dE
 G+OcTcH6qRARynBAzhZ++G0O+5j6NTi1ZUXubLVGbalHw3wdfVcD9CAT2Vna7PrszPURG4Bz9w2
 zPfdUB/6k/qz0SirJ96OCSQBbIpV/rFj+m0KIIP3fhg+zv3fyVyGTXzrtGk56t9BtiOg29hV2zV
 pUGsKSQhUcHFM8VvoNnV5qCBWTbX5vfSncpKVFxyUwVH1QQrlkFNAPgOLn8lckQQT9v9Hwchs9g
 Fv6YJlMsKlAJmPiiuwHlRBVwaA074NLQqJQQjqfrBElfcuKoto5eb+wYeIvbyHomq6d3wY1tfGE
 TzHZpOmGOrqWtS0nDJxnZbC4U22IXhNjoOeMn3RPHDdopT+6N3MnEBoZgkbJEKdHrobCtZw32BG
 fFeEdDWoH+pessddFzS3bQXpz08keS5AlfCdl7YMrehOjTcgL5ybPbVhVTWB2FtO7REQGsCOu0j
 u8PQcuijlk3cp+oydIdCoZ0uQPJA9t2WzMkZv7yIXCb+t
X-Received: by 2002:a05:6820:c2c8:10b0:71a:e7ba:8ae8 with SMTP id
 006d021491bc7-71b39261f6emr9674355eaf.1.1795569029720; 
 Tue, 24 Nov 2026 17:10:29 -0800 (PST)
Received: from
 runnervm0hi8g.uf2q4bgxt5yeljnr0owifoj32f.gx.internal.cloudapp.net
 ([128.203.198.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b3806fc45sm10457959eaf.8.2026.11.24.17.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 17:10:29 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Wed, 25 Nov 2026 01:10:28 +0000
Message-ID: <20261125011028.3809-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124180149.614825-1-rbranco@suse.de>
References: <20261124180149.614825-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

On Tue Nov 24 19:01:47 2026 +0100, Ricardo Branco <rbranco@suse.de> wrote:
> userfaultfd: Add tests for UFFDIO_RWPROTECT and UFFDIO_SET_MODE

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
