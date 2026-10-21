Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B839606A31B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=M2clAFyo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOwTylw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792597365; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/02WlbUIVqyoiiuHL06fyJ+xD4Y80LPnihpWHTVLXJc=;
 b=M2clAFyoYzZKIvlBc2W5auxPNXlUqvw9pPiBfB6dbk3lrIEzhHTVqA/Kj5KXiHpMM3uCc
 vzvV6g8wQ4auXluP5uKd7SA3TzyBQjZaX7cUiXK64HLnn9f93+5kks92bK6BfbU5hmL8R0A
 DeNcDK7su7PabpV5G/vzSaSWQW+BqXc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4F113CFD00
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 17:42:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93BCD3CFCDE
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCA43600110
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792597344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czWOqYssCvV95S0y9bqpSx/gO6YZ0gEFZnqlMCyI0PE=;
 b=gOwTylw+s0QZFzxXd/5fpC2PI0R06W6pglEW5DCL/ziMbTEiu3vk65KL1x7X5OCIvqMrjC
 rv0PCtfvFtTawyTsyhoj/j8WjLhmLHeG5T+G3p4088ledNF2nPpg+s9IJLOtCkPf3HKzvD
 78/WVx3JRk2vIbBUvw7kMF6BP/eZ8MU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ZJT9KYt3NpmtHy46hjsjBw-1; Wed, 21 Oct 2026 15:42:22 +0000
X-MC-Unique: ZJT9KYt3NpmtHy46hjsjBw-1
X-Mimecast-MFC-AGG-ID: ZJT9KYt3NpmtHy46hjsjBw_1792597341
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dff112181so778422f8f.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792597341; x=1793202141;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=czWOqYssCvV95S0y9bqpSx/gO6YZ0gEFZnqlMCyI0PE=;
 b=pIXV3YpRQs3idyJZm443F/LBpQBojRZoT//f1SG2lgNRyWnIAi5M2WHLnKTLoRHD24
 S8TjhRqQfShOWeodsNHRmpknMkIoUEx7DDgD+AO91IaHDNXslfthQKTMVdskd//QNXDd
 2OB00wsmOoEGSXTvVqCoS84zGheoOJwev9zuIOhCz3hrc+qYOlYGRWjAa5fGuk+ZHF0e
 HBgMWniuL8zLicSvQPER0xYapl8lKsXRQ4tGkV+/czIJBLQq3hAyI2n4mcMIxs1dDEbF
 IgBIJXJ6tQk1KYuT+W+bKki57K2dT7fxhpvyyUIirq/ltV9daHGY+3OMbXfYwdbkW3ys
 mPug==
X-Forwarded-Encrypted: i=1;
 AKwUvBww80n8lVe6L8kXUktNbTGRztj2+PiAdiSrooZzBa5yRYKNiglh4lScpg4ER5yTosK0tG8=@lists.linux.it
X-Gm-Message-State: AFq9FYLAvPNtfZ438wm9sB7NxusegA1D4kNB7PBs6JySGwfk6vqrsTg3
 ZXXU+osHM6NhL344Wa+t/ZDnm+vSBDcHSXq7FF7jQmKNr3IVHdxOLmcX+2DcbN6wrRaiyrn0zLX
 1d2Ac0dcpbbGy6Voo9Z5j/Ogd/9HV4PI0OpZc6GSHqRN5ntjqPwiCGJY8qo5hfPPnlq/dUE2sfo
 7tDjczZxN4eJIjrn3tb4rPXmiy/fg=
X-Gm-Gg: AYBFou38J8eYbOsRrcMIdvUqlqLp9WQd416Rz5+ihujuNr8GqpVnJvHdjaTh0ueN+qV
 op2ijeMuzGNbERr4oHfJaP6YDNRTA0RlMfdykA5pw4rks6zagRJGeRaVWM9f3eJ5/uKYM19cXkS
 eE2lEE+E9Ki47dBBU6JqvjXCcJS1pbD+5nc9BufCD0z9AjWzQoLmuuqnQ=
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e2642ce22mr6038044f8f.2.1792597340846; 
 Wed, 21 Oct 2026 08:42:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e2642ce22mr6038008f8f.2.1792597340441; Wed, 21 Oct 2026
 08:42:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019190513.3897-1-linuxtestproject.agent@gmail.com>
 <kgYvrQ9quAy6lg4m5do5rFhk6Pkrb2X7E2xj@localhost.localdomain>
In-Reply-To: <kgYvrQ9quAy6lg4m5do5rFhk6Pkrb2X7E2xj@localhost.localdomain>
Date: Wed, 21 Oct 2026 17:42:01 +0200
X-Gm-Features: AclHuK82eDkgK5OQuSO_2RgIOQ53rguxR29I5Gp6b8TPcorqAE497pxOb-Xi0qs
Message-ID: <CAASaF6xmgRAf_wTew15mtDYn+6YHHXj1R87AWdK29pxij7X+aQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eY5EGpxf_c6LNeGD659J-nxHrzh-EZsxKZV_IS74MHY_1792597341
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] float_exp_log: Fix ldexp exponents written by genldexp
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkLgoKT24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgMTE6MzPigK9BTSBBbmRyZWEgQ2VydmVz
YXRvCjxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+IFJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Cj4gLS0KPiBBbmRy
ZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbQo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
