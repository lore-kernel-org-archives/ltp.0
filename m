Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrTK6-0005TA-Gw
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 13:30:18 +0000
Date: Tue, 25 Jun 2013 15:31:46 +0200
From: chrubis@suse.cz
Message-ID: <20130625133145.GG31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
	<20130625124803.GC31268@rei>
	<CA+icZUUWAWObVLtPXug1YFFOUhB9P-5W88SbN4CebzOC-yGCwg@mail.gmail.com>
	<20130625131112.GE31268@rei>
	<CA+icZUUvJ6k8YD88t=ONv95hGBidrkXuzFtQfkS+Qq6=2Q=-bA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUUvJ6k8YD88t=ONv95hGBidrkXuzFtQfkS+Qq6=2Q=-bA@mail.gmail.com>
Subject: Re: [LTP] How to run only a specific test series like for example
 IPC?
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> # LC_ALL=C ls -l /tmp/ltp-* /tmp/ltp-*/mnt_pnt.* /tmp/ltp-*/*.img
> ls: cannot access /tmp/ltp-*: No such file or directory
> ls: cannot access /tmp/ltp-*/mnt_pnt.*: No such file or directory
> ls: cannot access /tmp/ltp-*/*.img: No such file or directory
> 
> # egrep -nr -i 'xxx|mnt_pnt' runltp
> 506:    export TMPTEMPLATE="${TMPBASE}/ltp-XXXXXXXXXX"
> 706:        mnt_pnt=`mktemp -d "${TMP}/mnt_pnt.XXXXXX"`
> 708:            mount -t $DEVICE_FS_TYPE $DEVICE $mnt_pnt
> 710:            mount $DEVICE $mnt_pnt
> 728:        rm -rf $mnt_pnt
> 984:mkdir -p "${TMP}/mnt_pnt.XXXXXX"
> 
> Are those directories created before usage?

Yes, for each test that needs to work with files a directory is created
before the test is started and removed at test exit.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
