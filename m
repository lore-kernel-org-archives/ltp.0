Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NXNX0-0002Q4-KE
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 23:30:42 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXNWz-0000jM-1n
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 23:30:42 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Wed, 20 Jan 2010 01:30:30 +0100
References: <4B44187D.5030702@cn.fujitsu.com>
	<364299f41001052124ga613fbag6adf7a7460a87ccc@mail.gmail.com>
	<4B445C36.6040505@cn.fujitsu.com>
In-Reply-To: <4B445C36.6040505@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201001200130.30897.jpalecek@web.de>
Subject: Re: [LTP] [PATCH] cpuctl_fj: replace ps by top to fix cpu usage's
	computation error
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wednesday 06 January 2010 10:47:34 Shi Weihua wrote:
> at 2010-1-6 13:24, Garrett Cooper wrote:
> > On Tue, Jan 5, 2010 at 8:58 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> >> Some abnormal messages outputted in my x86_64.
> >> -------------------
> >> pid 4622 cpu_usage 0
> >> cpuctl_test_fj    1  TFAIL  :  case19    FAIL
> >> pid 4646 cpu_usage 0
> >> cpuctl_test_fj    1  TFAIL  :  case20    FAIL
> >> pid 4670 cpu_usage 63
> >> cpuctl_test_fj    1  TFAIL  :  case21    FAIL
> >> -------------------
> >> I think cpu usage's computation error occured.
> >> So I tried to use the oldest arithmetic of cpu usage, fortunately it works.
> >> Maybe we should replace 'ps' by 'top' in  get_cpu_usage().
> >> By the way, I increased the admissible range of cpu usage in case21()
> >> because it jumps out range of 44-56 sometimes.
> >>
> >> My patch works now:
> >> -------------------
> >> pid 20277 cpu_usage 97
> >> cpuctl_test_fj    1  TPASS  :  case19    PASS
> >> pid 20307 cpu_usage 99
> >> cpuctl_test_fj    1  TPASS  :  case20    PASS
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 53
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 57
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 55
> >> pid 20336 cpu_usage 57
> >> pid 20336 cpu_usage 53
> >> cpuctl_test_fj    1  TPASS  :  case21    PASS
> >> -------------------
> >>
> >> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> >> ---
> >> --- ltp-full-20091231/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh      2009-11-16 15:40:40.000000000 +0800
> >> +++ ltp-full-20091231.new/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh  2010-01-06 12:36:32.000000000 +0800
> >> @@ -85,7 +85,10 @@ creat_process()
> >>
> >>  get_cpu_usage()
> >>  {
> >> -       ps -eo 'pid,pcpu' | awk '$1 == "'$1'" { sub(/(\.[[:digit:]])*$/, "", $2); print $2 }'
> >> +       top=($(top -b -n 1 -p $1 | tail -2 | head -1))
> >> +       top=${top[8]}
> >> +       top=`echo $top | awk -F "." '{print $1}'`
> >> +       echo "$top"
> >>  }
> >>
> >>  kill_all_pid()
> >> @@ -627,7 +630,7 @@ case21()
> >>        do
> >>                cpu_usage=$(get_cpu_usage $pid)
> >>                echo "pid $pid cpu_usage $cpu_usage"
> >> -               expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 > /dev/null 2>&1
> >> +               expr 40 \< "$cpu_usage" \& "$cpu_usage" \< 60 > /dev/null 2>&1
> >>                ret=$?
> >>                : $(( top_times+=1 ))
> >>        done
> > 
> >     Could you add a set -x to the top of the script so we can see the
> > output please? ps --version would be helpful too..
> 
> I wish it can help you.
> --------------------- sh -x -----------------------------
> + for i in '$(seq 1 $TST_TOTAL)'
> + setup

[ ... snip ... ]

I believe Garrett Cooper meant to send the trace output of the original script (the one with ps).

However, I'm not sure about the awk program there - particularly:

sub(/(\.[[:digit:]])*$/, "", $2)

should probably be

sub(/\.[[:digit:]]*$/, "", $2) 

(without the group). Not sure if this can actually cause what you see.

Also, I think we could simplify it a bit further, to something like this:

get_cpu_usage()
{
  ps -p $1 -o pcpu= | awk -F "." '{print $1}'
}

Please, tell me what do you think about it.

Regards
    Jiri Palecek

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
