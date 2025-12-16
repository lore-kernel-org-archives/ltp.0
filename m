Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F7D5C0D0
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765872527; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=saQAsLRt1KnAThiwC4GZFP5VhZTqoW8Rtdj4GGec4pk=;
 b=PFk6OEvDBHmpPad+SkwgqseyT3vVS0UAugzb/Vt64IKXjyJiFzAAjQArr624aXoEwPnWr
 Z0Klp6DTMlMu7BKPxhqo5SG5DBp0t1o/QR7ghj9IqTVmA/lvt3q+lJ9bCj3eZVzacRPHdq0
 3qKClJPQ6JUjqXOJIFzAqFyNxEueXFs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6101C3C9DEF
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 09:08:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5106E3C1817
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 09:08:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9BBBA1400963
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 09:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765872501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okE3VVTJ/mnNteyp844YlDjhg1WDGLjQ4X22mhWKrRA=;
 b=UEvb7x8UKOqoSaj/nzxT/vkYFykwuERCPEKCe+6QB8unjYVbat9QbSASFIibyuZrnBfBsJ
 3g+9dJZ1pxLatzIT/kwj019oaDXuqK0t9hDsroZg8ctYb48jBq9LEijlaXZdZ7DXFO2BTf
 /7hyuvqcm6e4U/nav0nLWDoznapHUMk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-7HlBFeVXMkajBPwrcaxlVg-1; Tue, 16 Dec 2025 03:08:19 -0500
X-MC-Unique: 7HlBFeVXMkajBPwrcaxlVg-1
X-Mimecast-MFC-AGG-ID: 7HlBFeVXMkajBPwrcaxlVg_1765872498
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b98e6ff908aso10989155a12.2
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 00:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765872498; x=1766477298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okE3VVTJ/mnNteyp844YlDjhg1WDGLjQ4X22mhWKrRA=;
 b=RzMNoCTCI81sxdQdvgYNK2J1HgjoU4HDD6DNgfh4YxY75tJG572f+ioGpE7rlhXBdo
 FmTJGmitVnx6qlj2JPuTWQPSl+ib7EzN0ZcBwWRQn/QAb6D5haFjwv1lGHiI+K2zIS2h
 dAwfFOPa+g8iIQxvSIyZtBdx0Zgd9xhkaXSCYswcXuU5CHKcM7ZXhYKc1Pl0iyKFP5ir
 aKWJW79pUKJf1IzYij59DjLdw9yt+KWWdAazuvkDXj0TQwichN/n5wya7PlAOettc0mc
 WbZG4vjMvSx+oHpKMIc3bB0fHp160KW/vtrVDepCT8sIMvHD6eOUrekUMJThGjYJoZpL
 ei/A==
X-Gm-Message-State: AOJu0YydA+9wSp4zhkAQ0ZOm9x+21JoULRzZjIyp80WpyJtKVai20J8B
 RJf/dpVaDlmH0Toh11rB6x686SaRK8J8vlShsf1qyJbWvFiD7IDinU9PGxmrGifDwtAUKhGdUya
 xfZJWIS4Tv0IystYoL95fiJNFPDHQRr2JSoAMIPbPzukXwYAafylmtko4Sz2GZWNMsQxcw3d30E
 IlK5RdeKy72k9LZR+MNC1VLePHjmA=
X-Gm-Gg: AY/fxX5h3l/dCNE88GP/94mRqK3q97QHQkbwIfZJJpiIdDxmBTMrXzeFxbX966B/OUO
 cSflqHA6WoloolzMaDVLljzXdR15HHHoe7aIRy3sjgtmOWtvSE1sL8vbAwn3B5QHdETue91Qzkm
 0r+7o8dfeGr2830CNmWOSrU8UgN3nBy9dPMj3SHND89EEXEWWRN+3xw2FIyz/vYn+Bick=
X-Received: by 2002:a05:7300:ce8e:b0:2a4:3592:cf75 with SMTP id
 5a478bee46e88-2ac3025c856mr10913780eec.25.1765872498204; 
 Tue, 16 Dec 2025 00:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ8t0dbcYhc2ft7ZCLSYFgKKLoI1VCHVhQ5ysGqMicpdQciSVagbSgQehbbHyYOpp6lyI3KQOxoZaQ5CX9u9Y=
X-Received: by 2002:a05:7300:ce8e:b0:2a4:3592:cf75 with SMTP id
 5a478bee46e88-2ac3025c856mr10913765eec.25.1765872497726; Tue, 16 Dec 2025
 00:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20251212115244.2027-1-wegao@suse.com>
 <20251214021541.3256-1-wegao@suse.com>
In-Reply-To: <20251214021541.3256-1-wegao@suse.com>
Date: Tue, 16 Dec 2025 16:08:05 +0800
X-Gm-Features: AQt7F2q3w1KkxZz-7SsKKoMPM6uvYD5eQPd_szgNNlGRfBG8yKshN5fqin_l_Ik
Message-ID: <CAEemH2f59g4n7w_mYnPhNkwYJSdvNps17zRouvddgShsfyinnw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gqEhyJ3OOZw3FxNPrCOp1tjRNFhGucisZ8jIOQ0SAyk_1765872498
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v6] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Patch v6 generally looks good:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
