Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N9w7M-0001ro-4U
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 07:35:20 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9w7F-0001cJ-R4
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 07:35:20 +0000
Received: by pwi12 with SMTP id 12so3340649pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 15 Nov 2009 23:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B00B3DB.7010803@cn.fujitsu.com>
References: <4B00B3DB.7010803@cn.fujitsu.com>
Date: Sun, 15 Nov 2009 23:35:08 -0800
Message-ID: <364299f40911152335x5b14f166gc3e9abd3c3640ba1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cpuctl_fj: fix syntax error of awk
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, jpalecek@web.de

On Sun, Nov 15, 2009 at 6:07 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> cpuctl_test_fj's case19-22 failed on my x86_64 box.
> ----------------------------------------------
> awk: print $9
> awk: ^ syntax error
> pid 8077 cpu_usage
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case19 =A0 =A0FAIL
> awk: print $9
> awk: ^ syntax error
> pid 8104 cpu_usage
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case20 =A0 =A0FAIL
> awk: print $9
> awk: ^ syntax error
> pid 8131 cpu_usage
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case21 =A0 =A0FAIL
> awk: print $9
> awk: ^ syntax error
> pid 8193 cpu_usage
> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case22 =A0 =A0FAIL
> ----------------------------------------------
> I fixed the syntax error of awk in the following patch.
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> --- ltp-full-20091031.orig/testcases/kernel/controllers/cpuctl_fj/run_cpu=
ctl_test_fj.sh 2009-11-02 04:07:14.000000000 -0500
> +++ ltp-full-20091031/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_t=
est_fj.sh =A0 =A0 =A02009-11-16 04:51:22.000000000 -0500
> @@ -85,7 +85,7 @@ creat_process()
>
> =A0get_cpu_usage()
> =A0{
> - =A0 =A0 =A0 top -b -n 1 -p $1 | tail -2 | head -1 | awk 'print $9' | aw=
k -F "." '{print $1}'
> + =A0 =A0 =A0 top -b -n 1 -p $1 | tail -2 | head -1 | awk '{print $9}' | =
awk -F "." '{print $1}'
> =A0}
>
> =A0kill_all_pid()

That code's just ugly anyhow. We shouldn't have to call top, when we
can call ps to do the same thing...

ps -eo 'pid,pcpu' | awk '$1 =3D=3D "'$1'" { sub(/(\.[[:digit:]])*$/, "",
$2); print $2 }'

Example:

ps -eo 'pid,pcpu' | awk '$1 =3D=3D "1" { sub(/(\.[[:digit:]])*$/, "", $2);
print $2 }'
0
ps -eo 'pid,pcpu' | awk '$1 =3D=3D "'$(pidof xfce4-session)'" {
sub(/(\.[[:digit:]])*$/, "", $2); print $2 }'
0
ps -eo 'pid,pcpu' | awk '$1 =3D=3D "'$(pidof vfork)'" {
sub(/(\.[[:digit:]])*$/, "", $2); print $2 }'
99

That's been committed to CVS.

Thanks for the report!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
