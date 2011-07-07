Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QepqI-0007vQ-SE
	for ltp-list@lists.sourceforge.net; Thu, 07 Jul 2011 14:46:14 +0000
Date: Thu, 7 Jul 2011 16:47:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110707144713.GB17217@saboteur.suse.cz>
References: <1309875852-3514-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309875852-3514-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH] mq_timedsend01: do not write out of the array
 boundaries.
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When preparing the message to be sent, limit the number of written bytes
> to the array's size, otherwise it will be detected as a stack smashing attack
> and the test case will be killed, as from the output below:
> 
> <<<test_start>>>
> tag=mq_timedsend01 stime=948808768
> cmdline="mq_timedsend01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> 
> ... [SNIP] ...
> 
> mq_timedsend01    0  TINFO  :  (case04) START
> EXPECT: return value(ret)=-1 errno=90 (Message too long)
> RESULT: return value(ret)=-1 errno=90 (Message too long)
> stack smashing detected: mq_timedsend01 terminated()
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=signaled termination_id=6 corefile=no
> cutime=0 cstime=2
> <<<test_end>>>
> 
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> ---
>  .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> index 63add02..db2b272 100644
> --- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> +++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> @@ -367,7 +367,7 @@ static int do_test(struct test_case *tc)
>  	/*
>  	 * Prepare send message
>  	 */
> -	for (i = 0; i < tc->len; i++)
> +	for (i = 0; i < tc->len && i < sizeof(smsg); i++)
>  		smsg[i] = i;
>  
>  	/*

Perhaps increasing the smsg and rmsg array to MAX_MSGSIZE + 1 would be
more consistend. Commited anyway, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
