Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SkS8R-0000oq-0w
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 03:44:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkS8P-00005A-JC
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 03:44:43 +0000
Message-ID: <4FED249E.5050206@cn.fujitsu.com>
Date: Fri, 29 Jun 2012 11:44:30 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1339421791.git.jstancek@redhat.com>
	<4FD5FC23.3090806@redhat.com>
In-Reply-To: <4FD5FC23.3090806@redhat.com>
Subject: Re: [LTP] [PATCH v3 1/3] add testcases/kernel/syscalls/cma
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

On 06/11/2012 10:09 PM, Jan Stancek wrote:
> 
> add directory structure for tests related to syscalls:
> process_vm_readv
> process_vm_writev
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/cma/Makefile             |   22 ++++++++++++++++++++
>  .../kernel/syscalls/cma/process_vm_readv/Makefile  |   22 ++++++++++++++++++++
>  .../kernel/syscalls/cma/process_vm_writev/Makefile |   22 ++++++++++++++++++++

Hi Jan,

pushed with .../kernel/syscalls/cma/process_vm_readv/Makefile and
.../kernel/syscalls/cma/process_vm_writev/Makefile deleted by my hand,
since it's no needed.

Thanks,
Wanlong Gao

>  3 files changed, 66 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/cma/Makefile
>  create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv/Makefile
>  create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev/Makefile
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 




------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
