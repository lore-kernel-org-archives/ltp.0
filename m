Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJA7i-0006s1-8b
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 19:26:22 +0000
Date: Thu, 18 Nov 2010 20:38:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118193811.GE19296@saboteur.suse.cz>
References: <AANLkTi=4D4yhyXoH4XWvi9NWjrZS9gaDeW+YcedHb5Mp@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=4D4yhyXoH4XWvi9NWjrZS9gaDeW+YcedHb5Mp@mail.gmail.com>
Subject: Re: [LTP] realtime test use of hostname with busybox
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi all,
> 
> Another one... The realtime test script :
>    testcases/realtime/scripts/setenv.sh
> 
> uses "hostname --short" which isn't supported by busybox. "hostname
> -s" is supported but gives "hostname: unknown host". Given that every
> other script uses "hostname" as-is I reckon it would be reasonable to
> match that usage in this script too?
> 

On linux "hostname --short" is equivalent to "hostname" at least on
linuxes I have here. So IMHO this is safe for linux only realtime tests.

Please send patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
