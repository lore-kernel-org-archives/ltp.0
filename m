Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NX7k2-00042v-2z
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 06:39:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NX7jz-000593-Mv
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 06:39:06 +0000
Message-ID: <4B5553EE.6070707@cn.fujitsu.com>
Date: Tue, 19 Jan 2010 14:40:46 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <89D32649C0790143AB985A5BF77A104F02BFAA2B@etsmsg-hkexm05.etsmsg.org>
In-Reply-To: <89D32649C0790143AB985A5BF77A104F02BFAA2B@etsmsg-hkexm05.etsmsg.org>
Subject: Re: [LTP] LTP math testsuite - float_power test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4034476117020009477=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Kiran.Girmaji@Emerson.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4034476117020009477==
Content-Type: multipart/alternative;
	boundary="------------010906030903070308050809"

This is a multi-part message in MIME format.
--------------010906030903070308050809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The new version has fixed this problem.
Plz try the new version.

Thanks.
Liu Bo

On 01/19/2010 01:46 PM, Kiran.Girmaji@Emerson.com wrote:
> Hi,
>  
> I am running LTP math testsuite and float_power test fails with the
> following output.
> Could anyone please guide me.
>  
> My machine details -
> 64bit Intel Xeon based with windriver linux.
> Linux megatron 2.6.21.7-WR2.0ap_cgl #1 SMP PREEMPT Fri Jan 8 01:49:51
> IST 2010 x86_64 x86_64 x86_64 GNU/Linux
>
>  
>  Running tests.......
> <<<test_start>>>
> tag=float_power stime=1034389477
> cmdline="cd $LTPROOT/testcases/bin; float_power -v"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> float_power    0  TINFO  :  float_power: will run for 500 loops
> float_power    0  TINFO  :  float_power: using . as data directory
> float_power    0  TINFO  :  float_power: will run 6 functions, 20
> threads per function
> float_power    0  TINFO  :  signal handler 1082132800 started
> float_power    0  TINFO  :  Signal handler starts waiting...
> float_power    0  TINFO  :  Initial thread: Waiting for 120 threads to
> finish
> float_power    0  TINFO  :  thread 0 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 1 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 2 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 3 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 4 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 5 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 6 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 7 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 8 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 9 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 10 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 11 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 12 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 13 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 14 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 15 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 16 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 17 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 18 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 19 (ceil) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 20 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 21 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 22 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 23 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 24 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 25 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 26 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 27 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 28 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 29 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 30 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 31 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 32 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 33 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 34 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 35 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 36 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 37 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 38 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 39 (fabs) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 40 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 41 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 42 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 43 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 44 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 45 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 46 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 47 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 48 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 49 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 50 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 51 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 52 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 53 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 54 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 55 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 56 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 57 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 58 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 59 (floor) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 60 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 61 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 62 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 63 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 64 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 65 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 66 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 67 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 68 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 69 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 70 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 71 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 72 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 73 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 74 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 75 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 76 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 77 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 78 (fmod) terminated successfully 500
> loops.
> float_power    0  TINFO  :  thread 79 (fmod) terminated successfully 500
> loops.
> float_power    1  TFAIL  :  thread 80 (pow) terminated unsuccessfully
> 439878 errors/501 loops
> float_power    2  TFAIL  :  pow failed at index 20: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power    3  TFAIL  :  thread 81 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power    4  TFAIL  :  pow failed at index 1: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power    5  TFAIL  :  thread 82 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power    6  TFAIL  :  pow failed at index 2: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power    7  TFAIL  :  thread 83 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power    8  TFAIL  :  pow failed at index 3: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power    9  TFAIL  :  thread 84 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   10  TFAIL  :  pow failed at index 4: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   11  TFAIL  :  thread 85 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   12  TFAIL  :  pow failed at index 5: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   13  TFAIL  :  thread 86 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   14  TFAIL  :  pow failed at index 6: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   15  TFAIL  :  thread 87 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   16  TFAIL  :  pow failed at index 7: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   17  TFAIL  :  thread 88 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   18  TFAIL  :  pow failed at index 8: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   19  TFAIL  :  thread 89 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   20  TFAIL  :  pow failed at index 9: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   21  TFAIL  :  thread 90 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   22  TFAIL  :  pow failed at index 10: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   23  TFAIL  :  thread 91 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   24  TFAIL  :  pow failed at index 11: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   25  TFAIL  :  thread 92 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   26  TFAIL  :  pow failed at index 12: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   27  TFAIL  :  thread 93 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   28  TFAIL  :  pow failed at index 13: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   29  TFAIL  :  thread 94 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   30  TFAIL  :  pow failed at index 14: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   31  TFAIL  :  thread 95 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   32  TFAIL  :  pow failed at index 15: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   33  TFAIL  :  thread 96 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   34  TFAIL  :  pow failed at index 16: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   35  TFAIL  :  thread 97 (pow) terminated unsuccessfully
> 440379 errors/501 loops
> float_power   36  TFAIL  :  pow failed at index 17: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   37  TFAIL  :  thread 98 (pow) terminated unsuccessfully
> 439878 errors/501 loops
> float_power   38  TFAIL  :  pow failed at index 18: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power   39  TFAIL  :  thread 99 (pow) terminated unsuccessfully
> 439878 errors/501 loops
> float_power   40  TFAIL  :  pow failed at index 19: OLD: inf NEW: inf
> DIFF: nan
>  
> float_power    0  TINFO  :  thread 100 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 101 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 102 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 103 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 104 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 105 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 106 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 107 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 108 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 109 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 110 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 111 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 112 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 113 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 114 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 115 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 116 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 117 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 118 (sqrt) terminated successfully
> 500 loops.
> float_power    0  TINFO  :  thread 119 (sqrt) terminated successfully
> 500 loops.
> float_power   41  TFAIL  :  Test failed
> <<<execution_status>>>
> initiation_status="ok"
> duration=14 termination_type=exited termination_id=1 corefile=no
> cutime=348 cstime=68
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20091031
>  
>        ###############################################################"
>  
>             Done executing testcases."
>             LTP Version:  LTP-20091031
>        ###############################################################"
>
>  
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for Conference
> attendees to learn about information security's most important issues through
> interactions with peers, luminaries and emerging and established companies.
> http://p.sf.net/sfu/rsaconf-dev2dev
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


