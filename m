Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55122CDD56B
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 02:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44B2D3C2F57
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 04:53:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DB3E3C2F17
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 04:53:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E1CB1A00A4F
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 04:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726714383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eOR0NeqSAE+yvES5FiYcqrEshT410Sf1I6Wc3KNYp3A=;
 b=hKcpRJdmNdeZbY3d2HcHDUnQdwYjqU+5ZHB4n48yJtwZvosg6rDWxPw2Go21JOZHwfD6hW
 rOxdLyu7ijmyOl44TY8Q69i4uAms2vcrOY97UOYHjxOLxNc39yUAQsjnfP/KGyETqVhEyh
 yrPzFj1Z7JZiPaPztHLyf9CGBQyT7UI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-iLe3gqXVONmycDp3Gt3ScA-1; Wed, 18 Sep 2024 22:53:02 -0400
X-MC-Unique: iLe3gqXVONmycDp3Gt3ScA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7cbe272efa6so407793a12.3
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 19:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726714381; x=1727319181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eOR0NeqSAE+yvES5FiYcqrEshT410Sf1I6Wc3KNYp3A=;
 b=ZnYpz0EgpW1p8MzPYsXTDd+V4T/MZA+gP/lEl3e5K8D4V/Uzb5dDAH0TIuy1//BEqE
 AsUufC0DxTIPnGai4LB0AtKT90MTcDOdGyHiSZqNOOKQYTDUw4dwMuCTctkt7sP7+3e5
 7JSkR8stEEWNWXo85fOQ0NSnNC1vFz2FGqxkBGob9DGlIILPhNN4EI8tKBm/wLlmQKxT
 Bq2pq9SxFe2AhzcDuZYBuRy72+PeHkKzZHnxJwaXVENLKBjbRKge8YZnxW6rFIFcqoXS
 RaSHnRscq9imG2lypf83zz2yQCIHBCa9+SGHWtBKH6WWS2fy0N/Wu1VJykjiJ28oiMfY
 UaoA==
X-Gm-Message-State: AOJu0YxPhMoJOrn77AgGv2k/8Bmla6aR09GJAOI58+yO9uoCw8WZhaxl
 arOO8qFLWiAmA5/2wrwN3Ix9lytQV8PpdbC5iwCQKU4tr/CLACemLQpbhcVdN8N3ApbgxtQYCaS
 uTgMUzb6uIdflAL1tnuuktwBputObRBELq2I6+VHRViRcr5ABl7kA4PCJTmiAfYXd5uY44ZXN72
 4SoRTqNHsoVX2nRg9xojWAUBk=
X-Received: by 2002:a05:6a20:c799:b0:1cc:b22d:979f with SMTP id
 adf61e73a8af0-1cf75e79807mr35065780637.4.1726714381024; 
 Wed, 18 Sep 2024 19:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZN1PlTEj1tgb/nZZtRe4fpj1cnGcnZjT+PJ2DZ1rWIpXEgghf1xGmQ0atovs+3m4H1uHnb1a4TAUdx23Zacw=
X-Received: by 2002:a05:6a20:c799:b0:1cc:b22d:979f with SMTP id
 adf61e73a8af0-1cf75e79807mr35065764637.4.1726714380528; Wed, 18 Sep 2024
 19:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240918081255.13686-1-chrubis@suse.cz>
In-Reply-To: <20240918081255.13686-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Sep 2024 10:52:48 +0800
Message-ID: <CAEemH2eo3tk7Ef_wqCDP1OGU-zUX+LFoBaHgdtfp2pFkcOov1Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Disable failure hints before we actually run
 the test
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBTZXAgMTgsIDIwMjQgYXQgNDoxM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gVGhpcyBpcyBwYXRjaCBiYXNlZCBvbiBhIHN1Z2dlc3Rpb24gZnJv
bSBQZXRlciBWb3JlbDoKPgo+Cj4gaHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
bHRwL3BhdGNoLzIwMjQwNTI3MjAyODU4LjM1MDIwMC0yLXB2b3JlbEBzdXNlLmN6Lwo+Cj4gUGV0
ZXIgcHJvcG9zZWQgbm90IHRvIHByaW50IGZhaWx1cmUgaGludHMgKHRoZSB0YWdzKSBpZiB3ZSBm
YWlsIHRvCj4gYWNxdWlyZSB0aGUgZGV2aWNlLiBUaGlzIHBhdGNoIGV4dGVuZHMgaXQgZm9yIHRo
ZSB3aG9sZSB0ZXN0IGxpYnJhcnkKPiBpbnRpYWxpemF0aW9uIGFuZCBlbmFibGVzIHRoZSBmYWls
dXJlIGhpbnRzIHJpZ2h0IGJlZm9yZSB3ZSBqdW1wIGludG8KPiB0aGUgdGVzdCBmdW5jdGlvbi4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IEFja2Vk
LWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpSZXZp
ZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
