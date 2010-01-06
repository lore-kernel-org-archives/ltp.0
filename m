Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSONx-0006Mq-5w
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:24:45 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSONw-0004Lv-9Z
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:24:45 +0000
Received: by pwj11 with SMTP id 11so11785728pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 21:24:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B44187D.5030702@cn.fujitsu.com>
References: <4B44187D.5030702@cn.fujitsu.com>
Date: Tue, 5 Jan 2010 21:24:38 -0800
Message-ID: <364299f41001052124ga613fbag6adf7a7460a87ccc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Jan 5, 2010 at 8:58 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> Some abnormal messages outputted in my x86_64.
> -------------------
> pid 4622 cpu_usage 0
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case19 =A0 =A0FAIL
> pid 4646 cpu_usage 0
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case20 =A0 =A0FAIL
> pid 4670 cpu_usage 63
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case21 =A0 =A0FAIL
> -------------------
> I think cpu usage's computation error occured.
> So I tried to use the oldest arithmetic of cpu usage, fortunately it work=
s.
> Maybe we should replace 'ps' by 'top' in =A0get_cpu_usage().
> By the way, I increased the admissible range of cpu usage in case21()
> because it jumps out range of 44-56 sometimes.
>
> My patch works now:
> -------------------
> pid 20277 cpu_usage 97
> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case19 =A0 =A0PASS
> pid 20307 cpu_usage 99
> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case20 =A0 =A0PASS
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 53
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 57
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 55
> pid 20336 cpu_usage 57
> pid 20336 cpu_usage 53
> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case21 =A0 =A0PASS
> -------------------
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> --- ltp-full-20091231/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_t=
est_fj.sh =A0 =A0 =A02009-11-16 15:40:40.000000000 +0800
> +++ ltp-full-20091231.new/testcases/kernel/controllers/cpuctl_fj/run_cpuc=
tl_test_fj.sh =A02010-01-06 12:36:32.000000000 +0800
> @@ -85,7 +85,10 @@ creat_process()
>
> =A0get_cpu_usage()
> =A0{
> - =A0 =A0 =A0 ps -eo 'pid,pcpu' | awk '$1 =3D=3D "'$1'" { sub(/(\.[[:digi=
t:]])*$/, "", $2); print $2 }'
> + =A0 =A0 =A0 top=3D($(top -b -n 1 -p $1 | tail -2 | head -1))
> + =A0 =A0 =A0 top=3D${top[8]}
> + =A0 =A0 =A0 top=3D`echo $top | awk -F "." '{print $1}'`
> + =A0 =A0 =A0 echo "$top"
> =A0}
>
> =A0kill_all_pid()
> @@ -627,7 +630,7 @@ case21()
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_usage=3D$(get_cpu_usage $pid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "pid $pid cpu_usage $cpu_usage"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 expr 44 \< "$cpu_usage" \& "$cpu_usage" \< =
56 > /dev/null 2>&1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 expr 40 \< "$cpu_usage" \& "$cpu_usage" \< =
60 > /dev/null 2>&1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret=3D$?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: $(( top_times+=3D1 ))
> =A0 =A0 =A0 =A0done

    Could you add a set -x to the top of the script so we can see the
output please? ps --version would be helpful too..
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
