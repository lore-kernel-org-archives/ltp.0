Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SzdcN-0000TC-Uy
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 01:02:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzdcM-0001yY-BD
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 01:02:23 +0000
Message-ID: <50245D45.90801@cn.fujitsu.com>
Date: Fri, 10 Aug 2012 09:00:53 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344533811-4683-1-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1344533811-4683-1-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 1/6] /lib/tst_tmpdir indentation and coding style
 fixes
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
To: Marios Makris <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 08/10/2012 01:36 AM, Marios Makris wrote:
> Identation and coding style fixes as well as moved the function descriptions
> to the header file (/include/test.h)
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>
> ---
>  include/test.h   |   26 +++++++++++++++
>  lib/tst_tmpdir.c |   97 ++++++++++++++++++------------------------------------
>  2 files changed, 58 insertions(+), 65 deletions(-)

Pushed whole series, thank you.

Wanlong Gao


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
