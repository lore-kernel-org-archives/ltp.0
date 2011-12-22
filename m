Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdfU2-0004tK-Q8
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 10:02:42 +0000
Date: Thu, 22 Dec 2011 11:12:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222101221.GC26303@saboteur.suse.cz>
References: <611ED426031E9E48A80D02BED70BC810570E4F83@ALA-MBA.corp.ad.wrs.com>
	<4EF2C511.2000605@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EF2C511.2000605@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: "Shang, YanFeng" <YanFeng.Shang@windriver.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > 
> > I think using cat /proc/cpuinfo get core number is better.
> 
> 
> But /proc/cpuinfo may not be supported by other OS.

Yes, procfs is linux specific.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
