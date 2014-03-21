Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ciprian.barbu@linaro.org>) id 1WQxOC-0003of-1F
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 11:13:28 +0000
Received: from mail-ee0-f50.google.com ([74.125.83.50])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WQxOB-0004iS-0W
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 11:13:28 +0000
Received: by mail-ee0-f50.google.com with SMTP id c13so1656571eek.37
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Mar 2014 04:13:20 -0700 (PDT)
Message-ID: <532C194C.7090307@linaro.org>
Date: Fri, 21 Mar 2014 12:49:48 +0200
From: Ciprian Barbu <ciprian.barbu@linaro.org>
MIME-Version: 1.0
References: <1394464444-23803-1-git-send-email-ciprian.barbu@linaro.org>
In-Reply-To: <1394464444-23803-1-git-send-email-ciprian.barbu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH] Fix ltp realtime hrtimer-prio and
 measurement to pass default profile to run_c_files.sh
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
To: Ciprian Barbu <ciprian.barbu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hello,

On 10.03.2014 17:14, Ciprian Barbu wrote:
> Signed-off-by: Ciprian Barbu <ciprian.barbu@linaro.org>
>
> Upstream-Status: Pending
> ---
>   testcases/realtime/func/hrtimer-prio/run_auto.sh |    4 +++-
>   testcases/realtime/func/measurement/run_auto.sh  |    6 ++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/realtime/func/hrtimer-prio/run_auto.sh b/testcases/realtime/func/hrtimer-prio/run_auto.sh
> index 366e746..ec3d83a 100644
> --- a/testcases/realtime/func/hrtimer-prio/run_auto.sh
> +++ b/testcases/realtime/func/hrtimer-prio/run_auto.sh
> @@ -1,5 +1,7 @@
>   #! /bin/bash
>
> +profile=${1:-default}
> +
>   if [ ! $SCRIPTS_DIR ]; then
>           # assume we're running standalone
>           export SCRIPTS_DIR=../../scripts/
> @@ -7,4 +9,4 @@ fi
>
>   source $SCRIPTS_DIR/setenv.sh
>
> -$SCRIPTS_DIR/run_c_files.sh "hrtimer-prio"
> +$SCRIPTS_DIR/run_c_files.sh $profile "hrtimer-prio"
> diff --git a/testcases/realtime/func/measurement/run_auto.sh b/testcases/realtime/func/measurement/run_auto.sh
> index 3011964..439f721 100644
> --- a/testcases/realtime/func/measurement/run_auto.sh
> +++ b/testcases/realtime/func/measurement/run_auto.sh
> @@ -1,5 +1,7 @@
>   #! /bin/bash
>
> +profile=${1:-default}
> +
>   if [ ! $SCRIPTS_DIR ]; then
>           # assume we're running standalone
>           export SCRIPTS_DIR=../../scripts/
> @@ -13,7 +15,7 @@ source $SCRIPTS_DIR/setenv.sh
>   # issues right now.
>
>   LOG_FILE="$LOG_DIR/$LOG_FORMAT-rdtsc-latency.log"
> -$SCRIPTS_DIR/run_c_files.sh "rdtsc-latency"
> +$SCRIPTS_DIR/run_c_files.sh $profile "rdtsc-latency"
>
>   LOG_FILE="$LOG_DIR/$LOG_FORMAT-preempt_timing.log"
> -$SCRIPTS_DIR/run_c_files.sh "preempt_timing"
> +$SCRIPTS_DIR/run_c_files.sh $profile "preempt_timing"
>

Sorry if I'm being insistent, has anyone got the chance to look at this 
patch? I would like to know if it can be applied to master.

Kind regards,
Ciprian

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
