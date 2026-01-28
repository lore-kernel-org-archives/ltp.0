Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58373D35663
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769561915; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fT+KkjzCHJQlWM/8bdF4f1iXuo0mNa14vwUP5ULDV/Y=;
 b=YIFIsWIhS7LEo28gsKRM7zgH1po4Ouf6fAl94/kz8mqx5Jc7F5gV0/s5nOGfuLaxMSzQw
 ssu552a0Vz73oxDJZ/0kbIzL5q8jk0PtJ+QMorXvuY6Oh8KAZlS5MCYdV6JOBX7v8fGi+oy
 x34ZBsobR93l5w940P6mneHfO6d/dqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1843CA135
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 01:58:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0107F3C4F49
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:58:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93DE82005E7
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769561889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+gCxwHRIguH/R5JjpZu2LtKGfyOAhQfkN3jJb6/Qmk=;
 b=IeIZAo7c+E5ss5JqHIiT1oZP7TIjTdp6jmh9qI3wl4FsJgUxhTt37QRSiFOF/+ScRAnWNE
 9B9bhZjnfMQMmSgCldu7wCC3DSGuhYb1Qs3zkIH60iTIuEcCy6gOfogtrzhh2HXEXPyZkp
 DREgCjfK6rLQAe4j/ybOx0KVY5sHO4M=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-9L4UjCwSM4aiBvdvXfGFvQ-1; Tue, 27 Jan 2026 19:58:07 -0500
X-MC-Unique: 9L4UjCwSM4aiBvdvXfGFvQ-1
X-Mimecast-MFC-AGG-ID: 9L4UjCwSM4aiBvdvXfGFvQ_1769561886
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1247bb4db53so8369285c88.1
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 16:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769561886; x=1770166686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+gCxwHRIguH/R5JjpZu2LtKGfyOAhQfkN3jJb6/Qmk=;
 b=R0RwbYwgrxyvnGgQpVPXh6JurXw2tjN8KqwHBlAxerjxakospA6r9CYJp1BSLVtbql
 JXCwZOdJbxHoPiRNLmnVILZzSe1emxWhdooavO9T7NS8qZBiwzdITC9YoF8dVpzzmXsN
 m1Wrzt+IMkI8SbNw1M37eEcYlVhT682ElDJpqmksms4ohQzb5oCB1XWXZaE3hchLUFXM
 IXQ4DgDupO6qm5gyYOntBCvvMrswoFdly6O5QK8M0oXUmG7qhyUUb8eGnIO9jqxjpCD7
 Na19NFdm1Z22+fhfA72wk7n8RuGjMA56veI1Gka8fuyLCoCFNOaqM5GFqPyEolXdNbCr
 XRLA==
X-Gm-Message-State: AOJu0YwRIuYFG1f12jEuJuuJ1tPdrrH7210qkaAX3ngaa1auK1zZPqWE
 YVZHANhTNVX9Jyy2pI9h+AUb6Z2Gc63TAuDZqfkUjWLosjc3386SL5pXNkanxxTMnq448DFrSJT
 oQZWYbo1Yjp+XuUbnWEY6s1rk8Z0FvvGxNnHyrakABXMlVNambFEQ2HCeYT/Qa7KweghD75yEhP
 fkxX1wnfB83tsv0b6UNtrFOBW4juds0AAFmRg=
X-Gm-Gg: AZuq6aI/QABxMT8ZBpJQt9G1DWkWl1ydbVDfywS5r9VDB+tM6iCvP3TQs2lItJ8hkk2
 hwpJAM+5WkEd+sY2xwKZzMKyR9/yIJl4QK00VqrwvBeWNMrIwXAzlr8O85Je9/WUwRarrNjv5Qt
 YDjC9zR4xZFBXykm+S1j0RUTlU7vJKbfTgAHobjVUIizIYzG8WEIncrqht26ukK8wLFz0=
X-Received: by 2002:a05:7022:786:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-124a00aaeaemr2575160c88.21.1769561885650; 
 Tue, 27 Jan 2026 16:58:05 -0800 (PST)
X-Received: by 2002:a05:7022:786:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-124a00aaeaemr2575143c88.21.1769561885190; Tue, 27 Jan 2026
 16:58:05 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan> <aXi4P0YdKx5rFZ8C@yuki.lan>
In-Reply-To: <aXi4P0YdKx5rFZ8C@yuki.lan>
Date: Wed, 28 Jan 2026 08:57:53 +0800
X-Gm-Features: AZwV_QhIXa_YmWfTrh650U75q26f_R2BJPlinA5hNof2cb8T1ic5F8qIsxogQtQ
Message-ID: <CAEemH2eUY9Mi5K4awa4+sxQKCr9NkgH_SJSsM6mZZQza3bZbGA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zVlTdG2X2LgMiWQkEXqlyQeZNP_ux3TJtQzLKhGVNrI_1769561886
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preprations
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

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> Are there any other fixes that should be considered before the git is
> tagged?
>

No from my side, and LTP pre-release test looks good on our latest RHEL
9/10 series.

I think with the merge of some extra fixes suggested by Petr, we could
make it a release. Better on this Friday.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
