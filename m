Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NXQgk-0001tm-6D
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 02:52:58 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXQgh-0003HJ-EX
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 02:52:57 +0000
Received: by pxi38 with SMTP id 38so1383240pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Jan 2010 18:52:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201001200130.30897.jpalecek@web.de>
References: <4B44187D.5030702@cn.fujitsu.com>
	<364299f41001052124ga613fbag6adf7a7460a87ccc@mail.gmail.com>
	<4B445C36.6040505@cn.fujitsu.com> <201001200130.30897.jpalecek@web.de>
Date: Tue, 19 Jan 2010 18:52:48 -0800
Message-ID: <364299f41001191852s5a13235bh31e8e5feb68978b9@mail.gmail.com>
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Jan 19, 2010 at 4:30 PM, Jiri Palecek <jpalecek@web.de> wrote:
> On Wednesday 06 January 2010 10:47:34 Shi Weihua wrote:
>> at 2010-1-6 13:24, Garrett Cooper wrote:
>> > On Tue, Jan 5, 2010 at 8:58 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrot=
e:
>> >> Some abnormal messages outputted in my x86_64.
>> >> -------------------
>> >> pid 4622 cpu_usage 0
>> >> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case19 =A0 =A0FAIL
>> >> pid 4646 cpu_usage 0
>> >> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case20 =A0 =A0FAIL
>> >> pid 4670 cpu_usage 63
>> >> cpuctl_test_fj =A0 =A01 =A0TFAIL =A0: =A0case21 =A0 =A0FAIL
>> >> -------------------
>> >> I think cpu usage's computation error occured.
>> >> So I tried to use the oldest arithmetic of cpu usage, fortunately it =
works.
>> >> Maybe we should replace 'ps' by 'top' in =A0get_cpu_usage().
>> >> By the way, I increased the admissible range of cpu usage in case21()
>> >> because it jumps out range of 44-56 sometimes.
>> >>
>> >> My patch works now:
>> >> -------------------
>> >> pid 20277 cpu_usage 97
>> >> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case19 =A0 =A0PASS
>> >> pid 20307 cpu_usage 99
>> >> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case20 =A0 =A0PASS
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 53
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 57
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 55
>> >> pid 20336 cpu_usage 57
>> >> pid 20336 cpu_usage 53
>> >> cpuctl_test_fj =A0 =A01 =A0TPASS =A0: =A0case21 =A0 =A0PASS
>> >> -------------------
>> >>
>> >> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>> >> ---
>> >> --- ltp-full-20091231/testcases/kernel/controllers/cpuctl_fj/run_cpuc=
tl_test_fj.sh =A0 =A0 =A02009-11-16 15:40:40.000000000 +0800
>> >> +++ ltp-full-20091231.new/testcases/kernel/controllers/cpuctl_fj/run_=
cpuctl_test_fj.sh =A02010-01-06 12:36:32.000000000 +0800
>> >> @@ -85,7 +85,10 @@ creat_process()
>> >>
>> >> =A0get_cpu_usage()
>> >> =A0{
>> >> - =A0 =A0 =A0 ps -eo 'pid,pcpu' | awk '$1 =3D=3D "'$1'" { sub(/(\.[[:=
digit:]])*$/, "", $2); print $2 }'
>> >> + =A0 =A0 =A0 top=3D($(top -b -n 1 -p $1 | tail -2 | head -1))
>> >> + =A0 =A0 =A0 top=3D${top[8]}
>> >> + =A0 =A0 =A0 top=3D`echo $top | awk -F "." '{print $1}'`
>> >> + =A0 =A0 =A0 echo "$top"
>> >> =A0}
>> >>
>> >> =A0kill_all_pid()
>> >> @@ -627,7 +630,7 @@ case21()
>> >> =A0 =A0 =A0 =A0do
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_usage=3D$(get_cpu_usage $pid)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "pid $pid cpu_usage $cpu_usage"
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 expr 44 \< "$cpu_usage" \& "$cpu_usage"=
 \< 56 > /dev/null 2>&1
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 expr 40 \< "$cpu_usage" \& "$cpu_usage"=
 \< 60 > /dev/null 2>&1
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret=3D$?
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: $(( top_times+=3D1 ))
>> >> =A0 =A0 =A0 =A0done
>> >
>> > =A0 =A0 Could you add a set -x to the top of the script so we can see =
the
>> > output please? ps --version would be helpful too..
>>
>> I wish it can help you.
>> --------------------- sh -x -----------------------------
>> + for i in '$(seq 1 $TST_TOTAL)'
>> + setup
>
> [ ... snip ... ]
>
> I believe Garrett Cooper meant to send the trace output of the original s=
cript (the one with ps).
>
> However, I'm not sure about the awk program there - particularly:
>
> sub(/(\.[[:digit:]])*$/, "", $2)
>
> should probably be
>
> sub(/\.[[:digit:]]*$/, "", $2)
>
> (without the group). Not sure if this can actually cause what you see.
>
> Also, I think we could simplify it a bit further, to something like this:
>
> get_cpu_usage()
> {
> =A0ps -p $1 -o pcpu=3D | awk -F "." '{print $1}'
> }
>
> Please, tell me what do you think about it.

    Actually he gave me what I needed (forgot to reply because I
didn't star the email); I'm pretty sure that your observation is
correct: we shouldn't be extracting \. unless we're actually going to
use it, so the ellipses [\(\)] can be removed.
    Are we using just the `major' number, or are we using the `minor'
number in the cpu usage?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
