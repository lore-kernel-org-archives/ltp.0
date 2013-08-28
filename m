Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VEYC5-0002D3-7R
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 05:21:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VEYC2-0000YW-Om
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 05:21:25 +0000
Message-ID: <521D8899.3000307@cn.fujitsu.com>
Date: Wed, 28 Aug 2013 13:20:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <2060663a46bc8d66f90a9686c7fe4a83d21e40a4.1377594171.git.jstancek@redhat.com>
In-Reply-To: <2060663a46bc8d66f90a9686c7fe4a83d21e40a4.1377594171.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add use-gss-proxy to known_issues list
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/27/2013 05:05 PM, Jan Stancek wrote:
> Following commit implemented non-blocking read for use-gss-proxy:
>   commit b161c144404c18f6a9e20e46b63828ae3c2eb093
>   Author: J. Bruce Fields <bfields@redhat.com>
>     Date:   Fri May 24 09:47:49 2013 -0400
>         svcrpc: implement O_NONBLOCK behavior for use-gss-proxy
> 
> Prior to this commit non-block read hanged, but it happened
> only in -rc kernels, which we can ignore.
> 
> Note, that this proc entry is available only when you load module
> auth_rpcgss.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed

Wanlong Gao


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
