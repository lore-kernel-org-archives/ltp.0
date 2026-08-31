Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D92BC61DF0
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 03:53:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 700003E9A1F
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 05:53:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A18AE3C74FD
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 05:53:35 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DFDA1400431
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 05:53:35 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-9349a22b22fso81860885a.1
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788148414; x=1788753214; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U25v7MwGAV03ieo5ftbsrtxlI7ZsWVc3Qy1e+pIzNFg=;
 b=DOg+2MwxFdSMpc0ztby8958w3Z4vae3UYGtQp7FH1RBhi1vI9QQXfFMffW35ICpJMb
 YeJvbg8l+tqamjxrzxDwNhZ3mCiaYN8YTbNTIuhPgVybzeLpeecKmhIOrcWkxTyfkYSe
 Rsk2mQdethDc1G8ftOaRAklBvp75LxOhYt8l7ek52fhWsuOfYdCzOdzWns+q3L/NACmI
 xNmloy8XD5kf8hCbk+FOiTUvTwU7q5CXm8y+k+gXq5B6iayLGoULyT4V4EB8j64dalhR
 NfUCkS41d9zY/Of7S5lvdi0iIPh9paPOQGpdCZCyBAVNnotYs/7I9E6lRDLjzg6J+ub2
 XTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788148414; x=1788753214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U25v7MwGAV03ieo5ftbsrtxlI7ZsWVc3Qy1e+pIzNFg=;
 b=ARbrJbPZPxLkYcRab45fuwVfDy99a0tUrtMPnHScRBMH8akbWFw8Cg18p+pJ0NomG5
 mwd2OF+vS4p1CJFwgLZznhPjOKh6nhLmNpIck0AX33Qs13U1KgF+UIc9oeLQI4Ygd0CU
 WIzmxD3sKWRXCG2t+L7A/ZZEqxiWH+wEGgslwJcY1U1Jy6OTOTgqhjFmtqnB5T0d8N3u
 1glqUJEDYaM4RosazOK3t/SNgzsXKQcpAJPnQqT3+CK3XapOXi9Otd6Iz78v089zQu/F
 nUTrovsCH3MMOSiZQ9zOIr9f2mTUeoo++ZbOp9oDOmaWKz3NesGqrLsxyuuyWFBdnwT6
 EK+A==
X-Gm-Message-State: AFuF++kDO+/+k96AzoXgYE98hBlaNlL5T1Jli0DETueE8OwVNc0Il8Tl
 cDBInogpcgoJhXD5nUzu5E8GpIo8oe9jAjNKeaKweNv1Ps0C93dMsMSw
X-Gm-Gg: AR+sD11A1AktvsLB2Ct/Rgx9FijbrZrdJF5A2D8SlJJOgLEo7ySTDPv5zutK3+vQty7
 9bNRZhiljtZwzKwiJrykbXjV1T6+t8IKXUuJ0cCr4Ztohbnp/UPeTXxHGwREJGTotmz+fuzZfjs
 9CyzkVer/dYgMBr3o0hAskaLxcJjICGjRQ1VPB/FmWAuX9V+ITbZCqFofl3HkiOws8P9b/0P+Jh
 72VGIP/euNx0XhgnnIebHz9+h3z//2h4umeNv2vhTSQs3QMEh6p9AqVt3VFn68rYYdnWT9J3yCL
 PCXegIcpt5sdd4URKQtoiT1Z8SdflUZ7I33DIhwtiQ/A+dqSpbj8xA9KXlI/IhjIxy2iz66Rx3f
 rLLwIO0l+v3DjmPOxhy/3tGQqWfarhkrUfXblQGeUmMpXtJ5oBCNtB0AD+eJCVwnrVGflZ+2tYu
 A4S/Z7qT2g9KfjLsYonjPK/LVdeXMqW+R1n8c9Oeqt+fmzGfLcno4cM/+7ZT4sj/uASgltkPY5W
 S/HIW1ojXX0JUAUg68/xck/q03QzJS7ks3QXz67OvkegZkwy3mjjD3E9BxvIojF2HTqxs5fvcE=
X-Received: by 2002:a05:620a:404e:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93942bed4c3mr41125685a.43.1788148413911; 
 Sun, 30 Aug 2026 20:53:33 -0700 (PDT)
Received: from
 runnervmgx7h7.ndtsheiqjcounhtwo050w5fsih.bx.internal.cloudapp.net
 ([20.55.15.230]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173db029sm691214685a.35.2026.08.30.20.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 20:53:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 31 Aug 2026 03:53:32 +0000
Message-ID: <20260831035332.9081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831020028.19193-2-wegao@suse.com>
References: <20260831020028.19193-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid
 success path
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

On Mon, Aug 31, 2026, Wei Gao wrote:
> lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path

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
