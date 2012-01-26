Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RqIbb-0002vX-6M
	for ltp-list@lists.sourceforge.net; Thu, 26 Jan 2012 06:14:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RqIbZ-0003Dm-F1
	for ltp-list@lists.sourceforge.net; Thu, 26 Jan 2012 06:14:42 +0000
Message-ID: <4F20EC63.4020601@cn.fujitsu.com>
Date: Thu, 26 Jan 2012 14:02:11 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <f1c1b1b8-3e46-4e00-9c9e-7e9ef02f4117@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <f1c1b1b8-3e46-4e00-9c9e-7e9ef02f4117@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v3 1/8] A library used to test memcg
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
Cc: LTP List <ltp-list@lists.sourceforge.net>


Jan Stancek said the following on 2012-1-20 20:06:
> last update of this series had different version on some patches,
> some were v2 and some v3. I'll be referring to it as 'v3'.
> 
> I ran all v3 test cases. They worked fine, just 2 comments:
> 

Thanks.

> 1. file mode of new test cases is 644, existing one (memcg_function_test) is 755.
> I'm not sure if installation process takes care of this, I put them to testcases/bin
> directly (I was lazy), so I had to "chmod a+x" new ones to run them.
> 

I will modify file mode of new test cases to 755.

> 2. memcg_use_hierarchy generates some errors, which are expected
> For example:
> ltp/testcases/bin/memcg_use_hierarchy_test.sh: line 53: echo: write error: Device or resource busy
> testcases/bin/memcg_use_hierarchy_test.sh: line 64: echo: write error: Invalid argument
> 
> Just by reading log, it isn't obvious, that these errors are expected.
> I'd suggest "2> /dev/null" or if you want to keep it in log, then add
> some note, that these are expected.
> 

I will add "2> /dev/null".

Thanks very much.

-- 
Best Regards,
Peng


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
