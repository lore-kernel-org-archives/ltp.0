Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B60C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 15:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E3693D212C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 17:38:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2CD13D20D9
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 17:38:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=richiejp.com (client-ip=103.168.172.149;
 helo=fout6-smtp.messagingengine.com; envelope-from=io@richiejp.com;
 receiver=lists.linux.it)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA17720111C
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 17:38:42 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal
 [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id B0922138FD09;
 Tue, 13 Aug 2024 11:38:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 11:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richiejp.com; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1723563521; x=1723649921; bh=i27KXuQgRc
 4GpBJ3WslDB1am3l+Iho9OJZOPO+tMmd0=; b=l3SGqa+qv7O/7o6zXhJZMyLN26
 gdDHS9Jah3lrsWZobjZllZRO8MFX0MVD3pZyL2WWT19rhfzxrXCyWTorEBw6z1NV
 wwB2mRd2J4hI8iVIGIQAKOkVF/75Q9lFsw/QgScRShC/4ZIFWNeDh+11jSv9JI8G
 sqajBe3KegIsQiaCEJ7NKyBODPtIa4VN2RRmGa44Mt+V30xININVsSDO6vira4BF
 OZxcqWpgiYK9w4vZZ0Z6szaC2n+F3Whf6v/8IDthl3cGSfJqn92EIjBglL7c03c4
 laIv5xQc1rOdwVMbFUiEpJsDpOPFRZ11y7DyAelZdEoFokZ2WyMe4q6VgVXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1723563521; x=1723649921; bh=i27KXuQgRc4GpBJ3WslDB1am3l+I
 ho9OJZOPO+tMmd0=; b=M8jjN4NHgE44Nyo4Z4BM+z9qwrvr/AGT5jQP4ciAa8zN
 9JSDog5PoTVmYKkC13B1kSQG1HKouf6ZT/ty14fR6C/oWuW9QXLQMpNEh+CGtuQo
 WW+XqcSxLEmZ2j3v7SXNH6g0UYaGkDD7q2wBGDisPaIbo8kaQY5tL1FtdPA42yAk
 rdehoWoisjomid9aFSU0wdvZv3RWxxvRCW16aBrW+92LP+BAsXvMIeUNA6XqZ0Tw
 UlYBWDJUzFOU8UpBe/u5To+DnEvjU7SqjOH0c9fn4EiAlhCRMdtZEu3ZgEXTsMoP
 FOQa6E+iiI32Uxu7cgc9ds/WtrqkRUvJJkjeSAaG4w==
X-ME-Sender: <xms:AX67ZhKQ8d5IzhpKRJTA4hxa3mht4v8e0Dg0F7dzvWpIzTqAKmjDLg>
 <xme:AX67ZtKf2KiGrw5Vq16VbuAEGKcEXPVcPpVeC_NV8NMX7qSjJ4rmAGg2u05fIfacT
 e9FpIld_mtwuBBw>
X-ME-Received: <xmr:AX67ZpsQy-whx6EAhQoCJzaqhmcW4RyOHUm09GGTCLztu3huozlRhlJq4Qc66y3wGU9keba2akpZk4MtHf24VlXFjrIJTYCeZGQcK-SaUoYkKO6ehg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecu
 hfhrohhmpeftihgthhgrrhguucfrrghlvghthhhorhhpvgcuoehiohesrhhitghhihgvjh
 hprdgtohhmqeenucggtffrrghtthgvrhhnpedthfduffekueeukefhjefhleeihfevgefh
 vefggfehtddvleeltdetgeejgfegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehiohesrhhitghhihgvjhhprdgtohhmpdhnsggprhgtphht
 thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlthhpsehlihhsthhsrd
 hlihhnuhigrdhithdprhgtphhtthhopegthhhruhgsihhssehsuhhsvgdrtgii
X-ME-Proxy: <xmx:AX67ZibAKEE0G6kboKmyi2lgQVD_Oc4bVF5H5e514Rh7WaYXoHmbKw>
 <xmx:AX67Zoa4R65rSG96_cfuNDOAGYKLNwDFS_EGYQgfB_QJbj4HFNODpQ>
 <xmx:AX67ZmCRwHTb72IBBo-05IUQoJkDnNyA0Cd8sxsfVMBiovDGPc8_3w>
 <xmx:AX67Zma3t2--Ki5ISuTTbGDkmjoNwmPuMukeOG6FrmCdP-lUUbSqfw>
 <xmx:AX67ZnkQA6V7koKxd4g7cMPOfU4VgqG-t936Mv_L1NtJeDBZ1NIATI_2>
Feedback-ID: i12a14689:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:38:40 -0400 (EDT)
From: Richard Palethorpe <io@richiejp.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <20240731092017.8267-3-chrubis@suse.cz> (Cyril Hrubis's message
 of "Wed, 31 Jul 2024 11:20:16 +0200")
References: <20240731092017.8267-1-chrubis@suse.cz>
 <20240731092017.8267-3-chrubis@suse.cz>
Date: Tue, 13 Aug 2024 16:38:39 +0100
Message-ID: <87sev8sa9s.fsf@richiejp.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] libs: Vendor ujson library
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


I spent quite some time in the past looking at this lib and don't think
I found any issues that I haven't already mentioned to you, so:

Acked-by: Richard Palethorpe <io@richiejp.com>

-- 
Thank you,
Richard,
richiejp.com.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
