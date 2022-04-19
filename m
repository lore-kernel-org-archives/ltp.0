Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDEFC433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 08:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A233C3C0305
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 10:08:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41CA03C0305
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:08:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0486260070E
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650355688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjgYXESIxIQ4C6tv3ds0z9Hq+9zXQYjSQUpJNMbdj3c=;
 b=EfZJSjH78n8IXhiifEiLngpRHhiLmbcxOMguhGynRMQenjUl0UTv1O/cI2IezJBK8He0k5
 smFnP52s3gfR0/V7yUst/XWCyZlIEZohdxXaPBkIhiuFrSW8FE2SWKOrZYfOpkDnJ1YeRy
 7F5jPsfPin5NGdBFCp1JDndhFFahUu4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-bBbQ4JNjNSCmuUPh6FnfzQ-1; Tue, 19 Apr 2022 04:08:07 -0400
X-MC-Unique: bBbQ4JNjNSCmuUPh6FnfzQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 y22-20020a2e3216000000b0024dba34425fso1511609ljy.8
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 01:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjgYXESIxIQ4C6tv3ds0z9Hq+9zXQYjSQUpJNMbdj3c=;
 b=WVJjmyvkUToFHufMInu6JjaUfaH5au1LjnpfuZNyqJo4NeFVTHTLcaNNkSGkdJytJo
 HkWD6CjBaulZub9/6wIsAfBmy8RWX9s2LBSFZnxitrpdAIhewg6rg12Ygjf38tbzJ0xb
 VGlqFE6PqHPe130N3tTkdDrslmrX/FRQC42vQMqECje4+iuZ6BOGcHH4E1G64T5rNh2B
 rKxS1xnkvi/Sa1mryA0UFg/A/06UqOzXRUY4wiYeOExptzcbiXX//7YI+8k8OwlUeJ2J
 fG86LJR6hF3qQCz8Fw8JGrEkfYNjKftGmlo/WNzrr5aYJU7DBBm/To/bxNSX4K0RlSRy
 Q+wg==
X-Gm-Message-State: AOAM532ryqs1C9KlfwosAJK/0fDhy/Pw0l4M4NnBW1cmskhM3vvKCvPB
 ve2vaIDQO7lHpUoMMTy6BTd5vDLSXvoWk83Gp7/ZRpAF8QIH67t9vV1iTy0bSbNALZIeR4e6nRl
 z8H/NxEmNOyZ4oxNkWDFi0Otzjpc=
X-Received: by 2002:a2e:5cc1:0:b0:24b:112f:9b36 with SMTP id
 q184-20020a2e5cc1000000b0024b112f9b36mr9694647ljb.337.1650355685769; 
 Tue, 19 Apr 2022 01:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP38Uci+WK8K53FbmzH2YRNjPyCkfyqPfMJs74oexh67mVJWpU4zmtbXBHGShU5qSZ0etvyAh+LCnNGT0q4dY=
X-Received: by 2002:a2e:5cc1:0:b0:24b:112f:9b36 with SMTP id
 q184-20020a2e5cc1000000b0024b112f9b36mr9694638ljb.337.1650355685567; Tue, 19
 Apr 2022 01:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220310105533.3012-1-chrubis@suse.cz>
In-Reply-To: <20220310105533.3012-1-chrubis@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Apr 2022 10:07:48 +0200
Message-ID: <CAASaF6xA9UizsYwy0qpjFM9Ttk3apXurgByjoEOnozXBoQw0cw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 10, 2022 at 11:53 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> While integer division by zero does trap on x86_64 and causes the SIGFPE
> signal to be delivered it's not the case on all architecutes.

With gcc version 12.0.1 I don't get SIGFPE even on x86:
int main(void)
{
        volatile int a, zero = 0;
        a = 1 / zero;
}

   0x0000000000401020 <+0>:     movl   $0x0,-0x4(%rsp)
   0x0000000000401028 <+8>:     mov    -0x4(%rsp),%eax
   0x000000000040102c <+12>:    lea    0x1(%rax),%edx
   0x000000000040102f <+15>:    cmp    $0x2,%edx
   0x0000000000401032 <+18>:    mov    $0x0,%edx
   0x0000000000401037 <+23>:    cmova  %edx,%eax
   0x000000000040103a <+26>:    mov    %eax,-0x8(%rsp)
   0x000000000040103e <+30>:    xor    %eax,%eax
   0x0000000000401040 <+32>:    ret

It does trigger with a small modification:

@@ -25,9 +25,9 @@ static void run(void)

        pidchild = SAFE_FORK();
        if (!pidchild) {
-               volatile int a, zero = 0;
+               volatile int a = 1, zero = 0;

-               a = 1 / zero;
+               a = a / zero;
                exit(a);
        }


> At least
> on ARM and PPC64LE division by zero simply returns undefined result
> instead.
>
> This patch adds raise(SIGFPE) at the end of the child as a fallback to
> make sure the process is killed with the right signal on all
> architectures.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> index 869ef18bd..8c351d120 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -28,7 +28,10 @@ static void run(void)
>                 volatile int a, zero = 0;
>
>                 a = 1 / zero;
> -               exit(a);
> +
> +               tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");
> +
> +               raise(SIGFPE);

I agree with Petr, that raise(SIGFPE) would be sufficient for this test.

>         }
>
>         TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
> --
> 2.34.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
