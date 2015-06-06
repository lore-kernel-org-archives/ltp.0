Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z1DcN-0007Ub-IJ
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2015 12:54:31 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z1DcL-0001oy-Op
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2015 12:54:31 +0000
Message-ID: <5572ED1E.1020203@oracle.com>
Date: Sat, 06 Jun 2015 15:52:46 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <20150428172442.GB25152@rei>	<1433247689-3984-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1433247689-3984-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1433247689-3984-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/6] lib6/runcc.c: Cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Hi,
On 02.06.2015 15:21, Zeng Linggang wrote:
>    *   Copyright (c) International Business Machines  Corp., 2001
> + *	05/2005 written by David L Stevens
>    *
>    *   This program is free software;  you can redistribute it and/or modify
>    *   it under the terms of the GNU General Public License as published by
> @@ -13,19 +13,12 @@
>    *   the GNU General Public License for more details.
>    *
>    *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *   along with this program;  if not, write to the Free Software Foundation,
> + *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>    */

You could use modern form rather then reordering the old, see 
http://www.gnu.org/licenses/gpl-howto.en.html.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

>   
>   /*
>    * runcc.a - common functions for lib6 testing

It is quite obvious, remove it as well.

>   
> -char *filetmpl = "/tmp/%.*s_XXXXXX";
> +static char *filetmpl = "/tmp/%.*s_XXXXXX";

Rather static const char filetmpl[] = "/tmp/%.*s_XXXXXX";
The same applies for the other changed variables in the patch.

Best regards,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
