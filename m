Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C903C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 06:46:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F45D3CA8B5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 08:46:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFC543CA4D7
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:46:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DB121A010FD
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662101170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lLOyhtX00W6b/lfr6WEHZNRc3s+tFrEgN/4phPhdiB0=;
 b=Jeawa0v3i5pOER70UoN0PwVudbfcJxOFxQ9lfq/pd5J9OkdOR/h0qslfwYMsx0kjU/LRJ/
 frEfsB180QhYrMZszevFgz8oGVKG0BA2VX+lEBGrby7XgGlPSdC33nCUIJg3ZgoeSG+obm
 d2IWv9oAo1SbJqxdtmCR9gYfc9YsQeI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-335-uRSo7WdSNxmfD1wiX0Femg-1; Fri, 02 Sep 2022 02:46:08 -0400
X-MC-Unique: uRSo7WdSNxmfD1wiX0Femg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-33f8988daecso9153597b3.12
 for <ltp@lists.linux.it>; Thu, 01 Sep 2022 23:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=lLOyhtX00W6b/lfr6WEHZNRc3s+tFrEgN/4phPhdiB0=;
 b=kJcosyMUHFla/NtgL9T7OgLAuDZetphjQDtZW6OovlmiGd6n6nvlDgOC/ecvLP/rNB
 ESeL6GRglfsZz4NiS5+PE15PCEx4u90hyhu05mDj3P2wLQZ1LXczK+fV5NK0OeEi4t/B
 CY+1fVO119BEe0cN8aVXaYkJdzO4hlUFKHwNQNh5lFRKUeBM5HjnosK+p/zT/2WGHsF6
 FvCveSEl0LW8fgXQyE2bkHBVikVej+/i7kTlQUammw/XJC4YlFzH9c98YWPGnivO3A5q
 ExCdEPEdQGBTW26tBvU4oyMDB4O2tRdtFlDpovCgix98rAzF1vHqjrcUWqPhcS164NfU
 QbXA==
X-Gm-Message-State: ACgBeo3AQ40Ep4imO21uJiedPD/gcOSFMDXgmn0aCikLMDwOKcU5NPIo
 pnXDc4lxKQ1IU/7Zq0gp0154r4VLUH6jeFd8RAJllQKENikBb/GaeiwoWmjmHDl7Rf+C5t46OA9
 WtKXjZXB/lAuwEhe64BcdEYOrpWA=
X-Received: by 2002:a25:5006:0:b0:699:18ad:e7a7 with SMTP id
 e6-20020a255006000000b0069918ade7a7mr21905988ybb.355.1662101167457; 
 Thu, 01 Sep 2022 23:46:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bdfQJIApVgYwIDytCqqm3tpyCO4O+HzZ2hd3oiEoYHmC7baG23by57I3TqIqy+FOI5ebIon9FBpZBa66bHXw=
X-Received: by 2002:a25:5006:0:b0:699:18ad:e7a7 with SMTP id
 e6-20020a255006000000b0069918ade7a7mr21905981ybb.355.1662101167288; Thu, 01
 Sep 2022 23:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220831092036.20779-1-pvorel@suse.cz>
 <20220831092036.20779-2-pvorel@suse.cz>
In-Reply-To: <20220831092036.20779-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Sep 2022 14:45:56 +0800
Message-ID: <CAEemH2dwrh2Q0knhZnpVW4Ari_HY3=rt+H5KxYpo=FeD5XMgkQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Document macros for stringification
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0361634794=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0361634794==
Content-Type: multipart/alternative; boundary="000000000000a84b3405e7ac1588"

--000000000000a84b3405e7ac1588
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

--000000000000a84b3405e7ac1588
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small"><br></div><div class="gmail_default" style="font-size:small">Reviewed-by: Li Wang &lt;<a href="mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div></div></div>

--000000000000a84b3405e7ac1588--


--===============0361634794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0361634794==--

