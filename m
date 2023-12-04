Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F38DC4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 18:40:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 098E23CF5C2
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 19:40:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBD4A3CC343
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:40:04 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FE3E60154A
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:40:03 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 120865C0192;
 Mon,  4 Dec 2023 13:40:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Mon, 04 Dec 2023 13:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:references:reply-to:sender:subject:subject:to:to; s=
 fm2; t=1701715203; x=1701801603; bh=aGFZfyQ2WN2CydKNxY+nIAAd1dL3
 9GKDKCTb2c27l2Y=; b=dtnrZ4CDSJVPXq7l92POJ6uLgu0WZ1kyuFt/oq89MmjX
 ma51E/dGqYux6RWuDpyPVvXZmQ1CsrUa921qoiyWhK1evdt/ixy2SjrdHgNTx1OB
 QuNhSi3QdzDWOqz3dPLsPNo23XB7IzGSz9sGtx1TdzBrVPO7B0WuBmuS6U271JZJ
 tg+vRio6lMKblOy/rEq2Hp1LNbxcC4byPOPbWCeHIdjj31psQ03NLT6ndP8KUNDM
 4dAjYQbJ3AcCC3svEfqqwa4f+jaxTDjU6iGvRdF2ByzoiQgxyW939iRKvdpymdSS
 0PvnRpskJLiRtEe1MJaMn4YfmYWLLSRqYcGafqG21Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1701715203; x=1701801603; bh=aGFZfyQ2WN2CydKNxY+nIAAd1dL39GKDKCT
 b2c27l2Y=; b=rB/TuKevUaHf6ExVgPLFb/d0zHHjCyhBSI53YjgRinui4ucSYER
 AXjjUpxJiUTVkiofH8y2J7ci4PCcbxjRQ9uY57z0fKRu7NRGcN+b8/A6dPIiOsJm
 ZfKOMlrj803CMQnXA0mBun75Q9P0vOhq3cKuPn/8HbiV8OLTZaHS3DtJ2IuVT/jm
 RtY2Gh9tSWokCQIqj/8plZGuu8+FtM0TypzhoBRysHLBV8QCmcK9Ndrnjt+/O5JX
 KcuzYF3uPYf6Zc0YMYdQXPvjh6Dm6xxskUbLEy+/tPnDsiUKtjNVjCwq0QAqI19j
 1DG53SOsjs/XraYBHhAqrfjC1evs2Dc0drQ==
X-ME-Sender: <xms:Ah1uZft2UaIRPZ8tngsHCmltg8pOEhl8BH4b7FjBra_A_w9lLsIf3g>
 <xme:Ah1uZQdH7-5fkYDeHV_HhSAe5yoRaN_Q7kiq1n01eQngxhWU6PIQxb08lLOXeiMj8
 dL5xkFH45nuYLXYXGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enogfpohfkffculddutddmnecujfgurhepoffhvfevuffffhgfjgestddttddtreertden
 ucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrd
 hioheqnecuggftrfgrthhtvghrnhephfehgeeifeffffelueejtdegheevgfelgedukefg
 tdehjefhhfehvedttedutedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghv
 khgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:Ah1uZSzghTnha6lSeuFUuycAu7wCPdwV0DUAPjyowWf9aFQvyQ4kMQ>
 <xmx:Ah1uZeNm29pmo41dBhD5x6orpDAkfHpyXDSuzxsAKhx1AQ4psQJ1Ug>
 <xmx:Ah1uZf-EYj2AY93XaRybGWODI2Ca7pBy4LBkPTBzHR5Rj_7Mw6SmsA>
 <xmx:Ax1uZbYXZkpVVgfyULfUOdIM0AzBa9w7ru8kepVRZmXFweCtYbULEg>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id AF102B60089; Mon,  4 Dec 2023 13:40:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 04 Dec 2023 10:38:14 -0800
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-2-shr@devkernel.io> <20231204104547.GB22019@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
In-reply-to: <20231204104547.GB22019@pevik>
X-TUID: OfuWPN+9L6d7
Message-Id: <20231204184002.AF102B60089@mailuser.nyi.internal>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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
MIME-Version: 1.0
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
