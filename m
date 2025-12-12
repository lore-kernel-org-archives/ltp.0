Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DD3D59D66
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765553488; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KQ4bmX9OCZeVofVYOioAeACjY9RFrL1jMPZZ5IxODLI=;
 b=pr2sojiVKZmqsWFPxbRvWMDr+VKaP9YV6zgQz05IRN97ONcuXdn4tm12u8I2LurplfO+H
 ONZKTZXvKmD/ADvxNIcVt/pAFgcU44CbTaiwm5T1ITNFwqHyUFmxe/LBTM7FpDlqZi3mHlS
 F+4OyFNoGCVHMA8UQ9W4DBk+j2ZKS7k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DD5A3CA790
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 16:31:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4A43C8435
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:31:04 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFD86600F08
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:31:03 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so813142f8f.3
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765553463; x=1766158263; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw9NyqOxH+vup97s7J/GuPEkDtmMRYktwiK/xn4ds8M=;
 b=gkR+8DFYRBg5qNAtTdyBSYFdibgd/PEuvMsVVB3JRRsnvXoCjt1iWfAKKYtWz/QRm3
 LF8tLK05N8KHuxGURwCaJhTVr45ZOTiWQACzeVprm2aAA0D0A+SQu7OflypZOS2SX+w8
 hnC1ruSmOIAfJ8CjQOULP0bn6FBt6k+PstW0RI1fENvk87poHZ6qWKWzxm0ssEQggdAn
 w+bw+IXKIUta5x6POASiB04OC1nBuVrdarxpy2BpBcJ9EXmRDUKxrekbmN9Uw+PzSmZx
 G5z65JGkXzSzc7uGHNJ0vQDaa4dRszv6BIMyKIxPNKCbpAUgpQojurCZbLYwAecc28HA
 rrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765553463; x=1766158263;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cw9NyqOxH+vup97s7J/GuPEkDtmMRYktwiK/xn4ds8M=;
 b=W1NAqO64jPSlATqJGr67cCcxxEIa7+lpBM1g84gHhC1czvcDTAabXu80uwsMpzaAR/
 IZWOJzHROTTavGxfrKo8x4XjZzQ61Seh1zg1WJiJ9mq77CfCFAhukRKJCROeqwzuYdhr
 nBcFdxqxfyftsPMm/8pu/ogD5FaEtI+u6ANXL7cKcjEK0oz4Pt5u3VAJThCbEREjS1FB
 XMJNZzJB8aRy1zWeiGJvZnKe9hKlJbKIanJZNFL29N6IEw8zu19u9Uwn5BAIjPk25myn
 2RcQU/nfZsXvOd9xkR9vXBjB/HGLrR5LUIZBNAAUwToqzkPVpWycDUmHDlJe+f1VmLoP
 sT3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWipoBoRyItvWzXXW0wusovR+Qj7IniMKyNZ/xtDDnZZizwCBQL59WxW6HzBegp0lrvBjE=@lists.linux.it
X-Gm-Message-State: AOJu0YxUAAfZpBG8qPJ+XMpHWBMKAojFjXvNgIOINu1oV7oqkHsUaac0
 fTkIfpz+HWreJaRNwv7Kw4PiT33y5Jnhu3ZM1NPljwNdW5fpQAs76Dgi+yd17TXEhTQ=
X-Gm-Gg: AY/fxX4YdEYdBcqR7xdQu5NWAAt7nHxU5lxhSA/44kDHJMeR3UaRaQL3vHtCT5BTWr+
 +AWDg7AmoYNBqgg6uqbGlTfw+JW72KiFXeg7sF03I8913zQqCWxl5oqjjmilW+PZMFT+UpMkkLP
 H0MK3BMJsXzq+MgbKr5woN9QUqLHFYFw+iU1PkQIdiMY6TCQhF7Mak+cos0JfvFRP1WFlMd/o5o
 4NGSJIfyoJLDOG7YGsdnIMyvIOpvgCZ254SQ2M/Q/EmYEu/Nfz6kspeT3x6PlYOyFNCrlytUy7v
 e1B5/x9ZR8Jh6SWedDqha3o/oU7GrRy0lsvgV3GJexXHZTg0NfwbvXBJ25+K/mH03T/cOwM1SBy
 5ksjjK6nh8PfVWhR3PY93xj6ny4IvoZW0NWpXjks/wPiyRoQ53oSv21jht/9EAknzopj9MKT08Z
 ViYSO7HOIjjz62UTk=
X-Google-Smtp-Source: AGHT+IERkh1wFCOgFuvTdf4WvdRpZZQAKbrpIa7finfyVH/4m7Y7uOdpaLiobU71/4rrOc1q5S2N5Q==
X-Received: by 2002:a05:6000:2489:b0:42f:9fc7:f944 with SMTP id
 ffacd0b85a97d-42fb48ed901mr2804329f8f.62.1765553463099; 
 Fri, 12 Dec 2025 07:31:03 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b97sm12665134f8f.7.2025.12.12.07.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 07:31:02 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 12 Dec 2025 16:31:01 +0100
Message-Id: <DEWCGV9PNMKJ.1PIME8TAQ3WDB@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251210-kirk_v3-1-v1-1-d610538666f9@suse.com>
In-Reply-To: <20251210-kirk_v3-1-v1-1-d610538666f9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: version 3.1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged!

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
