Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DE7FB44BC
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777012118; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RCHRYzFoFW6Hl5EAnvoq04Mz38v9Fusxcc4oRkeNd4Y=;
 b=WHpVlLWhJ6m0nGjrb3xOkyL61Z/BoyydNN39nU2Lwk9SGqOurw5L51l+NBgx1I6skO49z
 QIH+MgdD8vJahnxAHS0aLgHArU6ASEQNqqo7GJj9PCW9BCAJDuWLD25xoeGMrkrMQGV+hnA
 hglHxlZTm2QccLIlhtacVFp56S1Bvi8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01A43E257E
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:28:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EDDF3E18DC
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:28:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9553A600875
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777012092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdjkCoxVrZgNIK9ToiGJEvBVN8NWklG7DdDSzDW12ns=;
 b=c1c5amGp0mfhlsvkNHGFCSU0Nll2paMZWxNoU7xla0TyPDS0y3088/UQ6MV2z9nhd3Fk7Y
 visbYLK3wU6aFkDkwOnq4e8Z+insUVToKGE5aHl32ZzE743GFOH72NNr6sGXRe7KxtrSHs
 BzNet5bVwxDg6P9CmHkFqTmprj3IuX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-tqA3i1NqNmCTE1Jtx5-ojw-1; Fri, 24 Apr 2026 02:28:11 -0400
X-MC-Unique: tqA3i1NqNmCTE1Jtx5-ojw-1
X-Mimecast-MFC-AGG-ID: tqA3i1NqNmCTE1Jtx5-ojw_1777012090
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso5067265f8f.1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 23:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777012090; x=1777616890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdjkCoxVrZgNIK9ToiGJEvBVN8NWklG7DdDSzDW12ns=;
 b=kHqQjRXZ8vdR677b9C2iWv7ZLoT4TGKtWdzoIPtuDPiIWo3/lfkBBF0FKb2IA+YZ0B
 6OpxHFfKqAYWyWF/qZ51uboncbq7WlJhvE34Fg3g4mXenctdSqNaQuoV4owVtFRJfbMb
 oXlzV5rCtG8f3GRZ4FdE2ZNfW1EaOCS3NUYKGd3C24GbODTktZ037U7dJ1jVZ+uITkGQ
 G28hTJpos3ohhDqlpoTmaVzl5RSpEUgxFq/mYUJE76ZWRPi9vlNQRyHnryt205CI4pwX
 tEnFaG7LvJ61QUInesPiH0mKDsSJJjB6vGSdrzbNrWX74MLKgKc8Td/UC0vQ8Yid8STG
 8AvA==
X-Gm-Message-State: AOJu0Yxv6QfzRY2CGOp2rkwRAnePf/CirilA7TJKb7GBRdGS+0tHglyb
 YmISr4u3BibOIX4De0vHAtpGdJQH8fNVQbfMx1qVu9ibae+DnnBN94sUV2VmcFNzQaPuqQMUGPj
 7HOoiiHGnmsgfxcri1fw9Bd+o3UlQDQoZfTpu1MFjcSQIaZWOvAIW9l2UmMzXLCPLAWauv4OkFs
 jDCOK0oImQF0+PXGiRxmH2HrWffvc=
X-Gm-Gg: AeBDieuuHis99EvA8Br76qKMgw7LA4I/f7vbJ0Jl0ovqI39H6eHRGueFvcTkb8ExaN/
 2TuPVfQZVpoZjmL1zd25pQRgCaCUCS4bbqve++a+Cjm0KkD3pt0Xlmi7eH2Ll360AyN8Jd+wVhU
 J7cEYVriA5KJYEO1K8cZ4EEwAICM/0Q1QTZEbCv0mQOmI7MCfQxM5Q3dDcw4npIev2c3X/hfn4I
 IyUH0IDdtmQVdQ=
X-Received: by 2002:a05:6000:1866:b0:43c:f257:c706 with SMTP id
 ffacd0b85a97d-43fe4088c1cmr47246755f8f.23.1777012089850; 
 Thu, 23 Apr 2026 23:28:09 -0700 (PDT)
X-Received: by 2002:a05:6000:1866:b0:43c:f257:c706 with SMTP id
 ffacd0b85a97d-43fe4088c1cmr47246711f8f.23.1777012089441; Thu, 23 Apr 2026
 23:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260422113136.416482-1-pvorel@suse.cz>
In-Reply-To: <20260422113136.416482-1-pvorel@suse.cz>
Date: Fri, 24 Apr 2026 08:27:52 +0200
X-Gm-Features: AQROBzDwl00WthOh-Vc003BmzqhyKd-jqfYOpsJI4q_opMlMRAvjw2su6nGS4DE
Message-ID: <CAASaF6zL2QTXBCCLkWTOt6nE4ywpJd3n8vqP2Tt_jnSy+LKa-A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: quedFL_Qzh36wHbjsNiS2N6ipiMflTfS8CjMg48RspY_1777012090
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: Remove 'make install' support
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBcHIgMjIsIDIwMjYgYXQgMTozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IExUUCBoZWFkZXJzIGFyZW4ndCBuZWVkZWQgdG8gYmUgaW5zdGFsbGVk
LCB0aGV5IGFyZSB1bnVzYWJsZSB3aXRob3V0IExUUAo+IGNvcmUgbGlicmFyeSBhbnl3YXkgKHdo
aWNoIGlzIG5vdCBzZXBhcmF0ZWQgZnJvbSBzb3VyY2VzKS4gVGhlcmVmb3JlCj4gbmV3bHkgYWRk
ZWQgTWFrZWZpbGUgZm9yICdtYWtlIGNoZWNrJyBpbiA2ODRjYWU3NTUyICgiaW5jbHVkZS9sYXBp
OiBhZGQKPiBsZWFmIE1ha2VmaWxlIikgZGlkIG5vdCBzdXBwb3J0IGl0LiBSZW1vdmUgaXQgYWxz
byBmcm9tCj4gaW5jbHVkZS9NYWtlZmlsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PgoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQu
Y29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
