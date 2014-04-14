Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZhrs-00019B-Vl
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 14:28:17 +0000
Date: Mon, 14 Apr 2014 16:27:31 +0200
From: chrubis@suse.cz
Message-ID: <20140414142730.GB25967@rei.suse.cz>
References: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] configure: add configure check for GCC
 -Wold-style-definition
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
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  configure.ac            |    1 +
>  include/mk/config.mk.in |    2 +-
>  m4/ltp-gcc_option.m4    |   37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletions(-)
>  create mode 100644 m4/ltp-gcc_option.m4

Pushed with minor changes (renamed the m4 file and function to
warn_oldstyle instead of gcc_option and changed the AC_MSG_CHECKING()
message) and tested that it works fine, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
