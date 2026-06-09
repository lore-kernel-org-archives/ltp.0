Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B366CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:43:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8E653C2180
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:43:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7534E3C1C6B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:43:33 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EAB5160072B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:43:32 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-517b1f2c6adso24674001cf.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781009012; x=1781613812; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyoCwe5cFFw0c9bgb1Z8glZs1slDVDIgt5uKW2EZm90=;
 b=r4RCxQmsKcVUQdVbYCu1Xo6rkT0lGRsF8upl9FQZXijhP5dkP6qcw/SUPbW9JdD/bB
 J7drcFSZ7tlE4YvmGPA8rFEp9o63acaZf5aG5VxhTfdSb3+93ShDSp+M1XW+dSrp1huZ
 Ii2OdzUZrK+YGQT/vwyRWY/QGSvntXjZK5EzTY76Am7UbWqGOItR1xBLrmIqukwswfvK
 CdYgoHZs49JcINAYOeKrezzgwh+vd/zbEfpqcbMJqHk+mdLebvlSQrlSDT+LVVv9r7Be
 hGBli7+vUVCOjcbaPyDJo/ptQoF6q8Iw3/Ll6K+SQgRqzch/voNRsPVXyZ6frAaCZaco
 fyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009012; x=1781613812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VyoCwe5cFFw0c9bgb1Z8glZs1slDVDIgt5uKW2EZm90=;
 b=iDDT9N/htdxN7Mdl03g01CHDnQfhF1GzZg2EXF0wxgugATmrJCl8NI5dzEyUXr9UNP
 Oj3f5XDDo5TsNVzaMVeAQb6RXcexkNroBYjTbTOnCPxcB2DK22QFqMzOQiqta/uAjVa8
 xVcCkm6PoHef1XswOwFZfb58uEda6V/01upV+u1rtRfex5s7DDZn11EMOlCNFdhul9aZ
 OFuqk9BiWF62WqDBW3tIP3U+CzNKNipUPeERJp9ymwrxaRP2IJwtovEqp4K/ffCL/N+s
 HikXBL28vd7h70cvPwlgJft70VZF200B57buPubK1hUxuXWgcRVnYh8R7gvNpKLOtO9h
 G3yA==
X-Gm-Message-State: AOJu0YyrCU7VxtKy3ATQLhaOhL3JHRhf7b1vI4W7oe/8Sm5nW4rjPPFW
 BowFJPjDkAwxbLi9nKRN6WSOBJufWfOU6N1vAC9P72t8qqg7BVPxKMQi
X-Gm-Gg: Acq92OFoCVZNN4Ln2MQ0iyKwii1oHd5/HcEpk7gQizcMHXc4dRjv1f6icv6rn7aKgZu
 f37iEZboTQFU/ZR4dYAzpYcI4iZN061FGuhR8682wr0HhBifcLu00y24l7jatmTYfiEKtLYOA1Z
 Pqs7P2hOwaRPgdAmXPQN0lKeGAeTZHz+yhE+9ppuaL+0k5TUDvCtzL6YrNzszOBss0w1VRzT09r
 7mZszMS0vYtyGXYQTxW55eMM1I1ctptwekSxo4wBR3FYnpaUbKXhtUh6jaWLWgLeuj2jFqmrWAc
 mwNCxR2Wl3caGO2qqil8vzSvFrqVJjV5hJgrwc+Wh5ozsI32riglCF2Are2fRQ9hosPA87cnygm
 HRW6OSqB8bg0CV+tqSkoT8Tb6PHAR15WmSmNtqRyzUGsYHvOww/e+8LScs9la4LaZNgE2otKgLm
 1xFHxR3G6HyKUOt6wBdEzQRcNgnMrMQUnCprOqZV4lI62Ryk36sjPaMQ36koiRJCM0ECVNXOiRX
 QbPgkI/xydvfpO/IpZWRVuQyeeHJCUCEDe3l28Wf72OId00iQ0=
X-Received: by 2002:a05:622a:58e:b0:517:626b:786 with SMTP id
 d75a77b69052e-51795a2bc8fmr300070661cf.15.1781009011472; 
 Tue, 09 Jun 2026 05:43:31 -0700 (PDT)
Received: from
 runnervm3jyl0.ih4hag31ne3evk1eddqqqnr0uc.cx.internal.cloudapp.net
 ([48.211.210.112]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775d8161csm188687721cf.17.2026.06.09.05.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:43:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  9 Jun 2026 12:43:30 +0000
Message-ID: <20260609124330.4218-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609-doc_add_missing_headers-v7-1-779c18caddef@suse.com>
References: <20260609-doc_add_missing_headers-v7-1-779c18caddef@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

Hi Andrea,

On Tue, 09 Jun 2026 12:31:57 +0200, Andrea Cervesato wrote:
> doc: Add missing API references to api_c_tests.rst

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
