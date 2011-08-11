Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrY7v-000718-2V
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 16:28:59 +0000
Date: Thu, 11 Aug 2011 18:32:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811163258.GB21959@saboteur.suse.cz>
References: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
	<1313075860-20655-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313075860-20655-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH v3] mm/ksm05: new testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
Commited, however it seems like half of the ksm tests are missing some
checks. On my workstation (which is obviously not a numa system) half of
them prints that numa system is required while the other half crashes
and segfaults.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
