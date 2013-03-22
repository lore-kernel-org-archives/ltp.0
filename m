Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UIrwO-0005Ob-VN
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 02:42:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIrwN-0000K0-Gs
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 02:42:48 +0000
Message-ID: <514BC563.9020503@cn.fujitsu.com>
Date: Fri, 22 Mar 2013 10:43:47 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <e1988db86146bef7ddd363142fbe3174ccecadfd.1363878323.git.jstancek@redhat.com>
In-Reply-To: <e1988db86146bef7ddd363142fbe3174ccecadfd.1363878323.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] pan: fix potential overrun in tag_report
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

On 03/21/2013 11:08 PM, Jan Stancek wrote:
>   char *cuts_info[5];
>   ...
>   while (tok_num < 5 &&
>       (cuts_info[++tok_num] = strtok(NULL, "\t ")) != NULL) ;
> 
> While above can run for tok_num == 4, in which case:
>   cuts_info[++tok_num] becomes cuts_info[5]
> and that is outside of cuts_info array.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
