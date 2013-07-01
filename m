Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UtikM-00023t-78
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 18:22:42 +0000
Date: Mon, 1 Jul 2013 20:24:12 +0200
From: chrubis@suse.cz
Message-ID: <20130701182412.GA1204@rei>
References: <51D11D51.3030604@cn.fujitsu.com>
	<1706017246.1850560.1372677969601.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1706017246.1850560.1372677969601.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v3] mmap/mmap12.c: new case to test MAP_POPULATE
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
> > 
> > 
> > Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> Looks good to me. One small issue is "mmap12" missing in ../.gitignore,
> but I think comitter can add that easily.
> 

Pushed with the addition to kernel/syscalls/.gitignore, thanks.

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
