Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAeMf-00082f-M6
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 13:17:17 +0000
Date: Thu, 2 Jul 2015 15:15:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702131556.GA17833@rei.suse.de>
References: <1435814949-4420-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435814949-4420-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] network/xinetd: wait a while to make sure telnetd
 restart
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> telnetd not restart immediately after xinetd restart, which make xinetd
> failed. e.g.
> \# service xinetd restart; echo "^D" | /usr/bin/telnet ::1
> Stopping xinetd: [  OK  ]
> Starting xinetd: [  OK  ]
> Trying ::1...
> telnet: connect to address ::1: Connection refused
> 
> Wait a while after xinetd restart will make sure telnetd up and the test passed
> 
> \# service xinetd restart; sleep 1; echo "^D" | /usr/bin/telnet ::1
> Stopping xinetd: [  OK  ]
> Starting xinetd: [  OK  ]
> Trying ::1...
> Connected to ::1.
> Escape character is '^]'.
> Connection closed by foreign host.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/network/xinetd/xinetd_tests.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index ff1219a..a12f6b9 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -315,6 +315,8 @@ test01()
>          fi
>      fi
>  
> +    sleep 1s

No random sleeps in testcases please. Can you rather change the code to
retry in case of failure?

Something as:

$RETRIES=10
while [ $RETRIES -gt 0 ]; do
	echo "^D" | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
	if [ $? -eq 0 ]; then
		break;
	fi
	RETRIES=$((RETRIES-1))
	sleep 1
done


Looking at the code, most of it could be moved into the test library
in order to be reused by other testcases. Maybe we should add tst_retry
function that would retry a command a few times...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
