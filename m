Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1UuXxH-0001St-Dr
	for ltp-list@lists.sourceforge.net; Thu, 04 Jul 2013 01:03:27 +0000
Received: from mail-we0-f182.google.com ([74.125.82.182])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UuXxC-0006vV-Hd
	for ltp-list@lists.sourceforge.net; Thu, 04 Jul 2013 01:03:27 +0000
MIME-Version: 1.0
In-Reply-To: <1875908008.1793486.1372676206673.JavaMail.root@redhat.com>
References: <1372146532-3182-1-git-send-email-liuhangbin@gmail.com>
	<538407137.757498.1372350334215.JavaMail.root@redhat.com>
	<CAPwn2JTuF3EVb8_XoWkFk=qZc61FhNHenNDmdR7b6xrZFf9x1g@mail.gmail.com>
	<1243201217.946751.1372403630876.JavaMail.root@redhat.com>
	<CAPwn2JRYRWDEvn090NdtM1K178R=yQSasmBX3ZoKymVtcRWPXw@mail.gmail.com>
	<606017700.1063130.1372417612499.JavaMail.root@redhat.com>
	<CAPwn2JQ+ri=T9Fs6JWdF+v_8x9Nk5wPqo5aTrzb1A9ERr2DgEQ@mail.gmail.com>
	<1875908008.1793486.1372676206673.JavaMail.root@redhat.com>
Date: Thu, 4 Jul 2013 09:03:16 +0800
Message-ID: <CAPwn2JR4V_7wmHjy+Vk86ncysSuVVkw2LpUL7dm0O=9WU4PqmQ@mail.gmail.com>
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill the
 test case after timeout
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Sorry the late reply, too busy these days. I think 100 is suitable, It
won't take too much time on sleeping, and will check timeout after a
while.
I will send a new patchv2 for all this issue.

Thanks
Hangbin Liu

