Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1UuHcJ-0002Vo-9F
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 07:36:43 +0000
Received: from mail-we0-f178.google.com ([74.125.82.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UuHcH-0007Af-87
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 07:36:43 +0000
Received: by mail-we0-f178.google.com with SMTP id u53so4855690wes.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Jul 2013 00:36:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51D38924.8090400@oracle.com>
References: <mailman.80890.1372765469.12996.ltp-list@lists.sourceforge.net>
	<51D38924.8090400@oracle.com>
Date: Wed, 3 Jul 2013 09:36:34 +0200
Message-ID: <CA+icZUW=dX6NLpAWRA8neeJDZ7XP1bNhui-CtLLySP+Mfy6XMQ@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [LTP] [ltp-full-20130503] runltp cleanup() can't remove ${TMP}
Reply-To: sedat.dilek@gmail.com
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
To: Eko <hong.sun@oracle.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 3, 2013 at 4:15 AM, Eko <hong.sun@oracle.com> wrote:
> hi,
>
>  I executed runltp command in my box, everything is OK, but when cleaning
> the environment, got following errors:
>
>        ###############################################################
>             Done executing testcases.
>             LTP Version:  20130503
>        ###############################################################
> rm: cannot remove `/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458': Device or
> resource busy
> rm: cannot remove `/tmp/ltp-9NAwvmAbI5/sandbox': Device or resource busy
>
>
> Because  /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458 and
> /tmp/ltp-9NAwvmAbI5/sandbox are still mounted, so can't delete them, the
> best way is:
> # umount /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458
> # umount /tmp/ltp-9NAwvmAbI5/sandbox
>
> and then:
>
>     [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
>     [ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img
>     rm -rf ${TMP}
>
>

I have seen the same when dealing with a mount/ext4-fs issue (turned
out to be a BASHISM) and reading the code.
$TEMP is never used, it should be $TMP.

BTW, this line - which needs to be corrected...

[ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img

...makes no real sense, when doing...

rm -rf ${TMP}

...afterwards :-).

If you look at the code, for me it was not clear what $TMP
reflects/is, please look closer.
I remember darkly, it was swapped somewhere...

BTW, I have seen a lot of discrepancy in coding-style, beginning with
comments, etc.
The code was touched by different coders, so everyone seems to leave a
bit from his/her style.

    # DO NOT INDENT/DEDENT!
    # ^^DO NOT INDENT/DEDENT!^^

That should be changed to sth like "DO NOT INDENT/DEDENT - OR I KILL
YOU!" <--- /me just kidding

Unfortunately, I had a wait.h-issue in Linux-next to go through.

Anyway, runltp needs some more love.

- Sedat -

> --
> Best Regards,
> Eko
> --
>
>
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Windows:
>
> Build for Windows Store.
>
> http://p.sf.net/sfu/windows-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
