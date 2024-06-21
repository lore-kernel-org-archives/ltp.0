Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3AC2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:09:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CA3D3D0FAA
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:09:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D503D0660
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:56:53 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=arndb.de (client-ip=103.168.172.159;
 helo=fhigh8-smtp.messagingengine.com; envelope-from=arnd@arndb.de;
 receiver=lists.linux.it)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F64B60071B
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:56:51 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 153A01140210;
 Fri, 21 Jun 2024 04:56:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Fri, 21 Jun 2024 04:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1718960210; x=1719046610; bh=LCP3GPJDV8
 F/N+nAlcGiBZYx7s7qKdEXuPIAtCYCsw8=; b=H7mCTDwxBhL6/3nl2kvwH7Z2jf
 vHvRWJWjo62xKNC7P63pFKMi0lGQH1oK9d5uLt4KZnRj6RDabX6f042YKlcBY7VL
 ZZq1IVlKZ2tgE49wrDxmbx5ZugEMclHbG+fKzej1xJSCVx2tZvZ3YPE5yAhRu1hX
 g6XV6uYI8W0AZrAHJH7GLQD/PzjDkfnuabR9xUItNv+SX/LSx1+9CeE43E1pWrsw
 H3/6KJ+q3UXf2HjYInaAx+URfx3SrV1MtmOIAqug46Iecs28LMSKwCe+Wulv7Yzh
 +lVLEByNlljBiKAtUqzaNB80GN0U3FbfHu66zSBtt4AZT/eJby+pGlrYPqRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1718960210; x=1719046610; bh=LCP3GPJDV8F/N+nAlcGiBZYx7s7q
 KdEXuPIAtCYCsw8=; b=K4cdFx4S224MYRT+r8L/r9U1j5q9lsA7B7hhlIrlPjWc
 7EDb3ZPjlybzPs2NKQgEkl/fSHKd0CDqzFXj7P3t+qGfnRRJ78YrIYGTuI3sC43Q
 6y8H6AA1V0PIijyE6xMkgGupwrnRWrZbay1fonLCHWP6Qa/M3EcTzWO0bm0ePn1Q
 O38dmf9if6C4B+mrVHd9kbUcCSEJwcWVo6jkCthFmcFHahki2cGoOM3KesCvklVz
 YT5grRrYymPqsYUACYcdY9Sp9ICM60lfM3yEmkxnIiJkr+UigAeW3QKYo6psB+j+
 ytsTijk6h1ZVtxvQRM1KQbzMrZL3rRnt47XsyTlhYw==
X-ME-Sender: <xms:UEB1Zm4izm0yfspkW7ydjajHNz_V1xCdigbmfAZFmL5oM63ee-Wyhw>
 <xme:UEB1Zv6YEV3Oe7A3j2UMK3TBnvu3IWBefk9T9nUTdlpS5WMN3RIeTZ_JYgTz2Q3Id
 Mp3CcHRYUWGMbC0aLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UEB1ZlewerVmgQOEvLDFfmzpJCOmUBZQGyRAmjbsdJfs6xzQkp-YFA>
 <xmx:UEB1ZjKrwsZrMN1BtdbMbDwR4OJmLJPFU-kCoOw2HcS_usyMMgHDsw>
 <xmx:UEB1ZqKUDfHnKePjmuIj68bW7G0CAsctQb5pzimSurs_Ge9Zp4ONZA>
 <xmx:UEB1ZkxxkNjEJAVWyRsEOh7wRilHzDQTxq6cEooXIRlUnDuIBwJ2SA>
 <xmx:UkB1ZqViuRkEf_iw5Waz5bDUqxF18TnrV2GO1kTJMH4GWiGo1Svimx46>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 38B95B6008D; Fri, 21 Jun 2024 04:56:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
In-Reply-To: <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
Date: Fri, 21 Jun 2024 10:56:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
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

On Fri, Jun 21, 2024, at 10:52, John Paul Adrian Glaubitz wrote:
> Hi Helge and Arnd,
>
> On Thu, 2024-06-20 at 23:21 +0200, Helge Deller wrote:
>> The patch looks good at first sight.
>> I'll pick it up in my parisc git tree and will do some testing the
>> next few days and then push forward for 6.11 when it opens....
>
> Isn't this supposed to go in as one series or can arch maintainers actually
> pick the patches for their architecture and merge them individually?
>
> If yes, I would prefer to do that for the SuperH patch as well as I usually
> prefer merging SuperH patches in my own tree.

The patches are all independent of one another, except for a couple
of context changes where multiple patches touch the same lines.

Feel free to pick up the sh patch directly, I'll just merge whatever
is left in the end. I mainly want to ensure we can get all the bugfixes
done for v6.10 so I can build my longer cleanup series on top of it
for 6.11.

   Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
