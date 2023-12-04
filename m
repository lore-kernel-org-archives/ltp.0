Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC5AC4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 18:39:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC3783CFB76
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 19:39:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 892F73CC343
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:38:57 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C730F1401212
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:38:54 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 9E9895C0192;
 Mon,  4 Dec 2023 13:38:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 04 Dec 2023 13:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1701715132; x=1701801532; bh=aG
 FZfyQ2WN2CydKNxY+nIAAd1dL39GKDKCTb2c27l2Y=; b=sok3OtZ7ib25Uk88kY
 wQyhlPVLg7PmmROS95H8TqOdy9YpSW29JBeSUu46aQ/6PTCTv9VDEMiHE8j0GtM/
 99kSyTpbwUzfKRMHECoc9bQwfaQGoQe8pnK80sEVdEvnY+oI/iErr2EH1Y1rpXYN
 qxVYFoXerQGiJ93WrEWdiQrNbq1PwE0dUWv2/wG3nry1IFyIrNJjuFEBeRw/Oaic
 +gGxp4Q9pFlZV6XBrDtQsdqJ7DutlfSXOrQpdFDmOwX9mhOvLtSZmCwoX32sk6dZ
 GyvKeYUWN8BmOvkYbUO0ug5a0zwqwbAFedPvgNxLbAlGMPtdX9VQRURcl10rj05B
 4DHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701715132; x=1701801532; bh=aGFZfyQ2WN2Cy
 dKNxY+nIAAd1dL39GKDKCTb2c27l2Y=; b=T1VlFHiRlk2SsSY/P6XBGO3wPHk+Q
 W+SusPnURYnbAe6nInYPjykkFjxNp5FsH8OOB9Nb4uODPgfwdMwBOoRyAfKjEZXc
 2Os5LDvaC550Y7kqqqv76ACJpqf0kMR3kYnH+O1bEwmRv1osyOftWpYm0G9sm7Z/
 +B9TwKob916OUzb7gwDKFT04RdvAhm9afErxz9POkEPp0wHBjq/m23wPMLol38pR
 PQTCjFu/PFQQ8kMhtH+ZDijbkqC+2FFO4MhxW9QHucZbJyLLq6szePbXaD8mUQGI
 PZKT7FsssM/XgIsPjEOM4/2vGHUJVMvsYVSg9VF159TX6E2znjgOq3hlQ==
X-ME-Sender: <xms:vBxuZQRTAEMZQVP9zTMIaolxM1QiKkm1P51L8khZ7uNI-XyQv6YPlA>
 <xme:vBxuZdwMXxlCnVnr_qv-4oBHMJ_iNFK5NWnwJoNyG6TDTZ3dE_apJIgOEtwUMgK15
 zh8OQr9WMEqNB_J7KE>
X-ME-Received: <xmr:vBxuZd15Ns38qxVgy4v8mld2pVFkMeFbIdGqzlaWatjlqg-1S33UkuGe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
 fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
 htthgvrhhnpefhgfejveduudehvdduvefguddvffefgffhieeuudefudfhhfeijeefjeff
 heelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:vBxuZUDdTZRCUFM97J7-nHikYpx55cjpjZm-X9RtoKGcL2EG8v8NdA>
 <xmx:vBxuZZh4Ms3Tarsa6bjoNbXjwZ3YUUK4Y9esVSJ0T7cuyyYUewopSA>
 <xmx:vBxuZQqF3DPcVD4-uiVTZ649JHpKx-F742pLuASt0_vyqQ1Y-jcJOw>
 <xmx:vBxuZXbKQga2DwKkiYAOa568XnKntizv9CSI1zsvWSpJ7QMgAJlRXA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 13:38:50 -0500 (EST)
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-2-shr@devkernel.io> <20231204104547.GB22019@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 04 Dec 2023 10:38:14 -0800
In-reply-to: <20231204104547.GB22019@pevik>
Message-ID: <871qc1sthk.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] mem: disable KSM smart scan for ksm tests
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
Cc: david@redhat.com, linux-mm@kvack.org, oliver.sang@intel.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Stefan,
>
>> This disables the "smart scan" KSM feature to make sure that the volatile
>> count remains at 0.
>
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
>> ---
>>  testcases/kernel/mem/ksm/ksm01.c | 2 ++
>>  testcases/kernel/mem/ksm/ksm02.c | 2 ++
>>  testcases/kernel/mem/ksm/ksm03.c | 2 ++
>>  testcases/kernel/mem/ksm/ksm04.c | 2 ++
> Li suggested in v1, that also ksm0[56].c should disable smart_scan (ksm05.c is
> questionable, but since you prepared ksm07 it can IMHO be disable in both ksm0[56].c).
>
> https://lore.kernel.org/ltp/CAEemH2fqamX720diM1N+iN9a8HM30_5sHg8V0EMHgHdrh3iZPw@mail.gmail.com/
>
> With that, you can add:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

The next version will also disable smart scan for ksm05 and ksm06

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
