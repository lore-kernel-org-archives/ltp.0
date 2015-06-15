Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z4JJY-0001h5-Gw
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 01:35:52 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z4JJU-0003R6-Lf
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 01:35:52 +0000
Message-ID: <557E2BE0.4090203@huawei.com>
Date: Mon, 15 Jun 2015 09:35:28 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1433840491-21403-1-git-send-email-sunyuan3@huawei.com>
	<55799344.5090100@redhat.com>
In-Reply-To: <55799344.5090100@redhat.com>
Subject: Re: [LTP] [PATCH V2] containers: new testcase userns03
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


On 2015/6/11 21:55, Jan Stancek wrote:
> On 06/09/2015 11:01 AM, Yuan Sun wrote:
> I'm thinking if we shouldn't replace kernel version check with check that
> "/proc/self/setgroups" exists. Then it would work on kernels that backport
> those patches. What do you think?

Hi Jan,
     It is better to judge whether /proc/self/setgroups" exists. Thanks 
for your helpful
comment. I will update code according your suggestion.
     Yuan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
