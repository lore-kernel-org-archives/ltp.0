Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M9gS8-00061V-To
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 14:19:28 +0000
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id F2FFA90847
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 May 2009 16:19:21 +0200 (CEST)
Date: Thu, 28 May 2009 16:19:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090528141921.GB23822@schrodinger.suse.cz>
References: <20090528141453.GA23822@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090528141453.GA23822@schrodinger.suse.cz>
Subject: Re: [LTP] [PATCH] postponing close() after aio_write() has	finished
	II and cleanups
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Again forgotten to add:

Signed-off-by: Cyril Hrubis chrubis@suse.cz


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
