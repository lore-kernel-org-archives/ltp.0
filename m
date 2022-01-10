Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF78C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 17:44:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8719E3C93B7
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 18:44:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AB203C042E
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 18:44:24 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 676CF600A00
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 18:44:22 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1BF9CB80CA5;
 Mon, 10 Jan 2022 17:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D084CC36AE9;
 Mon, 10 Jan 2022 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641836660;
 bh=s3VaQYry9YzRVFw9ooPXpRnN4dxuZuXP3m4ecTGsQLA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AnhtHIxC9k43HJjkzA7ZkjfEi6dJ+Xifi+KYSEMXEEeRmqIOCVsAIkuK+atrbqrfv
 2Rn6y66nKh9+yu2dIWYroxSNhy6euNDJ3DArcUotr2DG0VQzgXHyongefye6b+P1SH
 Uy+PTM/gaP2t9Io5Zsy+qqnYY1tC++qNoMq8KTOXz8R3oqbo+NiU/g55xjJq5BUMX0
 LXfhvVBYvNtMBkFJHikveN0jTzQAowQAidDI6rJtynR6iFrHoX8rI2jQ459pNA1l1I
 2vPInqFIhVYQlzsT3/kNdRJdJMj0NXUBc3rqQTY74jTvecuUACj1Hnc+zDPcVqLr0f
 sq0D6KEcifr3w==
Date: Mon, 10 Jan 2022 09:44:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: wenyehai <wenyehai@huawei.com>
Message-ID: <Ydxwc65JO2C057hm@sol.localdomain>
References: <1641287729-194863-1-git-send-email-wenyehai@huawei.com>
 <YdW1m4D2wLYQm1v/@sol.localdomain>
 <0035845766004452880d56963135c616@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0035845766004452880d56963135c616@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?562U5aSNOiAgW1BBVENIXSBhZGQgc2V2ZXJhbCBoYXNoIGFs?=
 =?utf-8?q?gorithms_for_crypto/crypto=5Fuser02=2Ec?=
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

On Mon, Jan 10, 2022 at 03:59:39AM +0000, wenyehai wrote:
> Hi Eric:
> 
> 
> 
> Thank you very much for your kind reply, and I am very sorry for not
> describing the background clearly.
> 
> 
> 
> Actually, I wanted to test the sha3 algorithm in kernel 5.10, but
> crypto_user02.c return "no viable algorithm found" as follows:
> 
> 
> 
> [cid:image001.png@01D80618.14306F90]
> 
> 
> 
> So I add sha3 to crypto_user02.c and run again, at the same time, according to
> the latest linux kernel encryption module, add several hash algorithms, as
> follows:
> 
> 
> 
> [cid:image002.png@01D80618.F702D790]

[For compatibility with the mailing list, please use plain text email without
images -- thanks!]

I still don't understand exactly what you're trying to do.  If you're just
trying to get crypto_user02 to run in more cases, then your patch makes sense.
If on the other hand you're actually trying to get the kernel to instantiate
more algorithms so that their in-kernel self-tests are run, that is *not* the
purpose of crypto_user02; a new test should be written for that purpose.  The
test could try to instantiate all algorithms which have in-kernel self-tests.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
