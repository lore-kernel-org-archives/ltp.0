Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhHT8-0002Qk-52
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 11:54:02 +0000
Date: Mon, 5 May 2014 13:53:04 +0200
From: chrubis@suse.cz
Message-ID: <20140505115303.GA9027@rei>
References: <1395991214.5017.2.camel@G08JYZSD130126>
	<1395991331.5017.4.camel@G08JYZSD130126>
	<20140429163137.GG12523@rei>
	<1399262735.3177.14.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399262735.3177.14.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] read/read02.c: add new error number tests
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > > +	tst_require_root(NULL);
> > 
> > Does O_DIRECT require root?
> > (I haven't found anything in read man page that would suggests so)
> > 
> 
> In fedora20, /tmp is tmpfs.
> This test will fail if open a file with O_DIRECT in /tmp, like:
> read02      1  TBROK  :  open failed at read02.c:147: errno=EINVAL(22):
> Invalid argument
> So I test it in /root.

That is wrong way to solve this problem.

> > There is no need to unlink files if you call tst_rmdir(). You only need
> > to close filedescriptors.
> > 
> 
> TEST_FILE4 is not in /tmp.

The test should create all files in a directory created by tst_tmpdir().

We should handle this as:

* Skip the test (TCONF) if temp diretory is tmpfs (does not support O_DIRECT)
  (see include/tst_fs_type.h)

* User should pass alternative temp directory to runltp script to make
  the test working in case /tmp is on tmpfs

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
