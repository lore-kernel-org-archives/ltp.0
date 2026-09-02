Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8F7C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 17:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13863E93B6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 19:43:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 885EA3E93B1
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:42:56 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E22A214010CD
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:42:55 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2ceb5a39c48so4045835ad.1
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788370974; x=1788975774; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFAJ40IjjN9rFI3ut3MrNS8n+49qlxyWdWegANeOOHQ=;
 b=B3R2i1s/Ve9/kpDpDoiIpRB/X6yYcOAKnwD2bBGsVwC88g4hrOcZnno1zYMjqG9eiu
 VJb99Ar7nvBhqo2Zzrh2qZaxyHZpTpegdHIneSeRkKUJpA92yaXG9XOETGsJTWgDd76E
 qg9JwQeOXfFPiaIWQmxetKXr0iWalxwxTHBe8UIJWsHCTklfdtd3awZQQrCODg1yr7cG
 HX7AB+z8wEgJ9yuEN4ED4keoAOG+rCDfpfJ4Zwbe2PK5Gv/HxOn2fQyr/hGpkF5LjEks
 putwKahYK9XKdMwjAYuiEJFsbZt9gSyn2UPL84cG3aNQmieYSDfVQx1dI5T72dVxj3ov
 F3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788370974; x=1788975774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xFAJ40IjjN9rFI3ut3MrNS8n+49qlxyWdWegANeOOHQ=;
 b=HVbMkoLoaJeRMfTzXFaGKeSBYtxEymrCPVodwxZY11QZ7fkB9UwgcGUtCqC3S/w0KP
 5/jHIDNRQq62DD0MUg+XOhGz8E4LLkpT02EXmDhacyv+bxK3hsfziMUmBNP2VG3n96JP
 RKtgrxgtH9iarp89Yg4ZoNxRM7h4UWwGIW2GJhbluWDc+isw13GD1xCxqFqTbB9sRBne
 9/N4xsQwiJoq1GqIWRvZdhs03UCHXQe8G+ARbNpyC8rR8bpImRG6ilQ7Eq0EUQKohzaa
 oWv1yvCfa7k3CHmkZWUSyqi9qK8uPB44ycbIVWhpG8tJd/51TcgkDThdB92vEYB3rJpi
 81MA==
X-Gm-Message-State: AFuF++lce5+x98hqbho+MpLX2UCmM7yPqMM8GtS/fx50pnAqd4HLD3Q8
 tNiiPT+uqrWZzKZc+8OE4y52EPlNhj7F3KfANCuhNNSeTIjdROigzmH2
X-Gm-Gg: AYBFou3/SOqT+ix2bz2P1oxpq+XN6RHJJI3r2tYHW+tJaxtVw/+eb7LtyoO660jp8Oi
 +XmKoGz0QDUL8DA8IAmPcB0vLWfQaCqw5bkai8S+YCQjuiW7GYbIbeIk/JgTnJooLeQEyPe+DFB
 ChEZp7fUGEuhXZ4MtpNH3T1oHsBUvDnIDU9xErwXJblgXtcQBOWm/dSxZZinrGIXOM0hPGOg1j9
 0mVsmhAwvCsTsJc9nXDbUZj7guP2GGelL7VLDpm1m4m0aRHxNGkyM1vy0n8gcfI2M3bhdo+yK9J
 bkP3aj4h89NAIXSnNyBTqs9nWUVmAhkaVZAoysR33lQN5rn4sstOucTyhUbkNo6Dhfx32ZYLkgs
 lJ8SWZ0gN5IcxwJTe+Hd+wwmv/3hPo9JzJIdecVxYjzPoymTcF+a70JkzAL6uToBBog3hCJMiuy
 TVSZevEDk2xmT3GO7Z0OOBjIA6w1VQsjNmJVWYXFHeH7I1msDO7JV343auxfAXck7w/HFEeRp5A
 46YWNhUdbSb5qQ+QdmjxBjvYZV3OJJTDJv05uKobCqeciPoXwm0F2m+6fB0/BO9nyr3IqRQWHk=
X-Received: by 2002:a17:903:228c:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2daec71c663mr90494435ad.11.1788370973979; 
 Wed, 02 Sep 2026 10:42:53 -0700 (PDT)
Received: from
 runnervmgx7h7.dxhvdhli4vxebaq4qgplt43xjd.xx.internal.cloudapp.net
 ([52.183.7.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd382347sm16723605ad.27.2026.09.02.10.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:42:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Nirmoy Das <nirmoyd@nvidia.com>
Date: Wed,  2 Sep 2026 17:42:52 +0000
Message-ID: <20260902174252.9294-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902160113.1207205-1-nirmoyd@nvidia.com>
References: <20260902160113.1207205-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getrusage03: account for percpu RSS counter batching
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

Hi Nirmoy,

On Sep 2, 2026, Nirmoy Das wrote:
> getrusage03: account for percpu RSS counter batching

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
