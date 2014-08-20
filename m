Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XK6kv-0003sr-9H
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 14:20:53 +0000
Date: Wed, 20 Aug 2014 16:19:52 +0200
From: chrubis@suse.cz
Message-ID: <20140820141952.GA23454@rei>
References: <933677084.9868450.1408538960160.JavaMail.zimbra@redhat.com>
	<1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] open12 failing on i386 with EOVERFLOW
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> # env PATH=`pwd`:$PATH ./open12
> open12      1  TFAIL  :  open12.c:104: test O_APPEND for open failed
> open12      2  TCONF  :  open12.c:123: test O_NOATIME flag for open needs filesystems which is mounted without noatime and relatime
> open12      3  TPASS  :  test O_CLOEXEC for open success
> open12      4  TPASS  :  test O_LARGEFILE for open success
> open12      0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/opexIqjV3) failed: lstat(/tmp/opexIqjV3/large_file) failed; errno=75: Value too large for defined data type
> 
> Since it's linked from library, adding -D_FILE_OFFSET_BITS=64 to this testcase has
> no effect.
> 
> One simple way to fix it would be to unlink it in test, so that
> rmobj.c doesn't hit it.

That is simple enough but I'm a bit reluctant to add the fix to each
test that will test O_LARGEFILE.

Given that the only purpose of lstat() in rmobj() is to figure out if
given path is a file or directory, we can try to work around this by
trying to opendir() the path first and treat it like a file when we get
ENOTDIR. What do you think?

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
