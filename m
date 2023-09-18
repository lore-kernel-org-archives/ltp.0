Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A15CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:45:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B95913CE4F7
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:45:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8491A3C9D45
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:45:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4EAD1002049
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:45:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A0D8E219BC;
 Mon, 18 Sep 2023 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695030309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jL0iHTXCunHYvZlTo6TT+c2y92a1Cvy8GBIa12NU+iU=;
 b=wSmNtelqxzlGD0BLRKAQmm+jQEkG6vTST5rfieps5dNM0WUP427dWgGAU07an2mS9RxlAa
 GLEoUyfGGS1CF09dDV4nBayZKJbCqbb8dGNJG26fX7Q1LtP9AMNSxvMYWOCTf7zCiYPG0R
 onibDql3ImbC5FEc7D7EGhSxmuTU5dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695030309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jL0iHTXCunHYvZlTo6TT+c2y92a1Cvy8GBIa12NU+iU=;
 b=5NZU11UxT0+mXkJg4D3BqrN3yIXXV7ePKSk6rLcz0sMo5wi5wViiCNc42IbFl+4w4PMG+h
 iT0t/tX+u29VLPBg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4B5722C14B;
 Mon, 18 Sep 2023 09:45:09 +0000 (UTC)
References: <20221107191136.18048-1-pvorel@suse.cz>
 <20221107191136.18048-2-pvorel@suse.cz>
 <CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com>
 <Y3s+Czg8sBsGYO+1@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Sep 2023 10:38:45 +0100
Organization: Linux Private Site
In-reply-to: <Y3s+Czg8sBsGYO+1@pevik>
Message-ID: <87a5tjhl24.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Workaround division by 0 on vfat
 on ppc64le
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Li,
>
>> Hi Petr,
>
>> On Tue, Nov 8, 2022 at 3:12 AM Petr Vorel <pvorel@suse.cz> wrote:
>
>> > Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
>> > on ppc64le on stable kernels, where mem_used_total is often 0.
>
>> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> > ---
>> >  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
>> >  1 file changed, 25 insertions(+), 2 deletions(-)
>
>> > diff --git a/testcases/kernel/device-drivers/zram/zram01.sh
>> > b/testcases/kernel/device-drivers/zram/zram01.sh
>> > index 58d233f91..76a8ccab4 100755
>> > --- a/testcases/kernel/device-drivers/zram/zram01.sh
>> > +++ b/testcases/kernel/device-drivers/zram/zram01.sh
>> > @@ -105,6 +105,26 @@ zram_mount()
>> >         tst_res TPASS "mount of zram device(s) succeeded"
>> >  }
>
>> > +read_mem_used_total()
>> > +{
>> > +       echo $(awk '{print $3}' $1)
>> > +}
>> > +
>> > +# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
>> > +loop_read_mem_used_total()
>
>
>> This is not a looping function to check if mem_used_total is equal to zero,
>> the loop part is by means of the TST_RETRY_FUNC macro.
> Thanks for your review!
>
>> So, I'd suggest renaming it to check_read_mem_used_total().
> Agree. Unfortunately even this didn't help on ppc64le system where I was able to
> reproduce it, thus probably not worth to merge.
>
> Unfortunately later I was not able to reproduce the problem any more, I'll try
> it more this week.

I'd like to get this merged and if anyone still see's a failure, then
perhaps there really is a kernel bug or else we have to accept it is
zero sometimes.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

>
> Kind regards,
> Petr
>
>> Reviewed-by: Li Wang <liwang@redhat.com>
>
>
>
>> > +{
>> > +       local file="$1"
>> > +       local mem_used_total
>> > +
>> > +       tst_res TINFO "$file"
>> > +       cat $file >&2
>> > +
>> > +       mem_used_total=$(read_mem_used_total $file)
>> > +       [ "$mem_used_total" -eq 0 ] && return 1
>> > +
>> > +       return 0
>> > +}
>> > +
>> >  zram_fill_fs()
>> >  {
>> >         local mem_used_total
>> > @@ -133,9 +153,12 @@ zram_fill_fs()
>> >                         continue
>> >                 fi
>
>> > -               mem_used_total=`awk '{print $3}'
>> > "/sys/block/zram$i/mm_stat"`
>> > +               TST_RETRY_FUNC "loop_read_mem_used_total
>> > /sys/block/zram$i/mm_stat" 0
>> > +               mem_used_total=$(read_mem_used_total
>> > /sys/block/zram$i/mm_stat)
>> > +               tst_res TINFO "mem_used_total: $mem_used_total"
>> > +
>> >                 v=$((100 * 1024 * $b / $mem_used_total))
>> > -               r=`echo "scale=2; $v / 100 " | bc`
>> > +               r=$(echo "scale=2; $v / 100 " | bc)
>
>> >                 if [ "$v" -lt 100 ]; then
>> >                         tst_res TFAIL "compression ratio: $r:1"
>> > --
>> > 2.38.0
>
>
>> > --
>> > Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
