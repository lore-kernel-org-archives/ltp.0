Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vge0D-0000Xf-Ou
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 17:13:17 +0000
Date: Wed, 13 Nov 2013 18:13:04 +0100
From: chrubis@suse.cz
Message-ID: <20131113171303.GC12406@rei.Home>
References: <CAARHBVt_=_LFY1zdDyi1BeZnKPdpgJbG2Jhc7JK-G9t+eO+T=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAARHBVt_=_LFY1zdDyi1BeZnKPdpgJbG2Jhc7JK-G9t+eO+T=g@mail.gmail.com>
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
> Hi,
> I'm trying your newest code. All the multicast tests fail now.
> 
> It may cause by this line:
> /opt/ltp/testcases/bin/mc_cmds: line 71: /opt/ltp/bin/gethost: No such file
> or directory
> 
> Then I found this commit:
> commit 743f2fcd5744744d649496d8f0524cf5ca7d3859
> Author: Simon Xu <xu.simon@oracle.com>
> Date:   Tue Nov 12 18:59:57 2013 +0800
> 
>     move gethost from tools to sendfile01
> 
>     Move tools/gethost.c to
>      testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
>     since sendfile01 is the only test that requires gethost.
> 
>     Signed-off-by: Simon Xu <xu.simon@oracle.com>
>     Acked-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Could you fix it? Thanks.

Ah, I've failed to cover all cases when I was greping for the gethost
usage, sorry.

It's used in a few multicast testcases as well.

The list is:

network/multicast/mc_cmds/mc_cmds
network/multicast/mc_commo/mc_commo
network/multicast/mc_member/mc_member
network/multicast/mc_opts/mc_opts

I will fix that.

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
