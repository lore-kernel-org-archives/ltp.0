Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TLQ3U-0004jQ-Ld
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 03:00:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TLQ3T-0003Ib-Ea
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 03:00:24 +0000
Message-ID: <50738CED.7090209@cn.fujitsu.com>
Date: Tue, 09 Oct 2012 10:33:17 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1318126449-3660-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1318126449-3660-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] net: Install the missing file in network stress
 test
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 10/09/2011 10:14 AM, Hangbin Liu wrote:
> Some network stress test (dns, ftp, http) will lost local scripts while
> install. Remove the "-" in makefile fixed this issue.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Pushed, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
