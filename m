Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FA4EC1E84
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770284530; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PUNWK+EgyfYQM7b1DijDS47eyn2jYKF3eDgN1uIfIwg=;
 b=EPy5/qLhoC7KxkFcNbOx/rriG7C25Z2HXzVAWW8+YLSWD4Xm8MgC7v5BaxPLAxRaH5VRl
 CZk6XnpK7h5xMimYq/CDxNbg57z7zaHofOLfaZ6QxD+c35MtADd3+6RERHYqAoU36JYAOMT
 iXc6bg71zj0nBAD2aS8yKRcQ46V2BYQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653E93CE2E9
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 10:42:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9047E3CE20E
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 10:41:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C448010000E5
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 10:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770284504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4XtD3sP7Gsqi/FDcvzTOrApdfwE8R0fdGE/Xdxcrkl4=;
 b=BeEGHWJUNucBOFkKtmcJbLiO1U5gQxx4RW0xtySFv/9XRSjUd1XcvaUDUykl3VWPCKEir0
 kWeywt8P28olVjTyBPO584lraCRcZP+yVxEWM7vaTbNTeiduHb/tDkvIDVRZjli7QXKN3i
 GY9r6UdnLYcqHBmelGPjOo9IirTGa8U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-DN3NCs5sNdqbqNzm-OmrFQ-1; Thu, 05 Feb 2026 04:41:42 -0500
X-MC-Unique: DN3NCs5sNdqbqNzm-OmrFQ-1
X-Mimecast-MFC-AGG-ID: DN3NCs5sNdqbqNzm-OmrFQ_1770284502
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a8c54bbe46so18009525ad.2
 for <ltp@lists.linux.it>; Thu, 05 Feb 2026 01:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770284502; x=1770889302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XtD3sP7Gsqi/FDcvzTOrApdfwE8R0fdGE/Xdxcrkl4=;
 b=bBbYags9kNcIaKNO2zGLvVkruHyRJcE0CTbOsLLRqA7IN/S34A4JsyiLSikHtYsW8n
 U5RqxoJ7Ka1pfouRWVtxMes8aDoxojM8TcIjCVPYej4X6nRd9NnlAewlhsSrw1r8gKOX
 14bh0bLweHswpszIrc8Sa+N580mDe1wyDBhEAOwbilIdDehn6ZAzK0+PfP2bM4lhyaGn
 m8BeQazGgNqS+a/jX+z9d9F35zBx3aPH8Fl53JGlQ/PyTHnK3exaQ0WOCEhBG9zkEM/3
 v598fA1llCdo4q0CK6Nnq5uXzqYvlkNunvaF8H5wQP4pBmDD8hgryL9imDyoRzXVExur
 NSCQ==
X-Gm-Message-State: AOJu0YxczLw2CfAmTblTHrwi5rWaCF4O0ZtSlIRZF04W7qbF1hADTL/a
 iZ+19mte2WVu25wAaCzZnjtFdNQ5MN0Xfefp7sCa1sorQpyMPxn22Wif6Vx4r6dkXjv3Vzkb0tK
 5ImxdEcr8kJ8zfuMXkNk8se2Lr5YW44j67fjLpG1EiEKioKEDwadu
X-Gm-Gg: AZuq6aI0PNZkQqiEyEAWhPjj/UO5jlE4fRoIFdkkynbQFCtRb2oRSPRWfjtmLYZHLTL
 dLV9xtPxiS8pGsnHw+YlI3hmFC7cpuxEIIzVpfkbtluHrizbds3jdrfcRnUjsWPllY12uJKA1v4
 V2xgQfYufkS/wFJJThxAl0nUmjA8MFAlC/X6W+fp/Ie6XoeRnwonzeZym82cyG+zCEwA+zWPjGv
 c7Bb1D+78oJVDdB5lcPvqvOWyxLgqAFtUZFTlsxrJPfQMaAH0GpMwSUYNQMFDrUi91ewzLr6lVV
 /PoJbkea4QHdtC1ZUbNAKGs5op4K0K2x0Y7tFc1ZEXX7hlGQK2tXZLsSx29NLrFwiV82ipf1MtI
 j0QF7
X-Received: by 2002:a17:903:1a27:b0:2a9:3225:1e48 with SMTP id
 d9443c01a7336-2a933fe880emr56393705ad.48.1770284501682; 
 Thu, 05 Feb 2026 01:41:41 -0800 (PST)
X-Received: by 2002:a17:903:1a27:b0:2a9:3225:1e48 with SMTP id
 d9443c01a7336-2a933fe880emr56393535ad.48.1770284501336; 
 Thu, 05 Feb 2026 01:41:41 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93397ef6fsm49994215ad.95.2026.02.05.01.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 01:41:40 -0800 (PST)
Date: Thu, 5 Feb 2026 17:41:38 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYRl0mUYv1aYLlyC@redhat.com>
References: <20260204124323.244578-1-pvorel@suse.cz>
 <aYQz6gN7WvJbSg1k@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aYQz6gN7WvJbSg1k@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CCRYioiukNsiDG2Kc0OEjyQOz-dhkcAYaCHr9LafucA_1770284502
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openat2: Move includes to lapi, remove _GNU_SOURCE
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

On Thu, Feb 05, 2026 at 02:08:42PM +0800, Li Wang wrote:
> On Wed, Feb 04, 2026 at 01:43:23PM +0100, Petr Vorel wrote:
> > Improve 767b3e519e. struct open_how is also used in lapi/openat2.h,
> > which is used by all openat2*.c tests.  Therefore move <fcntl.h> to the
> > lapi header (and use lapi/fcntl.h instead).
> > 
> > Also remove _GNU_SOURCE which should not be needed.
> > 
> > While at it, move include "config.h" to the top.
> > 
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Li,
> > 
> > my points from the original patchset why not use _GNU_SOURCE:
> > 
> > glibc test tst-openat2.c [1] which includes <fcntl.h>, uses struct
> 
> Interesting, I haven't figure out why it can be built within glibc itself.

I think that becuase it uses '-D_GNU_SOURCE' cflags has already globally
enabled the GNU extension (equivalent to '#define _GNU_SOURCE'), which is
done uniformly by glibc's build system.

 glibc/Makerules: ALL_BUILD_CFLAGS = $(BUILD_CFLAGS) $(BUILD_CPPFLAGS) -D_GNU_SOURCE \
			-DIS_IN_build -include $(common-objpfx)config.h

To verify this, when I add the '-D_GNU_SOURCE' cflgs in the LTP/openat20*.c
compliation, it build succeed as well:

 # gcc -I../../../../include -I../../../../include \
   -I../../../../include/old/ -Wformat -Werror=format-security \
   -Werror=implicit-function-declaration -Werror=return-type -fno-common \
   -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition \
   -D_GNU_SOURCE \
   -std=gnu99 -L../../../../lib openat202.c  -lltp -o openat202

So, to this patch, we need to add the _GNU_SOURCE definition.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
