Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UsPDb-00079r-Ia
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:19:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsPDZ-00026e-HP
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:19:27 +0000
Message-ID: <51CD0031.7010104@cn.fujitsu.com>
Date: Fri, 28 Jun 2013 11:17:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v4] lib: tst_module: add library functions for
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

On 06/27/2013 11:09 PM, Alexey Kodanev wrote:
> There are new functions: tst_module_exists(), tst_module_load() and
> tst_module_unload(). These functions help to load and unload kernel
> modules in the tests.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

LGTM.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
