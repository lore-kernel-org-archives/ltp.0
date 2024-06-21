Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B5DC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 14:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E81323D0ED0
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 16:26:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE9453D0E65
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:52:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=arndb.de (client-ip=103.168.172.147;
 helo=fout4-smtp.messagingengine.com; envelope-from=arnd@arndb.de;
 receiver=lists.linux.it)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33FAC60565F
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:52:45 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id B795513801A0;
 Fri, 21 Jun 2024 05:52:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Fri, 21 Jun 2024 05:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1718963564; x=1719049964; bh=WMGDo/weqH
 B9YDWLlQD6sLBRrGER7ScpjCWRSqIRAJU=; b=MKJcxPLGgvmkBY+j/HTLZjZ8KI
 pvGXw459FAlanf7Ac5v5b80QkLQF8xlXMpxYpBvx4w9U/JqBjy+WLg42sp2LCoU7
 Q1b7sVY0U9atF6syLC4XY52fNn0nDOmK/ZAU1NPDw3Ole9FWcIKsJ3WhrUSbjS0O
 i2l2ZiXzugEyGrEBwdm3cuJRW2BdSaCh9EPr80/iCCtKcq6Na1X7f0bajgjej8Tx
 FitYQuzmPjk0hPwNzDjYuPI+Yp1cAv/YSHWqMQzL0+ow//AxFir6unBR1Xx43VMt
 sTtOJWUxx7oJFStml4ol1MIfUqgzo4a50v7aYyXLtepLNGOKd3V6UG9I95kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1718963564; x=1719049964; bh=WMGDo/weqHB9YDWLlQD6sLBRrGER
 7ScpjCWRSqIRAJU=; b=X7nAgy7BTqyAvR65qflUPcwaq1L6pXZMoo47rxn9ZM3V
 sKDdHt5wvqDbT5sa14aR9hCMiL0oj6CvWrv8SKMrJq40IWWOWM8MbFp61EphmqmA
 GCBih7Z83pGEIOJtdrxEY58EcLZTCfr3LtYlO5Bk5HkZc4y2HUPbxdUUvLm78WWR
 6tuoSmWxlD/uu2pPsgmL8g2dFZKC0Xt/QAcoFkPreb180QnAWGYkaopwGC6yCFEm
 /Z+Br4e5r/bgM/ZXXRokPJT4v4p+Ba0c7m4Kpk7n6XdiBc6ZZ4ATNt57/k27/Yh7
 tkRb7e0hgdJYE6Yo5pJL5NM0EiwSlMy6buj3koNHsA==
X-ME-Sender: <xms:a011ZoRKk0xgtXrnk7B-qG7CoQgSoOMrP6uxlJU8ziJL2FLkCKjJ-g>
 <xme:a011ZlxuT2HoJobpF--UwiCQxrck0_h0q9Qbx7ELDLXtD-5We7CXp5ouF-xDkVRRJ
 XeIZNFUDqIuP2U5LAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:a011Zl39KEhZ-U9AaTAu3qpgNWAWYG4Puo5AAhWDqyHAU63ILvKvOg>
 <xmx:a011ZsDatAkgsBYef_mlo8HxX4iiDqSBQuQ7pbgM9HyizWRoDF7JfA>
 <xmx:a011ZhhozQMBHEtX3Ty6cO1Tqt3jE9LlaBWOyo6ySWIoCH-OSDkLxg>
 <xmx:a011Zop-AXFZkCbuJe_8FCJsMNZLUN5VvVeVPrHUajKBVXxUTW5uxQ>
 <xmx:bE11ZsMsQ8wP4yZocAMKl9MACO-_6K03a9Qh0f0TNL0WVY97DHdpMQGU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D8547B6008D; Fri, 21 Jun 2024 05:52:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
In-Reply-To: <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
 <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
 <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
Date: Fri, 21 Jun 2024 11:52:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 16:26:08 +0200
Subject: Re: [LTP] [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
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
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>,
 guoren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-sh@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 LTP List <ltp@lists.linux.it>, Brian Cain <bcain@quicinc.com>,
 Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Xi Ruoyao <libc-alpha@sourceware.org>, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 linux-hexagon@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 21, 2024, at 11:03, John Paul Adrian Glaubitz wrote:
> On Fri, 2024-06-21 at 10:56 +0200, Arnd Bergmann wrote:
>> Feel free to pick up the sh patch directly, I'll just merge whatever
>> is left in the end. I mainly want to ensure we can get all the bugfixes
>> done for v6.10 so I can build my longer cleanup series on top of it
>> for 6.11.
>
> This series is still for 6.10?

Yes, these are all the bugfixes that I think we want to backport
to stable kernels, so it makes sense to merge them as quickly as
possible. The actual stuff I'm working on will come as soon as
I have it in a state for public review and won't need to be
backported.

     Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
