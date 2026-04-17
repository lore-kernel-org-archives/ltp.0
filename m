Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6983F8E498
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776385855; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dOQLE99ND1Zapg3A96em3dYQtXSeLy2YWNgjnFRGEvU=;
 b=YsuIVNqDlD/VteUfKNiWHJiwcL/tsFS7uRzx5IotSDQV4DpaLbqvqUDS7eOtkc5GujoM6
 QUkPvyLjzPBTWBpVbc5OBlOtEG4Kcx9DU2aue7sxA55B0Tc09OjPQrVTmCb4Mn149J1fhyE
 /F3WfCnXRe7nqJraHihBHC/+7AMmy6w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225493E4923
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 02:30:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A1F93C1C92
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:30:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CD306006F0
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776385828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LiPex3uJMen8JfjsEroE+VTWxMHfIMbMHlWPzmWXPhg=;
 b=VRnHE9vyVmgDBdaqQmGH/gXvQO8gI0sySkorpbFtZi27v6VbCo8ND1BEPOa2jmS1nMkgCw
 mkjxJlYwq69QVMl9VwhuzsnU1cVFC/aGs2f3qH8tjW83wucRDlPDy5Oa76VD235tnaRO18
 uJL4fljVld8ZOdV8bYuOZwEAcmpqs5c=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-toJ-2avuNi6AyWvshcaiIw-1; Thu, 16 Apr 2026 20:30:26 -0400
X-MC-Unique: toJ-2avuNi6AyWvshcaiIw-1
X-Mimecast-MFC-AGG-ID: toJ-2avuNi6AyWvshcaiIw_1776385826
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2d3a617ad90so750078eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 17:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776385825; x=1776990625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiPex3uJMen8JfjsEroE+VTWxMHfIMbMHlWPzmWXPhg=;
 b=XBniS3ZI3A6ZzkBUcH6ubJjoN7C3TAVlF1jjnu6SGmpbJuCKdhEPzCFAmvQaDIixwN
 FadiqqZ7DcqX8px5NzKB9b+kDOrr5W2iw1NaASvWhy39LEbH9Rx4h6wIS/Jnf6TUIpNR
 Fr5YKWKX69TxUKQEq1D+lpJDmO8jOe6aOceKHT+P3z/7HYpn7Q61jUSkvr9+FBRO4HUi
 7WrTk5/0jiGHdkOu3632/Vi6RGhclLd7ZLZR2FLWbJlalo1wXSQR8FfIKQwRG3ZlEcG9
 JVX74hrzTOMWcnoaxMeHZxzXX0ZEf/voIiBwtUtSpfOyCTJMCvacm5rXsZjv/NMb4l3t
 LAxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/m66D5Wq8MGaQSPQNBcAiGbTseLpSnuGE808CD3QnFkr/BsKg7lEPyTf0oNbe9LHGasps=@lists.linux.it
X-Gm-Message-State: AOJu0YylalIEyGWK9LSKbwxGlI9QH6UU/VK6CP+BGlWfeYtB6mHupQK9
 2iukuUuyLgh/Cq3a3HPIoiGAANnM43wBlOMO5STQK83hRn1SkUkIM+NWhdjhmBfEWKXge1vZgg3
 Q9Nphmh5tZnaxgoWmo6r1wby2YiKQ9/VZ3WHH/U5nD+xRfrxauYlIBRbjNVG7XQZTfCdWfVkDdU
 DKkhkbN9Fs45r/727ID1bIV8I8XD3dI3S+ZLBWXAcJdnPGig==
X-Gm-Gg: AeBDietVqStyvyTFi4c8SPcWDss2MhZ7AOezUwUPtPdaIAALqPc/Mra10TTyBdwPmpH
 zCtaSsEY5OJqupS+EBVdQ2SbnjQee0IWS+R7wckI2U8eBDeiDMCv5QzXL3jECbJm+9SqsU5VtRf
 z1fwF/Kf9zMdwti4bfw/qPPIBioCosrgfiqH4e0cai5/h1684fDpRjp3xEgYjQ119pDXoGAspt2
 lxp0qaG+IoZkxi9
X-Received: by 2002:a05:7300:72cc:b0:2cb:8d2f:e247 with SMTP id
 5a478bee46e88-2e478839116mr273488eec.13.1776385824937; 
 Thu, 16 Apr 2026 17:30:24 -0700 (PDT)
X-Received: by 2002:a05:7300:72cc:b0:2cb:8d2f:e247 with SMTP id
 5a478bee46e88-2e478839116mr273472eec.13.1776385824445; Thu, 16 Apr 2026
 17:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416185329.GA385137@pevik>
In-Reply-To: <20260416185329.GA385137@pevik>
Date: Fri, 17 Apr 2026 08:30:11 +0800
X-Gm-Features: AQROBzCaoO1Va6PHa9yLDFf4o7Z2F5ZFoWJReRF0mNnqx3daB6bdcGNfoZp7dE4
Message-ID: <CAEemH2e0apbnxzxWtScGEiwOPeR3j-ostXe9jrjjb+yQ+AfJOg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ypKlAOtNnxJ-zo64RSnISKKDTQj5C6okf_xq6Tp4Y4_1776385826
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] OpenPOSIX: Add common entry point function for
 all tests
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

Hi Petr, Martin,

Petr Vorel <pvorel@suse.cz> wrote:

> > Add a new shared source file implementing the main() function and rename
> > the existing main() functions in test case sources to test_main(). This
> > allows adding custom debug code to all test cases at once.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Martin, thanks!
>
> Li, Jan, hopefully you don't mind. We'd prefer not having to keep rebasing.

Never mind :). Feel free to add:

Reviewed-by: Li Wang <wangli.ahau@gmail.com>


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
