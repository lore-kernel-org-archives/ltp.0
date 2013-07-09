Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwZXh-0006Ck-KH
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 15:09:25 +0000
Date: Tue, 9 Jul 2013 17:11:03 +0200
From: chrubis@suse.cz
Message-ID: <20130709151103.GB760@rei.Home>
References: <mailman.80890.1372765469.12996.ltp-list@lists.sourceforge.net>
	<51D38924.8090400@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D38924.8090400@oracle.com>
Subject: Re: [LTP] [ltp-full-20130503] runltp cleanup() can't remove ${TMP}
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
To: Eko <hong.sun@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>   I executed runltp command in my box, everything is OK, but when 
> cleaning the environment, got following errors:
> 
>         ###############################################################
>              Done executing testcases.
>              LTP Version:  20130503
>         ###############################################################
> rm: cannot remove `/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458': Device or resource busy
> rm: cannot remove `/tmp/ltp-9NAwvmAbI5/sandbox': Device or resource busy
> 
> 
> Because /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458 and 
> /tmp/ltp-9NAwvmAbI5/sandbox are still mounted, so can't delete them, the 
> best way is:
> # umount /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458
> # umount /tmp/ltp-9NAwvmAbI5/sandbox
> 

This looks like leftover mount from some testcases. We need to find
which testcases are these and fix them to do their cleanup correctly.

Quick greping suggested that candidates are:

testscripts/test_fs_bind.sh

testcases/kernel/syscalls/mount/mount*.c

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
