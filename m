Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF77FC77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 14:18:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701E43C9B32
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 16:18:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B0C73C6BA5
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:18:02 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 723041A00EF0
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:17:59 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 82284140025B;
 Thu,  3 Jul 2025 10:17:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1751552278;
 x=1751638678; bh=ELCjAt/SQjWiLxFaoE+JA5BBE4/Ck0GCWWDaqcUeh0I=; b=
 OGq5NsqUjbvwQUp3jXfP/VhUv9L0Zv8mVx1gfFsb97HuCKdrzGEi7mOvANqRkSuh
 By1v5kBRSYwr0PcgyvckLfBc4VnEw703oCRlTiz7S1PRRxZtU7n8nkV2JyfE68bm
 gD/Jmbvu87r5afVjk79b4f11loDBAaSgGdhn5TE/BnNiC3xwfyMfXkibijQdQKfH
 evBv6kaRJM9XSuJCMz7zo7Ne1EHzuEP5xDFOySQMovFWorp+HRLXSnjuYRYCITr9
 796wyifi4KTy/Mqbq23gpKdvtjJGdKcC9GlzknejT13M40QjkNBY2xeSZmTkFNwF
 5CiA05Up1XH9nYqJXKGLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751552278; x=
 1751638678; bh=ELCjAt/SQjWiLxFaoE+JA5BBE4/Ck0GCWWDaqcUeh0I=; b=S
 t5ttD5lG6oy9bmYeAuYxR6XzfgrgGFNiH8TXGuRwa74uqR45wk+nBWP1FWocfEVe
 smdNtWXfeaveUDf0fZkn3sFpQAYGsIZtb5jV584YjHKx6kOTvBZhkwepkAVMWBGY
 +Sa+UKZZTBDEuz0klklpwR9GptmVI6Y6YzcaSIGTxAmnVZdm92S3zCtuI8Q7V6xf
 9LWvYIuE3Yr+7KqzI+xdTra4ncDNC9go7PgTpgQJpjdStI79YcL5ebL87qZCrqKu
 NH0bK8+WYxWhcAfHGnpQ7cL4l6iG0XyAq7BUxzb/l2msB58eU9aEMmaT7cUbzeir
 dKLh46wFYwNBlKDrC6IPQ==
X-ME-Sender: <xms:FZFmaIVBDFSS6YWEvqAIES-J0lUknGFuVds09p-xXbhMMO0h_g4VfQ>
 <xme:FZFmaMl_p9Avmch4AV-4yNVPmYh1PNqBc_dRs54rpa-ZwKG4GH9ecFco8vPTdJyM-
 bCvGsfyXwFWxavkcq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdeglecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtph
 htthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthho
 pehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplh
 htpheslhhishhtshdrlhhinhhugidrihhtpdhrtghpthhtoheplhhifigrnhhgsehrvggu
 hhgrthdrtghomhdprhgtphhtthhopegthhhruhgsihhssehsuhhsvgdrtgiipdhrtghpth
 htohepphhvohhrvghlsehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqkhhsvghl
 fhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FZFmaMZWzGb93E1bKyalCazjYS2yec3eP_BRZurVKVcb62OySSfSaQ>
 <xmx:FZFmaHVCYlJXuQElBfP6NHHIfhaciteV393AR-Vh6cZDAQTf2aV6xw>
 <xmx:FZFmaCkuq1FHhz8xDE8owbJh4lTIExVs7DtWA1EuPZTg6NQI6ugK_w>
 <xmx:FZFmaMcZDi4kKmt5d37reVBXuw8zO7K6SjTiwRF5CE_GGKOi5WD3_A>
 <xmx:FpFmaNLnn1XFE78JkCVpoE-Gd3bQ5ywX2lbmN9m_phGFjuEjcGHK9zfw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id CC865700065; Thu,  3 Jul 2025 10:17:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tb53dd688bc639d41
Date: Thu, 03 Jul 2025 16:17:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "LTP List" <ltp@lists.linux.it>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Message-Id: <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
In-Reply-To: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
References: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP syscalls mseal02 and shmctl03 fails on compat mode
 64-bit kernel on 32-bit rootfs
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 3, 2025, at 15:47, Naresh Kamboju wrote:
> The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
> with 64-bit kernel with 32-bit rootfs combination.
>
> Would it be possible to detect compat mode test environment and handle the test
> expectation in LTP test development ?

I think we should either make the kernel behave the same way in
both environments, or accept either behavior as correct in LTP.
NVAL (22)
> mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
> mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
> ENOMEM (12)

This is "length=ULONG_MAX-page_size+2", which overflows on 32-bit
but not on 64-bit.

How about this?

--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -234,6 +234,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
        if (end < start)
                return -EINVAL;
 
+       if (end > TASK_SIZE)
+               return -EINVAL;
+
        if (end == start)
                return 0;
 
Since TASK_SIZE is smaller for 32-bit tasks, it would detect
the overflow in the same way.

> tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
> shmctl03.c:31: TPASS: shmmin = 1
> shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295

I see this is being intentionally truncated to INT_MAX:

static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
                                        int version)
{
        if (in->shmmax > INT_MAX)
                in->shmmax = INT_MAX;
        ...
}

> shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295

Here the value from /proc is defined in the kernel as
"#define SHMALL (ULONG_MAX - (1UL << 24))"

On a 64-bit machine this is 0xfffffffffeffffff.

However the 32-bit ltp tst_assert_ulong() truncates it
to 0xfeffffff, which happens to be the exact same value
that it would see on a 32-bit kernel.

The second one is 0xffffffff, and I don't know how that gets
computed, as it is derived from the same number in
info.shmall = in->shmall;

Are you running this inside of a container that its own ipc
namespace?

     Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
