Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F1CC00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:00:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80D7A3C004D
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 16:00:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 639A33C80B3
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:00:00 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3637E600769
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 15:59:57 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 3FE975C015E;
 Mon,  1 Aug 2022 09:59:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 01 Aug 2022 09:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
 1659362396; x=1659448796; bh=w8yOK5zhRUfrswENLa2ermIDANkx3H0dpV/
 p0eexbt4=; b=Nr+4uuUVR6bd2B0VE0h3WxBH4Hx5/tOmWdxT+X2MQzeWYxpM7IN
 4rup0CzPwjDRUUOQT3igYvytmM592NXkMPZimfPrm27h1DbhEOfQSTDNJRSozRdG
 cFxr57V/FY37VtxA+MvCkT469DF4IYhgOWBKw6AXD80Ax+w8JzoG+2Io/vgU6Oqh
 FUBvjW9sDYbampPbQUJ2+vTXrGsDW6cDEVqXcR6Vj0wxZtTeM75IuYkGlM/EkEdx
 h3i7na2DKOVDwYexR2pPqXXwUkFayOKgzW80LpNo1xvDS6s4cxsHCTscWRNVcfxf
 LOfQJUpxw/Vnbb7tMk5dZi0tSS7XhWvhzKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659362396; x=
 1659448796; bh=w8yOK5zhRUfrswENLa2ermIDANkx3H0dpV/p0eexbt4=; b=C
 zJyE9UOw9mwJD+9fSrxISqjHV1BEdh4NneGDYjDgBRw2xCKcbnk9eKFjZwujB3uD
 bIv8Ny+S05d+S64WBASUcY/H8VPAKO1kj/6sJlYpJQGp7vJqn9YlhiSh7KXZlsgd
 nPYjZteR4SoVGLRSUJkxz6T5LT9C5fxiiNZwLrvIbvUNMG2Ihy4ZYake3iYXr5F+
 52PIhBCBAyGuDoGNn0dPx3/AceLrhFOOYvKe5TSPLIDiTsrHuGXAuWJ9JhTR6yhW
 X8J4jQJ37pIonJKECxkD+dVXHrEXL5hnA7qpS6/ThAp9cqaHewulwM1rNKVhAKV3
 Ae2CIjeMBvY505QQdhxzw==
X-ME-Sender: <xms:W9znYsoWhyurdVLGPfshMMQxy0dPTZzLMc3YXWlDHT5bfkJsIlYAtw>
 <xme:W9znYipMLF3gTQVt5j97vx_4nMYfssNoo_qYkYChk8m6if24BGwpIzDXVNuh4-Skw
 ff0fLUPOv6JDw>
X-ME-Received: <xmr:W9znYhOCYhK5OeyyxSK3Ae9tP0f2qbwY-C-ii5qFUFFzI6dBQbNfesyIou9pjThdbNmThHseJFC70W3rKAdzAaYMIEunEYPr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedgjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
 dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
 ggftrfgrthhtvghrnhepgfdutdevjeelffejtdefjeetjeeitefgffevheegkeefkeevle
 ehgfelfeeikeeinecuffhomhgrihhnpehlfihnrdhnvghtpdhlihhnuhigfhhouhhnuggr
 thhiohhnrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedvtd
 enucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:W9znYj7gNf3qizIg6OOrc-IjhjdKe1Qk3q7jOKQb8Mo14DC4mZb2Pw>
 <xmx:W9znYr7y0_ATGeDX7-31wsH-o8ojz4QmXbSMHJ9blcHfHljxBlTPjA>
 <xmx:W9znYjirYwKxypPHqn5vfBCzYnrhx4zmbMdfalCUO8WhxNVxOj83OA>
 <xmx:XNznYoiuiE_bniaOlqM0ggX0VPRRV1gwVGT0yB3BM7Lly5DKGV-8AA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 09:59:55 -0400 (EDT)
Date: Mon, 1 Aug 2022 15:49:09 +0200
From: Greg KH <greg@kroah.com>
To: ltp@lists.linux.it
Message-ID: <YufZ1ZcIhkjLFEWM@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Linux kernel development reports for the 5.10 release
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm trying to keep track of the different companies that people are
working for, or if people are just doing this as a hobby, or being paid
as a consultant for future articles on lwn.net about who is doing the
work on the Linux kernel.

Jonathan Corbet has also been writing articles at lwn.net about this
topic, and we share the same set of scripts, as well as we write a
yearly article for the Linux Foundation about Linux kernel
contributions.  An example of this can be found at:
	https://www.linuxfoundation.org/2017-linux-kernel-report-landing-page/

Your email address shows up in the changelog for the 5.10 kernel release
as a contributor, but I can't seem to place it with a company.  If you
don't mind, could you let me know what company you work for?  Or if no
company, do you want to be classified in any of these other categories
instead:
	- Amateur/Hobbyist/Unaffiliated/None
	  - this category is for people who are doing kernel work, but
	    not getting paid by any corporation to do it.
	- Consultant
	  - this category is for people who are consultants working on
	    the kernel and getting paid by other companies (not your
	    own) to do the work
	- Academia
	  - this category is for people working for Universities and
	    doing kernel work as part of their research or other
	    responsibilities related to school work.
	- Unknown
	  - this category is for people who want to remain in the
	    "unknown" category.

If you want, this mapping will be kept private and only myself and Jon
Corbet (of lwn.net) will have access to it.

The scripts involved in this can be found at:
	https://github.com/gregkh/kernel-history
if you are curious.

If you have any questions about this, please let me know.

If you never want me to bother you with this again, just let me know and
I will be glad to take you off of my list.

Thank you for your time,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
