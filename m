Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Osh3J-0007gn-95
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 19:08:25 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Osh3I-0004sB-D5
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 19:08:25 +0000
Received: by bwz12 with SMTP id 12so4614176bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Sep 2010 12:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinAQARYsEWv6jbezg=-J=xBZM3UXnWfOSz++Lto@mail.gmail.com>
References: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
	<AANLkTi=9PFi3k0eEyYO_SvwBsOK77CBECXkrWLy7rkhY@mail.gmail.com>
	<AANLkTinAQARYsEWv6jbezg=-J=xBZM3UXnWfOSz++Lto@mail.gmail.com>
Date: Mon, 6 Sep 2010 12:08:15 -0700
Message-ID: <AANLkTinDeS1ODKGwEtwRed0H57e3vyzjqQB8nnv_Cn4G@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ld01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Deepti Thite <dthite@in.mvista.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Sep 1, 2010 at 2:49 AM, Deepti Thite <dthite@in.mvista.com> wrote:
> Hi Garrett,
>
> The actual error messages which I got were:
>
> + diff -iw /tmp/ld-6569/errmsg.out /tmp/ld-6569/errmsg.exp
> --- /tmp/ld-6569/errmsg.out     Fri Aug 27 15:42:16 2010
>
> +++ /tmp/ld-6569/errmsg.exp     Fri Aug 27 15:42:16 2010
> @@ -1,3 +1,3 @@
> -arm-none-linux-gnueabi-gcc: x.obj: No such file or directory
> -arm-none-linux-gnueabi-gcc: y.obj: No such file or directory
> -arm-none-linux-gnueabi-gcc: no input files
>
> +gcc: x.obj: No such file or directory
> +gcc: y.obj: No such file or directory
> +gcc: No input files
> + [ 1 -eq 0 ]
> + echo FAIL -  ld failed to give expected error msg
> FAIL -  ld failed to give expected error msg
>
> We are getting this issue as the native gcc is actually a shell script wh=
ich
> calls
> arm-none-linux-gnueabi-gcc with compiler flags.
> So we are getting the actual output but as the two files dont match ld01
> fails.
> The patch attached in previous mail will not compare two files but will g=
rep
> the expected output.
>
> Regards
> Deepti Thite <dthite@mvista.com>
>
> On Tue, Aug 31, 2010 at 9:18 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>
>> On Tue, Aug 31, 2010 at 2:47 AM, Deepti Thite <dthite@in.mvista.com>
>> wrote:
>> > ld01 test fails as native compilers don=92t match in the expected and
>> > output
>> > file.
>> >
>> > The attached patch will grep expected results from the output file
>> > generated
>> > and will not create an expected results file.
>>
>> What is the actual error message that gets printed out by ld(1)?
>> Thanks,

Here's a solution that doesn't require any change:

export CC=3D'absolute-path-to-gcc'
export LD=3D'absolute-path-to-ld'
runltp # ...

this equals zero change in our code, and ensures that the absolute
name for the compiler is correct.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
