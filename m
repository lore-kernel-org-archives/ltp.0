Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B08DC4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 18:41:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854A03CF5CE
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 19:41:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 803F23CC343
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:41:31 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01508601419
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:41:30 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id A5C975C0139;
 Mon,  4 Dec 2023 13:41:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 04 Dec 2023 13:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1701715289; x=1701801689; bh=No
 fgSCWVbho0Iwa+msgmWbnu2ii1ZFGQNr+r4V3jW5I=; b=RV81CAqK2+OSznVbOP
 6tz8cjDrGPcU/Yw7adu00igmRRaCew5RByzHm/rbMU+vV3Evk4VKRLhD04qxyZPT
 6IH8MYSbnw1A47JjBU3mkNeCNC8o2Ll7+ksrvB7625QuP1sI2bD4CFAUJG8nlpgT
 lpG0uKie/do1pwOZxdp5BYKEOVPJ7MO42z/nW44+f3C6ruDXQJSyRy3xy6duWnLx
 gtMdi8s7NRJi/AT5FN3nmIS+KtBzh2er5ZjVHFyeIRKsnOKionxeUXjI2ZEDZEwc
 rxo1YGLWB+2PHw0DffB8KmvUamW8DOZjBqPOu1iBtzVIjbkWFWg0ocggi/0UsIzB
 4lFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701715289; x=1701801689; bh=NofgSCWVbho0I
 wa+msgmWbnu2ii1ZFGQNr+r4V3jW5I=; b=USWuEF9MurOXZzOyQdncEpztHybt2
 rSY8KtrD20mCI6yQpDkmDwEwfR4aG1lBO7Rh4cwRRaEoZoAYnyq2gq4YY1f7XES/
 e8DCZJw1NEwDXwTvD7zAHWjG6JUGAFF5VCTQaFQWRDz1Ls8EOvHozr0b+PqstOJp
 hUwnwJ5JrlMHeHSUHrsXfOkwRATljh/fTFInOoNjt1aIjS16N7i1+FRjU43RJu4g
 3i2rsPpuwDcq7YZ6eNKIsbwS3hh9nf0kZeB7mOEBvxzSW34x9GeU1MwGNSjjlUmP
 V01C4xgPZmJtvP3Chxq6sh4ZfhZIaReoiwffs19matDALVHZHNYpk5xYQ==
X-ME-Sender: <xms:WR1uZY5tz_oloaNsX7VTtSDgbpkVIpdqEeBzEMj6_hjmSy5AO6d-gQ>
 <xme:WR1uZZ5VnZGBetn6QMlxtgpprpR9p5erDgBJsmRhru4brtICQz8p0K_aWiCL7zXBw
 0NNzeYgNCfBZ-18XLY>
X-ME-Received: <xmr:WR1uZXfA8UMOG38ec67v7sJ3LTKIE9q7kXXhRB6H7BD-QxgvoDNpSKtt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
 fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
 htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
 geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:WR1uZdJIcQWF3GdVigDH4jVK7QPvuYJYflNuaQOwI8KRyyoe_PsJKQ>
 <xmx:WR1uZcJxhJLLmK2ALgTZoHIPFLxjbe6Gc7ViWN-NEeWfETJ3pj6dqg>
 <xmx:WR1uZexXV_xtM8cgT9oCbLldtmOJELk2FQeoQlwQLCCHXwtqxfcowA>
 <xmx:WR1uZWgBYe3sFGH6B8LGlgh3P7My2rhhrrLdTdZGeRYIxw8a2rcORw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 13:41:27 -0500 (EST)
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-3-shr@devkernel.io> <20231204092118.GB8727@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 04 Dec 2023 10:41:00 -0800
In-reply-to: <20231204092118.GB8727@pevik>
Message-ID: <87wmttresq.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] add ksm test for smart-scan feature
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
>>  testcases/kernel/mem/.gitignore    |  1 +
>>  testcases/kernel/mem/include/mem.h |  1 +
>>  testcases/kernel/mem/ksm/ksm07.c   | 69 +++++++++++++++++++++++++++++
>>  testcases/kernel/mem/lib/mem.c     | 70 ++++++++++++++++++++++++++++++
> You need to add 'ksm07 ksm07' line to runtest/mm.
> If it's the only error, we can fix this before merge.
>
> Kind regards,
> Petr
>

The next version will also update runtest/mm.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
