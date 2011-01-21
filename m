Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgOJX-0006AR-9E
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 21:14:35 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgOJW-0007Rq-7p
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 21:14:35 +0000
Received: by wwi18 with SMTP id 18so2183212wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 13:14:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110121213243.68c293fc@regolo>
References: <20110121213243.68c293fc@regolo>
Date: Fri, 21 Jan 2011 13:14:27 -0800
Message-ID: <AANLkTikP2kvH9kt84x1_756i2OHXdcrMLCS2DBYKW_Cu@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Remove misused variable: fixes an array
 out-of-bounds access.
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 21, 2011 at 12:32 PM, Cristian Greco <cristian@regolo.cc> wrote:
> Hi,
>
> this should fix an out-of-bounds access by removing the useless
> variable.

    snprintf would be better.
Thanks,
-Garrett

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
