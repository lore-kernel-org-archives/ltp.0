Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5515C5DF70
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787036981; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=hQ1TW0LmhcT1zy7/OX6t/wzjs9fXzaOtMPee5oR/5l0=;
 b=fW7m8Z7hdgk0Uzdu586Yc/lpnS4Wgq3AF0jIqJo/XHEzrbYmhPVmWQ1rZEbQ4otSU64ty
 uwNUKt/D1Gi2yf1o0JXUGk1kRbhPtb1BKSUR0F1aabQoId6O1vaamcRDeadjJz0HtXeOV7r
 K0IXhfxHA+myAwK4SEPT8Bldcvk5ywY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A32013CC2B3
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 09:09:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAB293CBBCE
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 09:09:21 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70D372003A4
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 09:09:19 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso1619991f8f.3
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787036959; x=1787641759; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d93QBU3+CYG5rmKZN91TsYjgTnTPD58D6dkzij/bWw0=;
 b=CIhMlv1wmbP5YIG71RseWkS6JxuAAnjeOTRuszb3MKWea1/B8410zv0vBBIzYYBnFP
 mJTNafIAN3MISVmHeE863j+Kw9Ekr25GgNUWdsoA7Uw1dDH73EwsTNORgexzuk1+ETJv
 WKjH1GqsBYzHXHJmeegsSEOLya0Wu96JgnBfJMQZfS0jTGpSqfg1GDhroDwKgKafdWRF
 hNzsC73oCj4zSnHWb3N2WFUvOqZdmgLCGYAYGLou5qAsH0Xe+1ap7lA72IkjLJiB6x9D
 YbWLMVLvbqofcIc/+y5HxuPmaY/DGo5m0hdAH8NBLWvAsi+cP4UKQj2wx4UxByD1Oijo
 AdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787036959; x=1787641759;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d93QBU3+CYG5rmKZN91TsYjgTnTPD58D6dkzij/bWw0=;
 b=SAmceUuLl3WnzKFMkWso7wVPbwTu5gYFaQFS7rt/EKwo3JUReYrK6TCHDqPw4dPlLO
 GkboaDHMG6q95TzPQeSPXK3IHdk7Eh6Az0AR0B54pr42DYwgvB3OYe6DSjRl9E10ye4T
 UbXK2G6hYn9nZF/0StPOec7Ao6RQzM8yqBIFwUygyTeiOEVjOFSmnL7O+0bYGhwDqLw/
 CnWCTJYOZdbX2kAui3Nre5ncy5FoHtqW5RlyzRJKt/H2GIRZYhExxFyS/VKs0aTyXa+l
 bOGHPV3Yh1ISpZj5GByyhN+GKnia7SncUX5lndRgOzsmdlpWRE6VgCUaL4Nzg7i/CgQf
 c1gw==
X-Gm-Message-State: AOJu0YyyCatZIDmQUBEYF3Z2hUnSrqTheLgdMsm3mrueuPktRcHyLHHr
 IFM8hWCuclEA1T2ydc0nDiNQ8PkrX9+z/ydaHUgm+rgTo+wbJEyjTtklAnQRpAibDp5R7s96QzJ
 2TN40szk=
X-Gm-Gg: AR+sD12b8MwIR0o0GwzN88SosfVL8Cp/hdSHXqaNuMmGkPdtFNjHPw/pFclteOhzh6/
 bLiQo9bNrnrrbHk16bXev+IIQePaI/47/3WEU2kSB5d1U0yiSqN+qTXW1yhpUHpNBSYAVDcPrFT
 48E85q7UDnSlrtEHbe3WtVBm2TbApDw7ydGrjROpzmp1erusT4u0wvyCGEYQ6MS/qjLQfJw4oug
 73aK5QCUL3CZ7F2p6jZLGR0XnzKrUHyJeq0ciWhit1LHOiRFd/9NTgC+PtolRDXNwqQtKk4rgyP
 AZ5vuhowTo7U9BRvL/BEoOediBxHbeZwilF/4l2o1m+EcEDzGcmzKk4m+4TtIg27zskmWNVOlp8
 nKPXHBZ/RkyWlb5LvlgiCWfffCjaDV1x8hXiTCUKzI7KwMxi7kxTvj8stSLPjASMjspzv9de80X
 WFjlojEzrCNu0OEHRRAiD8rFc8A4YvASuomkNVSWP+Duh/DbJDNVuumhu2hxMYGbIGmmDNW2t0Q
 bMyfkDqLw==
X-Received: by 2002:a05:600c:6087:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-4999fb07c9fmr104417445e9.2.1787036958472; 
 Tue, 18 Aug 2026 00:09:18 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm247964475e9.6.2026.08.18.00.09.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 00:09:17 -0700 (PDT)
Message-ID: <6a84051d.3ddf1959.26ce36.5668@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <CAHGiOXcygSrBCwc6AfoTiG--t6TOu2wCpYiHBYusiLEO8MNMyQ@mail.gmail.com>
Date: Tue, 18 Aug 2026 07:09:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] kirk/json2logs: "warn" treated as failure +
 robustness improvements
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

if you have any suggestion, please send a PR to the kirk repo, I will
take a look and discuss it there.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
