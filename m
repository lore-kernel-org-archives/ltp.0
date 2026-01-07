Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07860CD585E
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767787378; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Y87IaOJPxqGWxfhSSdNwagOf7w01jhi+Qj7G6p3SA2g=;
 b=lAVDHvkOk+0l9DR9c7avoGbgnJm08KuO0pAIqcX47KU8yWl08w87P7knXgNjnIhT1kbu6
 QaD20BJxWNOFQxzCNpj732anhFfcs1cwDQVZsQ6OT+ub7POji5qScp4x8iIZF5ix3bKz1Cd
 U3O5lsM+gkTNzqbRKK8Gcn5SG9+b7qI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868313C298C
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 13:02:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8F53C30BC
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:02:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCFF31400968
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQHp2Kkv1KEIhxA+koB2JGMZ8OkcwZENSpW828es7ys=;
 b=bgfgHGelWBWVbg9wENuqCRIg1y45Kp3o+lzOqMaEbEUPEhTpFYT17WVcQkhOvvivgvqJd6
 TsXskRFE99pBz8nr44qX4Qwp3Z+1Ys4kevEJ6KY4pwJsqjdawGVQxyQm61ojfqoAP7Asx8
 MCZVzMoBjRZRzMN/Us6n/s6r7ZMQESE=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-8aoRFotsPlO2b9meuoA8pg-1; Wed, 07 Jan 2026 07:02:19 -0500
X-MC-Unique: 8aoRFotsPlO2b9meuoA8pg-1
X-Mimecast-MFC-AGG-ID: 8aoRFotsPlO2b9meuoA8pg_1767787339
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b048fc1656so4696909eec.1
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 04:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767787338; x=1768392138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AQHp2Kkv1KEIhxA+koB2JGMZ8OkcwZENSpW828es7ys=;
 b=eVj0IVmfMT1rOuiHsNV24kSgSI4i1Y5LdTjaEJXyp68+B/iZ88h46HwLF1gV5rkOol
 SvT9/BRHzOj29BhkpxInMmHL30oIdGPMZSBkseu2OLcV5rm14LH0aIu0QYTSJayYj9n7
 iJPAuP3+MhxJYltcGBcC4RatyZN+pc3VH17JPghFrMJh9Vln7TIvw/HW6COOFknmeFUz
 v8yWRThvqL1JmYTclBzPkPyKD+VhPdemT7qZasN6S/zNpAkAXiH5/K6bRhFZuuk3KwMh
 3xbMR7yT/vE0ORT3qlEvyF7haH5vTKWcGwXv975CqI+ZqRwC234VkzulHkzBilQqm6J3
 pXXw==
X-Gm-Message-State: AOJu0YxWFGVq0y0zOQXa65xqjggDTlTMN1bukd+urUQ9qlNkTnwOjJUC
 enr2+D3DhHCp00UFTGzePirp0Or9PfTHcT9E1ZB3ylNLP2tvaJ8U9yfyKSx7Vnd1KBE7wNp/grJ
 UB4Tl/6pNWCnrt3IdCkvT372MSx/BAYxg0O12Bg7TlxYsneHZs24lMd1WMiK+Qfxg+WiSvz0ihu
 uhmExM0C2yI056KU/HJdQTDE7WRnw=
X-Gm-Gg: AY/fxX5YiOllRvDOHMSpEdQf7uwOQsKSF41zUIseJyMSBBIYaRaeDZDVfNed3uApP7j
 o/GQBOPhJ2Yer2n4/XWlns6J9vXuzL2J+KZInEvBqto05RkCkhXzD7i3wI2k+E94bSvATekWXxi
 AKlWMMtDIQdEBiSBpSFV0Gs+UYOg2ZM0kN7WwhLLNGeR1chcmtc+1JaIiM7a1NgIV1m2c=
X-Received: by 2002:a05:693c:6201:b0:2a7:27d:66e3 with SMTP id
 5a478bee46e88-2b17d20167dmr1788239eec.2.1767787338499; 
 Wed, 07 Jan 2026 04:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS0Z3cduxoangPawZ/h4Ixka13nUAv+0xArK9/W2MRr4qlZ+hVyRCHwrH44CXmZStd9aRDPENJdR3NKQ7u1hA=
X-Received: by 2002:a05:693c:6201:b0:2a7:27d:66e3 with SMTP id
 5a478bee46e88-2b17d20167dmr1788215eec.2.1767787338071; Wed, 07 Jan 2026
 04:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20260107114933.762846-1-pvorel@suse.cz>
In-Reply-To: <20260107114933.762846-1-pvorel@suse.cz>
Date: Wed, 7 Jan 2026 20:02:06 +0800
X-Gm-Features: AQt7F2rPr9gYK726riu5CZF5spEN0idAiDEHzdGTzaB26xC3ebGCaMgNZKFxkP8
Message-ID: <CAEemH2chyz+-_ejtOwBYsyOvo+suaW=nLYm9HYtWiu6q9ioPqw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2YIYwkvYTj_BjkaCIAmAQ5PaBCPFuSE1v9CF7s2-04g_1767787339
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fw_load: Skip on Lockdown/Secure Boot
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

T24gV2VkLCBKYW4gNywgMjAyNiBhdCA3OjUw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gU2ltaWxhcmx5IHRvIGRlbGV0ZV9tb2R1bGUwWzEzXS5jLCBmaW5pdF9t
b2R1bGUwMi5jIGFuZCBpbml0X21vZHVsZTAyLmMKPiBhbHNvIGZ3X2xvYWQuYyBjYW5ub3QgbG9h
ZCBtb2R1bGVzIGR1ZSBMb2NrZG93bi9TZWN1cmUgQm9vdC4KPgo+IGZ3X2xvYWQgICAgIDAgIFRJ
TkZPICA6ICBtb2R1bGUgc2lnbmF0dXJlIGVuZm9yY2VtZW50OiBvZmYKPiBpbnNtb2Q6IEVSUk9S
OiBjb3VsZCBub3QgaW5zZXJ0IG1vZHVsZSBsdHBfZndfbG9hZC5rbzogS2V5IHdhcyByZWplY3Rl
ZCBieSBzZXJ2aWNlCj4KPiBkbWVzZzoKPiBbICAgIDAuMDAwMDAwXSBbICAgICAgVDBdIHNlY3Vy
ZWJvb3Q6IFNlY3VyZSBib290IGVuYWJsZWQKPiBbICAgIDAuMDAwMDAwXSBbICAgICAgVDBdIEtl
cm5lbCBpcyBsb2NrZWQgZG93biBmcm9tIEVGSSBTZWN1cmUgQm9vdCBtb2RlOyBzZWUgbWFuIGtl
cm5lbF9sb2NrZG93bi43Cj4gLi4uCj4gWyAgIDE3LjY3OTgyNl0gWyAgIFQxNTkxXSBMb2FkaW5n
IG9mIHVuc2lnbmVkIG1vZHVsZSBpcyByZWplY3RlZAo+Cj4gUmVwb3J0ZWQtYnk6IEF2aW5lc2gg
S3VtYXIgPGFrdW1hckBzdXNlLmRlPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
