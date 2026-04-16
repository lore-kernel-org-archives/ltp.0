Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C0BF8A179
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:44:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CE7F3E4ADD
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:44:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6AF93C1C92
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:44:36 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3124C600271
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:44:36 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso8565098eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776347074; x=1776951874; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXuDgckK5czok9jhQa2NNEUySHfBZrr1D0XhJtCjuA8=;
 b=CGbK5A3qHDbYP/Untf6bq7/Ecg7pwKkRGB048f5pJNG6gvC7Uhe2qoT3eezymspUay
 JSx0SolK5QqEKT9py09cH5fD4zeWwmE5phFKa5jq1aevg34w3oPMzht2XAripQxiDPNm
 o+XStAZnRBdZZG4N24GlUhlglfrS0hztgdDeVNvCLQh1MbaAlmHVKj6/ny9xOUWWlqLw
 j14vN0tNJ5Q5qG9qABu31JozGvYWGpqVHeRZufe4guT6N13Yw8byVAYb9LDqo2iqutlV
 qpIBXx6f1VMTwpLQr5JnTRrWoLy58iXs+L1+ni/C72Y4kHAvnzbmjJbd0BUrnS7ui1Ub
 xATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347074; x=1776951874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXuDgckK5czok9jhQa2NNEUySHfBZrr1D0XhJtCjuA8=;
 b=D/MJisVCEBCCcB1X1lasERO2gkfdz/oY2epxpIhpcjUouhOIEDm39/JvZhqz7GL2+f
 pq6RBOZj79VzoRQuZhsd4mY5dR+jS0zk3MBSNzsv81m1kiCaCsweXT7nnRam3QD091wy
 O6vLeNY2Z+SVcQ4TQmCoJ1snpmzuY4CQegx13KKmWEvQzyYsMUeYBieuPi/E1KeeCBPH
 JmmwTj9tXhDp1NbXpTbgUPoqgrvizjLYZ05lAdzXszFRCSQXrIdIo8FEQL2p6vQnQ5vZ
 1JsP1u10HOzvpLVjXB8kQvwWNs2Uf+AAyBNU79NDU0hnXbjPjdlX2VlJsC7FPYym0ZgS
 j1ag==
X-Gm-Message-State: AOJu0YwAelPqeh1D5MKALVlNLM6Yf9k95hdJ4M2QTgsER9wVYn+G+uDq
 0yfdS6yOAtvGIWzIEIgwiV5yCkfgexKoo9FBKYOwzstdsTZkQbygg+c1
X-Gm-Gg: AeBDietcUj70C7QTSq115HCr6XaEafSWM/ZESJJwz/9SIfjzfbvU1ggToh6aA/KIXNH
 vPD8v5TKyLsSjLi8ExAN6EZNtvXo6WPku67AHwEjZYUGckAC/Zr8rdCCjy3hoddegR1rwmErN6M
 tl0kPaOvMpnjgVMAKKyVQaqYatk2UKzaLE0ITUuNCuBwP2CoC6Xw9Ew+bO3MP2QHJd02fwD5y2i
 DZb8Akk4a9j7NWM54pdWskQmMtxmW8U6ImgLhteQbnciul/vZZdyO47HS0tIIhwT+It/HwRThZz
 XC7uibWUD3U3+WF0pGdsFBqZlQSOLITKUjFZhQN+Hgg/+fUniMc4nlrj3rFCb45PZlaQZSokU8W
 TT/u7c7Lg12NGFHx3y6H9A5wTrmPBKE1UQACvGX62w8lcx/A/gJHD8KO89KilsNkFMD1wDpggdt
 YOQCe5HGkW7s2IxsVFKNL1QrpTB9Ssy4l8VqtjcSEWXdkZEHwJwYPOBdU8KBDih0P0j9JaBLSog
 cZGJHWIr4+S/HDIKp1oZGHMwg2SSJh2CcpgT5YCKHTdDsKrscQ=
X-Received: by 2002:a05:7300:8185:b0:2e2:27bb:a4a2 with SMTP id
 5a478bee46e88-2e227bba962mr1118313eec.13.1776347074435; 
 Thu, 16 Apr 2026 06:44:34 -0700 (PDT)
Received: from
 runnervm35a4x.yfcsjvjaih0utiqzf5szcxmspb.yx.internal.cloudapp.net
 ([172.208.153.25]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8fd54ef0sm7100961eec.29.2026.04.16.06.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:44:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Thu, 16 Apr 2026 13:44:32 +0000
Message-ID: <20260416134432.3941-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416125554.2920-1-always.starving0@gmail.com>
References: <20260416125554.2920-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

On Thu, 16 Apr 2026, Jinseok Kim wrote:
> close02: add test for double close EBADF

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
