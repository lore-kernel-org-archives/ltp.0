Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdfTO-0004qi-Hx
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 10:02:02 +0000
Date: Thu, 22 Dec 2011 11:11:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222101140.GB26303@saboteur.suse.cz>
References: <20111221132206.GC22113@saboteur.suse.cz>
	<611ED426031E9E48A80D02BED70BC810570E4F83@ALA-MBA.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <611ED426031E9E48A80D02BED70BC810570E4F83@ALA-MBA.corp.ad.wrs.com>
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
To: "Shang, YanFeng" <YanFeng.Shang@windriver.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> >> testcase create NCPU=4 threads running with a high priority with the same sched
> >> policy and one with a low-priority. The low-priority thread should not run
> >> until the other threads stop running, unless the machine has more than NCPU
> >processors
> >> when cpu core >4,testcase failed. redefine NCPU =
> >sysconf(_SC_NPROCESSORS_CONF)
> >
> >There are two problems with that. The first one, and less problematic, is that
> >_SC_NPROCESSORS_CONF is not yet POSIX standardized.
> 
> I think using cat /proc/cpuinfo get core number is better.

That won't work. Not only the /proc/ filesystem is not standartized by
POSIX, there is no /proc/ in other unixes.

The sysconf() is more common, it's not standartized either, but at least
it seems to work on newer unixes.

> >The second and more problematic part is that such process would eat all
> >your CPU time, which may easily lock the whole box while testing.
> I test this case on many kinds of board(arm,mips,x86,ppc), no lock issue.

It may work most of the time, but my expirience with realtime threadd
and schedulling is that you will burn sooner or later when you do more
realtime threads that is a number of your cores. Expecially if these
threads are cycling in infinite loop.

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
