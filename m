Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC8Bm-0002IX-C4
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 14:15:38 +0000
Date: Tue, 29 Jul 2014 16:14:52 +0200
From: chrubis@suse.cz
Message-ID: <20140729141452.GA27444@rei>
References: <1a3dd40e9f83bca2de34b08c8b0ac34874cae438.1406638271.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a3dd40e9f83bca2de34b08c8b0ac34874cae438.1406638271.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] extract pidns tests from runpidnstest.sh to
 runtest/container
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Extract pinds testcases from container_test.sh and list
> all separately in container runtest.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/containers                                 |   15 +++
>  testcases/kernel/containers/container_test.sh      |    8 --
>  testcases/kernel/containers/pidns/.gitignore       |    2 +-
>  testcases/kernel/containers/pidns/Makefile         |    1 +
>  .../kernel/containers/pidns/check_pidns_enabled.c  |   70 -------------
>  testcases/kernel/containers/pidns/pidns01.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns02.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns03.c        |    3 +-
>  testcases/kernel/containers/pidns/pidns04.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns05.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns06.c        |   10 ++
>  testcases/kernel/containers/pidns/pidns10.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns12.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns13.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns16.c        |   10 ++
>  testcases/kernel/containers/pidns/pidns17.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns20.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns30.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns31.c        |    9 ++
>  testcases/kernel/containers/pidns/pidns_helper.c   |   37 +++++++
                                     ^
				     I would name this one
				     pidns_helper.h so that we don't
				     have to skip it in the Makefile

The rest looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
