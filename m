Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SNGQY-0004t2-Sg
	for ltp-list@lists.sourceforge.net; Thu, 26 Apr 2012 04:35:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SNGQX-0003oC-45
	for ltp-list@lists.sourceforge.net; Thu, 26 Apr 2012 04:35:34 +0000
Message-ID: <4F98C68E.9050809@cn.fujitsu.com>
Date: Thu, 26 Apr 2012 11:52:46 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [BUG] I'm reporting a bug about file
Reply-To: gaowanlong@cn.fujitsu.com
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
To: file@mx.gw.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi folks,

Here, I'm reporting a bug, maybe it is solved upstream,
but it's already on Fedora 16. Below shows the bug,

It appears when testing https://github.com/linux-test-project/ltp/blob/master/testcases/commands/ade/file/file_test.sh#L292

the file command can't recognize below file as a "C program" file but just a ASSCII text.

> cat > $LTPTMP/cprog.c <<EOF
> #include <stdio.h>
> 
> main()
> {
> printf("Hello Hell\n");
> exit(0);
> }
> EOF





But when I add a line like "#include <stdlib.h>", it can recognize to a "C program" file,
this problem doesn't appear on RHEL6 but appears recently.

And just test use the files under the source of "file" command like,

> $ file src/file.c 
> src/file.c: ASCII English text






Do you think this is a bug, or I missed something?

Can you file command guys give me some idea about this?



Thanks in advance,
Wanlong Gao

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
