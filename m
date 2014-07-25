Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XAUlV-0002Kj-73
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 01:57:45 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAUlT-0005di-AI
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 01:57:45 +0000
Message-ID: <53D1B969.1030109@cn.fujitsu.com>
Date: Fri, 25 Jul 2014 09:56:57 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <239904743.14759248.1406204300232.JavaMail.zimbra@redhat.com>
In-Reply-To: <239904743.14759248.1406204300232.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] cpuset01 -I 3600
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, CAI Qian <caiqian@redhat.com>

Hi Jan,

On 07/24/2014 08:18 PM, Jan Stancek wrote:
> Hi,
> 
> is it necessary for this reproducer to run for an hour?
> 
> Would anyone object if it's moved to some stress runtest?
> Or we can keep it also in mm, but with some smaller runtime, say 5 minutes.

If it's a bug reproducer, I think reduce the runtime would be meaningless:)
Sometimes we just need to run that long time to ensure the bug does not exist.
So I'd like to move it to stress runtest, thanks!

Regards,
Xiaoguang Wang
> 
> Any thoughts?
> 
> Regards,
> Jan
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
