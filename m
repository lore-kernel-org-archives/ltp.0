Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDMj-0003Hj-B3
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:09 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDMd-0002nY-Bf
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:09 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F41a8012775
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:04:01 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FCuRm047894
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:12:56 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB382k8I024266
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 01:02:46 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012218.nB1MIb4f003732@e2.ny.us.ibm.com>
References: <200912012218.nB1MIb4f003732@e2.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:41:59 +0530
Message-Id: <1259853124.5085.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Don't fail the ssh tests if the home directory	we
	are creating already exists (eg. when it was created by adduser)
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-12-01 at 23:22 +0100, Jiri Palecek wrote: 
> Hello,
> 
> this patch silences the error message "mkdir: directory already exists" in ssh tests, caused by the code that handles home directory creation in case adduser didn't do it. Unfortunately, the same code failed when adduser did create the directory.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/network/tcp_cmds/ssh/ssh01 |    2 +-
>  testcases/network/tcp_cmds/ssh/ssh02 |    2 +-
>  testcases/network/tcp_cmds/ssh/ssh03 |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
> index 657449a..718f198 100755
> --- a/testcases/network/tcp_cmds/ssh/ssh01
> +++ b/testcases/network/tcp_cmds/ssh/ssh01
> @@ -57,7 +57,7 @@ do_setup()
>      # in adduser)
>      USER_UID=$(id -u $TEST_USER)
>      USER_GID=$(id -g $TEST_USER)
> -    if ! mkdir "$TEST_USER_HOMEDIR"; then
> +    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
>          end_testcase "Failed to create $TEST_USER_HOMEDIR"
>      fi
>      chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
> diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
> index 84c3637..a9974a0 100755
> --- a/testcases/network/tcp_cmds/ssh/ssh02
> +++ b/testcases/network/tcp_cmds/ssh/ssh02
> @@ -59,7 +59,7 @@ do_setup()
>      # in adduser)
>      USER_UID=$(id -u $TEST_USER)
>      USER_GID=$(id -g $TEST_USER)
> -    if ! mkdir "$TEST_USER_HOMEDIR"; then
> +    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
>          end_testcase "Failed to create $TEST_USER_HOMEDIR"
>      fi
>      chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
> diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
> index 5c7305e..927db76 100755
> --- a/testcases/network/tcp_cmds/ssh/ssh03
> +++ b/testcases/network/tcp_cmds/ssh/ssh03
> @@ -58,7 +58,7 @@ do_setup()
>      # in adduser)
>      USER_UID=$(id -u $TEST_USER)
>      USER_GID=$(id -g $TEST_USER)
> -    if ! mkdir "$TEST_USER_HOMEDIR"; then
> +    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
>          end_testcase "Failed to create $TEST_USER_HOMEDIR"
>      fi
>      chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
