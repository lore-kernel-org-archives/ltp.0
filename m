Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OTKIp-0007lD-5b
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 19:47:35 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTKIn-0007AK-0S
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 19:47:35 +0000
MIME-Version: 1.0
In-Reply-To: <201006281544.13666.vapier@gentoo.org>
References: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
	<201006281544.13666.vapier@gentoo.org>
Date: Mon, 28 Jun 2010 12:47:27 -0700
Message-ID: <AANLkTinzjwlLcX6zJ30Fxu9UjondsMavX21qXKfov840@mail.gmail.com>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP List Members <ltp-list@lists.sf.net>

On Mon, Jun 28, 2010 at 12:44 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday, June 28, 2010 07:52:18 Subrata Modak wrote:
>> + =A0 =A0 if [ $ALT_DMESG_OUT -eq 1 ] ; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 PWD=3D`pwd`
>> + =A0 =A0 =A0 =A0 =A0 =A0 cd $DMESG_DIR
>> + =A0 =A0 =A0 =A0 =A0 =A0 for dmesg_file in `ls`
>> + =A0 =A0 =A0 =A0 =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmesg_file_size=3D`wc -c $dmes=
g_file | cut -d ' ' -f1 | tr -d
> '\n'`
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $dmesg_file_size -eq 0 ];=
 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -rf $dmesg_=
file
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 =A0 =A0 =A0 done
>> + =A0 =A0 =A0 =A0 =A0 =A0 cd $PWD
>> + =A0 =A0 fi
>
> ugh. =A0what's wrong with simply executing:
> =A0 =A0 =A0 =A0find "$DMESG_DIR" -size 0 -exec rm {} +

Or find "$DMESG_DIR" -size 0 | xargs rm -f ?

>> + =A0 =A0 if [ `ls -l $DMESG_DIR | wc -l` -ge 1 ]; then
>
> if [ -n "$(ls "$DMESG_DIR")" ] ; then
> -mike

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
