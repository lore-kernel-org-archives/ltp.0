Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TEfNI-0001Vs-Uy
	for ltp-list@lists.sourceforge.net; Thu, 20 Sep 2012 11:56:56 +0000
Date: Tue, 16 Feb 2010 03:27:19 +0100
From: chrubis@suse.cz
Message-ID: <20100216022719.GA7902@saboteur.suse.cz>
References: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add option to limit max read bytes
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> single proc file. When this limit is reached testcase
> will continue with next file.
> 
> Reason for this new option is to allow running this testcase
> as sanity test, that doesn't need go through full content of
> files such as "pagemap" (which can take hours).

Wouldn't adding -m to the proc01 to runtest/fs make sense too?

(so we doesn't spend too much time in proc01 in defalt runs)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
