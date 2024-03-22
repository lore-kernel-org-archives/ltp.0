Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA58AC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 10:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E125E3CE623
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 11:49:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F68C3C997A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:49:23 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=invisiblethingslab.com (client-ip=103.168.172.152;
 helo=fhigh1-smtp.messagingengine.com;
 envelope-from=woju@invisiblethingslab.com; receiver=lists.linux.it)
Received: from fhigh1-smtp.messagingengine.com
 (fhigh1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF2307A6287
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:49:22 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id EA1021140127;
 Fri, 22 Mar 2024 06:49:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 22 Mar 2024 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1711104561;
 x=1711190961; bh=xcultb/FSBcS6o/jxb9oyVLP+U+jJ5Y6RAp7U7D4L40=; b=
 FkHKbBVqJ1AH69juG/Xd6uZfrr/O80nQka7wDViLb6dicKUoyApDlBZXL338YMpy
 4wImsVBBek5365LdAiGTntCSc7otcq/Bl5ypCOl6De0LGoIGvNzUUSlKC400bSXy
 NbzwoI1mfK+asAgMp9uFiBem+B41fv1ts0SPukKujICxbtfg+EJFFvDmiBrYylpb
 JPclMYzVf2TJveXbQoE+lsuFZ//JA1PNFYtdQ0ChastWk6fa2kOZgxqLnz09OjJ3
 RFP0qLr7CaduaTlcwTKns4Fp0SVfk7JmodaAUvBD19DggpsrZhzXgOum7NZTCzsP
 UBYov80jNMPMoYrAEnXlkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1711104561; x=1711190961; bh=xcultb/FSBcS6o/jxb9oyVLP+U+j
 J5Y6RAp7U7D4L40=; b=ffQ68PShILBBiiltQX3oq3XoTc7XrJnqpgdERVCIobww
 mRGkzdIoZLNoIKD70qOUIwdvmg+11R1e0kVIHvM0HukLUJLQrQFmxraVlg/QWUyg
 eQ8GnUUg6PQRaehXaXeNqS0e5+E0dPODeLEO+vjnOsv1Qgq/M05r3ZJ4sv4+vko3
 Jlzzp1CAVnNkvMwj1lGHwfccZFNvvk7FF+DbavGULqiRsbUzaPRD0DTWKhaM1xQx
 AnlDYNa2gCqvTBnU1KBwAg97a8lzClqQuWcisL8zA/Kkxm1AebwzjRn2qCUaqc0I
 eE341ZExMQJI+2KbAWNtN8x5do4gIolLfWLku1Cq5g==
X-ME-Sender: <xms:MWL9ZcMxyMNBAaqldfJ3zt305Rp3PkGQVwAa-p2TVHUWLJEXCBoQuw>
 <xme:MWL9ZS9-rHpeuwP8blptVZy6AcM8yuLFemccwLvUqKC60VoczK-RTCXnNS0OXLOJl
 blKZEBKpXlQVWQ>
X-ME-Received: <xmr:MWL9ZTRMhEHUSNgkYYc0Jjc0uQ2M7q7LaZQPPXuK5rCVk4lg6CC_G9pssHdjxgTXXy6kcNTOUxl1XA_Q4DXQVb_FjEAkvvIFLXkFL1JjPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggjsehttdertddttddvnecuhfhrohhmpeghohhjthgv
 khcurfhorhgtiiihkhcuoeifohhjuhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
 gtohhmqeenucggtffrrghtthgvrhhnpeegvdfggffgiefhvdeiteegffegjeefgfduheek
 hfekudfhkeevleeitedvffeiueenucffohhmrghinheprhgvrgguthhhvgguohgtshdrih
 hopdhrthhfugdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepfihojhhusehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:MWL9ZUuWnl5C3Nob6AGNMNNged2TcNkZwbNozeW5NndSRdti-s3GwQ>
 <xmx:MWL9ZUck9ZeMIA8yilG-gcQ7WOtk4ZZhO0aRKiXLG_kYBnYduuAUuA>
 <xmx:MWL9ZY3YUnYz7_dT4kBCEjeLsLp0d0aO3bhLZOiyBJ5gK7c5Jftr7w>
 <xmx:MWL9ZY9zbiqRmbUOLqaOfthENASAGusbCzgnrMZgzH1sQjhyLHhoug>
 <xmx:MWL9Zc7iNnoVLAtLFsB8Sd-Y4XOtIaoJkgjM0u5767PzsfYpCof1BQ>
Feedback-ID: i71cc40f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 06:49:21 -0400 (EDT)
Received: by mail-itl.localdomain (Postfix, from userid 1000)
 id 66C06ACC7C; Fri, 22 Mar 2024 11:49:18 +0100 (CET)
Date: Fri, 22 Mar 2024 11:49:18 +0100
From: Wojtek Porczyk <woju@invisiblethingslab.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zf1iLpAEQ2PSPPwi@invisiblethingslab.com>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
 <20240321082559.GA535362@pevik>
 <593a7a6a-f4dd-450e-9fbe-6f77ef62c6ff@suse.com>
 <20240321085656.GA543531@pevik>
MIME-Version: 1.0
In-Reply-To: <20240321085656.GA543531@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/10] New LTP documentation
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

