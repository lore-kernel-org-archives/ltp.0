Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1OLZVH-0004c3-A0
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 10:24:23 +0000
Received: from wine.ocn.ne.jp ([122.1.235.145] helo=smtp.wine.ocn.ne.jp)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OLZVE-0000hj-Cz
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 10:24:23 +0000
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<1275834288.7037.3.camel@subratamodak.linux.ibm.com>
	<201006070651.o576p4S0093912@www262.sakura.ne.jp>
	<1275901898.4851.2.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1275901898.4851.2.camel@subratamodak.linux.ibm.com>
Message-Id: <201006071924.CHE69736.FtHLVMFOFQOJOS@I-love.SAKURA.ne.jp>
Date: Mon, 7 Jun 2010 19:24:09 +0900
Mime-Version: 1.0
Subject: Re: [LTP] [linux-2.6.36] TOMOYO Linux update
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Subrata Modak wrote:
> However, this patch did not apply as it was not created properly:
That's strange... I can apply this patch cleanly. What tree should I use?

[root@tomoyo tmp]# wget 'http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;s
f=tgz'
--2010-06-07 19:19:34--  http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz
Resolving ltp.git.sourceforge.net... 216.34.181.91
Connecting to ltp.git.sourceforge.net|216.34.181.91|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/x-gzip]
Saving to: `gitweb.cgi?p=ltp%2Fltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz'

    [                                                                          <=>                          ] 8,240,148    118K/s   in 77s

2010-06-07 19:20:54 (104 KB/s) - `gitweb.cgi?p=ltp%2Fltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz' saved [8240148]

[root@tomoyo tmp]# tar -zxf gitweb.cgi\?p\=ltp%2Fltp-dev.git\;a\=snapshot\;h\=7f20a3add6c7f2166dbab5a712713ae8b5943448\;sf\=tgz
[root@tomoyo tmp]# cd ltp-dev/
[root@tomoyo ltp-dev]# wget 'http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&r
oot=tomoyo'
--2010-06-07 19:21:31--  http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&root=tomoyo
Resolving sourceforge.jp... 202.221.179.21
Connecting to sourceforge.jp|202.221.179.21|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/unregisterd-mime-type-to-avoid-IE-MIME-sniffing]
Saving to: `tomoyo-ltp.diff?revision=3740&root=tomoyo'

    [ <=>                                                                                                   ] 141,420     --.-K/s   in 0.08s

2010-06-07 19:21:31 (1.75 MB/s) - `tomoyo-ltp.diff?revision=3740&root=tomoyo' saved [141420]

[root@tomoyo ltp-dev]# md5sum tomoyo-ltp.diff\?revision\=3740\&root\=tomoyo
aeb0af73a8f140d50d4ab7435b10de16  tomoyo-ltp.diff?revision=3740&root=tomoyo
[root@tomoyo ltp-dev]# patch --dry-run -p1 < tomoyo-ltp.diff\?revision\=3740\&root\=tomoyo
patching file testcases/kernel/security/tomoyo/README
patching file testcases/kernel/security/tomoyo/include.h
patching file testcases/kernel/security/tomoyo/newns.c
patching file testcases/kernel/security/tomoyo/testall.sh
patching file testcases/kernel/security/tomoyo/tomoyo_accept_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_file_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_new_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_policy_io_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_policy_memory_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_rewrite_test.c
[root@tomoyo ltp-dev]#

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
