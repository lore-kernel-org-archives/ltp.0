Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qyi01-0005dE-Mh
	for ltp-list@lists.sourceforge.net; Wed, 31 Aug 2011 10:26:25 +0000
Date: Wed, 31 Aug 2011 12:26:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110831102620.GA32395@saboteur.suse.cz>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<201108292342.IBI64522.FJOFMVSOLQOtHF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201108292342.IBI64522.FJOFMVSOLQOtHF@I-love.SAKURA.ne.jp>
Subject: Re: [LTP] [linux-3.1] TOMOYO Linux update
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I updated TOMOYO testcases for Linux 3.1.
> http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.4.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=5388&root=tomoyo
> 4378 lines, 162,176 bytes.
> MD5: 4b1ce1f661a9b102b44ae59e495ee3d6

I'm glad to see the patch, however there are a few things that needs to
be settled before applying to LTP.

* Please next time send the patch attached to the mail, ideally inlined
  as well as attachement. It's much easier for me to review it that way.
  Or even better If you had a git repository on sf.net I could pull
  changes directly from there.

* Including <linux/sched.h> instead of <sched.h> may introduce problems
  in future.

  Look here how to fix the problem with sched.h:

  http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=commit;h=019ed6c71369217ac02c399abb12abb93bd527f3

  The clone flags are GNU extensions and Ulrich 'fixed' these, so they
  aren't defined unless you say they should.

There are some minor coding style violations and useless statements. But
I don't think there is a reason to force you to fix them. Just let me
know if you wan't to know ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
