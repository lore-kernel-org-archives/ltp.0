Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XPU33-0003uP-S6
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 10:13:49 +0000
Date: Thu, 4 Sep 2014 12:13:37 +0200
From: chrubis@suse.cz
Message-ID: <20140904101337.GA3151@rei.suse.cz>
References: <CAF7YWnxMVXpKKTbB3B4Sjqwp5K=u543PVbUBEy6jFGeq6YWkVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF7YWnxMVXpKKTbB3B4Sjqwp5K=u543PVbUBEy6jFGeq6YWkVw@mail.gmail.com>
Subject: Re: [LTP] [RFC] Realtime tests - autoconf problems in OpenEmbedded
 cross-build environment
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
To: Gary Robertson <gary.robertson@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Holmes <mike.holmes@linaro.org>

Hi!
> The autoconf scripts in 'ltp/testcases/realtime/m4/check.m4' evaluate
> whether priority-inheriting mutexes and robust mutexes are supported on the
> system for which the LTP realtime tests are being targeted.  Portions of
> the LTP realtime test code required to test these features on the target
> are then conditionally included or excluded at compile time based on
> autoconf results.
> 
> To check these features, the autoconf scripts attempt to compile and then
> execute initialization functions which rely on the features.  Is this done
> because the mere presence of the appropriate headers and protocol value
> definitions, etc. is insufficient proof that the features are supported?

Maybe I've overlooked something but all I see in the check.m4 file is
AC_TRY_COMPILE() which should only try to run the code through the
compile not even link it. At which point does the relatime configure
execute the cross compiled binaries?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
