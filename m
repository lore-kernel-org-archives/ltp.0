Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D322FC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788524833; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Gvy64eoKrQvU7gUR75HaV9puh8dZtjWuwKDtqd4XgyU=;
 b=jg1AuSooNJyD+UUDrcdY3sa6Ix7MZONv7D0W225DEXoLY1qF2HMIoIs+qF4lU0yF26n1+
 28b/+g77WfQsCXuLWNOekldBtlONDsV09xHoFfAYGKkurMHyZRoywCrVp0vrm+PpgWzVuAR
 XngrWQKt1oFjUI+zSrV88XBvKx6TbcM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189F53E9767
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:27:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA3D83CE9EB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:26:53 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A6F72002CD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:26:53 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso598956f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788524812; x=1789129612; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M5kC2C5DQl7fWgH4ZTOitA2SC8RiNw+10VKKovqGl/4=;
 b=Rm4r+39yPfiSejeVdQbPXv+8kzbYpG98zYw0L/C6dze0GZcciO6y66XEdMx6R3212p
 74FsC67AO17CqIUVzAOxO+GkQIwF3zaT+HYL1Q22akxJGjwE0QqmrWtUd1qsK+LMEU0g
 l00JrG+3N0WxBn0O0Za+HXT0uhTTlmSx/LFRsPGxNWMKGSxZrKUFawOKNndB50IlSwlt
 Pk4NVYyfbWqiOKeke8INu3jDxo111xfad43KsNa9jjdGkSfXOSI/gRLZOyBsI19rfBuz
 KjDp0i9nI5dx9lJVRCc7YPojs2dQ3GiKZW8le3MFUiuZHv1UIMfx4NXPVuHMD2Y25yUG
 oZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524812; x=1789129612;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M5kC2C5DQl7fWgH4ZTOitA2SC8RiNw+10VKKovqGl/4=;
 b=hn8oWgdtewFixBiViHthC3664Fpk6yP1iq4jVpAt+FlUro77whBQrjKmsNEnWkNYrj
 wF4Hq8CaumCBw1/VsmvZWR7qy6i7P4KuVMq2oQh+WgSOZ1GuIxtedFEyPJO+VFufrj22
 k6I1jLwoMgmE+3n1Csq0BLAEPpfxhBKe1zDT4mqTUVhpqR6IGidNSjlAWdeJ9aeef85a
 UUMy62pmn5zmaxSE7WIpnPqNEU+Dtn4b51gBpg59+fqgrkr9Ru/6hfXeDz0wETRMQvL8
 dzt9LIvaa/QL1Rf9kxKGsculiRIRcWgCeObLRP1dI1pljgprMUVti1b6lIe1sip2PJhE
 NYQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDWLW6RWelH06sZuccL0KdQgpurYedcTa7/5VYL8iXlgiRA1NIR3jEEi04WxATE90O2Fo=@lists.linux.it
X-Gm-Message-State: AFuF++moOyMg1kSATs0Mz9SO5UiWngwzrZLRo1Hz741iNo/tan1giauU
 RFtiCrOl5IeudeTvfHKy5MxfIFgrxuE3J/tIzI9lbSWyrwPM68oMrxxwORbOwrpRLf0=
X-Gm-Gg: AYBFou3bZca2cxRgsfDA1MI2IV+/yGECa1KP+IJB+rgcEA3SwK8M/glGXkJP12+VFUB
 Bofej2GjEdPRzyUTCgzDZtvOCqSJq6uO/Yrc6VFynVexKOH7+CmuQeIZ5Cqi5nJSz3EJNjJ5V35
 hfE9+K6U5yKNizvr/laP+KDDFjC1YZ2yVCMCFWO6A8MjxcYUM5OyJ6Z7eYrSvoLsLNIVOHQQJuG
 1Ox9mi3jUbz6xD2lr788X09tkeTPBMuyUOSoAFl6ekOA3ajga5/uBeDGntBVg0JIUacSTg7BGF6
 wNvryY2q+9iRrEp4q50zIkhswAXylqAOLrJpiGb8DPxaUJOzEbqTr2vMQ9TzPyC47a5DNylE3AX
 jVySD58hgSmxFy+2oPLVeg7aQUlKJVRMcvxFzZSqgUoLxrYb+jaUUHljzzRDayQvY32BmiMyX7l
 S/g8NgDvDxJaywDRfAcMQKX9wttvGs4MQxOknPEdvMbF4uqwauWAH3hrpqcB/hEWpHmsX3A8TnL
 bZl2jBPJnSB
X-Received: by 2002:a05:6000:46c8:b0:482:e2f2:19c9 with SMTP id
 ffacd0b85a97d-48587290dcamr7473514f8f.2.1788524812458; 
 Fri, 04 Sep 2026 05:26:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d312ca0sm2348715f8f.4.2026.09.04.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:26:52 -0700 (PDT)
Message-ID: <6a9ab90c.622c318d.bd035.fd0c@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260904122012.9088-1-linuxtestproject.agent@gmail.com>
Date: Fri, 04 Sep 2026 12:26:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> 
> This manually dispatches separate functions for the two test cases. Use a
> single struct tcase array and a generic .test callback, with
> .tcnt = ARRAY_SIZE(tcases), as required for multi-case tests.

no need for this.

> 
> --- [PATCH 2/2] ---
> 
> > 		} else if (ph[i].p_type == PT_LOAD) {
> > 			have_load = 1;
> > 		}
> 
> This only proves that a PT_LOAD header exists, not that its data is present.
> A short dump_emit() after the headers and notes leaves WCOREDUMP set, so a
> truncated core can pass every check here. Validate p_offset + p_filesz against
> core_len with overflow-safe arithmetic for every file-backed segment.
> 

this is valid

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
