Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YVzcd-00053I-CL
	for ltp-list@lists.sourceforge.net; Thu, 12 Mar 2015 09:41:43 +0000
Date: Thu, 12 Mar 2015 10:40:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150312094057.GA29425@rei>
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
> > There are systems without selinux support that does not have this
> > command available. You should check if setenforce and getenforce is
> > present on the system first, then you can try to set the selinux to
> > permissive.
> Hmm, how about these two ways, which one is better?
> 1.
> if [ -x "/usr/sbin/getenforce" -a -x "/usr/sbin/setenforce" ]; then
>        SELINUX=`getenforce`
> else
>        SELINUX=""
> fi
> 
> 2.
> COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
> if [ $COMMAND -eq 2 ]; then
> 	SELINUX=$(getenforce)
> else
> 	SELINUX=""
> fi

Both looks reasonably fine. The second may be a slightly better because
it does not expect the commands to live under /usr/sbin/, which may not
change, but it's more robust this way.

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
