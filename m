Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91755C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:09:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF273D0EC7
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:09:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7553C8B52
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:52:23 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66;
 helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de;
 receiver=lists.linux.it)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C0FF60004C
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E4Wi5d7bXBV7z5XVlT8JIza/vfQrRm742lmMk6jnmUc=; t=1718959943; x=1719564743; 
 b=NRCLkao+nB4Yoqza7Izz1dUT74TUhaR5S9m1kpiXMYfQ5XXXhfx3dP+bgA4sHGMNOQxBiHb/Lqq
 Vxk55l6FY2WEZzlRwg/ZzmAts4tW6JO31TBIvtOD9gjhV/w8kv1YO8u04u1JIWccJ4W/uIOCbbQO2
 wQRov8YoReJH4cLsQykC+xEf0d0Z3HBP7CafKqMYDVLAkhoIcUkHgksK4DdHYcLyYFqdpoRVMa0Gx
 Y7KRXyn+6tUO74xMiQn6YjqEs7S5ZRcgE/KsXqGPeDewsiZPfCsiyP9+p4hTyF+cjonNHJGehLq4q
 DQKf3+CdmyHpI7eGbostV2u/vZGu7lHNQjnw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.97) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1sKa09-00000001yDB-3V13; Fri, 21 Jun 2024 10:52:10 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117]
 helo=[192.168.178.20]) by inpost2.zedat.fu-berlin.de (Exim 4.97)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1sKa0A-00000001dsi-0AE7; Fri, 21 Jun 2024 10:52:10 +0200
Message-ID: <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Jun 2024 10:52:08 +0200
In-Reply-To: <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.117
X-ZEDAT-Hint: PO
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
 Guo Ren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-sh@vger.kernel.org, linux-csky@vger.kernel.org,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 musl@lists.openwall.com, Nicholas Piggin <npiggin@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it,
 Brian Cain <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 linux-hexagon@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Helge and Arnd,

On Thu, 2024-06-20 at 23:21 +0200, Helge Deller wrote:
> The patch looks good at first sight.
> I'll pick it up in my parisc git tree and will do some testing the
> next few days and then push forward for 6.11 when it opens....

Isn't this supposed to go in as one series or can arch maintainers actually
pick the patches for their architecture and merge them individually?

If yes, I would prefer to do that for the SuperH patch as well as I usually
prefer merging SuperH patches in my own tree.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
