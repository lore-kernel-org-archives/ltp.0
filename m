Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD793C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 03:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEA9D3CB034
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 05:29:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C3953C54F7
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:29:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C1056000BF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666063784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPjCMSqaHjKbhcOcHEySFiRArKomhMLZlqUSFAx2liw=;
 b=Wd1kYRS0Z/Il8PZayXnS0nxzm0XuEJ01jlnahWC72W8FuMss6Rm3hMsPiXD5axayTtkPTk
 Ho7/O5bMclXGJfuVeeGjVN5fC/I7rnAlam31iptyho4+SvI/SwDJLc3U9HFeTaZHwRV8hh
 uTMLFQsqAWIEfda1cifJpDUlt7gVUEM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-XheSmaFIMwu_QW7-wnA7AA-1; Mon, 17 Oct 2022 23:29:42 -0400
X-MC-Unique: XheSmaFIMwu_QW7-wnA7AA-1
Received: by mail-wm1-f69.google.com with SMTP id
 n6-20020a7bc5c6000000b003c6bbe5d5cfso10518610wmk.4
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 20:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPjCMSqaHjKbhcOcHEySFiRArKomhMLZlqUSFAx2liw=;
 b=TBVtGyfKrx4QG83cC0zADF6h0udWTbjLkoMQs8LJasqKVMHkvqJB/d9ZZ2h7FuDu/0
 7vGz8r7NjqK+yR1uKquuz07JAPgK8bVQp3Ckh3DZU4DhNCPaBVpMjYrQp14RRsvQlMig
 AXR93IeFTmKTRTsU0CKruUuOIjJrsQjyqdQdfZN7ZeflmEH7BBWzVkf4ITwsduDeOqcX
 YWDepXWQe7dscu1/cMrNPBfwOEBjS6pVnL8l0eT+9dFKX/D8i/3YNVHV51Wcc2WKXQ3Q
 SLuHEAVgjcnjiTFU1jXvfEC5HYhViVGQOzsPbFXQjnbXZL2t1balEnVipiuEY0/6l+Gr
 Co0g==
X-Gm-Message-State: ACrzQf1L/QU7F+lG0EFnWPxqWHk5Fis4+D9ARA+HjuV0TPqekFtPRai0
 zn5r1ANKkRAm01ebG+B53qThX+p5YAoew05n8y0lACCxs18eDxty07KYaUbp+70nvK3T1mNETUF
 UHEnW2Run7GwbZApMLrRop+snDzQ=
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id
 bz18-20020a056000091200b0023091131a09mr428289wrb.707.1666063781325; 
 Mon, 17 Oct 2022 20:29:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5a7rYI0MEjrAgtYSoyN7lpGeS6A6h8+h3ven3/+nJLCXtBU/ACr8InwlLfFYxPzuIpTZZ8bFpSPj92MuGZ72Q=
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id
 bz18-20020a056000091200b0023091131a09mr428281wrb.707.1666063781114; Mon, 17
 Oct 2022 20:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221018011716.17730-1-luoxiaoyu9@huawei.com>
In-Reply-To: <20221018011716.17730-1-luoxiaoyu9@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Oct 2022 11:29:29 +0800
Message-ID: <CAEemH2c61Hgh1DxyXSwexZV2bBf1YMw1zJ4Mu34UO5_GqA89ug@mail.gmail.com>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/nice05:Delete unnecessary setting.
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
Content-Type: multipart/mixed; boundary="===============2087089874=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2087089874==
Content-Type: multipart/alternative; boundary="000000000000d8ca1405eb46b36b"

--000000000000d8ca1405eb46b36b
Content-Type: text/plain; charset="UTF-8"

Patch applied, thanks!

-- 
Regards,
Li Wang

--000000000000d8ca1405eb46b36b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Patch applied, thanks!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000d8ca1405eb46b36b--


--===============2087089874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2087089874==--

