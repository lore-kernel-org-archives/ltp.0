Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URnWp-0002qw-SZ
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 17:49:19 +0000
Date: Mon, 15 Apr 2013 19:50:03 +0200
From: chrubis@suse.cz
Message-ID: <20130415175001.GB2405@rei>
References: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
	<516BB803.6000603@cn.fujitsu.com>
	<1428475737.306249.1366016603320.JavaMail.root@redhat.com>
	<20130415141743.GA1896@rei>
	<1471859220.549493.1366042467298.JavaMail.root@redhat.com>
	<1801607801.575766.1366046157443.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1801607801.575766.1366046157443.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] sendmsg testcase for
 ded34e0fe8fe8c2d595bfa30626654e4b87621e0
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> 2 more random systems with Fedora 18 GOLD and kernel-3.6.10-4.fc18 hit it almost instantly too:
> Romley-EP CPU: Ivy Bridge-EP L-1, 40 CPU, Genuine Intel(R) CPU @ 2.10GHz
> HP ProLiant BL495c G5, 4 CPU, Quad-Core AMD Opteron(tm) Processor 2347 HE

Strange indeed.

Let's get this into LTP git repo already, I will try to bring down some
of my testing machines then.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
