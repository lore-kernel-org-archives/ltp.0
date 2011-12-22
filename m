Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rdhcg-0006mk-Qn
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 12:19:46 +0000
Date: Thu, 22 Dec 2011 13:29:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222122930.GE26303@saboteur.suse.cz>
References: <145b91763d3c2670cd736cc7fa3072c9a6db219a.1311676572.git.czhang@redhat.com>
	<20110727161000.GA21916@saboteur.suse.cz>
	<4EF316E9.4050206@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EF316E9.4050206@casparzhang.com>
Subject: Re: [LTP] [PATCH] [syscalls] getrusage04: new testcase
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> while (wait--)
>     ;
> 

Hmm, I do not fancy the semicolon on next line, but checkpatch doesn't
seem to have problem with that...

Anyway this version seems good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
