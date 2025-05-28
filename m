Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F95C5AD49
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748433491; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YZ42VOF1vERD1Xan/8txkobEisGjpzRQoX3KRRH5g7U=;
 b=CkTwOwA0LF0oKUNMN0JPLvO65XwOSOdtGt2VIeMfhHhTYlXLAPACbMflFIqQnU4X6WsXQ
 wNNkypfKHn3eHrby4jP+ya6/UuMvmOpMM+Sf1KUhW1B0ZNDFwIDm//ynX+cVSneJIDV6g2c
 uAuANfWip+NHNzxLmYp742CrLy5YGFs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0BD73C760A
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 13:58:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C3CF3C22DF
 for <ltp@lists.linux.it>; Wed, 28 May 2025 13:57:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 575AF1400C7E
 for <ltp@lists.linux.it>; Wed, 28 May 2025 13:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748433469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wR/jrmnwXz7GMkwzfZH/Cyod9V52BIPsm8mq61moehg=;
 b=CCLUfjagZ74GJk7j9vgdOaAqT8/okhF/pX1lAw9iYESe15P/ekzThg1Jccx7l9BhcOQkOf
 T85Dpigj2HC/0YuH4mzNPxb+TXUrxjFvlF69NsxT+BOwi5KZJfKDleZX9U5iFgEMJzYou0
 RXfIDT3a54thHv83Nq/HBnNdk+qaVS8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-tfznrj_FOPeuOsHy2a3rkg-1; Wed, 28 May 2025 07:57:47 -0400
X-MC-Unique: tfznrj_FOPeuOsHy2a3rkg-1
X-Mimecast-MFC-AGG-ID: tfznrj_FOPeuOsHy2a3rkg_1748433466
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30a29af28d1so3274003a91.0
 for <ltp@lists.linux.it>; Wed, 28 May 2025 04:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748433466; x=1749038266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wR/jrmnwXz7GMkwzfZH/Cyod9V52BIPsm8mq61moehg=;
 b=jvGYf2UeDBMi51KePTicLZgAZbBvfNJw2HJ4bARNypgsXQk4k4+/N5u1wFOuvGuX2f
 7kql0S5swy/jpILkjN7alMWnlAuJmky3ZPA+biFFFVy+3WxnZyzdtyXWN7tKudgzGJwW
 6UuNKpl3kLdskZhTAZjTGFkNPgIbsQmgvuVtVlAMhLtb1Xed6z/rN9xv5hEmb7B2NU1e
 SGo8nL7JwVDCBb+nj0ZXdI0IFA5f4rwDZ76vGy8L8aA5ne4y1MOk23yMfZpMHHBDNJOr
 ++d2atar6wPuYWRv77IhoL6j1KidPQZTuiyiuvPO7ArBDFJYcrdMG0iUxLqZl2P7D+W5
 CfjA==
X-Gm-Message-State: AOJu0Ywi6ZUvQYc/XgImW0eNoWtAAEb8UBFDQpyBA9Rt4XEWz8JuGvyK
 niWq/z5a8SWQ0it+weCJHwj98sszGWAxewrbdnxKRy7SIMV2TX7Y82xqWyoR5XXpjCQIAh0vjxa
 Di2XJo+v27wb1Ezs9nWnpXgCy6dCu+GW3ok7S3hc4tq8FzT9T7uz2PUYFPWHx+9S4GLnecw/1AU
 fyYdYpmE7Nag8JQiQswBm+xKUsINM=
X-Gm-Gg: ASbGncsg10JKDhRT0WwP00j7TIPB4AJN8XC9W4pDrJb3dicTalKDwDOsUE/UvHTyvmM
 hT7Fzhd3RnjCjdqRzDWk6Te0jFTq41bzPZROEvYQeiFFD+TAOECgz0ROueF8MdiLfCIoN9w==
X-Received: by 2002:a17:90b:1dce:b0:311:c939:c848 with SMTP id
 98e67ed59e1d1-311c939c979mr7957056a91.0.1748433466418; 
 Wed, 28 May 2025 04:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELI84y/XRzwQsJrQV9MY+I1TbUQJfHSXGlezMGsqMlYw46cmTOmm4neVgKhfo7lmZcB+cnix0kkCx50qcoSBQ=
X-Received: by 2002:a17:90b:1dce:b0:311:c939:c848 with SMTP id
 98e67ed59e1d1-311c939c979mr7957035a91.0.1748433466019; Wed, 28 May 2025
 04:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250527052855.150398-1-liwang@redhat.com>
 <aDbXfsENtklt9K7G@yuki.lan>
In-Reply-To: <aDbXfsENtklt9K7G@yuki.lan>
Date: Wed, 28 May 2025 19:57:33 +0800
X-Gm-Features: AX0GCFtcTFbNjfFF6ECi98XR1Shw8NQQ_FZsoY-Try8eycvrML2PtRobOjQqDJ8
Message-ID: <CAEemH2dVqyAZuzXU-iTEPctpSd0KzLc-vckVu25A+WRqXZakqA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jfZmMtY9gMNSVyr4VLdL7eV9En3yHHSff8ZYegn7XvU_1748433466
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_controllers: remove outdated blockio test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TWVyZ2VkLCB0aGFua3MhCgpPbiBXZWQsIE1heSAyOCwgMjAyNSBhdCA1OjI54oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gUmV2aWV3ZWQtYnk6IEN5
cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1
YmlzQHN1c2UuY3oKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
