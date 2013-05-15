Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UcViJ-0000BG-LV
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 07:01:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UcViI-0001D7-Js
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 07:01:27 +0000
Message-ID: <5193329C.4040205@cn.fujitsu.com>
Date: Wed, 15 May 2013 15:00:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
	<6e4f2cc0db6d6544478fe24fe00f04755b617119.1368434507.git.zliu@redhat.com>
In-Reply-To: <6e4f2cc0db6d6544478fe24fe00f04755b617119.1368434507.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/3] mem: introduce clean_node() func
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 05/13/2013 04:43 PM, Zhouping Liu wrote:
> There's set_node func introduced in commit cb2967b27a65, but we
> don't have a func to clean the node mask yet.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
