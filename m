Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1T86Te-0004bS-3K
	for ltp-list@lists.sourceforge.net; Sun, 02 Sep 2012 09:28:22 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T86Td-0004wy-Fi
	for ltp-list@lists.sourceforge.net; Sun, 02 Sep 2012 09:28:22 +0000
Received: by obblz20 with SMTP id lz20so8338805obb.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 02 Sep 2012 02:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5042EF01.9020700@asianux.com>
References: <5042EF01.9020700@asianux.com>
Date: Sun, 2 Sep 2012 02:28:15 -0700
Message-ID: <CAGH67wTX0Lw_cNZduov1UnsGJLjP5GitJCe_zV64Vs2CtW9VgQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [QUESTION] ltp stress test for RHEL5 and NFS local mount
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
To: gchen <gang.chen@asianux.com>
Cc: ltp-list@lists.sourceforge.net

On Sat, Sep 1, 2012 at 10:30 PM, gchen <gang.chen@asianux.com> wrote:
> Hello ltp-list@lists.sourceforge.net
>
>
> Question:
>
> Use ltp stress test (/opt/ltp/ltpstress.sh) with ltp-full-20100331.gz
> to test RHEL5 (kernel-2.6.18-308.4.1.el5) for 72 hours.
>
> Not give any more configurations for NFS (using default configuration:
> mount NFS locally, so the NFS client and NFS server are on the same
> machine).
>
> My question is that "for stress test, is it suitable to let NFS server and
> client on the same machine ?"
>
>
> Background;
>
> This configuration will cause deadlock for RHEL5, and can not boot
> machine in normal way.
>
> someone from Red Hat has said that:
> --------------------------------------------------------------------------------------------------------------
>
> "Have configuration where the same host is acting as both NFS client
> and server. That's a configuration known to cause deadlocks."
>
> --------------------------------------------------------------------------------------------------------------
>
> can reference Red Hat Bugzilla (bug 848706) for more details.

    I've done that occasionally on FreeBSD (mount over nfs into a
chroot) before I discovered nullfs (sort of like the unionfs
equivalent on *BSD), but I didn't stress the system. It's an
interesting scenario, but I would say that this is more of a fringe
case than something that one would normally do.
    If it helps you better isolate an issue that occurs in scenarios
where the NFS client/server are separate from one another, I'd say go
for it.
Cheers,
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
