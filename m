Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WGWNV-0005Uj-Rt
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 16:21:37 +0000
Date: Thu, 20 Feb 2014 17:21:25 +0100
From: chrubis@suse.cz
Message-ID: <20140220162125.GA9474@rei>
References: <CA+icZUW10VjLz6V+yXwVHCaY6cMP2CJVowaGzsvt=+qrvG-G=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUW10VjLz6V+yXwVHCaY6cMP2CJVowaGzsvt=+qrvG-G=g@mail.gmail.com>
Subject: Re: [LTP] runltp-lite: Creates no logs below results-dir
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> congrats to ltp-full-20140115!
> 
> Recently, I have tested it with Linux v3.13-rc8+ (IPC-syscalls and runltp-lite)
> 
>   $ ./runltp -f syscalls-ipc
> 
>   $ ./runltplite.sh
> 
> The 1st result-log is attached.
> Is it possible that runltp-lite also saves its output to results-dir?

It is, but given nobody responded so far, you will have to fix it
yourself. And as usuall patches are welcome ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
