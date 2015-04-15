Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YiN8d-0005xH-W9
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 13:13:56 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YiN8Y-0002xb-1C
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 13:13:55 +0000
Date: Wed, 15 Apr 2015 09:13:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2086590012.310353.1429103623121.JavaMail.zimbra@redhat.com>
In-Reply-To: <1429090029-25456-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1429090029-25456-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] max_map_count: tst_fork() instead of fork()
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Wednesday, 15 April, 2015 11:27:09 AM
> Subject: [LTP] [PATCH] max_map_count: tst_fork() instead of fork()
> 
> In order to put output messages in order and remove "duplicates",
> we need a fflush() before forking and tst_fork() does it.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Should be safe even this to release.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

> ---
>  testcases/kernel/mem/tunable/max_map_count.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c
> b/testcases/kernel/mem/tunable/max_map_count.c
> index 96ec2b8..2c0599e 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -200,7 +200,7 @@ static void max_map_count_test(void)
>  	while (max_maps <= max_iters) {
>  		set_sys_tune("max_map_count", max_maps, 1);
>  
> -		switch (pid = fork()) {
> +		switch (pid = tst_fork()) {
>  		case -1:
>  			tst_brkm(TBROK | TERRNO, cleanup, "fork");
>  		case 0:
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
> Develop your own process in accordance with the BPMN 2 standard
> Learn Process modeling best practices with Bonita BPM through live exercises
> http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
> source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