[ sorry for repost, the list does not seem to like PGP/MIME ]

On Thu, Mar 21, 2024 at 09:56:56AM +0100, Petr Vorel wrote:
> > On 3/21/24 09:25, Petr Vorel wrote:
> > > > https://ltp-acerv.readthedocs.io/en/latest/index.html
> > > Out of curiosity, we need to register LTP on readthedocs.io.
> > > Then we need GitHub Action hook (including some secret for auth) for publishing.
> > > Correct?
>
> > > https://docs.readthedocs.io/en/stable/guides/setup/git-repo-manual.html
> > readthedocs works with any kind of git server. The only thing we need, it's
> > a .readthedocs.yaml file inside a specific branch (i.e. master).
> > So we need to create an account for the LTP team in readthedocs.com, then we
> > provide the git repo to readthedocs and site will be published
> > automatically.
> > ltp.readthedocs.io is available, so maybe we should create an account
> > already.
>
> ack.
>
> > > I guess you now deploy to your fork manually, otherwise you would add GitHub
> > > Action config in the patchset.
> > It's automatic done by readthedocs and we don't need Github actions.

If you're on GitHub on GitLab, may I recommend pull request previews:
https://docs.readthedocs.io/en/stable/pull-requests.html
https://docs.readthedocs.io/en/stable/guides/pull-requests.html

RTD will build partial (HTML-only) docs for each push to a PR. It's very nice
for online review, you won't need to push to your own ltp-something.rtfd.io
variant.


- -- 
pozdrawiam / best regards
Wojtek Porczyk
Gramine / Invisible Things Lab
 
 I do not fear computers,
 I fear lack of them.
    -- Isaac Asimov
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEaO0VFfpr0tEF6hYkv2vZMhA6I1EFAmX9Yi4ACgkQv2vZMhA6
I1FLLhAAhmWu1bFmcQB8uKNb+3d9OuPA7lwsnuK7Lo7HXQNaWG4qGdQBQLIwi4by
SEBEIw0olU7BF2JVvRun+KGHB9j5PCSHJmXFdmbQy2WLetVdc6Aogwr9O/w2gIvf
/5+iQNBdxe5dfB6naK5MnrR05S83bqjrsRtsDE+Bvng9yWuVdD4xvQTnZNOmfsOK
nzpZs0gNJszzuZ6hHu8dKulvBmqVlRS/+K5Agnd1W1Vc1ZOrJcPuFcn3GipvROgq
s8boPhBaGRoXWfU2Ye/ROw/WcgO/H2ISOC9N9RpQ9y5oQnDmMd6NnrlMEVEjUFkL
5xgqJUsOoisiodemoAFr5fPqvwpnCQQzy7OV3B2VMkrV/arXj9TQKkvKz7LA2HA5
YI5MGajflEZNoL4t5BjmBDMhF3UdlXxYW/EK946qkIpWm8ylX52CEHNXb7FSpNqY
IKDvORWb3TH+mGyLJO2Zyywd3IPnd8Z5v17+qyLMZWg5zfwUJbTPu2c5IXYCA8vf
umoDLdIow0ccnBQE1JE8UTMKvLFuC0w4XJgrvc0b7d+uzV1tbaSoL87XQib3EWYA
tM2Y3o0LTebiaF2UH17D71nvBQbpTEdoKgQa9TUpqdLyzLRuByUcK0odbWC9WDkG
iMwUHyaf0+GGSbrpGK5oNJDsA89Q2ElcqeLBhVY/0W4z1jxHM20=
=acLP
-----END PGP SIGNATURE-----

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
