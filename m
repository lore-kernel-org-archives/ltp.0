Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlIBv-00048H-VG
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 12:56:35 +0000
Date: Tue, 26 Nov 2013 13:56:06 +0100
From: chrubis@suse.cz
Message-ID: <20131126125606.GA10489@rei>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
	<1384400319-30776-7-git-send-email-vincent.hsu@linaro.org>
	<5285BEE3.5030405@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5285BEE3.5030405@casparzhang.com>
Subject: Re: [LTP] [LNG][PATCH 7/8] ltp-networking/tcp_cmds/netstat: fix
 netstat test
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net, Vincent Hsu <vincent.hsu@linaro.org>, linaro-networking@linaro.org

Hi!
> > The netstat command will return nozero on Ubuntu 12.04 even if
> > execution success.
> >
> > for example:
> > in Ubuntu
> >      $ netstat -s 1>/dev/null 2>&1 ; echo $?
> >      1
> > in CentOS
> >      $ netstat -s 1>/dev/null 2>&1 ; echo $?
> >      0
> >
> > Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
> 
> This should be a bug in netstat @ Ubuntu I guess?

Looks like a bug in Debian to me, I've looked into the source package
and traced it down to the netstat.c-assorted_changes.patch, that seems
to add ipv6 support and changes the exit(0) to exit(1) for no good
reason.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
