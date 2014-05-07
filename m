Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wi1Ro-0006sP-WA
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 12:59:45 +0000
Date: Wed, 7 May 2014 14:58:45 +0200
From: chrubis@suse.cz
Message-ID: <20140507125845.GC20240@rei>
References: <1396350731.10607.12.camel@G08JYZSD130126>
	<20140505163249.GD11256@rei>
	<1399373430.3177.55.camel@G08JYZSD130126>
	<20140506110048.GC6403@rei.Home>
	<1399427555.2397.8.camel@G08JYZSD130126>
	<20140507090930.GA18644@rei>
	<1399459901.2397.18.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399459901.2397.18.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] readdir/readdir21.c: add new error number
	testes
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
> Add ENOENT and ENOTDIR error number testes for readdir(2)
> 

Both pushed, thanks.

PS: I've added SAFE_RMDIR() to lib and make use of in the testcase.

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
