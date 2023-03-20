Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD893C7618A
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 16:05:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6FBC3CD366
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 17:05:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1539E3C8A8F
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 17:05:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18115600726
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 17:05:26 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31DBE3F0A2
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1679328325;
 bh=7ceXES5lFZEtj6TmgvXgLl3bdj1BHggKeu0jEs2Tx98=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Mhlpj0Aphs9ZkpEz7CCH3plwTdrWV+ywvbXA1kU+IgVpzg5oN6TJuAPrMvcvm7Fop
 R9c4UkUBRMU5JaaeUqejjmYBLrWIatcmmRJTRJ70p5xuewNCzMZ8fTRncClaek6VEI
 iAAW+hFm6e4q3p1WqR7fP1x5ZOhluUHcSwAvAhXWstAs5UKjifVCNgplbeoGFQVuE8
 o5OcCJ4LV0cS6O+/VAWIZ2vR/+FJNMJb3+T8VnD7/qnQ9w8XqLqvqZk1nCy34MURLB
 UrFuTgjQMTxoJSgmm8bFf+/D5+mgZYAoxHLgEPNM9xHHSHa7DPAptRszwK6m+GxH3H
 t2+wa4A9k1GOw==
Received: by mail-pj1-f71.google.com with SMTP id
 o10-20020a17090ac08a00b0023f3196fa6fso4469908pjs.2
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679328324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ceXES5lFZEtj6TmgvXgLl3bdj1BHggKeu0jEs2Tx98=;
 b=ANbp1CZNwIUVgSWPMYDSjweuSI//5GDPle1kmGwkymeZHLyiFDSdbZjGcYYWrRf2aj
 2T96u7ILDbI9YVxbtrV5ECwjvklrstuj/QMKSI3IqrJNWEz7TJI4UWFTGms6M7RreC3q
 7skoPxxxSgpmxB31puuOU0R7QffJJQTi5tI7orIbbQLcb0AeVcVbFV6n7mwCVhgYjnWD
 fBDDrKeFZRwLnh/mfWNffOEBEcP/oSMNuRa9nlKiiNtf9TH9b8UH3Y2kADfU9uypAK4e
 l59dyLOQtFpdp0U55r3AUfx5eZsVeXDv9AhbM19p+rF56h9gBRWuHAIWkDB7xbZx7hgW
 hDKA==
X-Gm-Message-State: AO0yUKX4T8my4ER9yQXE7R+/kpyedfDIvrZKLmEcN51mEDXvWkIDl7sM
 +slLX4eNDPKAi7dFlS+z49mVqD/f7i/inhausGOid9a1VPjbqu3Ve9dv2qPJTLZhd9piY0JZuZn
 fvSOi8K3gkfkCft+VtjPVapT36uL4Rt6oM9sXDigqOY27
X-Received: by 2002:a17:902:d2c7:b0:1a0:4664:319c with SMTP id
 n7-20020a170902d2c700b001a04664319cmr7455743plc.6.1679328323719; 
 Mon, 20 Mar 2023 09:05:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8lnMEuBi9OJ8TiZ8x3jVDh57ZPTJ9thNUYNST3wduSkYHdkPxWmtf2z8ivXNM2UO6alJIXW9PylnoRql8VAQM=
X-Received: by 2002:a17:902:d2c7:b0:1a0:4664:319c with SMTP id
 n7-20020a170902d2c700b001a04664319cmr7455735plc.6.1679328323308; Mon, 20 Mar
 2023 09:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik> <Y/N53BN2yr7WEIzr@qwirkle>
 <20230308165545.GA428998@pevik>
 <ZAoIT1NunhWyuIUR@qwirkle> <20230320075120.GA179606@pevik>
In-Reply-To: <20230320075120.GA179606@pevik>
From: Andrei Gherzan <andrei.gherzan@canonical.com>
Date: Mon, 20 Mar 2023 16:04:47 +0000
Message-ID: <CANZOvF30NNwhYhWuzvcgbHdP1skrZyo2w0V+jbNuvYM9+wCAYw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+
 machine
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

Thanks for the heads up.

On Mon, 20 Mar 2023 at 07:51, Petr Vorel <pvorel@suse.cz> wrote:

> Hi Andrei, Richie,
>
> merged with proposed fixes.
> I'm sorry it took me some time to get back to this.
>
> Kind regards,
> Petr
>


-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
