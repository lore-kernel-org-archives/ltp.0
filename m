Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O1wCh-0000zI-Sh
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 06:36:03 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O1wCf-0005ie-KZ
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 06:36:03 +0000
Received: by gya1 with SMTP id 1so3457354gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Apr 2010 23:35:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <s2m72fb0a5c1004132237k447d41f1occ861b51ce40be7@mail.gmail.com>
References: <s2m72fb0a5c1004132237k447d41f1occ861b51ce40be7@mail.gmail.com>
Date: Tue, 13 Apr 2010 23:35:56 -0700
Message-ID: <y2p364299f41004132335za6109aefvb37eadf5b3f4a2c5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Query
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
To: rahul agarwal <raahul4321@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 13, 2010 at 10:37 PM, rahul agarwal <raahul4321@gmail.com> wrote:
> I have a query regarding how to compile individual testcase in ltp.
>
> For example:
>
> fallocate tests inside syscalls are failing and so I want to compile and
> check them seperately after some modifications. But I am facing the problem
> due to various dependencies which are there. And as a result I am not being
> able to isolate the errors which I am facing.
>
> Kindly guide me so that I can overcome such a problem.

Hint:

    Files in runtest describe the tests. The format for runtests is:

# This is a call to a program called test-apps with args as the arguments!
testname1 test-app args

# I am a comment!

# The following is multiple commands strung together -- so I get run in a shell!
testname2 FOO=1; bar

1. You should export some variables like LTPROOT,  to your ltp
install, etc, i.e. these variables (clipped from runltp) if you want
the full experience:

    export LTPROOT=${PWD}
    export TMPBASE="/tmp"
    export PATH="${PATH}:${LTPROOT}/testcases/bin"
    export TMPBASE=`cd \`dirname ${OPTARG}\`; pwd`/`basename ${OPTARG}`
    export TMPTEMPLATE="${TMPBASE}/ltp-XXXXXXXXXX"
    export TMP
    export TMPDIR=$TMP
    export RHOST=$RHOST
    export PASSWD=$PASSWD

2. Or you can either pear down the runtest file, or use the
appropriate blacklist / whitelisting arguments via runltp (runltp
--help will give you more details).

Happy fishing,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
