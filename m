Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sandeep.mahato@sasken.com>) id 1S9bFf-0000Fb-Cx
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 11:59:51 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S9bFd-0007zy-NI
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 11:59:51 +0000
From: Sandeep Mahato <sandeep.mahato@sasken.com>
Date: Mon, 19 Mar 2012 17:29:40 +0530
Message-ID: <653A85C7F32C4741880F71219266EA02612A3E578E@EXGMBX01.sasken.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] cannot find -lpthread error in ltp cross compilation for
	Android
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,
  I am trying to cross compile LTP using NDK toolchain for Android . while executing the "make all" I am facing the below error.

pcb-msandeep:/u/ltp14032012/ltp-full-20120104# make all
make -C "lib" \
                -f "/u/ltp14032012/ltp-full-20120104/lib/Makefile" all
make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/lib'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/lib'
make -C "pan" \
                -f "/u/ltp14032012/ltp-full-20120104/pan/Makefile" all
make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/pan'
/u/ltp14032012/ltp-full-20120104/pan/Makefile:43: ltp-scanner will not be built because a working copy of lex was not found
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/pan'
make -C "utils" \
                -f "/u/ltp14032012/ltp-full-20120104/utils/Makefile" all
make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils'
make[2]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark'
make[3]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark/ebizzy-0.3'
arm-linux-androideabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include -I../../../include   -L../../../lib  ebizzy.c   -lpthread -o ebizzy
/usr/local/android-ndk-r7/my-android-toolchain/bin/../lib/gcc/arm-linux-androideabi/4.4.3/../../../../arm-linux-androideabi/bin/ld: cannot find -lpthread
collect2: ld returned 1 exit status
make[3]: *** [ebizzy] Error 1
make[3]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark/ebizzy-0.3'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils'
make: *** [utils-all] Error 2

Can anybody please tell me why this "cannot find -lpthread" error is coming and how to resolve that.


Regards
Sandeep

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
