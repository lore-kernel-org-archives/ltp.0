Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E284E65298
	for <ltp@archiver.kernel.org>; Sun,  1 Feb 2026 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769989983; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kyYOCKbzusQy5KlQuc6m/J1cdenA0KKHJa9dYo9hoEE=;
 b=E796crWqDa1frecWZwsNt41PNmkrMarpiHLBJb9TcMy2GeK/QyH6GE+0gvgQOZXfRN/BA
 DiYp9MX3TdUM1iV/hm8FDUUqlDjRQyuHHiFo/Mq+7Oq58IBM1b1OcJKMSLVIspEU4Zr0Hlo
 tMpUQRoF5bS2U335+4TnGjSi61ihWMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BAC93CCD85
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 00:53:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 980383CC814
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 00:52:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D40A12005CB
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 00:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769989956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlF9eIlGDhoSASeJQwIK6kVAAlyNqkLi22YN278xxa0=;
 b=cwpZ1X7iR7kc7kCpS9PtZ0liWkxRTlxkFixbKFj5pEdM0nvGCoxTyecoi8xpERwe/PM9Jt
 PJNfg1ldWe3yKgb7IVbIMryrdhIulcu/9PHS5kC1r7IfBQMGXJ/bxOgFQRxSQtkf1hDD1a
 JkVtXuIx1WcWNsrUxYmpyA4/lHL73Q4=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-KlPmx3m4PXKpoqszfuo22w-1; Sun, 01 Feb 2026 18:52:34 -0500
X-MC-Unique: KlPmx3m4PXKpoqszfuo22w-1
X-Mimecast-MFC-AGG-ID: KlPmx3m4PXKpoqszfuo22w_1769989953
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b74766fae7so4627650eec.0
 for <ltp@lists.linux.it>; Sun, 01 Feb 2026 15:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769989953; x=1770594753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlF9eIlGDhoSASeJQwIK6kVAAlyNqkLi22YN278xxa0=;
 b=IFXlxffBKWieZGDJQ5gWAJHP95JLt0UNvXFp59RI/6xBb/oyJF4Y/gE8JRR6J33h0w
 CCOrES3MWNPj1D6zzhPAQiM+s+suR7gtk0EmgtriMy9j8wjriFiU2lTAeXnC4kpjBswS
 6fqsTuv8oP5hTvVIPKVBm3VB5Kio+jC9ds8OzedLKqDrSB3MkLgiPTEax3QMiA/HeK38
 CrQ+p6lfHn9z5yP299Pymbdw11kGCOoJQIA/YSK64JorPfs1BhgCWFV1paVyxZ4Oekzt
 fhtE3/5TqnYSOtn+0Hivm09zP7dNGjXpfqrDpQEhZTWbHprZBrlY/qXeVt2qhh+9Aq+J
 OjMA==
X-Gm-Message-State: AOJu0YwssSNDR9JQIgG4pIUvaJi11BiLI0TfOMHt1rZqIfILa1lybQF9
 UOdh/Y1dwmBSNYwuDJNh8z3IOxoQOlt9Nnszy/PBigy8136fWVaebs3b7Vxo2BASYxQ6wPkhEQ7
 a04CEzGOAvOjnpnL+ofv3klghenej+CZnEzBMVPUJ8fvuK0q08srJXOQJD4ADPDXvtfof1WYdSu
 aQJ4keKMnrLq2W3mNmdbZZXS6GXG4=
X-Gm-Gg: AZuq6aI0NBC9RthM7vNx/3ElHwe9ZHBFe71g20//wy2bpaRisTiwI4jxEg8pypQpOGR
 osWx9BmItbuvKYddXOGrruxfJVboScvIcy8BbJvvacsMhdHg9hfNVuFkKGTfiCrhbQuN68kcIcJ
 +mv+KgQKUIedbBrtWWZg2X9DMAOZlVqn4g7Cb9n1jjI5ymYXldrbAQQzKtTw9MVcuuHzY=
X-Received: by 2002:a05:7300:a145:b0:2b0:1602:469d with SMTP id
 5a478bee46e88-2b7c8925181mr3744438eec.34.1769989953304; 
 Sun, 01 Feb 2026 15:52:33 -0800 (PST)
X-Received: by 2002:a05:7300:a145:b0:2b0:1602:469d with SMTP id
 5a478bee46e88-2b7c8925181mr3744429eec.34.1769989952682; Sun, 01 Feb 2026
 15:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20260130055249.137401-1-liwang@redhat.com>
 <20260130072151.GA126575@pevik>
In-Reply-To: <20260130072151.GA126575@pevik>
Date: Mon, 2 Feb 2026 07:52:21 +0800
X-Gm-Features: AZwV_QgJ1WMhqAvLzb8sUiOKMH4Oc1Dr8D9ELVEXWET55IELI7xF32Tca2WnXv8
Message-ID: <CAEemH2e4ow6uRYa6sKBUx1ki7N8QrvZRoovOnRs4Sc-tNz5p_A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YUwQcLUh4bTpiKnJS0H0hUNXhsZ4QRCEAvxedWlk9AQ_1769989953
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: unlimit the process's virtual memory
 (address space)
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
Cc: Xiubo Li <xiubli@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClBhdGNoIG1lcmdlZCwgdGhhbmtzIQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgpP
biBGcmksIEphbiAzMCwgMjAyNiBhdCAzOjIy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgYWxsLAo+Cj4gTEdUTS4KPiBSZXZpZXdlZC1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
