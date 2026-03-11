Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5499F106286C
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773229839; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gbXjZd7b8xgmwC8ph5zpyF3sKIKj6t4dLiTGfUn8xxc=;
 b=KgkhW0JNKQ0HFR6TGSCtYNL+YiI5FlbI/rfkJ4N2gjHqegzvF4qaVXiT8u8DpYMVaLysD
 ea4tMUGqA0HJk1hJ/JZwLXr/QTbZJBIJiKJfoWFjGU70f+NJy0Y0zfLTgcrE/7C32I9/Zgp
 jEJyOEQzV4eWgW3AwBncQhdRg7EWtyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD3BE3E27A7
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 12:50:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71F143C9963
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 12:50:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0913E600CD1
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 12:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773229814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XewWu0eK+PEhqungskpN8Z3OPSBOsvvACXs5qSU4bYM=;
 b=LM77lTCkXNERpiN79ECJiJPh+SvSWwVk1zT4PMr1lcO++WJj7zowiTHf4zYdf/sVCyNy+a
 MenhErTL1ThN900thuqawH4frSupnMMNPv6pAIo6hfwgpR5KhPECIxbXswIzMZbY9qZ6ip
 q4g9wLKM3HyWRfq7IXjYRAGTD9WKN5Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-vCnIR96qNJWExV3p0XT6-w-1; Wed, 11 Mar 2026 07:50:13 -0400
X-MC-Unique: vCnIR96qNJWExV3p0XT6-w-1
X-Mimecast-MFC-AGG-ID: vCnIR96qNJWExV3p0XT6-w_1773229812
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c73a4983fc0so2584621a12.3
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 04:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773229812; x=1773834612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XewWu0eK+PEhqungskpN8Z3OPSBOsvvACXs5qSU4bYM=;
 b=t9AeDgGUkWRZrExZXnNTCObcFo0stFuX5w+Hvz08Yqd26TLJ1n01zBghI3rIESgVM9
 4LLFiRhxb8Fu9G43hLs5sRsl6Qa0mQ1T8XARjj+fNxN2NDPZamqBYZGg9QgfD6BnHHwj
 gHtsShi6tnaB9eDC9l6B84c7T3wqznhER14uoAT9hx+03O6Vj98GmQd9R9bRJKeL77+C
 z/PitQctM1PvQLsbtRcgC27eUi6OToMKct+DesKyGLcFr+q2sI/TzvxI+rDLJ00dOmKh
 Lb9uX0G7hljyPloIWed5eTFksSZcHZ+0AAadNvvoQtUDsg/2QBRhI+LAEMLbVgFHYkbK
 TUOw==
X-Gm-Message-State: AOJu0Yw568blKnI3ENZzvgS9yej4MinrG+EN8TP2IQwMqxeFJIDvRx8c
 i2R60kbR0xQSkbNUBNZTgdh9WukcqdNnNJ1id4ZVC3cadY84/omP8MG6VaOuKUKU7VV2NItNkj6
 fR4JpFxTB7aVANDn3MIYFG8uZfgFEYdNaC7fosYeWcJScoZz0AG0I
X-Gm-Gg: ATEYQzyHwIiUcHfeJbRNRznWfuMk2aPSvxetiaG6VuKw2ah2yJui8vrH+M4s4or99cA
 5IXnBjCvzExzDwlu64tEJhP9LXe8rILO92YsQYRU0spT23BtW1ZgIMrCdUMnJXj+PpfrgS1lNDj
 06Ow+wb853PxI658wng0KR0qHYxC3po6SeYsxMKc6iNpWvSDcL9eHNR8L5bWPYOizwLWqq6apuk
 gZgdkEnUOKkXTQ5Kfj912V4MWn5jG46yVauzNEIRNBKXAKKrayWubkdw6JzWN+GFRBeE2KBQgsX
 EIuv3LEuJab9Tg3/aXZ3YBgn5BFFjCY8aVNLvjyTS5IoLvSOZt5GJPGTIUxlFes91HgZNWBAJfU
 tzlpsBCG8saSe33JADQ==
X-Received: by 2002:a05:6a20:729c:b0:398:bda8:d8b8 with SMTP id
 adf61e73a8af0-398c5eeba47mr2243416637.1.1773229811947; 
 Wed, 11 Mar 2026 04:50:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:729c:b0:398:bda8:d8b8 with SMTP id
 adf61e73a8af0-398c5eeba47mr2243391637.1.1773229811549; 
 Wed, 11 Mar 2026 04:50:11 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cde37ffesm2016775a12.0.2026.03.11.04.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 04:50:10 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:50:08 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <abFW8JI1H_m1NqS2@redhat.com>
References: <DGC27F1BK4VU.1MC5BNP80A236@suse.com>
 <69b14994.050a0220.a455b.bf65@mx.google.com>
 <abFUM_omuZzJuCzE@redhat.com>
MIME-Version: 1.0
In-Reply-To: <abFUM_omuZzJuCzE@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u6aZJorTadHzoeAVEFSLaw0f3N1dg0--RO9Bb43kkdI_1773229812
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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

On Wed, Mar 11, 2026 at 07:38:27PM +0800, Li Wang wrote:
> On Wed, Mar 11, 2026 at 10:53:07AM +0000, Andrea Cervesato wrote:
> > Hi!
> > 
> > > Hello everyone,
> > > 
> > > what about scheduling a new LTP meeting after the release?
> > > When's your first available date?
> > > 
> > > Kind regards,
> > > -- 
> > > Andrea Cervesato
> > > SUSE QE Automation Engineer Linux
> > > andrea.cervesato@suse.com
> > 
> > We still didn't decide a date for the LTP meeting. I was waiting for
> > more feedbacks.
> > 
> > @Li WDYT?
> 
> As long as it's my daytime, any date is fine with me. Thanks!
> (FYI: 9:00 UTC is 5pm Beijing time).

I just see Cyril prefer 10:00 and 14:00 CET, that unavalibe to me on Wed/Thur.
But if avoid Wednesday and Thursday, the time-slot works for me:).

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
