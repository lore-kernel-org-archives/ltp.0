Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwsKJ-0002O6-6K
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:12:51 +0000
Date: Wed, 10 Jul 2013 13:14:28 +0200
From: chrubis@suse.cz
Message-ID: <20130710111428.GA19178@rei.suse.cz>
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
	<51D3DA8A.5020602@oracle.com> <20130703103321.GA2906@rei>
	<201307031300.00679.vapier@gentoo.org>
	<51D548FC.9010003@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D548FC.9010003@oracle.com>
Subject: Re: [LTP] [PATCH v6] fw_load: new test of device firmware loading
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> >>> There are a lot of files that left after module's build and If I don't
> >>> clean there, I have to manually add files to the clean target and
> >>> perhaps, even more.
> >> Making make clean work would be better, but I'm not sure how to make
> >> that work, the kernel build leaves various files there and I'm not sure
> >> if these have stable names, but we can do some effort to clean up all
> >> the *.cmd.o and maybe some of the rest of them.
> > have it output to a subdir and add that subdir to the ignore
> > -mike
> But how to do it with external kernel modules and kernel build?
> 
> I still don't understand why is the current approach not appropriate? 
> 'make clean' works and it deletes make target file. 'make' works fine, 
> even if module doesn't compile. And we get only what is needed for the test.

The intention here is to make the 'git status' ignore all the generated
files and/or to make 'make clean' to clean them. Which is not criticall
in any way and I'm fine with fixing these once the testcase is merged.

> if we need to clean those files by 'make clean', I think it is better to 
> make LINUX_DIR variable available when clean is invoked, and add 
> additional rule with kbuild clean.

If kbuild clean works this satisfies the second part but not the first.

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
