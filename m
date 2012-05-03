Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPwOw-0007SE-TK
	for ltp-list@lists.sourceforge.net; Thu, 03 May 2012 13:48:58 +0000
Date: Thu, 3 May 2012 14:46:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120503124606.GA9999@saboteur.suse.cz>
References: <alpine.BSF.2.00.1204041738350.25027@toaster.local>
	<4F7CF7DB.2080802@cn.fujitsu.com>
	<CAGH67wRSAKEkn=MNn2HHivnPNjuP_tqE8+S1-ND_Z69VrBm9Ow@mail.gmail.com>
	<4F84F212.9070408@cn.fujitsu.com>
	<8DB64E3B-1B6D-4C27-85E8-11817A41F879@gmail.com>
	<4F854F21.5070208@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F854F21.5070208@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] Replace struct event_t with struct
 inotify_event
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> >>>
> >>> Yeah... let me get back to you on that...
> >>
> >>
> >> Any update on this?
> > 
> > I'm moving from CA to WA, but I'll try to get back to you sometime mid next week once I get settled in.
> 
> 
> That's great! I wonder what do CA and WA stand for?

I would guess that these are city names or something like that... ;)

And of course the patch is wrong, the event_t structure is used only to
record what have you done for sake of comparing the sequence to the
inotify events read later.

-- 
Cyril Hrubis
chrubis@suse.cz

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
