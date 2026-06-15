Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EFECD98CF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:35:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2547E3E5DF7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:35:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83DB03E2204
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:35:18 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 227CA1A0027B
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:35:18 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-5176a2fd597so34035411cf.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781548517; x=1782153317; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4lKvln+i+jLSDqHjBM1nngIZk26wSxodVmpFIFyXlk=;
 b=CQtcbGqio39m8NhznqJU16dkUYOcbMFd4Qfhaizx8TTrwg1SnqZGvnh8yXweFdg2PY
 SUmLtADIRoXp8iSF8DmG505Yfef0ejYMqsHnIoq6tuxsafajrPffjWDjObegA/BdVncc
 A7N4X9zNzXk6Af6Af2Scc6CyXw7+uE0xEmITF8Bj0KzNi2EeWDdTXKqzbFHSVsir3cGg
 jOIhn5biCuf2m2iqI9GmcHOT/7QO6n0JkYNLo9y5tvmeKFwGOclOq31pvGzlu/7go39m
 6woqjnifV3NlzJ6RppySqdf6qhx+t1tHow/tja7wEfAYc1SyCBxUlcNi7QzdJGZrOaW/
 UMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548517; x=1782153317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m4lKvln+i+jLSDqHjBM1nngIZk26wSxodVmpFIFyXlk=;
 b=nJ7/jqnVJNum2JrytKXKNQhRY+QXj6j8SVpHDUzvjrOyjZskQlizqLkWXMhwi7E7l0
 O9eAlbWPCYTksKsZQi0SeSQq4KgnEbh1h0MZJBYG79doHDJZ2PeXy8GgF0wYC2TjnLu7
 Ii2GhM/fUhkP41aJ3o/biWiojAXp+HoP9+zMPt7H6lF1dG1rmFXV9h4ek9z7crkHaEyN
 KzNFc9DE2MKkypPUvGU9Rh3IkVIDLkMuz/ijdo56NCF+qTjEBF3csA4BCbo3wg4N/jx0
 0E+U3JOVHJqmXVON6sOoXYIaNlSt0b1EV2qmPvgxj+w0W2NQRhEjPrj3XjwbtXZcXyGo
 X8rw==
X-Gm-Message-State: AOJu0Yy9Jmr7wrHtuVYi30HBHS2Qu1TkngVPzlLGyE8/4oiW1LUn4NcI
 9O+sGs74uD3+KQIHWodREo/TqyQSI6SkknXlMEWYsaSvYdCnwXG/N0l7P2X8ftLr
X-Gm-Gg: Acq92OFU9jWm7DM6Ql8q2AFl2i4CaYF8PDa1xcE1KFKGyvkJGoQ9YNEhqnb26lt13K0
 cN9nPPISTCx6ZRXy3Bl2rQ1SlCxJN+ClG+3WpcZQzvWOMxf8OepUzajrBH6HNIM/pP+yb+FTlCf
 AgCmgWuP8lv/V9uNRuTTmSZtNiLOUsmksHxwVkWXjes+ePslMym/QWyO1Td3IBddtyq5nxBU38U
 vRkjA2viUPDF38EEKAdRZCo6/5hNFM7oTcKg39MBQAwXG+W1V17dPI82RkG2r14u9ORTSIpZEMA
 bg8PivvLTKBMHkvu6EsBOVh0IRf1VD4oONqFDJQ+ThkAGn1ovAlhsCnvF5vS/qpfBk4KEVY/4kG
 EY9CIR+cVR3twEFKGNKqUTMRCn7Yj4KJv0+SACsm7KwVPC2vXfuwlGMlOhzXvkOhijuDaxwGE+w
 EaNwZRfwInwkPc/kDBLBOSBjl/RFIsli0X8K13n+HdtL2/XTO6ajaGntvQT16xTcP5sgdyAiwPK
 VEH6XamjRkTzWrYlDrXG14s4jnZCv25AL7zpvM9QP4dfws0OA==
X-Received: by 2002:ac8:5982:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-517fe17bdd8mr226352691cf.9.1781548516713; 
 Mon, 15 Jun 2026 11:35:16 -0700 (PDT)
Received: from
 runnervm1li68.5tem4wnxuzpupadixjw3cxa4tb.cx.internal.cloudapp.net
 ([20.55.214.123]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7e8900sm130072391cf.23.2026.06.15.11.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:35:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Mon, 15 Jun 2026 18:35:15 +0000
Message-ID: <20260615183515.4148-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615151555.71638-2-sachinp@linux.ibm.com>
References: <20260615151555.71638-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

On Mon, 15 Jun 2026 20:45:48 +0530, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 5/8] ---

> fs/acl: Add ACL symlink operations test

> +	if (user_obj->perm != (ACL_READ | ACL_WRITE | ACL_EXECUTE)) {
> +		acl_free(target_acl);
> +		if (unlink(TESTSYMLINK) == -1)
> +			tst_res(TWARN | TERRNO, "unlink symlink failed");
> +		cleanup_testfile();
> +		tst_res(TFAIL, "USER_OBJ has wrong permissions: %o (expected rwx)",
> +			user_obj->perm);

Use-after-free: user_obj points into the target_acl->entries[]
array that was just freed by acl_free(target_acl) on the line
above. Dereferencing user_obj->perm after the free is undefined
behavior.

The same pattern repeats for group_obj->perm and other->perm in the
two blocks that follow.

One fix would be to save the perm value before freeing:

    uint16_t perm = user_obj->perm;
    acl_free(target_acl);
    ...
    tst_res(TFAIL, "USER_OBJ has wrong permissions: %o ...", perm);

Or move acl_free(target_acl) after the tst_res() call in each block.

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
