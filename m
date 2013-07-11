Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UxIYv-0006Gg-NI
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 15:13:41 +0000
Date: Thu, 11 Jul 2013 17:15:21 +0200
From: chrubis@suse.cz
Message-ID: <20130711151521.GA7278@rei.suse.cz>
References: <1373463283-22437-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373463283-22437-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v8] fw_load: new test of device firmware loading
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
I've merged this version, thanks for your patience.


Now there are two little nits to be taken care of:

1. asprintf() allocates memory and as such its return
   value should be checked

   I will fix this one by creating SAFE_ASPRINTF() macro
   and replacing all the occurences.


2. The make clean from kernel devel fails here.

   make[1]: Entering directory `/usr/src/linux-3.7.1'
   rm: cannot remove '.tmp_System.map': Permission denied
   make[1]: *** [clean] Error 1
   make[1]: Leaving directory `/usr/src/linux-3.7.1'
   make: [ltp_fw_load.ko] Error 2 (ignored)
   mv ltp_fw_load.ko~ ltp_fw_load.ko

   As I'm compiling my kernels by hand the /lib/modules
   directory is just a symlink to the /usr/src/linux directory
   and the clean action tries to run cleanup in the whole
   tree which obviously fails. Nevertheless the build
   works fine, because the return value is ignored...

   Now the only way how to reliably fix this seems to use
   subdir for the whole module build and remove it as whole
   on make clean.


PS: Everybody who does git builds, don't forget to run make autotools to
    regenerate configure script.

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
