Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPZtW-0007BE-Fr
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 13:47:02 +0000
Date: Wed, 2 May 2012 15:45:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502134510.GE366@saboteur.suse.cz>
References: <CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com>
	<4F68400F.9080702@windriver.com> <4F684453.2060003@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F684453.2060003@cn.fujitsu.com>
Subject: Re: [LTP] Query regarding Open Posix Test Case failure
 (pthread_rwlock_rdlock)
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

Hi!
> This's a glibc's bug.

http://sourceware.org/bugzilla/show_bug.cgi?id=13701

(for example)

But nobody cared enough to fix it yet.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
