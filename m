Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86571C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 03:03:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 297B53C93E2
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 04:03:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D9D33C937D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:03:19 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 353DC600BE6
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:03:17 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B432B817DB;
 Tue, 11 Jan 2022 03:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC37DC36AE9;
 Tue, 11 Jan 2022 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641870194;
 bh=H/QBr2Q02Y3eMQmZDjw/ZzB5gFLeKMOvu1250obpqQs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qx57gaL/YZtjpHxRliDUyYLAtt2vbSQpuxh5RvMjtHCf8CMufBK8vd7OAssxJvIxz
 pSrvZU9hqKc5Q2v6dxABhdAmODnDVd/bZ/HUXMg+jdvIbg6SAhf2gPZ8WZpQs1g01Q
 O7kXYhjjlgfC7rUTTyImbf8wTJJiHqB8Iy6iQskKI3zs1/mblghRd+sDMel0PqVOZJ
 zYt0r/EVU2b/NSLrICXqp6vuJ6QQ4PVDnaEqrW9XYf+H7Z/vmjBkFZrqFuZIotdywf
 aKxagwO7xYlcAcHhHiExBGM6asbhtL97VzYBDzWFxaJPf0HP4PbeuC6o2mUxv7ELhy
 mpGFP74jiuf0w==
Date: Mon, 10 Jan 2022 19:03:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: wenyehai <wenyehai@huawei.com>
Message-ID: <YdzzcTlQpn+BNRsi@sol.localdomain>
References: <1641287729-194863-1-git-send-email-wenyehai@huawei.com>
 <YdW1m4D2wLYQm1v/@sol.localdomain>
 <0035845766004452880d56963135c616@huawei.com>
 <Ydxwc65JO2C057hm@sol.localdomain>
 <15b7314d82b547e997c0caca1ae1299c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15b7314d82b547e997c0caca1ae1299c@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?562U5aSNOiDnrZTlpI06ICBbUEFUQ0hdIGFkZCBzZXZlcmFs?=
 =?utf-8?q?_hash_algorithms_for_crypto/crypto=5Fuser02=2Ec?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 11, 2022 at 02:19:05AM +0000, wenyehai wrote:
> 
> Hi Eric:
> 
> Thank you very much for your kind reply, and also sorry for causing you confusion. 
> Actually, I do want to get crypto_user02 to run in more cases.
> 
> The product which I tested just only enable sha3 algorithm, but when I run cryto_user02, it tells "no viable algorithm found", as follows:
> ./crypto_user02
> tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
> crypto_user02.c:84: TCONF: No viable algorithm found
> 
> Summary:
> passed   0
> failed   0
> broken   0
> skipped  1
> warnings 0
> 
> 
> I want crypto_user02 to support more cases(not only sha3), but I am not sure which algorithms should list, 
> so I compare with the latest linux kernel encryption module, add several hash algorithms which not list in crypto_user02.

Okay, can you please properly explain this in your commit message?

Thanks!

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
