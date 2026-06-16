Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626BACD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781606627; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lJag318IZgOCGBD6pMuwLVGxydPEPtWOXe6fpVYtsKKt3QNWfWZbMtA5g2BHyf/NXVaZY
 xna7NbPhtKYuZooPleEsy+1cQfFgMv7dKl7UPhm3nXoUir/VzRw3Xbmer9auF59pK4ZwCLL
 wl4SG6IbqyrF1ybQO11tAKN87U8RsJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED1053E4E37
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:43:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1765B3C581E
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:43:26 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 122411A00936
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:43:26 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so3557628f8f.2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781606605; x=1782211405; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=GnPdgrYqGFMa5qfln++9pipaLR7VGXsmuf7gOXDL6ELXhqKuH8K7iX3GfTNkIGYsJE
 AwjaKWUr3iui6zrVr01sMISKVrvZ0dBf6SefBIiRYMy3QmHZ1bjXApSB2+J4GQC3vdpk
 7u2oNlaR2zZK1c5ce+1lVKbaUPriFBbDpImLzyEPIfk2pcUPD4GQVi0TXfPzZ/XtA+Yd
 6ZKhjKBgHGo8yRC0QSAf/nQ+piSnkuSREWyzT67WmcNs7KVETqth/Vz0DRBrVB4hZqlB
 TNHHh4ISPtQ2CKPkRYWAc3GWaivtWN4D3TIvdkMnexK6Az2Jwc3Y2Z2JQA1jzYDtAQtJ
 015w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606605; x=1782211405;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mCnj34y0YUXa0TOzuU8L6D/J3wNAPPPpbHIsMEgjQOEdcXuxsMgDF1QuY7KStE6qRE
 ON5NS9lW/h7y/En6FHWStQ/8RReDxnDi6IPtVCoV1cEKo+QlJK1X4BIEajs9HH+JC+/X
 U1boSAr2WRqP0gB4s/6/VnMxJOc46GeEi42hJldrErTAHKtOXxlkUe0A/HsczJYL/mxt
 jyyy0lV7KEtlw03cdQhMaCBPTXxLi3b9JaucJG5aJPDc4vg86u3+8d8qxRUxw5+VBZY9
 KQOvvm1pfkRoZMwxyToVAUu8TxpMVPcqgEdmSb9J7gwviDaX0xuDfaOxhH7DSHh3IEMy
 rQGA==
X-Gm-Message-State: AOJu0YxjeuianOEUkMByKddSZjJd0V/DpM7ZUG78Lj/nEPrypUFgdBeM
 VTMyl+Nf5pgX+Cvtf33Vqngi/xcX0eRGHtwEhNTrbNkIRdRM6BM40HVqTrwuVrslBTGIej6IFhV
 wXZvRkdaY8w==
X-Gm-Gg: Acq92OETE8TzV5HxqOP0PeJ5gyWsF4w3C5fiA1d5TY43rhtL3Ojb+dJKkVM49ko5hT2
 gVfLUDPTjDqo98WltqBaf3rY1ulmrhRRzqL6/D3uIYOMRAtN9CdOZcoFMHiHlFa0KB0YzAlLBZr
 tQ5dc+RgI7sFNY84TIBx5wS+3Gmgn0YAgtDUXWV/fJWwKhYGPWdR55nX2nHazRRGZbHzE5+27Sc
 0BJkpCArTvYO/Yvojz5gsLr+FPzLqKH2aplxgQy0o7xBeXrCbgkFY+2nKLFLMRyPmaUB7cioUkQ
 oeSiPbxNxQ0vtTtI5Rybj2o/Hi31fBs0p4pxC+CC44CSRUe9Fwp/62sjuuSTJmNrSTjbvZXfY5k
 2U7pU18ywk6GeAb6at4ia92RAhDzSRdJT1bggOCVQkIp+DMegGCf/VX+WMy06sSPCRCnfVL6Lqk
 IMpjvnacwVLgJSBsnrGuDqHzaQS9PlAg8pqUeQ/d0L9pbwr35rmTJUMayks5lYO0qpeDnneXuz
X-Received: by 2002:a05:600c:310f:b0:490:a646:9d77 with SMTP id
 5b1f17b1804b1-4922ff8eebamr45923155e9.6.1781606605179; 
 Tue, 16 Jun 2026 03:43:25 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm72941755e9.12.2026.06.16.03.43.24
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:43:24 -0700 (PDT)
Message-ID: <6a3128cc.99c1d4b1.edf84.6a0a@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260616092300.177787-1-avinesh.kumar@suse.com>
Date: Tue, 16 Jun 2026 10:43:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_security.sh: Fix bug in tst_disable_selinux()
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
