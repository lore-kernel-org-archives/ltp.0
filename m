Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4714DC3064D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719480241; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SAmjgwVCltzSABKyDCz7CSgs8OIWRs/9DLPvuUiQUPw=;
 b=e42geIEOrQm93yxYNGF5XzXGVojjbaMa/TbyM/R+4voC3JTQW+3NOakXWt5NDMNvE0vvs
 fP7lIE89/48oZY0aggwvjC0cWW++yi1P3RabnLC860yOMJGQW7nNobq6wAjikTmDq0p4cuF
 9fYAfuZD1jOvxuHFmcOcvkRGTkDV2bI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B72E3D1234
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:24:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DF4F3CF91F
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 18:30:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de
 (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=deller@gmx.de;
 receiver=lists.linux.it)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C5216013ED
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 18:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718987346; x=1719592146; i=deller@gmx.de;
 bh=TaVSF8Wo6axT8++84WQ+MyVXhldB4MqulOKt1aiG610=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dGyJ89S3Mtnb3qCeqKQ7dNrV2AX+MBvXvpFOS5qdU5StBNeSfBhj3npOOzwCrL2I
 OWu4Iw7nLS7C7FqGCqb9jP0mHnSAWNDp/B7oOpqNyH+7RhIwXCY7R/TwxqQG61hYm
 /IvwIpeBjt0GepWOMNkDAIUg6eRs65R2+nmi0nxpCsYyDq2gK2tPySnYyWpVG8S43
 ZvQEf501RrASQFyXuehQg5sXe2oBtvJ5uLn25WBdeSp2PKuSAq3KMcugDsB48Eqww
 CywDG9/PCKvur0T1ok3M2r3j5b7JRp7HrudYWXhNrBq8o2LuvA8pkp74qNhDfJjtS
 rCoZwjkgBr8NtnIQgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1srq1Z2d4N-00ddIK; Fri, 21
 Jun 2024 18:29:06 +0200
Message-ID: <cd7fdd76-8da0-4d43-9d1c-c93aed4c0f5d@gmx.de>
Date: Fri, 21 Jun 2024 18:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
 <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
 <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
 <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
X-Provags-ID: V03:K1:qzcGugqMcbMY+YWYJmVsNMJLSzXL1IFC+qPqRPEqwIjeHu1j8dW
 eKrd9zTKO8WqTBd1atZ9gk73fhgOsLFzmyt55jQz2EE0lv7OLTEi8eH1tERMhO+XealwSx1
 UGgBBAPSpMfKRXJChZsTA9t/N/bEd9WMNnHEwTU1TsTs3cyh1vRWNfUsERYHddYMxe16B2C
 4cE95QxNZt3dO/ZdT1fcQ==
UI-OutboundReport: notjunk:1;M01:P0:qkvA0SU8VBk=;7/QatZvg+BRxv1QkYdIagec8md0
 /gpUIUeNoh2h5Zc2DzrKSZAqUU/Uw+GnsiaAaeHEHI+myLKBBKPB0CZ4PI9GoNYcjlvRwC+Dt
 cj4SKrgECYJdrasgoF20T9r9P8F4BOUJuHY7LfSfBt6aBQXc93SxHPI1b2yssJl0RJaoaYxmY
 oLb2/KG/hDplIAs8CJ6xU8ciG5YfyKU1j1+jkWw1MQPFc3+e4aIxLiTSvFRncW/p38cwcMayq
 jza45P6I18yIb0lDFwYxfYx7JtvcYmz49tEM+mRNWRo0sqZOKrDutFk2bIfcxantsC9mqHxQs
 5a3j94hFYF0GycjrDV+oesj7qYVBuU6oYunEsd60beMeznHHR3ImzBXx0U+lZ1yg5DwK5B7CI
 QesCueVCEB/qYbWnjOn2wcuR9pB1PIHB4z/V43nmRFpwUH1vi3CFARq2AflaUsICu5nwLy9Xf
 Qkf/FIQ2HAWc3Nz8D7NpxmuEdmmXn1uUlfNkFMEIMvZS08xsLcvFw7HawfxyG3k0NSKzQBLpm
 ja62fYS6SAKuF+UBiwKzX5eFg26Sbjq3sh26tyiYHSDDdClW4X5tok+KvIYORgrjWs4GT9uCM
 6aaMHjRJ+tik9fPg2gVvQPbCJ7BZasXiujTtGovW47pMTNieoSrWh7Q3faXOlVgg6VgWPvFQn
 dRdHVRBA7/oVEYpoz4lYuxsnHQfksXpjaFITA0DK0Gs+syZDYB8Aqpcri4MPk01+eWrlM5X8c
 1YVFCGgstmmLXXu2b3Sj6ehNnDt85oZyT/Iy1bR4HWd48jJY/zu80u6vzoZmdVbwkKjEt+2ip
 ExQiXgsj0tPfrUnUe2j3FBUQbV3FxfoNfx2osTCe+13E8=
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 27 Jun 2024 11:23:38 +0200
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
From: Helge Deller via ltp <ltp@lists.linux.it>
Reply-To: Helge Deller <deller@gmx.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 6/21/24 11:52, Arnd Bergmann wrote:
> On Fri, Jun 21, 2024, at 11:03, John Paul Adrian Glaubitz wrote:
>> On Fri, 2024-06-21 at 10:56 +0200, Arnd Bergmann wrote:
>>> Feel free to pick up the sh patch directly, I'll just merge whatever
>>> is left in the end. I mainly want to ensure we can get all the bugfixes
>>> done for v6.10 so I can build my longer cleanup series on top of it
>>> for 6.11.
>>
>> This series is still for 6.10?
>
> Yes, these are all the bugfixes that I think we want to backport
> to stable kernels, so it makes sense to merge them as quickly as
> possible. The actual stuff I'm working on will come as soon as
> I have it in a state for public review and won't need to be
> backported.

Ah, OK.... in that case would you please keep the two parisc
patches in your git tree? I didn't plan to send a new pull
request during v6.10, so it's easier for me if you keep them
and send them together with your other remaining patches.
(I'll drop them now from the parisc tree)

I tested both patches, so you may add:
Tested-by: Helge Deller <deller@gmx.de>
Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
