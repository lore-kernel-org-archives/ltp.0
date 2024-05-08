Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE2C04FFE
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 05:23:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62F443CDE77
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 07:23:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87CEB3CDB88
 for <ltp@lists.linux.it>; Wed,  8 May 2024 07:23:37 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48BBE22A1F6
 for <ltp@lists.linux.it>; Wed,  8 May 2024 07:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715145814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1mv6TizJYPTCAvLUN2OGKj22huV4VGbzKIl6u/v6I8=;
 b=Z9mf5VErPPaDrhIn2SsM75JyM5ckOBGZJddFSfowxs1XcoOAxXZK45tzRpG+hL6DsWRmQb
 9oAMjXa7wm53Ctp9XaVBxgr9wNikz2JGaybm7jvHXF4w3Ca0MEgJVXU6dzV0U/uDr7T6M6
 5moWN8ascr1BnEXymmdUA+JpdKmxAGw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-qdPoJ2mYMgCdcimPI_AwjA-1; Wed, 08 May 2024 01:23:32 -0400
X-MC-Unique: qdPoJ2mYMgCdcimPI_AwjA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5ad0529f9c5so5134067eaf.1
 for <ltp@lists.linux.it>; Tue, 07 May 2024 22:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715145811; x=1715750611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q1mv6TizJYPTCAvLUN2OGKj22huV4VGbzKIl6u/v6I8=;
 b=U60tFYjc4GgPgNU8H3qV3lm0qgSCYZ3S63ki5HP6IwQJaQIyVRy7l44fjc1c8oFTR4
 JPKEgZO6QDzwsagdp4ozx0Qz4ZwV6GCfwPkBBehS6EkIoDQYv3QbchTRVkIIcsCdC9Cf
 eZKpw+NMcjHSfZS8ED81t1CzkOggozOGgum/zw4SSuRdFe/9LeE/zYZdVT0IpgUdzFjK
 ANd/0FK+WNAfWyD7rfJHASrIYUrndsQw7cxB8u4A+AgSzp1RDvvNf9qTJG0kBq/xiHhJ
 HQhGykmAVOAhBxYjMGKMJhqPFlUP7oFqxAfRgvy4/jn3OPuecQxtBqWImuaovajHQYdX
 V52A==
X-Gm-Message-State: AOJu0YxuEac4VHTsQtJ3FWl2d7ieiOUJFVciVccrfuzwx4uoijZ19pa4
 qgensIkWxifhJPNjRToojx5xa+1f/qB+KePy/XPeAhRYioIqnWNwr62uo4rWpfVu7VyZH6Jv34m
 K2NiabRWd4MJtrH8Hfc1l84GUMrMtXKwretDkQsBpAitsibEFW24Vu+UyNCgWLjbXAQcIl8GPq9
 DqUskJDPrTNOFJHGZuv6lQOXk=
X-Received: by 2002:a05:6358:7694:b0:17e:53f9:6985 with SMTP id
 e5c5f4694b2df-192d2a26af0mr198321055d.14.1715145811428; 
 Tue, 07 May 2024 22:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSRfM9U22FaYun3+4Rn1/THN8V0OP7g4IsVKeWSj88I/3LSFwvFEw1JObi5jzzTTkDzlnZRBxBPe+jQvU+nrk=
X-Received: by 2002:a05:6358:7694:b0:17e:53f9:6985 with SMTP id
 e5c5f4694b2df-192d2a26af0mr198319055d.14.1715145810895; Tue, 07 May 2024
 22:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
 <20240418113204.GA70047@pevik>
In-Reply-To: <20240418113204.GA70047@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 May 2024 13:23:18 +0800
Message-ID: <CAEemH2fF0Wh738hcOcQ0E8ziO7rHpyxmK8MB5=BTyrRxqUL_hQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open monthly meeting 8th of May 09:00 UTC
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

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:


> 8th May is a public holiday in the Czech Republic. I guess some of us will
> not
> be available in the call (definitely not me). Could we postpone a week
> later?
> (although it would work for me, there might be people taking 2 days of
> vacation
> on following Thursday and Friday).
>

It's been rescheduled to June 05, thanks.


Also, I wonder if 9 UTC is not too late for those working from Asia. If yes,
> please speak up what would be better time for you. I personally could start
> earlier (8 UTC or even 7 UTC).


9 UTC is 5-p.m. in the Beijing timezone, at least it works for me.
Anyway, thanks for considering us.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
