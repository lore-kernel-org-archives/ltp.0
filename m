Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA5FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777361926; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=AlHSm5xY+82svDEc2ROKGGyc+dHF9MQJkhWR6QOQWvbS5dOuT5BGg6hiu+KplkOPoT6yz
 dD2p5tSOAh4zr/zMyExOZFr39sELEet5sJ9yFPEQvi+mtxnuYez+qF48OI5SlEMQCcKUxpN
 Aj9A5/a0bJYvi9x7+T8ajzsgZmjI32U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E63BA3E2542
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:38:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCA403C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:38:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1EA9A1A0089A
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:38:24 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so143193585e9.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777361903; x=1777966703; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=gpTN8xep5YP93gsL/vc5dJuMK5y4afM6G7xmx4Pb9/EOJWzr6y+G9pWYm9hcb4E+Zz
 yI+u/sd3pBGpY9sjcbeDpC29zGf03UUy3iq80omM0ckONIp2elUxTVh8XFxUloRYA0vp
 j1KYDRGuo1jT6cMyXfrYZ3JrW9aRxOlNsA8DtOt2ZBymi9XyNtUlhCeBTqsNTIWtvys/
 ksAeWKIGYPDGfZh8QsYEr0BKpZC1Xzq3e63IQpETAdHvShf0tpTz3juVD5Qr8GV0Mvop
 N75SlZlBBWxHR8HTEYpm053m/vJA60+nJsCDKE2qBYbuZAzpC70lBsKThbfFUl13nc+i
 s/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361903; x=1777966703;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=f2SR/Iua7GuVWQltn38IHBA/4zdmIlet9AD68MkidBGavj/hYhEqDK1bHrPtr8K4wW
 Gkwivqg3Emj9qa5EfDZu7/6IRwCg9HTnVWcXNvZQXIVmH/F8S/aMBNNzAsyYZ9tj2QQO
 R3Z4iiFefH1smoo8j8sHFDpUmVR4qOLO2g4z9+tnyommIxfbrHx25AMZfyU9mtIDSojN
 UFM8m6bp/q2LRQWNQ1LB039bQx/tccpmXkxMpcC+IyD9kI9D2k3vF6PHAn38YTGnl+Bq
 MKJFQbgwlNp4h5N6NzlKWZdHC/78wiQ2Z7PL3EVGvh3r/Hbg0XXAmbYqCv7glVQfYqTT
 j7/g==
X-Gm-Message-State: AOJu0YwoivXyJAMGtA5zWgkN7inX6y5kHI1hfjzy+ppGypzymXQbFYp9
 Jvi3Wi67y5dAz3vXI28s4fpbsfvZvnt+OokRkGNtjL8XY2a8uxDhXZfBWbukWzreRB0HR9EPXhi
 0I3mZx9Y=
X-Gm-Gg: AeBDies0w2b/v1m0msnc7rJH9pb8BsQLDW0xCJ2gM1w2hHFMTUPfj+CyHI429THeA7J
 nFbNQkpDPzNzL7euqwvQ1YKJ4RNDfGJmzn6PqzD8VXfutCbTMU8lUERQQUCptRUfQSe/xvW6Nhp
 5mrR4pP99Y5OsDM6IDB03+xC31ottfEtl3Xll8HNAGBvwwyR8yy+lAG8xCmAPZ0hFvYkDL3/bqq
 U6ImBv5G46IvCZDnWuePGq0fEvVIl3pa/3WhumWRQX1FSGCUcdt0S7qMVnWlwQkSQC8ZOs3YWPM
 QRyQEMRbkef1/EN9zqwPYIV0bKHOq5fNGw2gt7LlIgdcCQBD+aT/vYrNE4gEGKhp4IYGop+g+cX
 2Abg1WPKfb84La0H8z+P//UAJA5117co17xzrttOkHRJq0156lmT6cnDxU6cpeDzTk6Ili310z5
 AvKZks166RPvyIGqzYLP+DWUOcy/nf1PngLajlwqjWTqBB9WUXDVx5
X-Received: by 2002:a05:600c:848d:b0:48a:761:5808 with SMTP id
 5b1f17b1804b1-48a777b8fb0mr28380485e9.0.1777361903387; 
 Tue, 28 Apr 2026 00:38:23 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773aeb6dsm46197995e9.5.2026.04.28.00.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:38:22 -0700 (PDT)
Message-ID: <69f063ee.050a0220.162ac9.c851@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-3-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:38:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] syscalls: Add epoll_wait08
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
