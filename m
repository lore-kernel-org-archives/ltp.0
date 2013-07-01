Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Utcu5-00030g-Kj
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 12:08:21 +0000
Date: Mon, 1 Jul 2013 14:09:47 +0200
From: chrubis@suse.cz
Message-ID: <20130701120946.GA15036@rei.suse.cz>
References: <51C7FD6D.4010904@cn.fujitsu.com>
	<990668294.1913615.1372679398858.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <990668294.1913615.1372679398858.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] mmap/mmap13.c: new case to test SIGBUS error
 of mmap
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > Test SIGBUS error by accessing to a portion of the buffer that does not
> > correspond to the file.
> > 
> > Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> v2 looks good to me. As for others, ../.gitignore is missing "mmap13",
> but I think comitter can add that.
> 

I've commited this one allready (along with another patch to add it to
gitignore (as I noticed this later)).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
