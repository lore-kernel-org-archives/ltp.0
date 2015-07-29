Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKTJ1-0003ea-1V
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 15:30:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKTIy-0000ei-Sk
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 15:30:07 +0000
Date: Wed, 29 Jul 2015 17:29:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150729152949.GA6478@rei.suse.de>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
	<20150729144508.GB3427@rei.suse.de>
	<CANKSX+ETp0jdXp+zSUtUPn8SWUQaCh1bETYzcpF_C8kZpPtGdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+ETp0jdXp+zSUtUPn8SWUQaCh1bETYzcpF_C8kZpPtGdQ@mail.gmail.com>
Subject: Re: [LTP] LTP make failed
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> arm-linux-gnueabi-gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W -static -Wold-style-definition   -I/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/../include -I../../../include -I../../../include  -c -o numa_helper.o numa_helper.c
> numa_helper.c: In function ??get_nodemask_allnodes??:
> numa_helper.c:68:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> numa_helper.c:71:4: warning: implicit declaration of function ??nodemask_set?? [-Wimplicit-function-declaration]
> numa_helper.c: In function ??cpumask_has_cpus??:
> numa_helper.c:107:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> numa_helper.c: In function ??filter_nodemask_cpu??:
> numa_helper.c:125:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> numa_helper.c:126:3: warning: implicit declaration of function ??nodemask_isset?? [-Wimplicit-function-declaration]
> numa_helper.c:133:5: warning: implicit declaration of function ??nodemask_clr?? [-Wimplicit-function-declaration]
> numa_helper.c: In function ??get_allowed_nodes_arr??:
> numa_helper.c:190:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> if [ -z "numa_helper.o" ] ; then \
>                 echo "Cowardly refusing to create empty archive"; \
>                 exit 1; \
>         fi
> arm-linux-gnueabi-ar -rc "/prj/vlsi/tools/libraries" numa_helper.o
> arm-linux-gnueabi-ar: /prj/vlsi/tools/libraries: No such file or directory
> make: *** [/prj/vlsi/tools/libraries] Error 1

Now this is pretty much random filesystem patch.

This looks like a hardware/kernel bug to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
