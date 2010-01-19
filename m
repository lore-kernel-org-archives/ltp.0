Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NXC8A-0007lS-CM
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 11:20:18 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXC89-0000JJ-9C
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 11:20:18 +0000
Received: by pzk28 with SMTP id 28so2265262pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Jan 2010 03:20:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <89D32649C0790143AB985A5BF77A104F02BBC81A@etsmsg-hkexm05.etsmsg.org>
References: <89D32649C0790143AB985A5BF77A104F02BBC81A@etsmsg-hkexm05.etsmsg.org>
Date: Tue, 19 Jan 2010 03:20:11 -0800
Message-ID: <364299f41001190320u288f4cf9w4efc624678046e39@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Kiran.Girmaji@emerson.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 18, 2010 at 4:38 AM,  <Kiran.Girmaji@emerson.com> wrote:
> Hi,
>
> I am running LTP math testsuite and float_power test fails with the
> following output.
> Could anyone please guide me.
>
> My machine details -
> 64bit Intel Xeon based with windriver linux.
> Linux=A0megatron 2.6.21.7-atca-7150-WR2.0ap_cgl #1 SMP PREEMPT Fri Jan 8
> 01:49:51 IST 2010 x86_64 x86_64 x86_64 GNU/Linux
> Running tests.......
> <<<test_start>>>
> tag=3Dfloat_power stime=3D1034389477
> cmdline=3D"cd $LTPROOT/testcases/bin; float_power -v"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 float_power: will run for 500 loo=
ps
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 float_power: using . as data dire=
ctory
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 float_power: will run 6 functions=
, 20 threads
> per function
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 signal handler 1082132800 started
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 Signal handler starts waiting...
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 Initial thread: Waiting for 120 t=
hreads to
> finish
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 0 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 1 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 2 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 3 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 4 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 5 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 6 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 7 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 8 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 9 (ceil) terminated succes=
sfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 10 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 11 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 12 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 13 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 14 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 15 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 16 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 17 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 18 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 19 (ceil) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 20 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 21 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 22 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 23 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 24 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 25 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 26 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 27 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 28 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 29 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 30 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 31 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 32 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 33 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 34 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 35 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 36 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 37 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 38 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 39 (fabs) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 40 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 41 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 42 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 43 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 44 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 45 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 46 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 47 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 48 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 49 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 50 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 51 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 52 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 53 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 54 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 55 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 56 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 57 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 58 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 59 (floor) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 60 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 61 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 62 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 63 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 64 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 65 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 66 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 67 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 68 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 69 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 70 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 71 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 72 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 73 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 74 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 75 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 76 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 77 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 78 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 79 (fmod) terminated succe=
ssfully 500
> loops.
> float_power=A0=A0=A0 1=A0 TFAIL=A0 :=A0 thread 80 (pow) terminated unsucc=
essfully 439878
> errors/501 loops
> float_power=A0=A0=A0 2=A0 TFAIL=A0 :=A0 pow failed at index 20: OLD: inf =
NEW: inf DIFF:
> nan
>
> float_power=A0=A0=A0 3=A0 TFAIL=A0 :=A0 thread 81 (pow) terminated unsucc=
essfully 440379
> errors/501 loops
> float_power=A0=A0=A0 4=A0 TFAIL=A0 :=A0 pow failed at index 1: OLD: inf N=
EW: inf DIFF:
> nan
>
> float_power=A0=A0=A0 5=A0 TFAIL=A0 :=A0 thread 82 (pow) terminated unsucc=
essfully 440379
> errors/501 loops
> float_power=A0=A0=A0 6=A0 TFAIL=A0 :=A0 pow failed at index 2: OLD: inf N=
EW: inf DIFF:
> nan
>
> float_power=A0=A0=A0 7=A0 TFAIL=A0 :=A0 thread 83 (pow) terminated unsucc=
essfully 440379
> errors/501 loops
> float_power=A0=A0=A0 8=A0 TFAIL=A0 :=A0 pow failed at index 3: OLD: inf N=
EW: inf DIFF:
> nan
>
> float_power=A0=A0=A0 9=A0 TFAIL=A0 :=A0 thread 84 (pow) terminated unsucc=
essfully 440379
> errors/501 loops
> float_power=A0=A0 10=A0 TFAIL=A0 :=A0 pow failed at index 4: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 11=A0 TFAIL=A0 :=A0 thread 85 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 12=A0 TFAIL=A0 :=A0 pow failed at index 5: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 13=A0 TFAIL=A0 :=A0 thread 86 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 14=A0 TFAIL=A0 :=A0 pow failed at index 6: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 15=A0 TFAIL=A0 :=A0 thread 87 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 16=A0 TFAIL=A0 :=A0 pow failed at index 7: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 17=A0 TFAIL=A0 :=A0 thread 88 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 18=A0 TFAIL=A0 :=A0 pow failed at index 8: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 19=A0 TFAIL=A0 :=A0 thread 89 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 20=A0 TFAIL=A0 :=A0 pow failed at index 9: OLD: inf NEW=
: inf DIFF:
> nan
>
> float_power=A0=A0 21=A0 TFAIL=A0 :=A0 thread 90 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 22=A0 TFAIL=A0 :=A0 pow failed at index 10: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 23=A0 TFAIL=A0 :=A0 thread 91 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 24=A0 TFAIL=A0 :=A0 pow failed at index 11: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 25=A0 TFAIL=A0 :=A0 thread 92 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 26=A0 TFAIL=A0 :=A0 pow failed at index 12: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 27=A0 TFAIL=A0 :=A0 thread 93 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 28=A0 TFAIL=A0 :=A0 pow failed at index 13: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 29=A0 TFAIL=A0 :=A0 thread 94 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 30=A0 TFAIL=A0 :=A0 pow failed at index 14: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 31=A0 TFAIL=A0 :=A0 thread 95 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 32=A0 TFAIL=A0 :=A0 pow failed at index 15: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 33=A0 TFAIL=A0 :=A0 thread 96 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 34=A0 TFAIL=A0 :=A0 pow failed at index 16: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 35=A0 TFAIL=A0 :=A0 thread 97 (pow) terminated unsucces=
sfully 440379
> errors/501 loops
> float_power=A0=A0 36=A0 TFAIL=A0 :=A0 pow failed at index 17: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 37=A0 TFAIL=A0 :=A0 thread 98 (pow) terminated unsucces=
sfully 439878
> errors/501 loops
> float_power=A0=A0 38=A0 TFAIL=A0 :=A0 pow failed at index 18: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0 39=A0 TFAIL=A0 :=A0 thread 99 (pow) terminated unsucces=
sfully 439878
> errors/501 loops
> float_power=A0=A0 40=A0 TFAIL=A0 :=A0 pow failed at index 19: OLD: inf NE=
W: inf DIFF:
> nan
>
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 100 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 101 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 102 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 103 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 104 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 105 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 106 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 107 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 108 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 109 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 110 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 111 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 112 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 113 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 114 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 115 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 116 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 117 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 118 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0=A0 0=A0 TINFO=A0 :=A0 thread 119 (sqrt) terminated succ=
essfully 500
> loops.
> float_power=A0=A0 41=A0 TFAIL=A0 :=A0 Test failed
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D14 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D348 cstime=3D68
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20091031

    Same issue applies here like with your earlier ia64 email. Please
use a more recent version of the test, or LTP, if possible.
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
