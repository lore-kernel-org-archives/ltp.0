Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OTKOV-0003Zc-Db
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 19:53:27 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTKOT-0005YW-76
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 19:53:26 +0000
MIME-Version: 1.0
In-Reply-To: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
References: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
Date: Mon, 28 Jun 2010 12:53:11 -0700
Message-ID: <AANLkTim8L2Ea9GnBKlvipbCbdWvXyPanpomq7L3ncb_S@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP List Members <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>

On Mon, Jun 28, 2010 at 4:52 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Hi,
>
> The recently introduced option:
>
> -K DMESG_LOG_DIR
> =A0 =A0 =A0 =A0Log Kernel messages generated for each test cases inside t=
his directory,
>
> when used will generate huge no. of files inside the DMESG_DIR. Many of
> them will be ZERO size as we do not expect KERNEL MESSAGE to be generated
> against all the LTP TESTS that we will run. It is better to prune them, a=
nd
> let only those files exist which will have real entries. The following
> patch fixes the same.
>
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>,
> ---
>
> --- ltp/runltp.orig =A0 =A0 2010-06-28 10:02:42.000000000 +0530
> +++ ltp/runltp =A02010-06-28 10:21:04.000000000 +0530
> @@ -858,6 +858,30 @@ main()
> =A0 =A0 cd ..
> =A0 =A0 echo "LTP Version: $version_date"
>
> + =A0 =A0 =A0 # DMESG_DIR will contain hell lot of files which will not h=
ave any entry
> + =A0 =A0 =A0 # since kernel message(s) will not be generated for every t=
est. The zero size
> + =A0 =A0 =A0 # files will clog the directory. Lets keep only those fules=
 which have real
> + =A0 =A0 =A0 # kernel message entries. If DMESG_DIR directroy is empty a=
fter test run, it
> + =A0 =A0 =A0 # will indicate that no kernel message was generated during=
 test run
> +

This comment could be abbreviated to:

# $DMESG_DIR is used to cache messages obtained from dmesg after a test run.
# Proactively reap all of the 0-byte files in $DMESG_DIR as they have zero =
value
# and only clutter up the filesystem.

> + =A0 =A0 =A0 if [ $ALT_DMESG_OUT -eq 1 ] ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PWD=3D`pwd`

Please use a different variable name. This obfuscates the meaning of
the shell set value.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd $DMESG_DIR

What if this fails? Won't this nuke all of the files in the current
directory? Are you checking to ensure that this isn't empty beforehand
as well? I hate it when scripts nuke files like this (I lost several
hours of work last week because of a similar mistake).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for dmesg_file in `ls`
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmesg_file_size=3D`wc -c $d=
mesg_file | cut -d ' ' -f1 | tr -d '\n'`
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $dmesg_file_size -eq 0=
 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -rf $dme=
sg_file
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 done
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd $PWD
> + =A0 =A0 =A0 fi

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
