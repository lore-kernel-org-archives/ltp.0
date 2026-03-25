Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE52109C029
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774450396; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8UG4xsZtWMT2Om/uaAncH5QgXWN8hFdLsojqVn87oQo=;
 b=J4AnIRPrXaWLlpLaVWP1743BK5D6Ifj7ybdkRQkuuqGW8HX3lvBFH423ySeJBZJ8rZecF
 J8Sr0YJQ46OlOOudc19eLSIanFXhQGHR/3l2oL6MbyqeobcLN90J9oIOYhIxEWBokOQ4Vci
 DLq5aRYMMYLFuiT5037Uap1EkHVVZzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DF93E2FED
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:53:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38AFD3CC6A9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:52:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A49E6600FA2
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774450369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvmP45Q8PbLTJk5HfDdmXBsRQB8bneXMWSSAwn2PPnE=;
 b=cvYd378P2MfJxkNxalkOTWW56c8hZuWcBXUzMU/YU2vzrpDpvP3PFLT5A0t5F6U9AAgpzk
 2ls9tDAm9aBwTW9axR3CT3i0SgEpgVY1fp+EelXknYdplMk37IEOUGSLx9ta7ZO9ltJggC
 IYPAMxTGBKxXmrm6NVKgK1kebx6es9w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-W6TK21wMN5mkobmF4PXyDQ-1; Wed, 25 Mar 2026 10:52:47 -0400
X-MC-Unique: W6TK21wMN5mkobmF4PXyDQ-1
X-Mimecast-MFC-AGG-ID: W6TK21wMN5mkobmF4PXyDQ_1774450367
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b97a25a43f0so368278666b.1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774450366; x=1775055166;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvmP45Q8PbLTJk5HfDdmXBsRQB8bneXMWSSAwn2PPnE=;
 b=S5/O4Xg8tXk6wtfH/rwLhDVLszwauOcWtlxAWv/BgEYqcuCBzJOrC7e5Y1Mg00ZxD2
 1/9FavF0cMr1wQTN6FNR2zuybaWpq/U8IUgeoKrz8L5xcZzfFrlEGU2Y4f1hNFhrNn+r
 t1GeLTBIvjpXRfvM4l1T2ePbc8MZXCTGZ1wSFkPRxt1dSKvNGehXYbIsweqz/GuFhyw+
 Y3pZf2rMKaJ+xIoS9xdnguxmMaoPclYQKH+ApOYxT4Vvz25bE5/eXeCFiS7egHmf55zq
 zoQMJ49rywYJS6+I0DdiN2TJeHISuXD3CJlPfli9aT2e3HR3cI7AY7Bk0a2wJZ05YDOn
 FU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsL1zJqcd8Hz9BVTvV6B3REH9/ue15OvCF6RkfH77rkeZIcjIP9KAuz49cAHZ5VQCsDzU=@lists.linux.it
X-Gm-Message-State: AOJu0Ywp+VZe0sz4+zrjWLedJABKey6Ejrl4kutZ7vOihZLEs0GFFek1
 IEiMMpX5elfv0zfkUj9ne+y35XHWLRh/wku4oxWw3OLaI2UU0aotncSG6H8MUJnC6BOZPY69w4k
 G86iEMxLZmZs7FeOQxo7b9H1EqPW0LGHA7lJbNuZYdZz2qKhNPsDV
X-Gm-Gg: ATEYQzxZE/PlQoKATMy+91IwoPdqsnvJmModIiXASGBcEpDL4pDA4dt2WSpNzpqSbqr
 XarOr5FjoShLh2JSuMwt2tGBLCLsjZiwdpQLtMyIDd592X651faVZsEoy5eESQy+wPJw95KuZt1
 +q8vMLohFWuq8BBZWMQburC1QufNYTcCPSsgHC8kzwgSFAWNGzWi2Fytm7AGCFbkHq+9apLlLjg
 ukaPt01NyF2+BwoD8AfInmrrtSd5rYRRx29cdhni8IghpmI8+6CvE3PlovCPMfaQEU+dviwgQb6
 rbJUJZONKdZg1RV8yvq62OXPJ7eOJ4CP1g/8/t8TLMRdKOCQyVsKohbtaED8VWFwl6Ub+o9CrAO
 TD32nuyk6DGubsq+d2K/b+/+2PqzU/InbSw==
X-Received: by 2002:a17:906:fe03:b0:b98:36cd:7e18 with SMTP id
 a640c23a62f3a-b9a5426d368mr256699266b.40.1774450366370; 
 Wed, 25 Mar 2026 07:52:46 -0700 (PDT)
X-Received: by 2002:a17:906:fe03:b0:b98:36cd:7e18 with SMTP id
 a640c23a62f3a-b9a5426d368mr256696166b.40.1774450365707; 
 Wed, 25 Mar 2026 07:52:45 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98b20c8c7bsm220504666b.63.2026.03.25.07.52.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2026 07:52:45 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:52:43 +0100
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260325145243.daqrazagomckexgj@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
 <acOs7mrlNceEtchW@yuki.lan>
 <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
 <acOxlitfqdMfAbZs@yuki.lan> <20260325135723.GA121486@pevik>
MIME-Version: 1.0
In-Reply-To: <20260325135723.GA121486@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pWgXjs4cXP036zrEOulH62CIHlCVYRraNJepuUd1c5M_1774450367
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

On  Wed  2026-03-25  14:57 , Petr Vorel wrote:
> > Hi!
> > > > > That sounds reasonable to me.  Which one would you prefer to
> > > > > keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> > > > > and dropping LTP_QUIET but no really strong preference on my
> > > > > side.  Thoughts?
> 
> > > > Maybe we can finally implement proper debug levels in LTP. E.g. hide
> > > > TINFO and TWARN messages with debug level 0 and default to debug level
> > > > 1. With debug level 2 we would show TDEBUG as well and with debug level
> > > > 3 we would show TDEBUG messages for library too.
> 
> > > That would require running valgrind tests with something like
> > > debug level -1 ;) because what LTP_REPRODUCIBLE_OUTPUT actually
> > > does is that it hides testrun specific output like e.g. testrun
> > > specific addresses, temporary file names etc.
> 
> > The LTP_REPRODUCIBLE_OUTPUT would have to stay, but the LTP_QUITE would
> > have been replaced by different debug levels.
> 
> I thought just remove LTP_QUITE and control everything with
> LTP_REPRODUCIBLE_OUTPUT.

Sounds fine, Petr.  For Valgrind testing, the functionality of
both LTP_REPRODUCIBLE_OUTPUT and LTP_QUIET is useful.  But
there's no need to control the two features independently.
Merging the functionality under one controlling env var works
perfectly fine from the Valgrind testsuite perspective.

Thanks,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
