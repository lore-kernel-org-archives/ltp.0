Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2719CC77B7A
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 20:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913923CEDA9
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 22:33:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 814A03CB92C
 for <ltp@lists.linux.it>; Wed, 24 May 2023 22:33:48 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47183600972
 for <ltp@lists.linux.it>; Wed, 24 May 2023 22:33:45 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 526075C00CA;
 Wed, 24 May 2023 16:33:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Wed, 24 May 2023 16:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684960424; x=1685046824; bh=Mz
 NhUul+bEm3BteWRKBV9/dLTmt7J6tRi74LAQE6rWo=; b=MHRWZnGI7OhFZGHeFA
 TyVLSNckNfP5nOlDCUpHCKh5t8fWoZxtx6OkiTL7lR29T6g2aG8xV8R7017vLX1x
 fVv1IqkeLjVKxhedNwRzZNl8uVLpBg2ZNduMY8jw24KaE/QPAoIhAe7OQpGjR9ri
 6L0aP2n77ePsouI7zmBwCIUbDO1+d4dXx5yonMw9j9+PtbED0TjRgM3vWbnaaXsQ
 /uL3yEChDt8/FiC5lwR69kc1ph2qtMhg+Msy/lsOOLiuLDAq/CIyl8cjPw9JIGVb
 vx/PCvnC+Cz+U+McjDMWwy/ML8eB0oeOQ4W91c4WFYPwZFtHyd4DIwGOas10QfbS
 I8zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684960424; x=1685046824; bh=MzNhUul+bEm3B
 teWRKBV9/dLTmt7J6tRi74LAQE6rWo=; b=FgSGekCfpwSjrm5TRLOhkniPAb6Uu
 PLek8e1lqO08uf5wJvzB2yRjH12vUe/rMWF/vRqJnbVxdSfyZMrA25bXE9D4wpW2
 bTp8pmNPhvTNJdq/GeE3W98HReNRxHUSe9ffjFUZeGrVn3xU8dDeqTx/yvB4e7/p
 NmPo2U35XSyTnRyJ48Vzq8P/R3N1gxNmJL+2k7p0XEupBWPy8OQJjI9PPuSp1zKI
 NEPtG2lc54pmCOK28ueIZI8yOakljNstN9uu9YO2txqZpT/ztMZTXIA81nrijCbJ
 F3QIk64CQy84JuWGNDKYLJuC6ceGaH2ZcA4toM8VKus/JNVbkfaVFWY1w==
X-ME-Sender: <xms:p3RuZOMbOINR5aaBu8yurAPXPP641OZ5xbkXd79XbcNIMlZxbZ9dKg>
 <xme:p3RuZM_tKx_j7IEuggNYS5_OvdXPeFtADSGpqGEri_yz_fQNTGkzi1KZOTlXeEsQ1
 N9oYQSbMpam9GwCoPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p3RuZFSTkHHPlDcnGV4tnzglKSYoe4gt4qAwIXuQAHtGGjO-0Rj7rg>
 <xmx:p3RuZOuePy209nYcCHPVz-cmIplJZVHDEcb5YYtHogoMZqYyfVTPFQ>
 <xmx:p3RuZGeQxfMIb-VBo5id4TF013UWed03lH0O8Pt4EQuYGQ3QudE4ww>
 <xmx:qHRuZM2WOBqjVB7HiYRin-V94n3Wdy51MXTxTwc10ssjl-AJaQVcLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 664AFB60086; Wed, 24 May 2023 16:33:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <797a1074-4174-402a-a172-78191dfb426c@app.fastmail.com>
In-Reply-To: <20230524175442.GO4253@hirez.programming.kicks-ass.net>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
 <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
 <20230524175442.GO4253@hirez.programming.kicks-ass.net>
Date: Wed, 24 May 2023 22:33:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] qemu-x86_64 compat: LTP: controllers: RIP:
 0010:__alloc_pages
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, lkft-triage@lists.linaro.org,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, May 24, 2023, at 19:54, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 09:39:50PM +0530, Naresh Kamboju wrote:
>> FYI,
>> These are running in AWS cloud as qemu-i386 and qemu-x86_64.
>
> Are these hosted on x86 and using KVM or are they hosted on Graviton and
> using TCG x86 ?
>
> Supposedly TCG x86 is known 'funny' and if that's what you're using it
> would be very good to confirm the problem on x86 hardware.

Even on x86 cloud instances you are likely to run with TCG if
the host does not support nested virtualization. So the question
really is what specific cloud instance type this was running
on, and if KVM was actually used or not.  From what I could
find on the web, Amazon EC2 only supports KVM guests inside of
bare-metal instances but not any of the normal virtualized ones,
while other providers using KVM (Google, Microsoft, ...) do support
nested guests.

      Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
