Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4480FC4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 08:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8B63CC5BD
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 09:47:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DD513C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:47:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57E061000649
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669711625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBcB9q6rDRjyahnkWwjo93oEPRLBmA9ngIA+drVsIZc=;
 b=DxFZzFQ2n2fBBbS3mB28hqYiIr1O+1igIo7NI9ll6D4G/z4JHm9q3oWZmHSTAZNTJTzfQ9
 Wzzdt0fqO9AixHsj/gOT+2BgAs4OZckm9ZqQAWVaJR6wsRZDvllEgqfm48n9nmv7wZEvL/
 kkZ5MI47FtEJxZX405lq0keO2h1IWa8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-y7X2mpQIMS2-_lbywkl3PQ-1; Tue, 29 Nov 2022 03:47:02 -0500
X-MC-Unique: y7X2mpQIMS2-_lbywkl3PQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 w11-20020adfbacb000000b002418a90da01so2621950wrg.16
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 00:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBcB9q6rDRjyahnkWwjo93oEPRLBmA9ngIA+drVsIZc=;
 b=c1x/Q52unnJX6m2C1VSfwGBF1nPVLws2osRQzEqv3eDea5mnJAVJ+P4Zjc6GTkD/IR
 ZF7WV+SK1yWXuQ/s/brxR/g/1QBJTyIZmLKk80B1zyEEiInZzVSlcC7O52HimVoUXCTp
 tCksS4goOp9iMu2NGPu0ATVAiSlmh2+lt2a+8gqr0DArltZn/ExOCEwqx132mz5P/jFH
 G5RMFv8h3+UYlW2n1nMYq/4UF9H7Xipgn56Od91meElxxQKryz2bF2CJiCXUyLl1j0zV
 ZobpBGgVcsN1fJBdS/1CzRx0Xt+xkp5n5w8Ev+Fm8or3Hy5NcVuB/Wqv7TesbOHusggo
 jxMg==
X-Gm-Message-State: ANoB5pn9cKeVDp4J33mWGf1aMo3cRvlQZ6LEiXQpeNfvF3jc80SgTi+6
 SpPEu9CgofIM2/x5c91t9rArkvkaHkLiVJCU+0rS00ne8JxY6TYA9MESK2kCDpTwnGTOpgsQAZD
 oA1C6aryy2Q4=
X-Received: by 2002:adf:f902:0:b0:242:862:3c12 with SMTP id
 b2-20020adff902000000b0024208623c12mr11910367wrr.531.1669711620923; 
 Tue, 29 Nov 2022 00:47:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6hwp9Zh3b5w0Z0lF2Z+MPPiI+QzRas9VjSDGOMnjjkdLkIt0gG+d5IgkfAuQhoihPfloWIBQ==
X-Received: by 2002:adf:f902:0:b0:242:862:3c12 with SMTP id
 b2-20020adff902000000b0024208623c12mr11910349wrr.531.1669711620576; 
 Tue, 29 Nov 2022 00:47:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:ca00:3fb8:c253:3bf7:b60e?
 (p200300cbc705ca003fb8c2533bf7b60e.dip0.t-ipconnect.de.
 [2003:cb:c705:ca00:3fb8:c253:3bf7:b60e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a5d5109000000b00241f467f888sm12952393wrt.74.2022.11.29.00.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Nov 2022 00:47:00 -0800 (PST)
Message-ID: <3bcde8dc-cf2d-5881-33c6-b91b58681e60@redhat.com>
Date: Tue, 29 Nov 2022 09:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>,
 ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
References: <20221128111833.98937-1-david@redhat.com> <Y4SiDZXCSqMafjIb@pevik>
 <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
 <abd991c4-e6eb-349e-807c-71e7283ee83e@redhat.com> <Y4UBAa9GS9SU/bVt@pevik>
 <Y4XC5sBLL8z8gviA@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4XC5sBLL8z8gviA@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>> I can just add to commit message of the first commit the reason Martin reported:
>> ppc64le on kernel 5.14 does not seem to support userfaultfd minor fault.
> 
> In the end I merged without any change in commit message. You described the
> reason (runtime check) enough in the second commit. I was wrongly looking at
> fist commit, sorry for bothering you.
> 
> Thank you both!

Thanks all!

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
