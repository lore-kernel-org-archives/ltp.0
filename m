Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31762C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788506234; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=K72aQH378eoQC3x6ErQQAfARTJ3+ujt515s4/+4dzDg=;
 b=BxOGqJOALja0OEcNKtPzquE/xIc+gVdsuerc27S9Q0vxFG99xIvOi0oPxPEGqWUJG/ZUU
 3Snx0aAFCOWBIrJqFB8WzxZkezZ7U3Oz99q5dKhyYFgp2cd2WWXajybDAOIZuHPueokXSom
 EBgOOwCBD2hxUxp4bX2/HdQMnNT8nDw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD70B3E9361
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:17:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13C833CE9EB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:16:54 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AA72600F08
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:16:53 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-482f9309813so605119f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788506213; x=1789111013; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Va3EIbGplGD27jgQUyW3D0J4QST7ph5a6hOmmhJlMlI=;
 b=OJnSUz28I6rUH0yWHeFLpEdmzXA4sNPIh6fhkApptl1rMYd7amUAMuQzxJx0tHQ7Sp
 ARGyFmXgpsTxLThB1xMQ8s6vsX2uzKPLDBQAfx2DRxPzm0IZOz8HzFs4KJ757B1hOCka
 mj8gIFJEEdEhmFGEj7l7H4iY6QJ/EjXdl9wXZVap076wmvJek5x6Gpi9y+P1ZbeHzOYM
 9kv9eKToeKe8CAlTh0uWKbnKMpCQtU2+fMi10xzEgQW+1oWZAz2aqFbVNsFoPePL8Kgm
 XNX0ZeLIPDdY/y6wtA/QuhbCdZOTGbVjyOYWIVdGqtFxiIkyb2DBz1lVOhBxQvkr8oJK
 5xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506213; x=1789111013;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Va3EIbGplGD27jgQUyW3D0J4QST7ph5a6hOmmhJlMlI=;
 b=JJg3DejODsHFdHmgpOEj1eyeoSHc026aOp2eNXELz+QAEFUaI82429gz38akP83JHx
 1UChic1zJMEyln/ywWaNCmGz5hKjNxgx5LzzT+gdQMjYB6Se2vvxpU2KB+CmcNk+RQu1
 GnDyQXeADn5m1xcaJ9XfExdPWUxnXBCrgzyxV+2Cx8G7LhkvvzM1dgr411lOd+byQpjc
 h1ziaW/HvQWGgxgm+n3num9ElTLw2qqlg5Fts7oqvQzkZGaZcotFAVzRuhjVapDSHbRH
 5iUERoLnn3XEjexZtC33w/y4y3YaiUd2j2mj7IqH65JcF41/ShfX3HdS2/l3A7+rMbQU
 nROg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlXrj4r8zU9CKEBDctBaW3ttsYT84kXvOSg5rR/q0HGaAYenwfchCp/lQ0FLkXJ4Xt2ME=@lists.linux.it
X-Gm-Message-State: AFuF++nPh7VDy48WgJl6+hO5RBIPueil91cyGbp8a84E18qbiphn9QCV
 WmY0Mp9yzgwuWP81zMu6OXHitEAExSfp/3UEyN3PURe8R7crJKP2ol98YauN9e276BA=
X-Gm-Gg: AYBFou37/E1MasvkDjCGACt22dvZRkemyZ/as2Wyg2AqAxJBKLyiXd0yzzFWbvScBT2
 SgGQ7FSii3cDewKzbxH/r4bA9ZLcqQ7T4F1KUbOgLUn3hy1JaJtWNO6YesiQCcZQYzhEz18aEzC
 lH5g56rljL04SSj/urJQVOt4gMSrf4jA8i2IlOLiyzfNIlvuYgANmHSYKHn//0gfoyohW8CXxtw
 80BEtSyygATVhHzCu1wOQAf2S++ptXsHokpOKT5WrzzJuJUoZ0LtUirsgHMTlS7FTXW5fNl9/RS
 D5Z9lJJMQH2Y5UrLnUYqtOc7sUE7j3LZqBvXbkR5u2nwt4YC2a5Q/Pa4z2Av3EyDe8cA+ydzoX1
 gw1Wvnn2i3sIUaQefKhEYU2BmEMiau93xMe7a9Ja1HWHk07bmJ3QWbA30ykyLW1n/z8a02Vm9T5
 uzYyXQ9QKRaD1hfTzh7qgtT08uv0kYVQBB9T5e0edUtuOXTq9tMJ242gh9BQcp2yOcprSWfx3r9
 GiPfBgz+qGg
X-Received: by 2002:a05:6000:26d3:b0:485:847f:fd8e with SMTP id
 ffacd0b85a97d-48587090f7emr6571264f8f.2.1788506212920; 
 Fri, 04 Sep 2026 00:16:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm3617487f8f.2.2026.09.04.00.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:16:52 -0700 (PDT)
Message-ID: <6a9a7064.18b7d65e.17573c.2e31@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260903160137.8963-1-linuxtestproject.agent@gmail.com>
Date: Fri, 04 Sep 2026 07:16:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tse_swap: Add fallback definitions for swapon
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

> Hi Andrea,
> 
> On Thu, Sep 3, 2026, Andrea Cervesato wrote:
> > [PATCH 1/3] tse_swap: Add fallback definitions for swapon
> 
> --- [PATCH 2/3] ---
> 
> > static struct tst_test test = {
> > 	.needs_root = 1,
> > 	.mount_device = 1,
> 
> SWAP_FLAG_DISCARD_ONCE and SWAP_FLAG_DISCARD_PAGES were added in Linux
> 3.11. Add `.min_kver = "3.11"`; older kernels reject these bits and the
> test reports TFAIL instead of TCONF.
> 
> --- [PATCH 3/3] ---
> 
> > 	{
> > 		.err_desc = "Invalid swapflags (undefined flag bits)",
> > 		.exp_errno = EINVAL,
> > 		.path = SWAP_FILE,
> > 		.flags = 0x80000,
> > 	},
> 
> Invalid swap flags started returning EINVAL in Linux 3.4. Add
> `.min_kver = "3.4"` so the test skips older kernels, which may accept the
> flags and produce spurious failures.
> 
> Verdict - Needs revision
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

both can be ignored, we don't support those kernels. I will add a
rule to the Agent so we remove this once for all.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
