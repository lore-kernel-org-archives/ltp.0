Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UsSsa-0005pR-5p
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 07:14:00 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsSsX-00013u-UF
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 07:13:59 +0000
Date: Fri, 28 Jun 2013 03:13:50 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1243201217.946751.1372403630876.JavaMail.root@redhat.com>
In-Reply-To: <CAPwn2JTuF3EVb8_XoWkFk=qZc61FhNHenNDmdR7b6xrZFf9x1g@mail.gmail.com>
References: <1372146532-3182-1-git-send-email-liuhangbin@gmail.com>
	<538407137.757498.1372350334215.JavaMail.root@redhat.com>
	<CAPwn2JTuF3EVb8_XoWkFk=qZc61FhNHenNDmdR7b6xrZFf9x1g@mail.gmail.com>
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
> Sent: Friday, 28 June, 2013 8:36:05 AM
> Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill the test case after timeout
> 
> No, we can set up $CONNECTION_TOTAL connections as soon as possible, and also
> transmit tcp data at the same time.

Where does this happen?

I'm looking at the while loop, and I see it creates 1 connection each
iteration, then it sleeps for 1 second. 

Am I missing something here?

while true ; do
        # Making connections
        if [ $connection_num -lt $CONNECTION_TOTAL ]; then
                # make new connection
                ...
                connection_num=`expr $connection_num + 1`
        fi

    # check time
    ...
    sleep 1
done

Regards,
Jan

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
