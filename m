Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U7HHR-0007kj-K1
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 03:20:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U7HHP-0003EZ-HA
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 03:20:37 +0000
Message-ID: <51219DC8.3080808@cn.fujitsu.com>
Date: Mon, 18 Feb 2013 11:19:36 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <02591071dc6cc1bdbb630e4c0d8e349042247fd7.1360919410.git.jstancek@redhat.com>
In-Reply-To: <02591071dc6cc1bdbb630e4c0d8e349042247fd7.1360919410.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] rename syscall() macro to ltp_syscall()
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

On 02/15/2013 05:16 PM, Jan Stancek wrote:
> This patch renames syscall() macro defined in linux_syscall_numbers.h
> to reduce confusion with syscall(2). It also updates all places
> where it was previously in use.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Applied, thank you very much for your contribution.

Wanlong Gao


------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
