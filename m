Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhzTC-0001N9-S9
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 10:53:02 +0000
Date: Wed, 7 May 2014 12:52:03 +0200
From: chrubis@suse.cz
Message-ID: <20140507105203.GA19305@rei>
References: <1396953708.3005.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1396953708.3005.6.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] readlinkat/readlinkat02.c: add new errno testes
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
> Add EINVAL and ENOTDIR errno testes for readlinkat(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

I've added configure check for readlinkat and lapi/readlinkat.h and
included it in the testcase and pushed, thanks.

(I've also cleaned up readlinkat01 testcase)

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
