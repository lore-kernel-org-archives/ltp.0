Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB9C44502
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768987642; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=Vo8py+7PFXcF6X2bpJlGWWUfFttE5V4y3ZSzLs6IjsK/fIYmiSsVWU89FattsBJcPk5Bm
 jEYcCQxSQX3fUuH+levO+rc6TVmpT+7UZ/F0NNIrYwpKR9cLjJu2/rRPW9qda+Jmomw2AQH
 Gz/PbZZWfAxj/bPAA8aocuOb/JiKNAw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AD2B3CB266
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 10:27:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AB603CAFD3
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:26:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F76D6003CC
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=idCA2IHa/ueloXyChT8ql+O3r7Kld9l3bhHigulGRy4SAmPo1+XsrGACL+Vv9bO6u8EEBp
 yh7adpi+qwuX4mkOJMuDqu4B9TdpvppH1wWn8NCtyYQ3i807vo4MCarDd/csZj1N3ZJSqY
 E3KK8BPFtJ2QLXSN2GjwfP0+f558MRk=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-3jmI-OjxPm6N-AdaMpn3rw-1; Wed, 21 Jan 2026 04:26:55 -0500
X-MC-Unique: 3jmI-OjxPm6N-AdaMpn3rw-1
X-Mimecast-MFC-AGG-ID: 3jmI-OjxPm6N-AdaMpn3rw_1768987614
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b70bd4a2ccso2078498eec.1
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 01:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987613; x=1769592413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=Y3Mbbw2VDewUTs8QGctDjIC7Ym2TnSeol2F6ramDNwDgd/QEnl70PYKyc6z761EMl2
 etvCjfhzhQ3KLxrXFIniXgIeYX+Kd1l+kve6FwBs5iXUYfxwr6YEMTWioDkCMfH9Mzzo
 3CjMCeKRSpgx/sH/8AWe1KXMqO4H5xxQP11DSk6Bs3/51fcOLI459c0wFXXNnVnQtKGc
 zUUDh7ipwd7nwevE0AuN6HLiYBcXOJLSgRwM1HLe8AdhYV89rY5/PvzeohLSuGGy2mlL
 S+QhAXAPO+wQQ7IegD5LaJ8OsAI8ih1kCJmmZnfgzI9/9yhcFhrXejWBfXV3n/5U4UO0
 lhfQ==
X-Gm-Message-State: AOJu0YwYkvb2sr14veaJ+XBSYkmd6oQdcyElreooVPfyxG9uAgn5wDtJ
 bIoa2TonoTXJD920muMY8YIwejVoRPrZrUgvqD37ZgL+3kovPZdFlUpv2mN2HIxjsJEWaAseL0s
 U1ftZM9HJ13e/VmAOrVKWv7OzeEF/vL2jcJtTAfDMnH8dSpwcTlS0a40AMD6T5QdyImwSQX686f
 3nqu+FQGonnR8QTNQ0/ha8BxDqf21fXnRd3a5VHA==
X-Gm-Gg: AZuq6aJB7hmsRUfjnNNfG0zFYjnEWLzSVSiaDYcLUpltXYd+9vApehQLj81M5GgO6w2
 H6wDtglwqF4Rz5DRXId4VnnRzk5QTF66ozPgq2oVi9EZCo/wvCLiDVcur8bSXMDj8RzQrE6EzKe
 qpX9bdEC71zo3sNPpZrdyDdEzrJwiJXos6njRdM7MeZfmKKr8F6PfEumPXuX3PLjnWTXA=
X-Received: by 2002:a05:7300:e7a3:b0:2ae:5ffa:8daa with SMTP id
 5a478bee46e88-2b6b3f13a00mr12787300eec.5.1768987612745; 
 Wed, 21 Jan 2026 01:26:52 -0800 (PST)
X-Received: by 2002:a05:7300:e7a3:b0:2ae:5ffa:8daa with SMTP id
 5a478bee46e88-2b6b3f13a00mr12787289eec.5.1768987612372; Wed, 21 Jan 2026
 01:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20260120-file_attr05-v4-1-7cf444e3c7ea@suse.com>
In-Reply-To: <20260120-file_attr05-v4-1-7cf444e3c7ea@suse.com>
Date: Wed, 21 Jan 2026 17:26:40 +0800
X-Gm-Features: AZwV_QhZW2VUFfz1JK9E7BK-nVzO6cFEJ9zeGZ010s4en1MYfQLuh3eleiWrAQ0
Message-ID: <CAEemH2fxhXkRt+BDcePg5F3jUJj81fPy9H71+5G7xzcQ5YrN2w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FrYZCHRtThH0-iR35jKfKfhkMmS0O9e2wUnLwmXRBBs_1768987614
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls: add file_attr05 test
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
