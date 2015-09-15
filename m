Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZblH9-0003vy-Uf
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2015 08:07:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZblH8-0000eU-Dh
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2015 08:07:39 +0000
Date: Tue, 15 Sep 2015 10:06:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150915080647.GA3351@rei.suse.cz>
References: <CAO0kMxDg1KJWzFMqyYOmP5xLe78pyf21MwizsM_P38Vbx02HeQ@mail.gmail.com>
	<1441866309.29760.18.camel@G08FNSTD140232>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441866309.29760.18.camel@G08FNSTD140232>
Subject: Re: [LTP] Query related to LTP test suite run
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: Ltp-list@lists.sourceforge.net, ltp@lists.linux.it

Hi!
> As I known, inotify06 would make some system crash caused by a known
> kernel bug and the bug has been fixed, you can see this url:
> https://github.com/torvalds/linux/commit/8f2f3eb59dff4ec538de55f2e0592fec85966aab
> 
> If the issue is inotify06, I suggest that you should remove it before
> using runltp script.
> You can just do like:
> rm -rf <path_to_install_ltp>/testcases/bin/inotify06

Right, the inotify06 may crash the kernel if the kernel wasn't fixed.
Even better than removing the binary is to remove the line from the
/opt/ltp/runtest/syscalls file for your testing until you kernel
contains the fix.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
