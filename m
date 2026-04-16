Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F3F8E48C
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 23:32:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DF6B3E9567
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 01:32:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 330363E1BDF
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:31:56 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E9392000E5
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:31:55 +0200 (CEST)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-50baf2df711so891181cf.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776382314; cv=none;
 d=google.com; s=arc-20240605;
 b=Ds26Nghk/BJyuBF5vMJoWKMTRZavj4F+S6cGwAJwrtaXChY6oWqC8PoE/48FKUiMf+
 0RkNBk52AMlbamumMQ2o1A+1Smh44Dr81IVxEhmOoVYRWYS1E87bJlSVZjkfRWxcu+MD
 ZUJ3FF5KKbrBEtd3hcYrj+P3K/emDHNEQEdVa4PBZnYusMwSQ/fEINU445ongpxYHQnd
 h5adVxWeVDYGILeKFbtmp74Ov6e7P2d+apYsJeC6s9JkEx/+v/q31HjJ0eJ8CIYExCzD
 e2K9PD1rBoLA3qXfrFBoCX38swwQJb31UdYxm20P59YZBSzKs1fYlVXq3XVLeyrgHQjp
 SRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FynCeO40JkciFMiMqjukgiPPAk59l7LUOfLocrwkp7U=;
 fh=oZR0M7g+5QguD45q4Z0L8n4C44WmzH6SMHooAAaVk2g=;
 b=OYfy3neS8GUxowdrmdNnLh7VZsmcY56uy9bEDAIzQoeNP9WCqASqEtEK6YUkKrsoF+
 OlXAfsdvG877lst4p5Ebj1nR+dCHuwf193cMzCJC5eBtBeFHVDXUXvhFim3yf2P2ROl/
 CoEBgnPaQM6HkWcXN3qHZ5nNXZCUWPcoGvNPWCeBQ4LGDDn3B7N54P2bnOWQ57n+VbSD
 P+40QLId3Aw6tm76NxXM0x0ygcC031Gt96dIam/QBNFQWn7tYtJo+UbztUw22zjUgde6
 0gw4FCr9qj/9rfxpu44ThUgdNnzYalAf/nSWkW0scaD3m/zteB5Bk3KRWWZtDVB9CyNT
 bPig==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776382314; x=1776987114; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FynCeO40JkciFMiMqjukgiPPAk59l7LUOfLocrwkp7U=;
 b=F+Wx0ZqCAnu507JTHRGB6Qv4Ay0dwf3gGO03c3nSrM/sli5iGWg7XocRX6eSkK/ccz
 HNbCmcj+meoRYXjwrs7o2lu7cFf65mpBUZyBK55LR1Wt/hxZZjsbyDwQxPefFP9hYVhF
 OyWG8Cr2hvGD2HkBo8CokorUrOfLa9lGR7ax9FrXOrlj6VlSG43PjtSWrX8VHWz4SmrH
 zGb3EH+3PnNGiAP64GqkHdC8qRQmDYzIOQxYq7OzHV3vXpnud8FgGU+mJ27AZKGaMSgZ
 fDHOWMnAVtUqk91iIT0R2wPz4PK54eaqPk4eOUtB1vME8Z5eDvn1fZZHTnl1TxRQghBL
 RZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776382314; x=1776987114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FynCeO40JkciFMiMqjukgiPPAk59l7LUOfLocrwkp7U=;
 b=mpymt+lMqNkVN2rxQ4Genh+zdLEljn1E4x+f8g9J9ubzvnPpDVJvhfD4kQw55smtAu
 P2kV1+lF6TenzOy7Mv+aknKdGdDEP89Hu7Ft3EN38W0CfZbNDNHWzUafFZ5tVuV5KBlV
 yoHUwI0Q/QivlBGhPGvad383oqlMrh1Nzm+D7J/6gaLuJfCoreVBC4xduk9mwL39Zl9I
 mdOnbRcHwMUXidVdSDelIgpmXunuL/Be/CK2buw8RQil5dr82/WL6qtkpYzdVIGid20m
 TfZWv3xszIJzH7ouf2IiCpTv034XvkbWA/82nDa/kNPSCZrQQXPrro8wE95Uxkn79oN4
 OWFw==
X-Gm-Message-State: AOJu0YyuZl1u17Szz57Aj9v4vpISvKMyjcqHC6Qwqgt81wJq9med1MiP
 nzJqhJUKIJbHw09HwiqGcJs6zIxikLe77EPxDCfaJJNFBjqgnBqKqXMA6Wu6eT6WHqCNAokhx8A
 7CTNBHxrctQf/btcnAjooOeTpMnobqg==
X-Gm-Gg: AeBDieuavHYRurfC0thWv+PL9WA3Nm/zSDpHEHB4/rPX50vomUlWva9tzwfsHEMMpSW
 49zr889+c3UHqjOuABU88NuWI2JlVus1sXPwQc3zNNodR3ZoJvyz6k+kqvVKpavqyx6fAQruLSY
 d581SG+22vTJ/wWEaqw0Mn2y/NFoVkuFX38YzCdI8Ym+qKY2l8ce8T36G4vude6mKjdutje+dVh
 d719ngdgSsrl1SXD7OdVGnXZhhS3m6lNl2btltdMr5BqLXf/pS1FHSnLTBcTe5GAldd9TM8fgD9
 DrotQ35sNk9/M0g0
X-Received: by 2002:a05:622a:5512:b0:50d:eb68:af6d with SMTP id
 d75a77b69052e-50e36f157f7mr7159381cf.60.1776382314316; Thu, 16 Apr 2026
 16:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260416183500.316638-1-pvorel@suse.cz>
In-Reply-To: <20260416183500.316638-1-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 17 Apr 2026 07:31:42 +0800
X-Gm-Features: AQROBzBgmd0IFhy_N7Rv6juIRX1uUo2dlr3i6dGo01M2TbH75rVnMVWNKOh3GOk
Message-ID: <CANgNiRzL9AdHaMERqshSFO+9kvYRkB_3CYpfScdDA=cEMrkD3Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: doc: Remove Ubuntu bionic
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

> Ubuntu 18.04 LTS bionic EOL 3 years ago (2023-04). Repositories were
> publicly available until now, remove it to fix CI.
>
> Exact error is missing Packages file
>
> W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic-backports/InRelease  Connection failed [IP: 91.189.91.82 80]
> E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic/universe/binary-amd64/Packages  Connection timed out [IP: 91.189.92.23 80]
>
> which causes gcc not being installed.
>
> Although repository has Packages.gz and Packages.xz (therefore it
> should somehow work or it might be GitHub Actions issue) we don't need
> to keep bionic (we have older distro openSUSE Leap 42), which we still
> use for testing SLE1-SP2 build).
>
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <wangli.ahau@gmail.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
