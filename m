Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YVzgS-0008Ep-N6
	for ltp-list@lists.sourceforge.net; Thu, 12 Mar 2015 09:45:40 +0000
Date: Thu, 12 Mar 2015 10:44:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150312094453.GB29425@rei>
References: <1425966954-887-1-git-send-email-liwang@redhat.com>
	<20150311123018.GC3713@rei>
	<1426151599.1400.32.camel@dhcp-13-206.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426151599.1400.32.camel@dhcp-13-206.nay.redhat.com>
Subject: Re: [LTP] [PATCH v2] fs/acls: fix some permission issue in the
 testcase
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > This looks more like TBROK as well. And even better the test should use
> > tst_tmpdir() and tst_rmdir() to create temporary directories.
> sorry, I don't know how to replace the $TMP/tacl by tst_rmdir() function
> in this test.
> any detail instruction here?

The tst_tmpdir() creates an unique test temporary directory and changes
the working directory to it.

The testcases usually call tst_tmpdir() in the setup and then proceed
with creating temporary files with local paths so that they end up
creating files in the working directory.

The temporary directory is then deleted recursively with tst_rmdir() in
test cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