--------------010906030903070308050809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
The new version has fixed this problem. <br>
Plz try the new version.<br>
<br>
Thanks.<br>
Liu Bo<br>
<br>
On 01/19/2010 01:46 PM, <a class="moz-txt-link-abbreviated" href="mailto:Kiran.Girmaji@Emerson.com">Kiran.Girmaji@Emerson.com</a> wrote:
<blockquote
 cite="mid:89D32649C0790143AB985A5BF77A104F02BFAA2B@etsmsg-hkexm05.etsmsg.org"
 type="cite">
  <pre wrap="">Hi,
 
I am running LTP math testsuite and float_power test fails with the
following output.
Could anyone please guide me.
 
My machine details -
64bit Intel Xeon based with windriver linux.
Linux megatron 2.6.21.7-WR2.0ap_cgl #1 SMP PREEMPT Fri Jan 8 01:49:51
IST 2010 x86_64 x86_64 x86_64 GNU/Linux

 
 Running tests.......
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=float_power stime=1034389477
cmdline="cd $LTPROOT/testcases/bin; float_power -v"
contacts=""
analysis=exit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
incrementing stop
float_power    0  TINFO  :  float_power: will run for 500 loops
float_power    0  TINFO  :  float_power: using . as data directory
float_power    0  TINFO  :  float_power: will run 6 functions, 20
threads per function
float_power    0  TINFO  :  signal handler 1082132800 started
float_power    0  TINFO  :  Signal handler starts waiting...
float_power    0  TINFO  :  Initial thread: Waiting for 120 threads to
finish
float_power    0  TINFO  :  thread 0 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 1 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 2 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 3 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 4 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 5 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 6 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 7 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 8 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 9 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 10 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 11 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 12 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 13 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 14 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 15 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 16 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 17 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 18 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 19 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 20 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 21 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 22 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 23 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 24 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 25 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 26 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 27 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 28 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 29 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 30 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 31 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 32 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 33 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 34 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 35 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 36 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 37 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 38 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 39 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 40 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 41 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 42 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 43 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 44 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 45 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 46 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 47 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 48 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 49 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 50 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 51 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 52 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 53 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 54 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 55 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 56 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 57 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 58 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 59 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 60 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 61 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 62 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 63 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 64 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 65 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 66 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 67 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 68 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 69 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 70 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 71 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 72 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 73 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 74 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 75 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 76 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 77 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 78 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 79 (fmod) terminated successfully 500
loops.
float_power    1  TFAIL  :  thread 80 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power    2  TFAIL  :  pow failed at index 20: OLD: inf NEW: inf
DIFF: nan
 
