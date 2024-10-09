Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D9CCF07BF
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728549326; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=LIJrI5XWV7SA8E5jTExyCo9Xd+K9pSawLoYeFd+Y+7I=;
 b=OpBQiOVHzoOELDsvrAqCx6bhfGMFgAhDwViPnrt41VtFNQ8C1HItcnA2RYr8nrQgyBWfp
 QESYAYauFrn2wWyWz/obqEi1bsZ5Asa8jSlys7EgaSOshZYj/6ys2fCie0wVPVU3HlIrKzq
 ZP0zCi2D0EkTqVBKljs0knWoz3DQ0Yg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE19E3C2AF7
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 10:35:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D4753C0368
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 00:03:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71533205CE6
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 00:03:21 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4AD2AA4478E;
 Wed,  9 Oct 2024 22:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D998C4CEC3;
 Wed,  9 Oct 2024 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728511399;
 bh=wHu0vL5OYfmu+L39nIZU7+e1wsKSMJA58f6KwHUZgcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WV6vF9/2fDQLRiQPFYPkhYe8w4fpee9+NbNJZy0nVD5UsYX/9qnd+VZN5aZqKkPa9
 fMNDVQcholTOjszBa+mA2ZH84jZ798H9vTL7erJBZm/O+W1DepFkMNBGeLz52Kwnpj
 fS1Gw3kxcO8cgDd5vwwko4bWQr1sHg3dGR6WvnpCUCqRw8mL5EVRy1LH9vBOnq1Oet
 mPuSzCByAW6VY9aRwT/feic4jL3wopgxfwXyYXDtoAAGMvEYKk4RFO09ffMIZG6baH
 veTgjlvlCFKSy5SMiVgCqdrmaDnB1h1MFQWxikEn+cZato8SeAGvDVcQWyTxiCMAS8
 tz8hPaEzluwmw==
Date: Wed, 9 Oct 2024 18:03:17 -0400
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zwb9pbX7MnPqGPoM@sashalap>
References: <20241008115648.280954295@linuxfoundation.org>
 <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
 <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
 <ZwZuuz2jTW5evZ6v@yuki.lan>
 <CAASaF6wdvXAZyPNn-H4F8qq6MpHmOOm9R+K+ir9T_sOG-nXpoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wdvXAZyPNn-H4F8qq6MpHmOOm9R+K+ir9T_sOG-nXpoA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 10 Oct 2024 10:35:06 +0200
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
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
From: Sasha Levin via ltp <ltp@lists.linux.it>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org, patches@kernelci.org,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 jonathanh@nvidia.com, linux@roeck-us.net, srw@sladewatkins.net,
 broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 rwarsow@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 allen.lkml@gmail.com, conor@kernel.org, linux-kernel@vger.kernel.org,
 pavel@denx.de, patches@lists.linux.dev, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMDI6MDM6MzFQTSArMDIwMCwgSmFuIFN0YW5jZWsgd3Jv
dGU6Cj5PbiBXZWQsIE9jdCA5LCAyMDI0IGF0IDE6NTbigK9QTSBDeXJpbCBIcnViaXMgPGNocnVi
aXNAc3VzZS5jej4gd3JvdGU6Cj4+Cj4+IEhpIQo+PiBXb3JrIGluIHByb2dyZXNzLCBzZWU6Cj4+
IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI0LU9jdG9iZXIvMDQwNDMz
Lmh0bWwKPgo+YW5kIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWV4dDQvMjAyNDEwMDQy
MjE1NTYuMTkyMjItMS1qYWNrQHN1c2UuY3ovCgpJJ2xsIGRyb3AgdGhlIG9mZmVuZGluZyBjb21t
aXQsIHdlIGNhbiBncmFiIGl0IGFsb25nIHdpdGggdGhlIGZpeCBvbmNlCml0IGxhbmRzIGluIExp
bnVzJ3MgdHJlZS4KCi0tIApUaGFua3MsClNhc2hhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
