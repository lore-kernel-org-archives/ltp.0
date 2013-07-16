Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uz3ds-0005Jc-7x
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 11:42:04 +0000
Date: Tue, 16 Jul 2013 13:43:47 +0200
From: chrubis@suse.cz
Message-ID: <20130716114347.GB20826@rei>
References: <1373966367-18078-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373966367-18078-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V2 1/2] lib: let tst_kvercmp2() contains major
 kernel version
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> +int tst_kvercmp2(struct tst_kern_exv *vers);

I would prefer if the tst_kvercmp2() would contain version numbers for
vanilla kernel too so that we can do just:

static struct tst_kern_exv kvers[] = {
       { "RHEL5", "2.6.18-132" },
       { NULL, NULL },
};

if (tst_kvercmp2(2, 6, 25, kvers) >= 0)
	...

But that is minor.


And what about we add an TINFO message about which distro was detected?

Something like:

	if (!strcmp(vers[i].dist_name, cur_dist_name)) {
		tst_resm(TINFO, "Detected %s using kernel version %s",
		         vers[i].dist_name, vers[i].extra_ver);
	...


The rest of the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
