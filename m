Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NRiaf-0002Rt-2I
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 08:47:05 +0000
Received: from mail-yx0-f188.google.com ([209.85.210.188])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRiac-0002ju-SP
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 08:47:05 +0000
Received: by yxe26 with SMTP id 26so14360171yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 00:46:57 -0800 (PST)
References: <20100104004355.GA760@us.ibm.com>
Message-Id: <51111C51-DD4E-44E6-B093-3B3FC0DEE8C5@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100104004355.GA760@us.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Mon, 4 Jan 2010 00:46:35 -0800
Subject: Re: [LTP] [PATCH ltp] p9auth: add missing checkp9auth.sh script
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Sent from my iPhone

On Jan 3, 2010, at 4:43 PM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> This was in my original patch submission but somehow didn't make its  
> way into
> the ltp tree.
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
> testcases/kernel/security/p9auth/checkp9auth.sh |   70 ++++++++++++++ 
> +++++++++
> 1 files changed, 70 insertions(+), 0 deletions(-)
> create mode 100644 testcases/kernel/security/p9auth/checkp9auth.sh
>
> diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/ 
> testcases/kernel/security/p9auth/checkp9auth.sh
> new file mode 100644
> index 0000000..f917ce6
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/checkp9auth.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +## 
> ### 
> ### 
> ### 
> #####################################################################
> +## 
>     
>     
>     
>                                                                    ##
> +## Copyright (c) International Business Machines  Corp.,  
> 2009                 ##
> +## 
>     
>     
>     
>                                                                    ##
> +## This program is free software;  you can redistribute it and#or  
> modify      ##
> +## it under the terms of the GNU General Public License as  
> published by       ##
> +## the Free Software Foundation; either version 2 of the License,  
> or          ##
> +## (at your option) any later  
> version.                                        ##
> +## 
>     
>     
>     
>                                                                    ##
> +## This program is distributed in the hope that it will be useful,  
> but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of  
> MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public  
> License   ##
> +## for more  
> details.                                                          ##
> +## 
>     
>     
>     
>                                                                    ##
> +## You should have received a copy of the GNU General Public  
> License          ##
> +## along with this program;  if not, write to the Free  
> Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
> 02111-1307 USA    ##
> +## 
>     
>     
>     
>                                                                    ##
> +## 
> ### 
> ### 
> ### 
> #####################################################################
> +
> +yesno=0
> +if [ "$1" = "yesno" ]; then
> +    yesno=1
> +fi
> +
> +# check for openssl
> +rm -f /tmp/ab
> +echo ab > /tmp/ab
> +openssl sha1 -hmac "ab" /tmp/ab > /dev/null
> +ret=$?
> +if [ $ret -ne 0 ]; then
> +    if [ $yesno -eq 1 ]; then echo
> +        "no"
> +    else
> +        echo "openssl not installed, skipping p9auth tests."
> +    fi
> +    exit 1
> +fi
> +
> +majfile=/sys/module/p9auth/parameters/cap_major
> +minfile=/sys/module/p9auth/parameters/cap_minor
> +if [ ! -f "$majfile" ]; then
> +    if [ $yesno -eq 1 ]; then echo
> +        "no"
> +    else
> +        echo "p9auth not detected.  Skipping p9auth tests."
> +    fi
> +    exit 1
> +fi
> +
> +if [ ! -c "/dev/caphash" ]; then
> +    rm -f /dev/caphash
> +    maj=`cat $majfile`
> +    mknod /dev/caphash c $maj 0
> +fi
> +
> +if [ ! -c "/dev/capuse" ]; then
> +    rm -f /dev/capuse
> +    min=`cat $minfile`
> +    mknod /dev/capuse c $maj 1
> +fi
> +chmod ugo+w /dev/capuse
> +
> +if [ $yesno -eq 1 ]; then
> +    echo "yes"
> +else
> +    echo "p9auth ready for testing"
> +fi
> +exit 0
> -- 
> 1.6.1.1

Hi Serge,
     When do this script need to be run? Before compiling or before /  
while running?
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
