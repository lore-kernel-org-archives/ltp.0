Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96400F8A16E
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776343195; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qaouHPOn0EX4nKLhketYZAffQFfFOx1Y8pZ93kDKflg=;
 b=dbTig0E78ALNkxXZ1E9SPl29fdwXLMSEfmrEOF+A0MFViL2K8rDayOCyYmb9zRLipT6t8
 gz0rfou+JfdEV39LED2vidgWg1jUWwH4vJv+T4EZBv9auY/x60uXP/7W7QD/VSKzyLMsvtg
 XNe/4nbHm2nM2ngGCiBA2WwgiuxoTpY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6DF13E2638
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:39:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323593C1E06
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:39:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9BC021400425
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776343168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DaWqQ48wN7QhtHRKl6kWvik41UG+L5WmsfpUGCewtWY=;
 b=dEtE7GcdTwO+LbqvzfLSH97alRMJQ5fabNVUR6gNhRcJTRZ60sS3ZOGtU+ObCcQCFzW43G
 fNOqMtdFh3EzvVWEFH2sKHnCg2pwtYMiA9uxxpEWcsaXZ6qA7qLBpdNV098ClSoHKChdKs
 6wRGCy8sb8f18JSqf9N99eL4DQU2/RY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-J2LJ0TolObO7bQerv6Angw-1; Thu, 16 Apr 2026 08:39:27 -0400
X-MC-Unique: J2LJ0TolObO7bQerv6Angw-1
X-Mimecast-MFC-AGG-ID: J2LJ0TolObO7bQerv6Angw_1776343166
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cfb72377bso6871325f8f.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 05:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776343166; x=1776947966;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaWqQ48wN7QhtHRKl6kWvik41UG+L5WmsfpUGCewtWY=;
 b=ZR5QPwqwuo9eaDxzVNdOukvJ261+7qVCV2B0xi0Tbj26UOghj/Mn4YWTw5t3iRbLHt
 fEqdFnq9tZVuKpDJ2D52Pb1hYBz8efxpkxeYPVlWtY6Qots+BZKP2t76/CuO3jf+JFzV
 SD1j/cvIlOfMnyrH352W13wKbzsirdKk9USSmXlW8dE/CM46M+AnFUPbMugY3NuD4swL
 wajy4X5GOV1tCVlCHjWjS2WVTVAcipeiWXvXHZnwOAHoCn1ZN2XX4FPx7W85tuzzjpEs
 kkyj6FLLZ9LpZuDqRre9Gg9B/+7x4NNkkLqg6r5eZ8L/EhGXIB8WS5GIRxjeqxLYGRG2
 V6KA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tpuUd9StcdsKccUyTfk1bTZRKvUw0+h5FSePFh7f0d7CEf8059QexjmGSRmOWLOVQgOQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzaFcWlaFLK46FuKV7YrS2dZen1/AicZutgAcqCXfQM/gaU8nTd
 0zp84r4dzsKr/i8VY/IIvXGZ1131gmBhj5b+VZRnzOxJvJgIm9UuaLfChH+hvYY/aHQIhiZBj4Y
 xu6A2GEk4jLG3kaR3TwaZ1ld9gW11TRrm86nxOR6jTjsL9og/XkqM1WBjt3a5
X-Gm-Gg: AeBDiethg/joohMJ9kpYFmwVHpx61K8aqv+yMvTGTy2DFfarANKEDg4kN8QkQEFGiFl
 x/6DEX2Ydd1NGSiVK4TNtemii9H87t2nteYPp0p930u/PGJ024J70fug3nXd5m8NSmj8ZNyTN9e
 dfawjYfrC+QpUCi/s2KllPJPsINrSsI4k4cQRTslzqmdlarpXj9uxwFYhzOVJVcXPxJloSzWC1G
 LBpQqg04fVCXnNH2ifoWl3J3ztK5wyX2DSVGR+hERoaV3FskYF6VivpAnLMOxZOwoCVQwQJXqF9
 V17y5tebsgHl9HwE+kBdeXuR5DZ38UZHdf1trk5k6V61pimnTibMMNJwAdUoC0Jdy0XQKh/qGL7
 lAb7f1g2LTCcxg5YglcnHISfgL/fz9DVuzg==
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id
 ffacd0b85a97d-43d642b6a47mr42546110f8f.29.1776343166125; 
 Thu, 16 Apr 2026 05:39:26 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id
 ffacd0b85a97d-43d642b6a47mr42546055f8f.29.1776343165491; 
 Thu, 16 Apr 2026 05:39:25 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d6d3sm13734526f8f.8.2026.04.16.05.39.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2026 05:39:25 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:39:23 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260416123923.3xxfhyxztcw2rqth@lida.tpb.lab.eng.brq.redhat.com>
References: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
 <ad9l7MeJneX1LdCe@yuki.lan>
 <20260416092131.kkbfd3cdi3tv7z7l@lida.tpb.lab.eng.brq.redhat.com>
 <aeC01nkaA2jzhUVV@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aeC01nkaA2jzhUVV@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lIau2chaz2jkP_3sRwZVLP8QWLime0U2NTgGtEoRoo4_1776343166
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid syscall param ioctl(generic) points to
 uninitialised byte(s)
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

On  Thu  2026-04-16  12:07 , Cyril Hrubis wrote:
> Hi!
> > > > diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > > index 7368d3863..d24766e7c 100644
> > > > --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > > +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > > @@ -92,8 +92,8 @@ static void *handle_thread(void)
> > > >  static void run(unsigned int i)
> > > >  {
> > > >  	pthread_t thr;
> > > > -	struct uffdio_api uffdio_api = {};
> > > > -	struct uffdio_register uffdio_register;
> > > > +	struct uffdio_api uffdio_api = {0, };
> > > > +	struct uffdio_register uffdio_register = {0, };
> > > 
> > > Given that we were using = {}; in the code before can we keep using that
> > > and for all instances?
> > 
> > I saw both initializers in the LTP source, see `$ grep -rIn  '= {};'` and
> > `$ grep -rIn  '= { 0, };'`.  The latter one is compliant with older standards.
> > But to keep the coding style within this file, I've updated the initializer.
> > 
> > > Also I assume the problem is the ioctls field in the uffdio_api
> > > structure that is not initialized beacuse is supposed to be set by
> > > kernel before returning into userspace. Should valgrind warn about such
> > > cases?
> > 
> > You are right that zeroing just this uffdio_register.ioctls = 0; is suffi-
> > cient to to avoid the valgrind complaint.  Zeroing whole the struct seems
> > syntactically more concise and also correct.
> 
> That's not what I was trying to point out. Some fields of structures
> passed to ioctls are output-only. The question is if valgrind should
> warn if we do not set output only field in such structure?

You are very right.  Curent version of valgrind doesn't recognize
UFFDIO_REGISTER, and treats this ioctl as unknown ioctl via
ML_(PRE_unknown_ioctl)(tid, ARG2, ARG3);  Good point, thanks!

Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
