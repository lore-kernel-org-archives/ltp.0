Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgdWz-00079j-3H
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 14:34:01 +0000
Date: Fri, 30 Dec 2011 15:44:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111230144427.GB29431@saboteur.suse.cz>
References: <82BEC95A68153C46932D3E196B922B7217E79C0E0A@BLRKECMBX07.ad.infosys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82BEC95A68153C46932D3E196B922B7217E79C0E0A@BLRKECMBX07.ad.infosys.com>
Subject: Re: [LTP] LTP on IMX53 QSB Board
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
To: Pramod Gajula <pramod_gajula@infosys.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Problem:
> I have mounted rootfs folder and /opt/ltp folder onto the target board and executed this command
> 
> ?  ./ltp-pan  -a $$  -n $$  ../testcases/bin/access01
> Error: "Could not open zoo as "2165", errno:13 Permission denied"
> (Permission is denied to even create a file.)
> Suggestions are welcomed to overcome this issue.
> Thanks.

It's trying to create file to log what tests are running, see
pan/zoolib.c.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
