Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92F0C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D40663CC0AE
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:37:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE043C1047
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:37:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 467381000646
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675953439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V955VpJSOsiH8KvSRrhi1dTiJ/oOPcY+EVNtjIqcNPs=;
 b=QRv6tKxEZ1Vj/QAKEnyBYm4u8thfxht1AjFPgtZpHYPWfBvBEIuVFSyMaheBqNmJRI0DWW
 qYPUX9m/rPuHby9xgQKxn8cppL57uEQcNnn+mZ/ZqoXRFCYlAJMufKUrBcQk+TWN1d/h0U
 7UxjnAMStRfB24INQhZUR37nypcPqJY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-VRYzV2ztPVqgeslFwnQVPg-1; Thu, 09 Feb 2023 09:37:18 -0500
X-MC-Unique: VRYzV2ztPVqgeslFwnQVPg-1
Received: by mail-vk1-f197.google.com with SMTP id
 g6-20020a1f2006000000b0040115ff8783so702864vkg.19
 for <ltp@lists.linux.it>; Thu, 09 Feb 2023 06:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V955VpJSOsiH8KvSRrhi1dTiJ/oOPcY+EVNtjIqcNPs=;
 b=cXBUY+rSHmy/uF/zDwY6AR4yyo2pzsEXuTneyLuUqL2KzUdHhe0urdFMgZVisIN/Zz
 /gGJisGk2aTPn3dVYMlEiM+80auxtmllnSLbRZvbeccJFuQQyN4laLCLkNyRgORoDbra
 1khcCgr6RZ6+DG2yUDOlmEapFUD1gbWe4jnJpklL5KYnzJ32R4hMQ8un08nk/pH7ax2A
 G7uNbtbqco4EgazBHQUhZYFdiSspSJHswM+tXPJfg4e341ukSsIyuHjkCmOSE9+OMQrZ
 BO9ZMMS+bTB7Lp2c+JSGxBE+sVd+to6AZjuDYbgcoBNhyR6h0T975Hptl1waIjaV6F+A
 lOew==
X-Gm-Message-State: AO0yUKUbMTezj4OGF32dKGq4QCafMAx7hVzkqf8vJ+1+Gx9baxTWR6EM
 92Euh76ojGgUwap1S+Qn5hW8eA+3xdTxLEAXLbnzm4GouuBtOu+TceVfU8r/HRQzxZf8OFtuUea
 kTt00Bw15P68qL+bbA+hG5LyOpDi7YeY9YLA=
X-Received: by 2002:ab0:32c3:0:b0:683:8438:b701 with SMTP id
 f3-20020ab032c3000000b006838438b701mr2607658uao.34.1675953438025; 
 Thu, 09 Feb 2023 06:37:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9WEgrVn0aczjNBJwGptDKKMbCF5JmApMPgibXdXZRh+3Vc+qkBXHzSmjevF3QnSseFb412XNbWxUs+WuHHZKk=
X-Received: by 2002:ab0:32c3:0:b0:683:8438:b701 with SMTP id
 f3-20020ab032c3000000b006838438b701mr2607654uao.34.1675953437824; Thu, 09 Feb
 2023 06:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20230209142016.494090-1-pifang@redhat.com>
In-Reply-To: <20230209142016.494090-1-pifang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Feb 2023 15:37:00 +0100
Message-ID: <CAASaF6w5BPQOP1RTPLvYh3vN1-1X1b3jFkP-hEV4DyBGOvj-JQ@mail.gmail.com>
To: Ping Fang <pifang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] aiocp: remove the check read unnecessary flag
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

On Thu, Feb 9, 2023 at 3:20 PM Ping Fang <pifang@redhat.com> wrote:
>
> When aiocp executed with -f DIRECT will fail.
>
> <<<test_start>>>
> tag=AD049 stime=1675520824
> cmdline="aiocp -b 8k -n 8 -f DIRECT"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
> aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> tst_device.c:585: TINFO: Use uevent strategy
> aiocp.c:250: TINFO: Fill srcfile.bin with random data
> aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
> aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
> aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1: EINVAL (22)
> ...
>
> The code which checks that the data has been written correctly
> may wrong use the O_DIRECT flag, which may cause a failure like the
> one above.
>
> Signed-off-by: Ping Fang <pifang@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
