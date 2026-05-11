Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F548CD37B9
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778500483; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ea/4i/ywgPz2ZuFnWubjgOWcKGK1RjDE4sUIH8kibv8Xg/F+oADxum489Y19Yf+Qda0YC
 UNh7Q8vunxBjR9h/STn0hYPBzbfbTr0jfnDMRnoQii5eRIg0R9RxlGWLpdtID/S+FTBL6jN
 chG/ObcM4pdtkZuz8pWSNfhAPO1CoXQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D22D3CB3F9
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 13:54:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1CA3C029B
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:54:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CAAA910007B7
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:54:16 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso36741195e9.0
 for <ltp@lists.linux.it>; Mon, 11 May 2026 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778500456; x=1779105256; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RM5ymCdRLg8NGQVLSSacYj5OIzUjTm4Jk7acpKP/MCIDHKLp/rmZg7aUQSSczRm0Su
 hUmJRmB2/uvv+upMPRZzjyQLZMz5uT5jqtd8T7mkvW5dvFhGBC3beqBwpBU8jQHwxUBg
 AEZU6HCoQ9jIZwffiZvgiiTmsJDVtm62o1ov/qhyYTysrr4t2UobuSb1raP2wO+V2/NG
 gxARFyWUCxmhnJIzn4CFQdFxzVlDUPWnvSE2D0zgz30Zawx6cGJpM4hBfVSNX68w6MK1
 71RrmeQ0KxPbJTuNUtjxRh80ZOk8X1NVPY90QvQfYGhAtSiHQn1X4KE979Ek8ihmKsM0
 UZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778500456; x=1779105256;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=gsr4IsF3Qy8nCQQOAu+gcAPrmXcEIx/9G5urQdZPpCRtZX7WKNLVRsayBMXALx7Z2F
 hirHmQwCv6psqO6GQWouKjhSdKdiVr4sTqUw4Xr4E2qJHkslGyHcg5aJlBCATo9vQiVI
 4ZyPJD9cJT0FbtrCk3c8cGaPFkviDPyixgPZ6r/vxbCf5v84wrBOBywkpMZ3/arHL5ih
 pC2gFdSZ0qC7UqStnFFXQHaJhP2dsJslZch4cvfQEx3NYndLHe6BVGngeI7mS/qg1aly
 cTPYc/y13qNDFzJ6rnzwOyoIQdeyKSSi+/KrzPWB6U19lQ2VanRwfcdsD6Y+EZPUt2nz
 D7Jg==
X-Gm-Message-State: AOJu0Yx/uE/qjBTYW/eIQaS7IpXxUOeJt5isGVex6d+LV/MtL7+wKac4
 9pABT1xMwDmER0wH5+eL3A2w3U7jxCnBzWXi3l/tLaxO3K+2Lu7WfY/RZFehNH+a/eM=
X-Gm-Gg: Acq92OEXghTlc8s730zSzHKelFVJSNg6eaLgXXWrlMrRiepKwXrBdXH0op9oWFYDT4p
 W6PG0QCf4oBZGxy3YVRvZP5yFxHu55Uu5x5wt9MFZCXH7BpZzZoY6PFpZLbjpUhFEgSATbj0o8R
 P/zCtLImvjW/03CSnpDLLygQFpmHUJqF71l4/a8aeQh4fMiiIDtmYDhvaMe7QYadMYrcalJ1Ph7
 xKYDEuyI5z/XPzElJI3DfSGw0kcax4GsoFmX5JHxv5ekrd2Fk9kVupiFAc3iuYZOt+VW6ucQb0h
 XOYtI0mcxKsm1IoPJJlh+60MrHdausq4fHhno8fIWI4zZEiOpUM5rz9HG8YTMGWD9kIJdK7y4Jr
 AQ152kNQHMBfqsVfBmKiPmSt37/KM1ovRgqmvGUSh5W3VpI9LjL3xRclHZtBIctTDa66ONsX3xp
 ZIpahkm2sVeF4lquKZSKCc7XmUON2ea/Wg0JZJo+aG
X-Received: by 2002:a05:600c:3507:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48e706b2726mr140071165e9.15.1778500456063; 
 Mon, 11 May 2026 04:54:16 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db098e0sm61736165e9.17.2026.05.11.04.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 04:54:15 -0700 (PDT)
Message-ID: <6a01c367.7292c033.9b7b0.e46a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260511070852.90379-1-pvorel@suse.cz>
Date: Mon, 11 May 2026 11:54:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
