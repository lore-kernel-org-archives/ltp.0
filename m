Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC52p-0004IT-AT
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 10:54:11 +0000
Date: Tue, 29 Jul 2014 12:53:25 +0200
From: chrubis@suse.cz
Message-ID: <20140729105325.GD24424@rei>
References: <1406586824-1692-1-git-send-email-gary.robertson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406586824-1692-1-git-send-email-gary.robertson@linaro.org>
Subject: Re: [LTP] [PATCH] Allow mutex initialization without PI configured
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
To: "Gary S. Robertson" <gary.robertson@linaro.org>
Cc: ltp-list@lists.sourceforge.net, mike.holmes@linaro.org

Hi!
> LTP seems primarily intended to be built and run on the same machine,
> and thus uses autotools / autoconf to determine the features of the host
> machine's environment prior to compilation.  However, when distributing
> precompiled binaries, or when building in a cross-compilation environment,
> it is better not to disable features based on the compile-time environment.
> 
> This patch removes compile-time dependencies on priority-inheriting mutexes
> and allows the code to attempt initialization of PI mutexes even
> if the runtime environment lacks that feature... in which case
> the associated test(s) should fail.
> 
> Without this patch, init_pi_mutex() may be compiled as an empty function,
> allowing subsequent operations to be attempted on an un-inititalized mutex.
> Likewise, testpi-3 may fail to initialize a mutex before starting pthreads
> which attempt to use the mutex.

As far as I can see the configure check tests if PTHREAD_PRIO_INHERIT is
defined in system headers. So if you just remove the ifdefs the
compilation will fail and if that is not the case, the check is broken.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