2013/7/1 Jan Stancek <jstancek@redhat.com>:
>
>
>
>
> ----- Original Message -----
>> From: "Hangbin Liu" <liuhangbin@gmail.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: "ltp-list" <ltp-list@lists.sf.net>
>> Sent: Monday, 1 July, 2013 10:31:28 AM
>> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill the test case after timeout
>>
>> Hi Jan,
>> The problem is the connection won't  fail, but only need too much
>> time. For example:
>
> I see, checking after each X connection seems reasonable.
> I'm not very familiar with this test, so it's up to you to come up with some number.
>
> Regards,
> Jan
>
>> On a guest:  on cpu process, 2G memory
>> # for i in `seq 4000`; do ./ns-tcpclient -b -f 4 -S 10.66.87.216 -p
>> 9999; echo "The $i connection : `date`"; done
>> The 1 connection : Mon Jul  1 04:03:05 EDT 2013
>> The 2 connection : Mon Jul  1 04:03:05 EDT 2013
>> The 3 connection : Mon Jul  1 04:03:05 EDT 2013
>> The 4 connection : Mon Jul  1 04:03:06 EDT 2013
>> <snip>
>> The 19 connection : Mon Jul  1 04:04:46 EDT 2013
>> <snip>
>> The 30 connection : Mon Jul  1 04:06:34 EDT 2013
>> The 31 connection : Mon Jul  1 04:07:52 EDT 2013
>> <snip>
>> The 45 connection : Mon Jul  1 04:10:11 EDT 2013
>> <snip>
>> The 50 connection : Mon Jul  1 04:12:05 EDT 2013
>>
>> You can saw we took 9 minutes to set up 50 tcp connections.
>>
>> But on a powerful physical machine,
>> The 1 connection : Mon Jul  1 04:21:08 EDT 2013
>> The 2 connection : Mon Jul  1 04:21:08 EDT 2013
>> <snip>
>> The 499 connection : Mon Jul  1 04:24:35 EDT 2013
>> The 500 connection : Mon Jul  1 04:24:35 EDT 2013
>>
>> It only use 3 minutest to set up 500 connections.
>>
>> So we can't just continue on success, but should check the time after
>> some connections.
>>
>> Thanks and Best regards
>> Hangbin Liu
>>
>> 2013/6/28 Jan Stancek <jstancek@redhat.com>:
>> >
>> >
>> > ----- Original Message -----
>> >> From: "Hangbin Liu" <liuhangbin@gmail.com>
>> >> To: "Jan Stancek" <jstancek@redhat.com>
>> >> Sent: Friday, 28 June, 2013 11:30:02 AM
>> >> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill
>> >> the test case after timeout
>> >>
>> >
>> > Hangbin,
>> >
>> > just fyi, your replies are not going to list.
>> >
>> >> Opps, My mistake.  Didn't find there is a sleep 1...
>> >>
>> >> I will send another patch for this issue. How about check
>> >> $connection_num every 100 times. like
>> >
>> > I'd go with new variable to count each attempt, not just successful ones.
>> >
>> > Or something like this (on top your patch):
>> > Skip the sleep and continue on success, if we hit issue sleep and retry as
>> > watchdog allows.
>> >
>> > diff --git
>> > a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> > b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> > index 206a0d1..649c60b 100644
>> > --- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> > +++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> > @@ -351,9 +351,10 @@ while true ; do
>> >                         fi
>> >                         # Failed to start a client
>> >                         tst_resm TINFO "$connection_num seems the maximum
>> >                         number of the client"
>> > -                       break
>> > +               else
>> > +                       connection_num=`expr $connection_num + 1`
>> > +                       continue;
>> >                 fi
>> > -               connection_num=`expr $connection_num + 1`
>> >         fi
>> >
>> >      current_epoc=`date +%s`
>> >
>> > Regards,
>> > Jan
>> >
>> >>
>> >> --- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> >> +++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
>> >> @@ -340,7 +340,7 @@ connection_num=0
>> >>  start_epoc=`date +%s`
>> >>  while true ; do
>> >>         # Making connections
>> >> -       if [ $connection_num -lt $CONNECTION_TOTAL ]; then
>> >> +       while [ $connection_num -lt $CONNECTION_TOTAL ]; do
>> >>                 # Run a client
>> >>                 ret=`$LTP_RSH $RHOST
>> >> ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p
>> >> $server_port' ; ec
>> >>                 if [ $ret -ne 0 ]; then
>> >> @@ -354,7 +354,12 @@ while true ; do
>> >>                         break
>> >>                 fi
>> >>                 connection_num=`expr $connection_num + 1`
>> >> -       fi
>> >> +
>> >> +               # check timeout every 100 times
>> >> +               if [ $(($connection_num % 100)) -eq 0 ];then
>> >> +                       break
>> >> +               fi
>> >> +       done
>> >>
>> >>      current_epoc=`date +%s`
>> >>      elapse_epoc=`expr $current_epoc - $start_epoc`
>> >>
>> >> 2013/6/28 Jan Stancek <jstancek@redhat.com>:
>> >> >
>> >> >
>> >> >
>> >> >
>> >> > ----- Original Message -----
>> >> >> From: "Hangbin Liu" <liuhangbin@gmail.com>
>> >> >> To: "Jan Stancek" <jstancek@redhat.com>
>> >> >> Sent: Friday, 28 June, 2013 8:36:05 AM
>> >> >> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will
>> >> >> kill
>> >> >> the test case after timeout
>> >> >>
>> >> >> No, we can set up $CONNECTION_TOTAL connections as soon as possible,
>> >> >> and
>> >> >> also
>> >> >> transmit tcp data at the same time.
>> >> >
>> >> > Where does this happen?
>> >> >
>> >> > I'm looking at the while loop, and I see it creates 1 connection each
>> >> > iteration, then it sleeps for 1 second.
>> >> >
>> >> > Am I missing something here?
>> >> >
>> >> > while true ; do
>> >> >         # Making connections
>> >> >         if [ $connection_num -lt $CONNECTION_TOTAL ]; then
>> >> >                 # make new connection
>> >> >                 ...
>> >> >                 connection_num=`expr $connection_num + 1`
>> >> >         fi
>> >> >
>> >> >     # check time
>> >> >     ...
>> >> >     sleep 1
>> >> > done
>> >> >
>> >> > Regards,
>> >> > Jan
>> >>
>>

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
