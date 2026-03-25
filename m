Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9725FEA835
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774430550; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ivq326o2YIQHRMe2DxAXyrJaZEX64V41Uqbm6vD9ifA=;
 b=lm1tla6rkvLEjikC8zfFY3MIAz3OnIurXRhyjddKu9WEimITXYpaucLOph0SbiahbeMhP
 Yqgzo3vkURNqI+aAOi4sKZHxVTCirQv1oBjN5NGdu3qM8KAVEjH9DASAHcQB8xbwn55B440
 A65yVenlUorjdGjC7HAJN4Zl7OQkbKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ED943E26EC
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:22:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BDC53CC6A9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:22:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2CB0600D72
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774430524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Q2BaPMOcot7u5YXITZhj3iLKnVoeS6qBOfNBrv2beM=;
 b=ZF+XplZp5DMn+2V1bgLO7Mbeg6dQN3hEAodAGBRIERdpyEfhKuy1GQMOJ7Sp13NZ1Rf+hI
 5wwmhG+Hhxlsd9nddypMmnd6jeoz+3RT0i8d1dkogrqBVAVoKWb5P3sJEBSFpquBD1Axlh
 xpBn1y4Sa37L/Lva4TEi4JUqR9k69y4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tCrQTScONXK38CaDnqeNtQ-1; Wed, 25 Mar 2026 05:22:00 -0400
X-MC-Unique: tCrQTScONXK38CaDnqeNtQ-1
X-Mimecast-MFC-AGG-ID: tCrQTScONXK38CaDnqeNtQ_1774430519
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so19002425e9.1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 02:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774430519; x=1775035319;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Q2BaPMOcot7u5YXITZhj3iLKnVoeS6qBOfNBrv2beM=;
 b=CROiUV19qhexTpxWP+1PcsyUvRlrN6f3I3c95fS8Xz/cipC47Gqad/ebu7F3CJMtzA
 EWOfOxIwN2l477VZaxhZaiwBKHIMAg0sOoM1Ei+IQtt4/UTv9pa9MYJodhQbjK1N3lEK
 CAHCVPkO1e6g6sW7GVd5r3agzaFONSWTqWm0fL+Feca+q0KJKPWM7twGf5C/6XoXEljz
 K4fvG079az0palmUVcIsitMx43gyP+X3hGam0vI8D47mfLprHtHcrV5uJWDzY2RQqgr0
 AEI1x5xSYas6Ru+5qGRGo23clCU3PMdZctHH+Nn5OpqakEAJLg7nLZ7bXbWuiJZolHdX
 ofbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN5mR206ohhTQFxzQeTdT4yHBoT43uIFPJF408qGC2PanNlW5N3NqwqLXuYaZ6IYBNij4=@lists.linux.it
X-Gm-Message-State: AOJu0YyiLn4tDlGiS9jwCFbeEMv9/TDQ7xV6IKJah0+k/QdIQoJ8cylY
 fsKJVwzjGI9+5+RtIW5QLLEA2MQUZC1l9syaVgEgioipQwOrc/PQhV/gY9y7XhUQCafaVE4LA5f
 lJLdpqZwkOBneEnc2TmzK7BUADpBsV7Hn1Zuh6vyNdDqdnLR0neZB
X-Gm-Gg: ATEYQzzD885V0Izf6iLMHbu2B6WkcW797aWiDP/Q1+b5jRE884wKRGwUYNQDN62KVjr
 D7lB3qtNl9eg/h2mfx4k9khGnEXyn99EgM2BGb+pKGRWBnNyxA4fNXAeHB968eINXh23A9oZvib
 vbBur2Jn6RmvEBN8JqKDDYeSDdXf1t4n/AR+tmk7YBO7m74XzJULYczmoN0Q0u5W41Ws8TEvPoh
 dRl+SEqO6RJyif9ax0eOQ1AsFj+/gPTQVafdtBM6GQuNYc4l1X2CEasDVwCuy7d4aiTPMejKgmc
 FnWO4zVxrrGJatLjNuOW6zCZKJpHZFkgWVz1Nel+OR7TtS2pyVphD7svHmUzGrN7SseSywhCevU
 6XzTua6CQY8FN5Z+J7IAOcypNsH4rwHbbug==
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-487160aa232mr38402455e9.31.1774430519279; 
 Wed, 25 Mar 2026 02:21:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-487160aa232mr38402195e9.31.1774430518768; 
 Wed, 25 Mar 2026 02:21:58 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116f17f3sm110020065e9.1.2026.03.25.02.21.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:21:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:21:56 +0100
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
MIME-Version: 1.0
In-Reply-To: <20260325091003.GA86256@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A43ZYur8ZQnwZn_YwMsU6Xj_Hh74LLqCz58PG7v0fMo_1774430519
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Wed  2026-03-25  10:10 , Petr Vorel wrote:
> > On  Tue  2026-03-24  15:09 , Martin Cermak wrote:
> > > On  Tue  2026-03-24  14:18 , Cyril Hrubis wrote:
> > > > Hi!
> > > > > LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> > > > > help valgrind to use LTP for testing. It discards the actual content of
> > > > > the messages printed by the test (removes everything after printing
> > > > > TINFO/TPASS/TFAIL/...  flag).
> 
> > > > > Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> > > > > TINFO, and TDEBUG messages. Therefore LTP_REPRODUCIBLE_OUTPUT=1 is not
> > > > > needed any more.
> 
> > > > I do not think so. We still have things like pids and timestamps in
> > > > TPASS/TFAIL messages that needs to be removed in order for the output to
> > > > be reproducible.
> 
> > > From Valgrind persp, seems like we could drop it at the first
> > > glance.  But let me confirm that based on a thorough check.
> 
> > My quick guess above was wrong.  We do need
> > LTP_REPRODUCIBLE_OUTPUT for Valgrind testing.
> > Please keep it.
> 
> Thanks for info, Martin. Sure, please drop this patch.
> 
> I still feel these 2 variables somehow overlap, wouldn't it make sense to merge
> the functionality into a single variable?

That sounds reasonable to me.  Which one would you prefer to
keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
and dropping LTP_QUIET but no really strong preference on my
side.  Thoughts?

Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
