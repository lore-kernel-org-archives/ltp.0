Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsDhK-0006v8-4D
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 15:01:22 +0000
Date: Thu, 27 Jun 2013 17:02:52 +0200
From: chrubis@suse.cz
Message-ID: <20130627150252.GA22545@rei.suse.cz>
References: <1372344742-5138-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372344742-5138-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] lib: tst_run_cmd: add tst_run_cmd() to exec
 specified program
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

Hi!
> vfork() + execvp() specified program.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/test.h    |    9 +++++++++
>  lib/tst_run_cmd.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 0 deletions(-)
>  create mode 100644 lib/tst_run_cmd.c

This one looks fine to me.

Let's wait a day or two to give other people chance to look at the code.
And if nobody object I will start pushing the patches in the order.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
