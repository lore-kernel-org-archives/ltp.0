Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FADCD8CAD
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780993492; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=I3xKbIaa2TVBgB40R1dcmJPqDbt9cvj77Q81wFBXebzS4cE2EAYtnfI0KPPHjin0ipxon
 ERPu8xI/fjvEb0EtVMd8XzLBb5nM+HuSZ8nYW8Rg4pKxo55h8U1MyQrctK1pkTewuihloyk
 2t4/P3vRzP3tq2m2hA7uIDZSjYJThzE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA47A3E4E6F
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:24:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40CBD3C22A5
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:24:32 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3A2D60154C
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:24:31 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso36554175e9.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780993471; x=1781598271; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ftlayAYdCtHJErbKNADD0xkOrQB8LGqQhimOqFvCyRXHwueM2CstdxSCLZI/skJhOu
 eIoANNr01tUm/+diyKHIRc3LV0hzPS7jk+twaGGob8UYVO1JKXTqtqWh3R6oCgzvOl9S
 E4KluDvG7NCD8k2AgttZzuHasUMhn7nY65pXr16gq/m1wVMC5TmRU/aNMYNEAiTQbzsb
 kZQhZSIs47JMmxkp0i0v1r13JHnPPCZg4UgYE4p3+rfOX9d9HdaKIHOQtilqGRBP+Gpc
 QfjLOIcVmGVkVv4UTpVoNxrQjt1iBaC3qnHdOhTKFcI2JLCB64jYu7aIOCxhfk77WrO9
 X1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780993471; x=1781598271;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Q4RrelLorut832idb9z+vCIMN2ExAYkwgCjKqFnLgQEhC7janSgv7pWZU9KBOhaqxW
 Z8e/2CPHtIMtnEGsgZJrZXCMwHNm/84WF05/xLS9DRW9AwR8j+yYY3sqvDDqoTA7/cH/
 BHVNF8f8cJqeRyIJRbxBpeFyWmYA4Goh4mSFw3LWAczbmK33BxPLEznkX9LV2KGM8sm1
 HQhSvDn7mZYTR6RjAXhDDhUjT0QhsPtMUDyhkw8ZoSAh1lZgz8RviPQuxKLGIhc7bXEy
 6d/FVhyV+wT2pMMmpjFxINt/h4RNGEwE71lFEAg4XeH6tafcXFy+ilt64hvWBtpq2EG3
 eJOQ==
X-Gm-Message-State: AOJu0YzmyGH9gslXUCWcdP9Nmin/PF1902WE6Yye2itZxbQa35FZYnCC
 w/25787GoRxskMNBnlJTdxoRtjG5HKkSkXD0a+85y6rt92EaGZYpW8W2AYZbY4KMp2wenbdCvzm
 Lh9PN4HqcFA==
X-Gm-Gg: Acq92OGkXmrjZlLlRIQeTXgDTi9d+WToQ2BPt9PWEfk6pUZh46BlPQyerESIUlnH+NC
 F/nEyFtfamw+Vwl5Pq3Ea1BP/xnhVVAiU41P+yacdReb4W6KVkljp9nm89ULqWOiup3diO35cl6
 dYw7m78vepKwfFRr+vHnR7YSRzcsn4nEldLB84xHfhj84hGmTozwkuic44G3insWED4qWykk6cB
 xyeKlVyuuf7upycgx8WccIOnVMGjTGspi1OQ9FWU2LFg1d3vCDWnn4GBwSWLcL3OQOyWQeC51Ht
 azB5G8buRjSUqruI5CCLIQIi3QiWax7qYyg3dxhx85MYIAvDCGO8nQ07lRz75FadfpCDslVG0on
 JygyYbJxoBe8AQxO4gog64nLfZSn4FYwXNFx1vVDxhC7eTRrUuhe0WPxoL5RA+T2lpKQYqhHIul
 LYkcwh4doXd8sMus9sfxAYYVPgZaMELauMI8z+am5uujxZWsoRb5dXsMVrbcqkWtitZJGN3Tt5i
 YjvveC09j7ujxfA7Ylw2zQxLq/12cHfcyINvRMowoLx5Q==
X-Received: by 2002:a05:600c:81c9:b0:490:b724:507d with SMTP id
 5b1f17b1804b1-490c259f6e2mr263767745e9.11.1780993471068; 
 Tue, 09 Jun 2026 01:24:31 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a87dasm447974085e9.7.2026.06.09.01.24.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:24:30 -0700 (PDT)
Message-ID: <6a27cdbe.a485311c.446d3.37e8@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260608074419.1276-1-wegao@suse.com>
Date: Tue, 09 Jun 2026 08:24:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ksm: Fix sysfs path concatenation in ksm_test.h
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
