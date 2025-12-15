Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D16D5B16E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765807463; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2+o6AksVhoAz97IrAoYhR8vch48clMahC7g3RUN+UKI=;
 b=Rxgpx5vA9A1r2cUh64MIoY74gD92IbHYtsJ9jhHWhIoz4tHmd6R9DvO3Qbzuo51tSPaQ7
 9ee0jwYB1XU8U9kXjwXDBYc9Nxq3hyr76aVpDxowN0xat5c5pFrXW+K84+yqS0pZA28aAfb
 7nu4jH3tyeXgjTxKsfr6ncKqLmzFRsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E0863D01F9
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:04:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853BD3D0061
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:03:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E69E620075B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765807437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1JqJNL/mA54aqaan5dqdICptmI3vehn3iZ5aYD2LNY=;
 b=UGAnCaabD6TeNv/ZyM6q0vid4yNI0047ReZ7OJAo/qcwownLWQfhK5dxC51G+kIRFUaotD
 ra5hxryEVhusLLl8z7gJfChLj15SzXu4wRdaU3FgcQqdOqoXJmu1SfzBNSPiRwzqU8oJgi
 UyumziL7rwNvyPkWIJbAo+VS05k9sH0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Mhp80o4FOxeFfPtePbVJ1Q-1; Mon, 15 Dec 2025 09:03:55 -0500
X-MC-Unique: Mhp80o4FOxeFfPtePbVJ1Q-1
X-Mimecast-MFC-AGG-ID: Mhp80o4FOxeFfPtePbVJ1Q_1765807434
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso6406135a12.2
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 06:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765807434; x=1766412234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1JqJNL/mA54aqaan5dqdICptmI3vehn3iZ5aYD2LNY=;
 b=EpUnwCLZEMpTeR6Pp/fWkH4HSkVMGuGsBfCBdeaS00qIp+walVGz32SkSHdODRXTUs
 4amWks/dAv6h9ujvyiLE339YvzINc8Lw3hyWj9EaetohTglKbY7+S1lYlli7tUapq9e+
 YwE3TcxKdb71HfOvQ27VTG9EbwBqTW4yWmriBVBuri7RvqONPvVnziWSNzFcEp4qPznc
 ffew6bSMazOrEk73Pauk4DdaUF8HkX1g+dAVCebxndiUqNjfqwTIYEe/rK+yXK/CI9yQ
 qX4KlsnVmRP4g+W7aMdpLnoG+vsut5pHg+05JsoKgHHq/osk6lLMSODp17s2jKMvhE8V
 PDjQ==
X-Gm-Message-State: AOJu0Yy+s3bH4RCk14hUm+PXRCRvijiiX8Mphr1T+sxR+L+QAVHzSa53
 QUz6UdhaUwZBM+aTT6Dbec6RWIHYZT5WYT4L9jksrWuw4uzTIaUJN3CzAJbadUFlsicKODLlIkI
 ZWdf+5aFx/TZx1mTecQkCmDgpY3LZR3HjAM2L7/VyqYYjKcLCa0CTkGi9fwkO+ChOMeGkPcMnEw
 u2yOAztFReRrgBM4hskbUzh374QOoeOrs1eFGUxoic
X-Gm-Gg: AY/fxX7clc+bphgtHWg9OU6c9bOZ/AtYh/SOSBrVuqghrDO9+dlVL2CzcDzgRaUTsQE
 8B3U9zEF6pksa4V8lgV07saKttsTUsGwuaBNa3mmsWWuzlt3AZN922x5tQ1uhzVLK5dejOWzM/N
 oegOANk/uxEdS2ab4XB3j+gkkZZRCrqi35CkxkLT0l36tFzXNpDFAkX5OXQtkkgRGSZlk=
X-Received: by 2002:a05:693c:40d1:b0:2ac:2dd2:2f8 with SMTP id
 5a478bee46e88-2ac2f8a665dmr7156704eec.17.1765807433344; 
 Mon, 15 Dec 2025 06:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQkoCw8jZQrASEvn4oO61vcD5DT8WWtGTRFLt15J7vo7646UfKPz3Vj1r2LXoclSfVdX+F3Sc7yuEY5HF89tU=
X-Received: by 2002:a05:693c:40d1:b0:2ac:2dd2:2f8 with SMTP id
 5a478bee46e88-2ac2f8a665dmr7156618eec.17.1765807431413; Mon, 15 Dec 2025
 06:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
In-Reply-To: <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
Date: Mon, 15 Dec 2025 22:03:39 +0800
X-Gm-Features: AQt7F2oCEDQO-TBy70osSjIVGz0ed9T1f0k_eS31HjOLeOt-R62wezHPbYFpEqg
Message-ID: <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m4-31Wivk_niYUxYWqUEP8lCBFRnl4cVTfGJD_bxeLM_1765807434
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

Another *important* rule concerns artificial intelligence. I've noticed
some beginners submitting LTP patches directly generated by AI tools.
This puts a significant burden on patch review, as AI can sometimes
introduce a weird/unreliable perspective into the code.

Be careful when using AI tools
========================
AI tools can be useful for executing, summarizing, or suggesting approaches,
but they can also be confidently wrong and give an illusion of correctness.
Treat AI output as untrusted: verify claims against the code, documentation,
and actual behavior on a reproducer.

Do not send AI-generated changes as raw patches. AI-generated diffs often
contain
irrelevant churn, incorrect assumptions, inconsistent style, or subtle
bugs, which
creates additional burden for maintainers to review and fix.

Best practice is to write your own patches and have them reviewed by AI
before
submitting them, which helps add beneficial improvements to your work.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
