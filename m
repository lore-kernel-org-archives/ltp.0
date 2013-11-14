Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgyjb-0006Bt-7E
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 15:21:31 +0000
Date: Thu, 14 Nov 2013 16:21:15 +0100
From: chrubis@suse.cz
Message-ID: <20131114152115.GC15449@rei>
References: <CAARHBVt_=_LFY1zdDyi1BeZnKPdpgJbG2Jhc7JK-G9t+eO+T=g@mail.gmail.com>
	<20131113171303.GC12406@rei.Home> <20131113172944.GD12406@rei.Home>
	<CAARHBVuge7FNc2FXkLnEJttP0gjnPj4-n+MNyWaaRfMZSffTyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAARHBVuge7FNc2FXkLnEJttP0gjnPj4-n+MNyWaaRfMZSffTyw@mail.gmail.com>
Subject: Re: [LTP] LTP networking multicast test fail
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Linaro Networking <linaro-networking@linaro.org>

Hi!
> Hi Chrubis,
> This patch fix gethost missing problem, but will get this error:
> bash: mc_send: command not found
> You used absolute path for this command previously.

Ah, that is the one executed remotely, this is really badly engineered,
the way the tests execute remote programs should be more robust.

Anyway I will add back the absolute path for this one for now and push
the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
