Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A68CCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 09:17:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DACA3CE9B8
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:17:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F025D3CD776
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:16:54 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAA88200B70
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:16:53 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id AAAE7EC0128;
 Fri, 10 Oct 2025 05:16:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Fri, 10 Oct 2025 05:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1760087812;
 x=1760174212; bh=Ofa34C0eziBgO5jaTSPeu8sP0qRhUB3owqt6y97NDlY=; b=
 D3C6OHGNr1yf8d+4X4qDiG11YoJ6Ic/IqST1K32jhuCude0wNkLoOf+RYF46q5Vo
 wDTYhcEOhDvybAeo290D/iwF8naWZ59bKnE/BjaY0F3WbnKoBVt+Ps5WP2yE0TJB
 R+g5L7HD9JXskvOwf4wOZTy2/9sd6qnYE0YDEteCSmzEqLeJNd+v85R41Hc954w4
 PYT+Sc5Zs9RD3qR3Hoz+n6/Fx61ICXMxJYm7TDAclw7KCpPp28ggV01w7UPRjkeO
 AfDlCIbHdVPjncDDNhirLXrWEgFeZYKFIGs8Pq9mXcqG/587msyoH49CvfVFsPqY
 PPPenfLtAIeU54l8pSL77g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760087812; x=
 1760174212; bh=Ofa34C0eziBgO5jaTSPeu8sP0qRhUB3owqt6y97NDlY=; b=P
 XMaym7Pm0/3XpKn71Z9Kp1EllL+Dm/4XWp0lLVHLtd5p54Qq0mQVaVm51MOMfAjX
 dy6TwwVMztjW5wXAXLUVGyLTOX4XYtSCylhDeqWVywVhDC7RenGVf+pQKj9KCoJM
 OQf+mq+o8A3VSq2z5VHFGR8j6kBzL9wtFLOoCgGoJsqUEZCOJpcMBezZ/Ag7zNIi
 x4nJRcntaTGnYmXH3Bm22MsfOHpYEUmS4VEt7P470uimpeJlpvzAKTxCWD7JmDDf
 hfh21n+T+RdUVW3zqlmAhyYkmuKcmyVKl0gGguB42ORxf08cnnGLylxCPWOCaIMw
 gkLfCCFDGto2tQzAHrcrQ==
X-ME-Sender: <xms:BM_oaKdDADfRT1Prmcb7HTNkLHMdffYTkQWgPJseg1Ojp7uC_WcNKw>
 <xme:BM_oaPCrZ7O_P6hDeva4_4X82Ry46RCKqHaAd7Yeb_2aNgKfti3zP8WGH1CmJjG-d
 feDSILe4G29Gqww9VoTDT2lZayu3Kmt6oKlR_5F2AQoyVsVv2ic1AU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
 uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
 hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
 gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtg
 hpthhtohepsggvnhdrtghophgvlhgrnhgusehlihhnrghrohdrohhrghdprhgtphhtthho
 pegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehnrg
 hrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhkfhht
 qdhtrhhirghgvgeslhhishhtshdrlhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhtph
 eslhhishhtshdrlhhinhhugidrihhtpdhrtghpthhtoheptghhrhhusghishesshhushgv
 rdgtiidprhgtphhtthhopehpvhhorhgvlhesshhushgvrdgtii
X-ME-Proxy: <xmx:BM_oaH-rk3Fc6ovHCyA1URoL6tPdc2SkMUTBzWR229sBtu-U2TqNmg>
 <xmx:BM_oaPscwCOe_e1qLvWbt2zAAUfeeKY9dbc7iL1W5EERifS2npoCnw>
 <xmx:BM_oaHMp_bbNJzlJXQfz5R_z3JngABM-ZSbo5ehsIjdP1h3BqyG5Bw>
 <xmx:BM_oaEjYv3_istKFgG2XiupvYJRdQ1rEl8jcF63tHoo1-zRVKs_7VA>
 <xmx:BM_oaGbOk2rgDk12PjlhEV_urGmiWacXywox2F6VbCV68a3lpr-ldR6w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4A65B700054; Fri, 10 Oct 2025 05:16:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AE0GvpRtNP3N
Date: Fri, 10 Oct 2025 11:16:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Benjamin Copeland" <ben.copeland@linaro.org>,
 "LTP List" <ltp@lists.linux.it>
Message-Id: <081171be-d613-473a-9e72-6ff603d96dc4@app.fastmail.com>
In-Reply-To: <20251010090426.2243464-1-ben.copeland@linaro.org>
References: <20251010090426.2243464-1-ben.copeland@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: lkft-triage@lists.linaro.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 10, 2025, at 11:04, Ben Copeland wrote:
> The overcommit test uses sum_total, the sum (memory and swap) to test
> the overcommit settings.
>
> This fixes two problems on 32-bit systems. The first is seen with a
> integer overflow can occur when calculating sum_total * 2, if the
> sum_total is larger than 2GB. The second is limited virtual address
> space (2-3GB) means the test can fail from address space exhaustion
> before overcommit has been tested.
>
> Now the test runs correctly on low-memory 32-bit systems while avoiding
> both the overflow bug and virtual address space issues.
>
> Signed-off-by: Ben Copeland <ben.copeland@linaro.org>

The logic makes sense to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  	update_mem();
>  	alloc_and_check(free_total / 2, EXPECT_PASS);
> -	alloc_and_check(sum_total * 2, EXPECT_FAIL);
> +	/* Skip if sum_total * 2 would exceed address space.
> +	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
> +	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
> +	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
> +	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= ONE_GB) {
> +		alloc_and_check(sum_total * 2, EXPECT_FAIL);
> +	} else {
> +		tst_res(TCONF, "Skipping large allocation test due to address space limits");
> +	}

It would be nice if it was possible to express this in terms of
the kernel's TASK_SIZE constant and not have to check for
64-bit kernels.

Unfortunately I have not been able find TASK_SIZE from userspace
directly other than maybe probing MAP_FIXED mmap() calls which
would be overly complicated. Your approach is probably as 
good as it gets.

      Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
