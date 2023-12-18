Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A25C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 07:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD2AE3CF32D
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:47:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BC23C99F7
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:47:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA6551A027AC
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702885652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xoUqtXgNzeuKxypXoRhqQBN1uCW0Uh79uRijCbvGCjc=;
 b=b/hIis4rcLNt4xQEemUCuXnWro3E/l/y32rwdS9FXaolCVID1o0IiYIyGpib1BQZQDGs3l
 weTgtC+TmQqBD56nnlNx/1oEeSIbwny1sBeAJI9ee9PNk51ZE6JjE7/cGyDSZrNm0FFpiG
 WJcuFs4dmlYVNrDCoJOnxLvWKGVHj2Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487--oQwKQKfP7eVZV106-nCtg-1; Mon, 18 Dec 2023 02:47:31 -0500
X-MC-Unique: -oQwKQKfP7eVZV106-nCtg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50c21a1733eso1961950e87.2
 for <ltp@lists.linux.it>; Sun, 17 Dec 2023 23:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702885648; x=1703490448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xoUqtXgNzeuKxypXoRhqQBN1uCW0Uh79uRijCbvGCjc=;
 b=R1k2WXGfvXjypRUH4+aJjt+/JfzsDMRYKZlcigDPMrxF0SUUFXANl1WSJ5tDiwm+AY
 yZyvT5gFwAur+oRfvGx6B1K5gGaggKqYgBRH6YYgQNyXr4P0bRVJHAqs8l8F44Cy3YjZ
 8t8oOstvB8v5uW7bVHjoQ2t6tjKAmUY8KZlqikpbn8rIpCf44IdEQUee3v6YWmbPhKOo
 9tg/aoj+7rCq8Afhh6PYMBwVW3GekWqQNOl5OA1JCqSB/AFqtlpRabzseJnNUw7dfzIz
 SVqemPeFEM/1QdgM97RQyOxw9e88e0nmeXG8Y3ljhzEUy0amXvg9bddl9eSOd9bGB/vv
 GtAA==
X-Gm-Message-State: AOJu0YyLh7329UFF8f058ZvXm7WGkv/zhFlxFcSnTHZXA+I3lAy9wozp
 Vkn0Vrnnudl4oVQSITMz1ZcTJrermIZKLyO/MG96GWo+fXdJPcjY1XmEx4XUNGcNeqkGnoSl7VM
 Qqkjgp9+arvSvkyctSJB8hK5LfLFkjrXkHmmpB/Ua
X-Received: by 2002:a19:ae03:0:b0:50e:3292:8d with SMTP id
 f3-20020a19ae03000000b0050e3292008dmr683641lfc.67.1702885648223; 
 Sun, 17 Dec 2023 23:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7b3qReZ3peuS23jjFXb7EmYQWFeTqIj5hOIW/kRPkdZLSG729uGZD/+QA6m7XI9mxy7UKpAKY1nyqGTlpqtg=
X-Received: by 2002:a19:ae03:0:b0:50e:3292:8d with SMTP id
 f3-20020a19ae03000000b0050e3292008dmr683639lfc.67.1702885647969; 
 Sun, 17 Dec 2023 23:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20231215183121.57632-1-pvorel@suse.cz>
 <20231215183121.57632-2-pvorel@suse.cz>
In-Reply-To: <20231215183121.57632-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 15:47:16 +0800
Message-ID: <CAEemH2eCGdvp1SZw-aUHpuxsRT+TyPMmAkqq_mgt1BshT5dgSg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] fsx-linux: Add .max_runtime = 60
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

For patch set:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
