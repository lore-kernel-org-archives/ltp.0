Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1C8C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787924136; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=SHaogugWHjNGnJ1szON2J3vSoqQQy6h24+EZWwtSQAQ=;
 b=OiqM4mFLPZD0/qG2HBKU9HGwXUigjtOcooYix1ZJaQWaYp+fApmthM4mQ4WUA1kApGW42
 PHRawgsYWoYXNvQJrypUqLzYabi+r31Sb78U+3XsisJtaekjx/dc/hBVmnnBnB28x3UoInZ
 A2WQyyz7vor02n6AQjkTrlwp7RjtoUg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876E93E6162
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:35:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BA663C0E10
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:35:14 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3F921400422
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:35:13 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so4821195e9.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787924113; x=1788528913; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qgTa4YNdjBS2FJkF9eOTy9hPwKq0RY9EL1/7n5TBQOo=;
 b=YnpB+V2bXl0VbH8r47iCo591t/CzNql85+fV6A8sHRkzEcJlPMdaRrFKDxcqa9eDGO
 TTtLIuwUic/+LtrVTiTH7nnLGZ5geuG3LHgUASMoZJ3l4OeLKC32dvKcxTayZvIyj3oA
 GNHSPsaEf3uUzV8SKsURpIGDp/78AiLETBCFv5XzXzA8Ui8CLFQoe/ZwKMO/yIikcdZD
 GDlBqZIbqgukeq0C/rUcIZqgByJpEof3xEsz+SdsmWlKFkSywj1i7bZTmD6Gvx2HIGCI
 L1JB8TvTLpsu3HzHl018TT5qD33w1Le1vF8S4pEQh5SO1GqcIj/mIqtUvMYhwJUXhrja
 VUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787924113; x=1788528913;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qgTa4YNdjBS2FJkF9eOTy9hPwKq0RY9EL1/7n5TBQOo=;
 b=duZF/sasZBCzZ+MgMJsEXlM7S+cSiZ1HBfvWZ4wEibqXgXBf8pZ1GBI011r9QP6/Vw
 ewHxRK+yqMFnUhZuUU2sDdS0ch43yZ4gLitq6THa+o8o2MGBpoc/LgjX/xtzHm7dNGBK
 szwvZwVRsfoR6ArPY4V9OwAApNg2JZDfD78rWX+VsoO03YOhOqna+6iYWHKJMJegj+Mn
 bbTVh7dQ6+NCf7CeewMLmeEcpqDBNSrxghpOoDuGwSMPAkafzz4GQNMz3aKdALy1SK3o
 d4CZHmLwU+dX1nTwiOg9PWILVue4jIiVvCPKrNDB7K7e+yiNzrpE16yqzFgTrGSyDMMh
 YRwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuV+7smmFO9FSp7pvvrxbide05Uyj+lTTfW8K2tFNONFaw4LZYJ+Y1UsQUTVW4aoxCfSI=@lists.linux.it
X-Gm-Message-State: AFuF++niyLvCUqbkH/vxARwNcFo5HlXjBw6mdVOp02WPkEw/4o1S7rfE
 atxci2pJ0J7DA/DIPsx3+DninX/z0ZDAern2EPqUL4/yvWm0o55LcyUXcB3Dl5QBrNUdv2hX5EV
 w2qyYLnxd4w==
X-Gm-Gg: AR+sD12eZxshksY9VWRYkeWjMDvxMQk4es1WEq/jbIIvalNIYwSggeXkWblQ5TyG+x2
 rOlonzKOyXBSgXf4B85wgdRUl/sqHqInpxB+vao8/8o3ssLMRKsCPjBKD9O4erjbe9VU8I0gbbO
 nhzyzZgjUy+HT8jPxx0Az2xVkP1dPgl4v7CzynpVNbz9GAILt7kcvtC/cMW7aZm4VJK2uXyrDqx
 fj0nhbvhwFmslPeu0L6x6wGS55HKk0JVsHEfh0Uh++DjeYDXsI5PG5R3eWyXDt8B8Z/9W87lj+8
 RybCvAmZc47XkeGymRFgCy96BzsDYubtD1H5Y6kqf7xpAqFg4AyYCvVEUC7n2AAFVsd1KEhYw1o
 62n/PCpqTNpjrBXH5KSwj8Y5jB3oTN60HsDXOW9+nZygCJYkL4axwlUCBPpA+x3F04xm7Hc53XS
 XKJnJHlukC/szk24M9NRhK0AhPoa3c0r5bVUAoeEQUelj0zOVLfwsrFN3CHAvz90fV99MqADcLq
 VHmnp4k1WT4kPIOJrXgKjeBuEsUJx4VLs6E
X-Received: by 2002:a05:600c:3549:b0:49b:5521:785d with SMTP id
 5b1f17b1804b1-49b91c1e9d8mr99378325e9.4.1787924113025; 
 Fri, 28 Aug 2026 06:35:13 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4e2c1af7sm133900375e9.15.2026.08.28.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 06:35:12 -0700 (PDT)
Message-ID: <6a918e90.62f374cd.18666e.d1ad@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aocM-vVTSlaqdXve@yuki.lan>
Date: Fri, 28 Aug 2026 13:35:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 06/16] fchroot03: test fchroot()
 permission checks
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > Verify that with a regular directory fd the kernel first checks the
> > execute permission on the directory and then CAP_SYS_CHROOT: an
> > unprivileged process with an accessible directory fails with EPERM and
> > a process without execute permission fails with EACCES.
> 
> Here as well, the order of the checks is subject to change.

sorry I don't get the review, can you please explain where is the
issue? it's a description problem only?

same for the other reviews

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
