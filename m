Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C198AC2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:09:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F3353D0EB3
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:09:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263183D0660
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:54:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66;
 helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de;
 receiver=lists.linux.it)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4EC8D607136
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ux19xNP9Z9FPgP5f+00+S+qPS6imbskeOogbDqAbYA=; t=1718960058; x=1719564858; 
 b=FUD7S7ybRmEmtwH5OE6cfQGIJoFvpPOIITGZnmRw6dKGuwQT+w61l3YvRmDi6nZW/i5atz+NQWm
 z00YkhsnZ7YXJN/vDrkHjw5EULQ2XCNMdLGz33jEPn3MUjNVC2/mSFiux5G3Ei5EY3UWwhytGIDvf
 2M5rTTOwHNy8iDfZ2oL3Y0UxVVYFtGIRMA1QqPOJH6r+YjA/AqiTbB5fSQ3zqnBX0HQZr+c+thDHv
 USA3QsiauqsAgpgCs+KHomRz/FkLDF+fz8v3KjN2chtm/K1EynMoOJ9bNM6bSWv+osc6heZ0yEgpc
 xX+xK3p55W8BM0addSrFhDJVErZ0lnw0sTmg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.97) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1sKa25-000000020GB-1Me6; Fri, 21 Jun 2024 10:54:09 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117]
 helo=[192.168.178.20]) by inpost2.zedat.fu-berlin.de (Exim 4.97)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1sKa25-00000001eAa-2Euu; Fri, 21 Jun 2024 10:54:09 +0200
Message-ID: <3444b93ce46c7e7c156f912495e5c35ccf275549.camel@physik.fu-berlin.de>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, LEROY Christophe
 <christophe.leroy2@cs-soprasteria.com>, Helge Deller <deller@gmx.de>, Arnd
 Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 21 Jun 2024 10:54:08 +0200
In-Reply-To: <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
 <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
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
 guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 LTP List <ltp@lists.linux.it>, Brian Cain <bcain@quicinc.com>,
 Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Xi Ruoyao <libc-alpha@sourceware.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Fri, 2024-06-21 at 08:28 +0200, Arnd Bergmann wrote:
> It's more likely to be related to the upward growing stack.
> I checked the gcc sources and found that out of the 50 supported
> architectures, ARGS_GROW_DOWNWARD is set on everything except
> for gcn, stormy16 and  32-bit parisc. The other two are
> little-endian though. STACK_GROWS_DOWNWARD in turn is set on
> everything other than parisc (both 32-bit and 64-bit).

Wait a second! Does that mean that on 64-bit PA-RISC, the stack is
actually growing downwards? If yes, that would be a strong argument
for creating a 64-bit PA-RISC port in Debian and replacing the 32-bit
port.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
