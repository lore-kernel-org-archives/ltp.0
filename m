Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE6FC43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 09:46:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3D43CC67F
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 10:46:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3744F3CC63E
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 10:45:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B7B7140020C
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 10:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669628750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6BOn0gwOTyek1iV57UXXWUy/sD2+7KJm5+mvPQMHuM=;
 b=JQCtsZnAktNAJnH81vG9A1xkjfvSiwb3MYGXA0nLAM4as8hJwokOaTM4FzXdduPS4A92n/
 vrEolSzaELGHOCRQIaQGCUYBjtJDnQsIIgdyNR4YH1YVQ0RmJ2gVo0EDpaLjzWAGue1vkd
 Cz6dUedbsQVoyLpZrpJBqNLr3e8L6nE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-zSrCzv2gMhuL-zZKkgobIw-1; Mon, 28 Nov 2022 04:45:47 -0500
X-MC-Unique: zSrCzv2gMhuL-zZKkgobIw-1
Received: by mail-wm1-f72.google.com with SMTP id
 1-20020a05600c028100b003cf7833293cso8380361wmk.3
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 01:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V6BOn0gwOTyek1iV57UXXWUy/sD2+7KJm5+mvPQMHuM=;
 b=nGjEujph1hmnLSl6RaC3Pxf49pW+ycNvP8AU5DrWvHW9PNJUijWSFqmltqMg6CIAZ7
 TllmEVt6tXd6AibzXV/oecud2yXECvhoOEbdjLl1b6ld+GIQn8nxMYHrF2Nc7Tl3++lK
 vn9ZiN+i3qymIXDPQAkRiDby4wy7q1JdnxLMhw1n5u8/2oDBcEpgcJ0MFBTgwxMvIhOg
 +LCkDpDgNuoo6auyBvvl+aG5Y2aXny/GGgvyJl4qVw6S/EuSFZfmi1+S2uui9EWwmG2i
 vRjKwmd6QbkB71gp+AtlFJ6iBiA0LUEiq9kPt/RT3rmu0e+U3uJZY2oCZC3PKJMg20NW
 65TQ==
X-Gm-Message-State: ANoB5pkSKUQ9j9/nTpkAa0xvQOmp61LQfGCYSFX+a40t5A7oDtwvyfZR
 KcIgaVCMw7iGvpbIvssxsTA7qR8/+AYN4wxAGAihHNcF2U6m/rBNlqioJOP5bPIOO4m+ro2OOhJ
 TdfaGDcdbLzg=
X-Received: by 2002:a5d:5702:0:b0:242:569:3028 with SMTP id
 a2-20020a5d5702000000b0024205693028mr9479498wrv.435.1669628746364; 
 Mon, 28 Nov 2022 01:45:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7rwSwI0wNF/p/vhujnOriBYHvQq+x1hWUFGka6ciDggMyd+XLLW6+buTAEHRzr3juOifZoBA==
X-Received: by 2002:a5d:5702:0:b0:242:569:3028 with SMTP id
 a2-20020a5d5702000000b0024205693028mr9479473wrv.435.1669628746061; 
 Mon, 28 Nov 2022 01:45:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf?
 (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de.
 [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600010c600b0024217e7aaa7sm2204157wrx.50.2022.11.28.01.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Nov 2022 01:45:45 -0800 (PST)
Message-ID: <58d046ff-c89c-611c-0607-c2ec8f556526@redhat.com>
Date: Mon, 28 Nov 2022 10:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>
References: <20221125122546.99144-1-david@redhat.com> <Y4DL5928NpuPI2Q6@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4DL5928NpuPI2Q6@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25.11.22 15:06, Petr Vorel wrote:
> Hi David,
> 
> thanks for fixing this!
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

This seems to be quite a controversial topic :)

I stumbled over [1], which still left me confused regarding what to do 
and what to not do.

Interestingly, the problem doesn't seem to be that NULL is defined in a 
strange way, but that the representation of (void *)NULL and (char 
*)NULL might be (weirdly enough) different, and that no explicit cast 
could result in undefined behavior.


IIUC, the second answer indicates that with C99 it might be fine, 
because that case is defined behavior ("one type is pointer to void and 
the other is a pointer to a character type.").


Having that said, I have cannot really tell if this change must be 
performed. :)


[1] 
https://stackoverflow.com/questions/52195275/can-the-compiler-cast-void-0-in-execlprog-arg-void-0-to-a-null-po

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
