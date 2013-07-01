Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UtZsw-0002QO-Gl
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 08:54:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UtZsu-0000yQ-9p
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 08:54:58 +0000
Message-ID: <51D14343.6080003@cn.fujitsu.com>
Date: Mon, 01 Jul 2013 16:52:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1372668159-3932-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1372668159-3932-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v5] lib: tst_module: add library functions for
 kernel modules
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On 07/01/2013 04:42 PM, Alexey Kodanev wrote:
> There are new functions: tst_module_exists(), tst_module_load() and
> tst_module_unload(). These functions help to load and unload kernel
> modules in the tests.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