float_power    3  TFAIL  :  thread 81 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    4  TFAIL  :  pow failed at index 1: OLD: inf NEW: inf
DIFF: nan
 
float_power    5  TFAIL  :  thread 82 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    6  TFAIL  :  pow failed at index 2: OLD: inf NEW: inf
DIFF: nan
 
float_power    7  TFAIL  :  thread 83 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    8  TFAIL  :  pow failed at index 3: OLD: inf NEW: inf
DIFF: nan
 
float_power    9  TFAIL  :  thread 84 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   10  TFAIL  :  pow failed at index 4: OLD: inf NEW: inf
DIFF: nan
 
float_power   11  TFAIL  :  thread 85 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   12  TFAIL  :  pow failed at index 5: OLD: inf NEW: inf
DIFF: nan
 
float_power   13  TFAIL  :  thread 86 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   14  TFAIL  :  pow failed at index 6: OLD: inf NEW: inf
DIFF: nan
 
float_power   15  TFAIL  :  thread 87 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   16  TFAIL  :  pow failed at index 7: OLD: inf NEW: inf
DIFF: nan
 
float_power   17  TFAIL  :  thread 88 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   18  TFAIL  :  pow failed at index 8: OLD: inf NEW: inf
DIFF: nan
 
float_power   19  TFAIL  :  thread 89 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   20  TFAIL  :  pow failed at index 9: OLD: inf NEW: inf
DIFF: nan
 
float_power   21  TFAIL  :  thread 90 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   22  TFAIL  :  pow failed at index 10: OLD: inf NEW: inf
DIFF: nan
 
float_power   23  TFAIL  :  thread 91 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   24  TFAIL  :  pow failed at index 11: OLD: inf NEW: inf
DIFF: nan
 
float_power   25  TFAIL  :  thread 92 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   26  TFAIL  :  pow failed at index 12: OLD: inf NEW: inf
DIFF: nan
 
float_power   27  TFAIL  :  thread 93 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   28  TFAIL  :  pow failed at index 13: OLD: inf NEW: inf
DIFF: nan
 
float_power   29  TFAIL  :  thread 94 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   30  TFAIL  :  pow failed at index 14: OLD: inf NEW: inf
DIFF: nan
 
float_power   31  TFAIL  :  thread 95 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   32  TFAIL  :  pow failed at index 15: OLD: inf NEW: inf
DIFF: nan
 
float_power   33  TFAIL  :  thread 96 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   34  TFAIL  :  pow failed at index 16: OLD: inf NEW: inf
DIFF: nan
 
float_power   35  TFAIL  :  thread 97 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   36  TFAIL  :  pow failed at index 17: OLD: inf NEW: inf
DIFF: nan
 
float_power   37  TFAIL  :  thread 98 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power   38  TFAIL  :  pow failed at index 18: OLD: inf NEW: inf
DIFF: nan
 
float_power   39  TFAIL  :  thread 99 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power   40  TFAIL  :  pow failed at index 19: OLD: inf NEW: inf
DIFF: nan
 
float_power    0  TINFO  :  thread 100 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 101 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 102 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 103 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 104 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 105 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 106 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 107 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 108 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 109 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 110 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 111 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 112 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 113 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 114 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 115 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 116 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 117 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 118 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 119 (sqrt) terminated successfully
500 loops.
float_power   41  TFAIL  :  Test failed
&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status="ok"
duration=14 termination_type=exited termination_id=1 corefile=no
cutime=348 cstime=68
&lt;&lt;&lt;test_end&gt;&gt;&gt;
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20091031
 
       ###############################################################"
 
            Done executing testcases."
            LTP Version:  LTP-20091031
       ###############################################################"

 

  </pre>
  <pre wrap="">
<hr size="4" width="90%">
------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/rsaconf-dev2dev">http://p.sf.net/sfu/rsaconf-dev2dev</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------010906030903070308050809--


--===============4034476117020009477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============4034476117020009477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4034476117020009477==--

