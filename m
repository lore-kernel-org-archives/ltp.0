Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D2CC5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 16:03:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DF0E3E743B
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 18:03:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266B03E26D4
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 18:03:01 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 996FE20035E
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 18:03:01 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4483c9986ceso486035fac.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786550580; x=1787155380; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+P8bKIOsI/79hmIQLdlO+1dbtDDFAzNbyYcsDBJmfkA=;
 b=qkmfTkpKkc9AnNSNwXc+Ny+hXn9P2jvQSo5Kgkoqdaxd9IXn8CxXn4jjqJ4tUAEIN+
 61SJPQ6HGOyOuEr1cZOyE9qZHUMVt7ozCYykrBM5Xb46OAMnXUy2hg5gpaDHDqc6Oj7k
 ejJ2i3uDG6GQYFvzMZI4LzKTtg5ggeAMXOZzzyL9Yl3hSs6MeKIZUscQPbW0H9cNh3k8
 kglrX1IEGdURdv43R2sEH8NCGzmrXBw4Gxi86NLao6MlGr8C2Z8yqRFRsBCvXPsBkGiV
 mRGgKxEvNiXU2bFoWJaibpwhkvPrw3/9A/i7M4N3CfhFbLvNSx8XLFSKwbwKrFf1deWA
 EpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550580; x=1787155380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+P8bKIOsI/79hmIQLdlO+1dbtDDFAzNbyYcsDBJmfkA=;
 b=IMsKanuhz8tKcylR6MWvQu7gtJlvT8ftoSbWTqjGd16beQrOuj4RC/H0Dnxb0cGGF/
 Qm2wSExMLxBb/kFqwFsN4liVYbcvlrXs3hlWjaPS09Q4BzXk2xDELaaEFD9jVb8X0+Hk
 812hPvUNDq8L46pqoM29ndUGoHQ3aigX+Lo2Qa0mx8RdhsLC8BDiYEyV/4z0gSBlXUCS
 e+M0iqlAK7CoMPELOQxQ28NU/F6Exzc8lWuv8MrChBBFZIs4S69yFn10WG9wF0tQ9clD
 mLglpzbACkZteGLNMlANESH9TDwWNUmGTD6bE/6zXQxKrCteUeV6gsJ3gXlpo1lQbJe0
 g5YA==
X-Gm-Message-State: AOJu0YxeWnTTFVNusk8Dn1tcskjhs5ePdXfgor2xbDZoCEgUwyoJCi5u
 pctAJdBQp/9gqqZBkNAPYF7ahfo78OEYyDk9LtzdUOhe+ApGm30wyC5t
X-Gm-Gg: AR+sD11qkUMknuHCN814tDrJ5oMoHRzNnHVCO2CZMQY0hE07MYTgCS7w1MNoNEBluFf
 7h/YdGTxeifsF3z2bIevH1n3ZA46yKZoJ/Ly+dAkpI5OyVbAvFQtvYREbFU4ZRj+USQ3auCKehM
 X+uE7xnWpKeSfC2XTh2olPTyUwAxghYU/BPRez69ZbuXExg89QZem2svBs//Njtk6QdS5MdR9gF
 oJKhDvIpjiGJj8FQvwYUigD859UBGVe6sM43o5zya0u2/WwxIVe2sJKAFcJqD5yaoc92J8kVWe1
 OnES9SMkJZThX2huXJ3JiA2DGXBfixMtm6ncvJFs76dGj9+j+07gGes0JPEYh3PMmGIt8fjfF5R
 W2CxZdM4R6Pqny2vAjJanzGKOJRn9yRSeyIzJHR6o9dBTx/x+SfvPXpZebIMKV2e6QC94scb/hI
 z7PlV10S3bia9YGBBq1p2qvnsmwdysPjukGPD8SYkQsoZD5HM3IvxNtjN1fDGIgufF6bA7jDLaH
 p0xTRY+myHhYOovSMC2l9EVPpbkIhXr8oM6rD+wUcqa+WsmvKqBjmrAyWvD9druwmB5n1StRb8u
X-Received: by 2002:a05:6871:d3c3:b0:433:cb0d:7702 with SMTP id
 586e51a60fabf-45e5e83907bmr100081fac.13.1786550580060; 
 Wed, 12 Aug 2026 09:03:00 -0700 (PDT)
Received: from
 runnervmvrwv9.mbrvyqtikzxedkwvaf01wtqthd.gx.internal.cloudapp.net
 ([20.106.22.230]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e35175873sm2162218fac.7.2026.08.12.09.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 09:02:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 12 Aug 2026 16:02:57 +0000
Message-ID: <20260812160257.8730-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812152300.64499-1-mdoucha@suse.cz>
References: <20260812152300.64499-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] refluxfs: Check kernel reflink support before mount
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

Hi Martin,

On Aug 12, 2026, Martin Doucha wrote:
> refluxfs: Check kernel reflink support before mount

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
