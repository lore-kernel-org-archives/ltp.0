Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UsWW6-0006k2-Rw
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 11:07:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsWW4-0004uR-Me
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 11:07:02 +0000
Date: Fri, 28 Jun 2013 07:06:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <606017700.1063130.1372417612499.JavaMail.root@redhat.com>
In-Reply-To: <CAPwn2JRYRWDEvn090NdtM1K178R=yQSasmBX3ZoKymVtcRWPXw@mail.gmail.com>
References: <1372146532-3182-1-git-send-email-liuhangbin@gmail.com>
	<538407137.757498.1372350334215.JavaMail.root@redhat.com>
	<CAPwn2JTuF3EVb8_XoWkFk=qZc61FhNHenNDmdR7b6xrZFf9x1g@mail.gmail.com>
	<1243201217.946751.1372403630876.JavaMail.root@redhat.com>
	<CAPwn2JRYRWDEvn090NdtM1K178R=yQSasmBX3ZoKymVtcRWPXw@mail.gmail.com>
MIME-Version: 1.0
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>



----- Original Message -----
> From: "Hangbin Liu" <liuhangbin@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Sent: Friday, 28 June, 2013 11:30:02 AM
> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill the test case after timeout
> 

Hangbin,

just fyi, your replies are not going to list.

> Opps, My mistake.  Didn't find there is a sleep 1...
> 
> I will send another patch for this issue. How about check
> $connection_num every 100 times. like

I'd go with new variable to count each attempt, not just successful ones.

Or something like this (on top your patch):
Skip the sleep and continue on success, if we hit issue sleep and retry as watchdog allows.

diff --git a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01 b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
index 206a0d1..649c60b 100644
--- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
+++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
@@ -351,9 +351,10 @@ while true ; do
                        fi
                        # Failed to start a client
                        tst_resm TINFO "$connection_num seems the maximum number of the client"
-                       break
+               else
+                       connection_num=`expr $connection_num + 1`
+                       continue;
                fi
-               connection_num=`expr $connection_num + 1`
        fi

     current_epoc=`date +%s`

Regards,
Jan

> 
> --- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> +++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> @@ -340,7 +340,7 @@ connection_num=0
>  start_epoc=`date +%s`
>  while true ; do
>         # Making connections
> -       if [ $connection_num -lt $CONNECTION_TOTAL ]; then
> +       while [ $connection_num -lt $CONNECTION_TOTAL ]; do
>                 # Run a client
>                 ret=`$LTP_RSH $RHOST
> ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p
> $server_port' ; ec
>                 if [ $ret -ne 0 ]; then
> @@ -354,7 +354,12 @@ while true ; do
>                         break
>                 fi
>                 connection_num=`expr $connection_num + 1`
> -       fi
> +
> +               # check timeout every 100 times
> +               if [ $(($connection_num % 100)) -eq 0 ];then
> +                       break
> +               fi
> +       done
> 
>      current_epoc=`date +%s`
>      elapse_epoc=`expr $current_epoc - $start_epoc`
> 
> 2013/6/28 Jan Stancek <jstancek@redhat.com>:
> >
> >
> >
> >
> > ----- Original Message -----
> >> From: "Hangbin Liu" <liuhangbin@gmail.com>
> >> To: "Jan Stancek" <jstancek@redhat.com>
> >> Sent: Friday, 28 June, 2013 8:36:05 AM
> >> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill
> >> the test case after timeout
> >>
> >> No, we can set up $CONNECTION_TOTAL connections as soon as possible, and
> >> also
> >> transmit tcp data at the same time.
> >
> > Where does this happen?
> >
> > I'm looking at the while loop, and I see it creates 1 connection each
> > iteration, then it sleeps for 1 second.
> >
> > Am I missing something here?
> >
> > while true ; do
> >         # Making connections
> >         if [ $connection_num -lt $CONNECTION_TOTAL ]; then
> >                 # make new connection
> >                 ...
> >                 connection_num=`expr $connection_num + 1`
> >         fi
> >
> >     # check time
> >     ...
> >     sleep 1
> > done
> >
> > Regards,
> > Jan
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
