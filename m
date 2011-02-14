Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Poz1k-00060z-Fb
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 14:03:44 +0000
Date: Mon, 14 Feb 2011 15:23:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110214142304.GA32554@saboteur.suse.cz>
References: <4D590650.4090806@nokia.com>
	<20110214124921.GA29415@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110214124921.GA29415@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH] Fix the file permissions and other issues in
 "fs_perms" tests
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
To: maxin <john.maxin@nokia.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > On the preliminary analysis of  this failure, I came to know that the reason was due to insufficient file permissions provided in the
> > "runtests/fs_perms_simple" . To execute a script file, 'user', 'group', or 'others' should have 'read' and 'execute' permissions.
> > Based on that, I have modified the "s_perms_simple"  file as follows:
> > 
> > -fs_perms01 fs_perms 001 99 99 12 100 x 0
> > -fs_perms02 fs_perms 010 99 99 200 99 x 0
> > -fs_perms03 fs_perms 100 99 99 99 500 x 0
> > +fs_perms01 fs_perms 005 99 99 12 100 x 0
> > +fs_perms02 fs_perms 050 99 99 200 99 x 0
> > +fs_perms03 fs_perms 500 99 99 99 500 x 0
> 
> Actually these are correct, the last number in a row is
> 'expected result'. So execution of these files must fail in order for
> the test to succeed.

Reading the source again, 0 is success there.

But then 001 is right to exec by other which should work.
         010 is right to exec for group, which is the same on that line
	 100 is right to exec for owner, which is the same again

So this should really work. Let me know if the test works for you with
previously posted patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
