Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UmC9c-00062N-OX
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 00:09:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UmC9b-0007lK-3F
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 00:09:40 +0000
Message-ID: <51B66A5F.4090302@cn.fujitsu.com>
Date: Tue, 11 Jun 2013 08:07:59 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <00f801ce63f3$7d4cc8f0$77e65ad0$@lge.com>
	<690761261.792664.1370873255744.JavaMail.root@redhat.com>
	<012501ce6633$55508a70$fff19f50$@lge.com>
In-Reply-To: <012501ce6633$55508a70$fff19f50$@lge.com>
Subject: Re: [LTP] [PATCH] syscalls/chown01: Fix test file creation
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

On 06/11/2013 07:36 AM, Jungsoo Son wrote:
> I added 'void' to setup() and cleanup() as your mention.
> 
> 
> There is a bug in the code to create the file and the code is
> very intricate. So replace it with SAFE_FILE_PRINTF().
> 
> Signed-off-by: jungsoo.son <jungsoo.son@lge.com>

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
